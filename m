Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B790C47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 05:08:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1380A87BD1;
	Fri,  2 Feb 2024 06:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MQdWhvLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E94B987CCA; Fri,  2 Feb 2024 06:08:00 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F59E874B1
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 06:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41257lNM035317;
 Thu, 1 Feb 2024 23:07:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706850467;
 bh=xZx+MiuaI45K+hmxJ+uqJdX8JY5DedB1n3MwaPvhL5A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=MQdWhvLq8yWlu8qxeA3qW1M8ptC3AXXLTLb+9tB9+kisXiYygKgdkMQlGYJlmy/M8
 5Z0R+xaI9bEqYml+8dpRHEyOEUAULH9l0kVI/Ot1wNXblEotPKGA+tVkjDNDrlWBl/
 SIRPZ4Swh35fQ+hgNYvlpkeUJUZUVK2nUQNqFZqM=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41257lcT092405
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 Feb 2024 23:07:47 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 23:07:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 23:07:46 -0600
Received: from [10.249.135.225] ([10.249.135.225])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41257hOX029034;
 Thu, 1 Feb 2024 23:07:43 -0600
Message-ID: <e944b9e1-0c3e-4588-8f36-5503893bfd89@ti.com>
Date: Fri, 2 Feb 2024 10:37:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dma: ti: k3-udma: Use ring_idx to pair k3 nav rings
Content-Language: en-US
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20240130061804.2342672-1-danishanwar@ti.com>
 <be6f43d8-e3a4-4e58-9704-f3a0a4b50adc@ti.com>
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <be6f43d8-e3a4-4e58-9704-f3a0a4b50adc@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


On 2/2/2024 10:31 AM, Ravi Gunasekaran wrote:
> 
> 
> On 1/30/2024 11:48 AM, MD Danish Anwar wrote:
>> Use ring_idx to pair rings. ring_idx will be same as tx flow_id for all
>> non-negative flow_ids. For negative flow_ids, ring_idx will be tchan->id
>> added with bchan_cnt.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>> Changes from v3 to v4:
>> *) No functional change. Splitted the patch out of the series as suggested
>>    by Nishant.
>>
>> v3: https://lore.kernel.org/all/20240124064930.1787929-2-danishanwar@ti.com/
>>
>>  drivers/dma/ti/k3-udma.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 8a62d63dfe..eea9ec9659 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -876,13 +876,20 @@ static int udma_alloc_tx_resources(struct udma_chan *uc)
>>  {
>>  	struct k3_nav_ring_cfg ring_cfg;
>>  	struct udma_dev *ud = uc->ud;
>> -	int ret;
>> +	struct udma_tchan *tchan;
>> +	int ring_idx, ret;
>>  
>>  	ret = udma_get_tchan(uc);
>>  	if (ret)
>>  		return ret;
>>  
>> -	ret = k3_nav_ringacc_request_rings_pair(ud->ringacc, uc->tchan->id, -1,
>> +	tchan = uc->tchan;
>> +	if (tchan->tflow_id >= 0)
>> +		ring_idx = tchan->tflow_id;
>> +	else
>> +		ring_idx = ud->bchan_cnt + tchan->id;
>> +
>> +	ret = k3_nav_ringacc_request_rings_pair(ud->ringacc, ring_idx, -1,
>>  						&uc->tchan->t_ring,
>>  						&uc->tchan->tc_ring);
>>  	if (ret) {
> 
> I see this change present in upstream linux kernel as well.
> You could consider providing the link to kernel if such changes are already
> merged there.

Sure Ravi,

Link to upstream kernel code for the same [1].
Upstream Commit: d2abc982333c02f9e1ff1c6b3782174f5b7662d7

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/ti/k3-udma.c?h=v6.8-rc2#n1686

> 
> Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Thanks and Regards,
Md Danish Anwar
