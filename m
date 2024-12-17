Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6428AE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CF56801FB;
	Tue, 17 Dec 2024 14:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CWQHf6t2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C5A780224; Tue, 17 Dec 2024 14:53:21 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA2F480107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHDrGHm011360
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2024 07:53:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734443596;
 bh=HKS7gMUU5tz8k2rEz7QVMS9WNPjXv3I3Ol98hnncrlc=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=CWQHf6t2xEw1jCME5n4BaMTytGAisLGmjZnCVC42OENX/CddYTArgl49qSOjdYK5k
 pXbX+v8QV2qlL0dVtCU+D+7uLaeeXwn9hWXL1ZzmrMpq2Fk0TaABEq3cvSJjtjSuqQ
 zRhwUakXfnKRuYQIz/qtlulAyuIerDKS5qXmymCI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHDrGMk006448
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Dec 2024 07:53:16 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 07:53:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 07:53:15 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BHDrFer125974;
 Tue, 17 Dec 2024 07:53:15 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: Re: [PATCH] dma: ti: k3-udma: Fix BCDMA probe by adding check for
 MMR_RFLOW
In-Reply-To: <20241210135059.1043095-1-p-mantena@ti.com>
References: <20241210135059.1043095-1-p-mantena@ti.com>
Date: Tue, 17 Dec 2024 07:53:15 -0600
Message-ID: <86r0664dro.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Prasanth Babu Mantena <p-mantena@ti.com> writes:

> RFLOW config related MMR does not exist incase of BCDMA.
> Add check to bypass the RFLOW MMR extraction.
> Without this, the probe sequence fails checking for
> the MMR_RFLOW region, which is valid only for packet based
> DMA and obselete for BCDMA.
>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index dac4023ccfd..3013c4741d0 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -1331,6 +1331,8 @@ static int udma_get_mmrs(struct udevice *dev)
>  			continue;
>  		if (i == MMR_RCHANRT && ud->rchan_cnt == 0)
>  			continue;
> +		if (i == MMR_RFLOW && ud->match_data->type == DMA_TYPE_BCDMA)
> +			continue;
>  
>  		ud->mmrs[i] = dev_read_addr_name_ptr(dev, mmr_names[i]);
>  		if (!ud->mmrs[i])
> -- 
> 2.34.1

Tested-by: Jonathan Humphreys <j-humphreys@ti.com>
