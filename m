Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D93EBFD28
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B779683F75;
	Mon, 13 Apr 2026 11:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kUcTxPj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE38841CD; Mon, 13 Apr 2026 11:45:51 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 802EF839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F3BA3406C0;
 Mon, 13 Apr 2026 09:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7AEC116C6;
 Mon, 13 Apr 2026 09:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776073547;
 bh=gtN5KbbFVVVE8SjORMB0iLwIn6l8E09nCpjciAJM99M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kUcTxPj4/Xz4odYqi1rwVKftiQeWT1CvfhCihy16kTa9s/9r/Ti10lhx+AuweiKdy
 WzJsj9SOOh+34ePlGnkFfsmMzIizZp5d2PZuQg06Bhy5cBMhwHLCjFn/KWSs/7G6Rf
 3NAaIEqZyL9L7aHDNlEFNnmI+p2CCAyvXPEyrCZWz2PDokU6CNfB1TLwffBuNKou35
 z0TzJxVC2UugCWBIbZjGRL+bIdbMnFLW9FU9h/64RjKEppzJg5B2XnSoQYutwAYAOi
 IOUvaAmpMt9QXPD9mAyOjZm5g9wBM/DEH5exUx6LGBYTPCgJf60nooAtZ55Ifz3owB
 l1EL0WXheUTfA==
Date: Mon, 13 Apr 2026 15:15:39 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] drivers: mmc: uclass: Set removable flag based on
 device tree property
Message-ID: <ady7Q-acflFr07v-@sumit-xelite>
References: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
 <20260324-emmc_sd-v1-2-883a45538b6e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-emmc_sd-v1-2-883a45538b6e@oss.qualcomm.com>
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

On Tue, Mar 24, 2026 at 11:22:35AM +0530, Balaji Selvanathan wrote:
> The block device removable flag should reflect whether the MMC
> device is physically removable (SD card) or soldered (eMMC). This
> information is specified in the device tree via the "non-removable"
> property and stored in the MMC_CAP_NONREMOVABLE capability flag.
> 
> Update the removable flag in the block device descriptor after
> successful MMC initialization to properly reflect the device's
> removable status. This allows the block layer and upper layers to
> distinguish between eMMC and SD cards for appropriate handling.
> 
> The default removable=1 is set in mmc_bind(), and this change
> overrides it only for non-removable devices after confirming
> successful initialization.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/mmc/mmc-uclass.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 698530088fe..b218c69b494 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -507,6 +507,7 @@ static int mmc_blk_probe(struct udevice *dev)
>  	struct udevice *mmc_dev = dev_get_parent(dev);
>  	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(mmc_dev);
>  	struct mmc *mmc = upriv->mmc;
> +	struct blk_desc *bdesc = dev_get_uclass_plat(dev);
>  	int ret;
>  
>  	ret = mmc_init(mmc);
> @@ -515,6 +516,10 @@ static int mmc_blk_probe(struct udevice *dev)
>  		return ret;
>  	}
>  
> +	/* Update removable flag based on device capabilities */
> +	if (mmc->cfg->host_caps & MMC_CAP_NONREMOVABLE)
> +		bdesc->removable = 0;

Looking at other MMC drivers, this update happens in platform specific
driver. Check if this rather belongs to msm_sdhci.c.

-Sumit
