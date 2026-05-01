Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CD8FF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 06:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC25C803C6;
	Fri,  1 May 2026 08:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gW6lX6KQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F9AB839D5; Fri,  1 May 2026 08:58:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B8FD80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 08:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D5E3A40B89;
 Fri,  1 May 2026 06:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060DBC2BCB7;
 Fri,  1 May 2026 06:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777618676;
 bh=E2cZZ3W/lx3jc6cqZTPNUf0QTl69F90TseKMAKkk8Hs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gW6lX6KQ8BKUgfNF7Y5Wn1l8yP/Uy3FysIM8T/hKHiukIizxmulzPPYVjhpvhHuKm
 8ZwULenNhboAk99xESCVwzjUTHoATqWuOMG7If42K9Vwk32ND78Y0hZQ6KKbzYMbiJ
 muFVWmWpmC0piuMQglJbmzBNjd0U43XYGB31N28xoCzaIGKE1JGEbP6OtaT1wHuaV+
 79qYl7yHmw+g9npFPZVXii2Xt6c8kXO21nsu7MTkSuC3t8Kr7r/+3pEfYTsU/r5J/u
 PyvjUwdFd5w0kNVlN2qpPtEkTkFkxm99RYBRlCmVvfXfLiLxZMp2RGSjZSgGU+HHAR
 Vpstsg4aws9uw==
Date: Fri, 1 May 2026 12:27:48 +0530
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
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Sajna <sajattack@postmarketos.org>,
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] drivers: mmc: uclass: Set removable flag based on
 device tree property
Message-ID: <afRO7KbCEm1SdG0d@sumit-xelite>
References: <20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com>
 <20260421-emmc-v2-2-0ebd3322b676@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-emmc-v2-2-0ebd3322b676@oss.qualcomm.com>
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

On Tue, Apr 21, 2026 at 06:30:09PM +0530, Balaji Selvanathan wrote:
> The block device removable flag should reflect whether the MMC
> device is physically removable (SD card) or soldered (eMMC). This
> information is specified in the device tree via the "non-removable"
> property and stored in the MMC_CAP_NONREMOVABLE capability flag.
> 
> Update the removable flag in the block device descriptor during
> controller probe to properly reflect the device's removable status.
> This allows the block layer and upper layers (particularly EFI boot
> manager) to distinguish between eMMC and SD cards for appropriate
> handling.
> 
> The default removable=1 is set in mmc_bind(), and this change
> overrides it only for non-removable devices after mmc_of_parse()
> has set the MMC_CAP_NONREMOVABLE capability from the device tree.
> 
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Moved removable flag update from generic mmc-uclass.c to platform-
>   specific msm_sdhci.c driver

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> ---
>  drivers/mmc/msm_sdhci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 66f3cf2de4f..13fd4ae8a7d 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -189,6 +189,7 @@ static int msm_sdc_probe(struct udevice *dev)
>  	struct sdhci_host *host = &prv->host;
>  	u32 core_version, core_minor, core_major;
>  	struct reset_ctl bcr_rst;
> +	struct blk_desc *bdesc;
>  	u32 caps;
>  	int ret;
>  
> @@ -252,6 +253,12 @@ static int msm_sdc_probe(struct udevice *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (plat->cfg.host_caps & MMC_CAP_NONREMOVABLE) {
> +		bdesc = mmc_get_blk_desc(&plat->mmc);
> +		if (bdesc)
> +			bdesc->removable = 0;
> +	}
> +
>  	host->mmc = &plat->mmc;
>  	host->mmc->dev = dev;
>  	host->ops = &msm_sdhci_ops;
> 
> -- 
> 2.34.1
> 
