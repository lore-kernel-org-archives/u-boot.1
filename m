Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01636C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D3587754;
	Wed, 20 Dec 2023 13:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k79OKA8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC5A87530; Wed, 20 Dec 2023 05:50:40 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D34D4807D9
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BK4oUQP019184;
 Tue, 19 Dec 2023 22:50:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703047830;
 bh=K7i+7glkS9ceYGIyM0sQn/RUTdbH8wz5IBi32odVxO0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=k79OKA8pHBZWmSKOFu269BE3BWGz3X2BeZlFuT0K/+oCiIih/lvX/oOVFsrYHmghC
 EoJpjmPLZOoqmzeltZ/MyK/mLIZCG9SP9UAB1LhEJQ72wSGKjafQWt3H+aAEBu54L6
 F+c5lGvsY9MCWwqSwIWgetkXNj6OhOS/7kAp1Ong=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BK4oUHY116246
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 22:50:30 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 22:50:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 22:50:30 -0600
Received: from [10.24.69.31] (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BK4oO6j079775;
 Tue, 19 Dec 2023 22:50:25 -0600
Message-ID: <5b8bc069-a934-4963-9348-212b6559522e@ti.com>
Date: Wed, 20 Dec 2023 10:20:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/16] Revert "dm: core: Report bootph-pre-ram/sram
 node as pre-reloc after relocation"
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <r-gunasekaran@ti.com>
References: <20231219101225.3443978-1-danishanwar@ti.com>
 <20231219101225.3443978-33-danishanwar@ti.com>
 <CAPnjgZ18vCeBT9ykZdF1iV8ten1OJti1qXyU5BPKmcf5kMmiUA@mail.gmail.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <CAPnjgZ18vCeBT9ykZdF1iV8ten1OJti1qXyU5BPKmcf5kMmiUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 20 Dec 2023 13:13:44 +0100
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

Hi Simon,
Please ignore this thread. This patch is actually not part of the series
and I mistakenly posted it. I have reposted this series. Please review
that. Sorry for the inconvinience.

On 20/12/23 10:16 am, Simon Glass wrote:
> Hi,
> 
> On Tue, 19 Dec 2023 at 03:13, MD Danish Anwar <danishanwar@ti.com> wrote:
>>
>> This reverts commit 9e644284ab812f2db23f6185af77c0e771b0be73.
>> ---
>>  drivers/core/ofnode.c | 2 +-
>>  include/dm/ofnode.h   | 8 ++++----
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
> 
> Can you please add some info more info about why this is needed?
> 
> Regards,
> Simon
> 
> 
>> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
>> index 21a233f90f..cc2029e62d 100644
>> --- a/drivers/core/ofnode.c
>> +++ b/drivers/core/ofnode.c
>> @@ -1485,7 +1485,7 @@ bool ofnode_pre_reloc(ofnode node)
>>          */
>>         if (ofnode_read_bool(node, "bootph-pre-ram") ||
>>             ofnode_read_bool(node, "bootph-pre-sram"))
>> -               return gd->flags & GD_FLG_RELOC;
>> +               return true;
>>
>>         if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE)) {
>>                 /* detect and handle old tags */
>> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
>> index 5795115c49..5f1c8c2787 100644
>> --- a/include/dm/ofnode.h
>> +++ b/include/dm/ofnode.h
>> @@ -1254,15 +1254,15 @@ int ofnode_read_simple_size_cells(ofnode node);
>>   * determine if a node was bound in one of SPL/TPL stages.
>>   *
>>   * There are 4 settings currently in use
>> - * - bootph-some-ram: U-Boot proper pre-relocation phase
>> + * - bootph-some-ram: U-Boot proper pre-relocation only
>>   * - bootph-all: all phases
>>   * Existing platforms only use it to indicate nodes needed in
>>   * SPL. Should probably be replaced by bootph-pre-ram for new platforms.
>> - * - bootph-pre-ram: SPL phase
>> - * - bootph-pre-sram: TPL phase
>> + * - bootph-pre-ram: SPL and U-Boot pre-relocation
>> + * - bootph-pre-sram: TPL and U-Boot pre-relocation
>>   *
>>   * @node: node to check
>> - * Return: true if node should be or was bound, false otherwise
>> + * Return: true if node is needed in SPL/TL, false otherwise
>>   */
>>  bool ofnode_pre_reloc(ofnode node);
>>
>> --
>> 2.34.1
>>

-- 
Thanks and Regards,
Danish
