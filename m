Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DE1C47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 05:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4099987CA4;
	Fri,  2 Feb 2024 06:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pCf7ZVoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5989C87CCA; Fri,  2 Feb 2024 06:01:36 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2DAF874B1
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 06:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41251Phl094428;
 Thu, 1 Feb 2024 23:01:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706850085;
 bh=iy2Zwi08Z5PuTUB8sm7Xqp6oq6LVuFIPKS3OhhFjzFc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=pCf7ZVoemjh35xQPCoOy+VVmMePix6FvhPMz4RdPcw994u2YmgY2F7jI4itxfJuXR
 72rBLSFB+7Y5N8HjL87nA8YytKT5Y7fZ0LCNfl787bNxwYk7QnvmIpzDWHSTcjGYxy
 PSu8F8PSUkD8Mp4yIruQIcSwfj1EdquqfpqQ4gek=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41251PPc070518
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 Feb 2024 23:01:25 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 23:01:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 23:01:24 -0600
Received: from [10.249.129.226] ([10.249.129.226])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41251KvU020199;
 Thu, 1 Feb 2024 23:01:21 -0600
Message-ID: <be6f43d8-e3a4-4e58-9704-f3a0a4b50adc@ti.com>
Date: Fri, 2 Feb 2024 10:31:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dma: ti: k3-udma: Use ring_idx to pair k3 nav rings
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20240130061804.2342672-1-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240130061804.2342672-1-danishanwar@ti.com>
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



On 1/30/2024 11:48 AM, MD Danish Anwar wrote:
> Use ring_idx to pair rings. ring_idx will be same as tx flow_id for all
> non-negative flow_ids. For negative flow_ids, ring_idx will be tchan->id
> added with bchan_cnt.
>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Changes from v3 to v4:
> *) No functional change. Splitted the patch out of the series as suggested
>    by Nishant.
>
> v3: https://lore.kernel.org/all/20240124064930.1787929-2-danishanwar@ti.com/
>
>  drivers/dma/ti/k3-udma.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 8a62d63dfe..eea9ec9659 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -876,13 +876,20 @@ static int udma_alloc_tx_resources(struct udma_chan *uc)
>  {
>  	struct k3_nav_ring_cfg ring_cfg;
>  	struct udma_dev *ud = uc->ud;
> -	int ret;
> +	struct udma_tchan *tchan;
> +	int ring_idx, ret;
>  
>  	ret = udma_get_tchan(uc);
>  	if (ret)
>  		return ret;
>  
> -	ret = k3_nav_ringacc_request_rings_pair(ud->ringacc, uc->tchan->id, -1,
> +	tchan = uc->tchan;
> +	if (tchan->tflow_id >= 0)
> +		ring_idx = tchan->tflow_id;
> +	else
> +		ring_idx = ud->bchan_cnt + tchan->id;
> +
> +	ret = k3_nav_ringacc_request_rings_pair(ud->ringacc, ring_idx, -1,
>  						&uc->tchan->t_ring,
>  						&uc->tchan->tc_ring);
>  	if (ret) {

I see this change present in upstream linux kernel as well.
You could consider providing the link to kernel if such changes are already
merged there.

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
