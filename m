Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5326C4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 11:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D7C0878CA;
	Tue, 16 Jan 2024 12:44:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lB9/P+4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CCF878EE; Tue, 16 Jan 2024 12:44:00 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD2538787B
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 12:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 680A3B80B7F;
 Tue, 16 Jan 2024 11:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99759C433F1;
 Tue, 16 Jan 2024 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705405436;
 bh=oCtmgge925ZcoFHYg9RXAOI/HA71HSeIKMWZ4glZQXM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lB9/P+4fMVTyGG9gfpAv0HVWbsAN5Sn9bbqFs3qn7xiWLaFbOFA1GtMGpWgr6DSn1
 ltTOUegx3turLD892p0pE6Kz70oXTYvSBZROOKF+fYUDeFqqMh0SQg+2XZ3ny0u5Tg
 8RIPwx7jX6GjT3dqmaWyACaijnby4Lr+pVM2Bj0neY37TmmfejGPN5W8MlIMzYZ+Ai
 aXbhlyE6dtOm85o86e59QK9Zx1fefIqBH9+EBplIxT6IcwQK8IVaeJ8+c/fPPI97wq
 EPqFy+8gvLTh3Aao5/GCt1mSuGygb1y9/3zw+g58+JjEpial9GnbuimQMUg3+mRLwy
 LFzyYcBDneHhg==
Message-ID: <121dc2b7-0fc7-42ac-80cb-9c1af64a09eb@kernel.org>
Date: Tue, 16 Jan 2024 13:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] soc: ti: k3-navss-ringacc: Initialize base address
 of ring cfg registers
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com, nm@ti.com,
 sjg@chromium.org, afd@ti.com, vigneshr@ti.com
Cc: u-boot@lists.denx.de, dannenberg@ti.com, srk@ti.com
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-4-s-vadapalli@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240112064759.1801600-4-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 12/01/2024 08:47, Siddharth Vadapalli wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Initialize base address of ring config registers required to natively
> setup ring cfg registers in the absence of Device Manager (DM) services
> at R5 SPL stage.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/soc/ti/k3-navss-ringacc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
> index 7a2fbb0db6..31e9b372ee 100644
> --- a/drivers/soc/ti/k3-navss-ringacc.c
> +++ b/drivers/soc/ti/k3-navss-ringacc.c
> @@ -1030,8 +1030,8 @@ static int k3_nav_ringacc_init(struct udevice *dev, struct k3_nav_ringacc *ringa
>  struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
>  						struct k3_ringacc_init_data *data)
>  {
> +	void __iomem *base_rt, *base_cfg;
>  	struct k3_nav_ringacc *ringacc;
> -	void __iomem *base_rt;
>  	int i;
>  
>  	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
> @@ -1049,6 +1049,10 @@ struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
>  	if (!base_rt)
>  		return ERR_PTR(-EINVAL);
>  
> +	base_cfg = dev_read_addr_name_ptr(dev, "cfg");
> +	if (!base_cfg)
> +		return ERR_PTR(-EINVAL);
> +

Should this be restricted only for R5 SPL case? else we conflict with
Device Manager services?

>  	ringacc->rings = devm_kzalloc(dev,
>  				      sizeof(*ringacc->rings) *
>  				      ringacc->num_rings * 2,
> @@ -1063,6 +1067,7 @@ struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
>  	for (i = 0; i < ringacc->num_rings; i++) {
>  		struct k3_nav_ring *ring = &ringacc->rings[i];
>  
> +		ring->cfg = base_cfg + KNAV_RINGACC_CFG_REGS_STEP * i;
>  		ring->rt = base_rt + K3_DMARING_RING_RT_REGS_STEP * i;
>  		ring->parent = ringacc;
>  		ring->ring_id = i;

-- 
cheers,
-roger
