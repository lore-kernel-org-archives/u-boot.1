Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B438606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gJe2Mehj;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ySx+5V7j
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F4804059C;
	Mon, 23 Nov 2026 15:05:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EfvUvq6lMVID; Mon, 23 Nov 2026 15:05:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E7EAC405A4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795446319;
	b=KiW5FJNhG5QLmD5mdIKNhSJWvdKp3kdCoqn+gmMKZ683eObtHkqp4fcBET7OdCHGlDWI
	 wjmf9MdRO0wTI+g3KGJkkGEakL/TigrYDIqEdfDLFrEYZ+f6oPEUn19Tr19EFO9kyqO+Z
	 9ezfgrWv6bjRb793sn0Duu5Awk1DSwuoUfZrPW+PoZsEQwBVRDkoclI5Qd9vcpsNnLziH
	 sXdnQz8HUdtImA+uf2bdz512aL8aw05CXWmdw+Cs5SkO9ZmLy0+c/oh8R2p/rolX/lwxy
	 AErhllh+lAGoADmMQbjCSkhNpqpruSxpMNmxTQqA5NyrCAXoEtrDjaJoZBTOa436zfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795446319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oOZnWnfjyK9rl2o6AR28X00yOLDGrJUDMljmh0fe5GM=;
	b=hpmUou/2hp3cW5PBTYy5Q10id6PIvZoZwzvGkItOgeZF0sYGFSMgf/hg0JEVsR2uoN6v
	 MtazTic4M3mp+wS64I3wME41XVwqGpIoW5K4cFWBrraw6cUPTX+/93pBm3ge2DEMI0J2b
	 T0TtxCjkjk7dUIKm9/VWasgerz6Whg3KrgANY/elPNvcCEF4rW5eCkC0nUXtE8D/pDgwE
	 yye1AY4bxJqab6l7dFbaxo/iPUvV09aqlDTUJlzEx9R0eKUAoKtP9h+Viqh1xTZzeTHiR
	 iglkEm+G8+VDIFknJlHKz3LOyw/kd00nMVp9hBvATD/V68rdKkvuqpNfOOwbu2NWd7Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795446319;
	bh=oOZnWnfjyK9rl2o6AR28X00yOLDGrJUDMljmh0fe5GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gJe2Mehjd7Ns9S6vI2Z3RJefvi/zD1n0c1n9RyC1Gu5H0VSgbHvaCa038Cc9E7jAQ
	 CYITNic0sp985O49L6MubraOq/4zgOQ1L03Jbw+wUe+/f58WZPyPdK4uiiih6t9ItK
	 KrFnoWo3vRGyjw/ev+YohlOee3DhnXPQz1i+H9NKGO5R/A9i2+pBn6KF7QhOJRm/rK
	 nsKFTieXudX9ZOVOYtx5Pgi1g6VCrvZ31o5Me3CzPUMHDST4yIP3SmWMGqtlpXv1Q/
	 HLF1RuLTE6FQM1WukgYcFf8z1yiwixFf9KflHpcbHlNTRFTdtrhSb8UdQh/A7izIUM
	 jO9UxY5x5CTXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7EAC405A4;
	Mon, 23 Nov 2026 15:05:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 01DA822B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E80416071F
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:05:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndnqZYF6LKk7 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:05:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5917C60712
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ySx+5V7j
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5917C60712
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:05:15 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4acb44dcd7bso2810121f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 07:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795446314; x=1796051114;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oOZnWnfjyK9rl2o6AR28X00yOLDGrJUDMljmh0fe5GM=;
 b=ySx+5V7jYLvmNKnzKp9bN+1OR5ax7lMc2NQ3HVxwIwJZfszpLxZFUo0kjrbwFZtHyA
 +bRmv0nZ99wl9d+5oiv9TTgbOwmGZUfRLgTnRjCRAydGkaj2dqEBIgSf3lzwfI2zKOdX
 5JbBkoqIscFIySAG4o+dKOjIstJjbCIMsY5GIsTH4vQHQlxcQbHR2veVMZTuPk+Xn939
 8DXfeaxwsa0/NY9Tjtl+o+mlq+Yrk4TvuTvnNSZOtZnfBlZsmLTEUjJ/zAeVGLBVVPUX
 3dJljl4qdua/emY/+XXK8sroS6v9FUfQLea7LSyNNQ3J/041D20wpMBODWGdUE115ljT
 Rt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795446314; x=1796051114;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oOZnWnfjyK9rl2o6AR28X00yOLDGrJUDMljmh0fe5GM=;
 b=U7jyUqLaRwbMCswibjQIYNqKKOwpcV45kGY5GuWYqFNf9EENxwHhCuhyxBh0yW0fGq
 Fa0CmjboIKOZ+vr8iHIs70x3y5E+0ig3Sk0LiZGJyaiAISf9V4C6LO2xEFlpHzesiNfl
 Kx4XLlu2Y+rV8dckpMJIOz3nyzIZv53U55E0UBj/dwO7LLlqIIJMs3wgSizWEclNz737
 8Tln3G+67ver20JoZqBH0iS3pUYiIIILyga0em4xxGQO8Xh8UAdR7lErzzu82MgsG7Jk
 2AEzn/hiEU9fue3HfseXAw11R1t/eGNC8JdgRQJ6VaR6MItgDGxpuuxxtDvCoftX5+CT
 SgYg==
X-Forwarded-Encrypted: i=1;
 AL+hErHR963ZJomKXOfjBlU7nyP28up7GgYgIWlYFfLuLwKY7NkcnwotZRjwaGvY4lK0yOYtxJkKJ78=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+G71joO62Dwl+rakcmUsuZ1WJPdFmBV21X2soyLqKJG7rRvaIl
 KiG9YLcWOAMY9mws+/yG+hB9/Rv4BgkkpKwlU4XL54cJSkjDC8CFKIhfd3noCR5GmDE=
X-Gm-Gg: AZFdTZem+2lqLsKJYDaerExppAxgoeh8yhD73BzPQsPd9agEN8Ahv5SFXzo3/7rGzO4
 iaqvyOs5z7odr+PT0YqoqzoUTfYa/vnuYG5bN5y0osVNA5pLIYSJgm7DKjGZ5ye53dwiWDI4lEH
 PiIYXFryXh1U2/z0P9czzjpS0ChMkn6GzEz/+QHoAZzDvmB/yZ+USfMOybyNhvWVwe+4uWTHNpW
 kWe2Ev23IFeL5cExXZfWTyGqXD4q4oD70PkqZyEF72WW7TYpu7FdhMGQ7L2Ci2DyDgxxoK0vDk1
 RgD0/0XhPZx4wrNQIZE/wTyDU29mCtS3Oy4zfPVLT/dAW+XEWr64Pt5qiLwhE2kx3HxOoktw9PT
 llbZr0f9A/kOHqtub+5qdlxzrRatNCA9lW+Hq1mGWb1ptSp8XxoN8qxmlJFk0Gb55s+Gsprh/iu
 N69eSqwxdGp+/FTHL1hZ/NLmGLorTu9xvZLFr+LVdArq1HlWQqDGFnPk2IggYGzgzuCTzk5uiOA
 J4JgN1zSPum6MYGEE6arn3HUnuE/eyKdqJKfMd67I66+gDCyR7DRZI+d7kwT3b+ucWJYZrT14jX
 I8IH08cpJZGGvNyN7mj0Y/AaVfrqmBufoza9gLAU
X-Received: by 2002:a05:6000:4b03:b0:48d:ff71:dd9d with SMTP id
 ffacd0b85a97d-4abb2ce4d3dmr24125083f8f.23.1795446313464; 
 Mon, 23 Nov 2026 07:05:13 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff25:4f10:13e5:52ff:a219:e96b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm25732484f8f.24.2026.11.23.07.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:05:12 -0800 (PST)
Date: Mon, 23 Nov 2026 16:05:06 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 nathbappai@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 2/4] mmc: msm_sdhci: add CM_DLL init and HS200 tuning
 support
Message-ID: <awRWIvN0mcOa6p_b@linaro.org>
References: <20261110114520.229480-1-aswin.murugan@oss.qualcomm.com>
 <20261110114520.229480-3-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110114520.229480-3-aswin.murugan@oss.qualcomm.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 05:15:18PM +0530, Aswin Murugan wrote:
> Add the CM_DLL (delay-locked loop) initialization sequence and wire up
> platform_execute_tuning so the driver can perform HS200 tuning. The
> 14LPP DLL reset and Tassadar DLL variants are selected based on the
> SDCC core version, and an optional qcom,dll-config DT property can
> override the computed DLL configuration.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  drivers/mmc/msm_sdhci.c | 411 ++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/msm_sdhci.h |  45 +++++
>  2 files changed, 456 insertions(+)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index d7ae26c609c..23c06e8d15e 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> [...]
> +/*
> + * Programs the MCLK_FREQ (CMUX_SHIFT_PHASE) field. Must be set before
> + * enabling CORE_DLL_EN/CORE_CK_OUT_EN, otherwise the DLL will not lock.
> + *
> + * host->clock is not updated by the generic sdhci.c, so mmc->clock is
> + * used instead.
> + */
> +static void msm_cm_dll_set_freq(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	struct mmc *mmc = host->mmc;
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 mclk_freq = 0, config;
> +	unsigned int clock = mmc->clock;
> +
> +	if (clock <= 112000000)
> +		mclk_freq = 0;
> +	else if (clock <= 125000000)
> +		mclk_freq = 1;
> +	else if (clock <= 137000000)
> +		mclk_freq = 2;
> +	else if (clock <= 150000000)
> +		mclk_freq = 3;
> +	else if (clock <= 162000000)
> +		mclk_freq = 4;
> +	else if (clock <= 175000000)
> +		mclk_freq = 5;
> +	else if (clock <= 187000000)
> +		mclk_freq = 6;
> +	else if (clock <= 200000000)
> +		mclk_freq = 7;

I'm not sure if this is correct. At the moment, the U-Boot
implementation sets the GCC clock to the maximum possible rate in
msm_sdc_clk_init(), and then relies on the internal SDHCI dividers to
get the correct clock for the MMC card.

Linux on the other hand avoids using the internal SDHCI dividers and
changes the GCC clock rate instead.

This code path needs to pick a value depending on the input clock to the
DLL. I'm not sure if the internal SDHCI dividers are applied to the DLL
input. If not, using this function as-is may result in picking the wrong
register value in U-Boot.

It's hard to make any claims about the setup with the internal SDHCI
dividers. Given that the Linux code contains the following comment:

 * MSM controller does not use internal divider and
 * instead directly control the GCC clock as per
 * HW recommendation.

I think you should prepend a patch to set the proper GCC clock rate via
clk_set_rate() and make sure the internal SDHCI dividers are disabled.

> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~CMUX_SHIFT_PHASE_MASK;
> +	config |= mclk_freq << CMUX_SHIFT_PHASE_SHIFT;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +}
> +
> [...]
> +/* CM_DLL initialization sequence */
> +static int msm_init_cm_dll(struct sdhci_host *host)
> +{
> +	struct udevice *dev = host->mmc->dev;
> +	struct msm_sdhc *priv = dev_get_priv(dev);
> +	const struct msm_sdhc_variant_info *var_info =
> +		(void *)dev_get_driver_data(dev);
> +	u32 config;
> +	int ret;
> +
> +	/*
> +	 * Keep the clock enabled while DLL tuning is in progress; PWRSAVE
> +	 * may otherwise turn it off.
> +	 */
> +	config = readl(host->ioaddr + var_info->core_vendor_spec);
> +	config &= ~CORE_CLK_PWRSAVE;
> +	writel(config, host->ioaddr + var_info->core_vendor_spec);
> +
> +	if (priv->dll_config)
> +		writel(priv->dll_config, host->ioaddr + var_info->core_dll_config);
> +
> +	if (priv->use_14lpp_dll_reset) {
> +		config = readl(host->ioaddr + var_info->core_dll_config);
> +		config &= ~CORE_CK_OUT_EN;
> +		writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +		if (var_info->core_dll_config_2) {
> +			config = readl(host->ioaddr + var_info->core_dll_config_2);
> +			config |= CORE_DLL_CLOCK_DISABLE;
> +			writel(config, host->ioaddr + var_info->core_dll_config_2);
> +		}
> +	}
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_DLL_RST;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_DLL_PDN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	/*
> +	 * MCLK_FREQ must be programmed while the DLL is reset and powered
> +	 * down, unless a DT dll-config override is in effect.
> +	 */
> +	if (!priv->dll_config)
> +		msm_cm_dll_set_freq(host);

CORE_FLL_CYCLE_CNT part is missing here for the
priv->use_14lpp_dll_reset case, which is strange because this seems to
be pretty much an exact copy of the Linux source code otherwise.

Did you omit it on purpose?

> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~CORE_DLL_RST;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config &= ~CORE_DLL_PDN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	if (priv->use_14lpp_dll_reset) {
> +		if (!priv->dll_config)
> +			msm_cm_dll_set_freq(host);
> +
> +		if (var_info->core_dll_config_2) {
> +			config = readl(host->ioaddr + var_info->core_dll_config_2);
> +			config &= ~CORE_DLL_CLOCK_DISABLE;
> +			writel(config, host->ioaddr + var_info->core_dll_config_2);
> +		}
> +	}
> +
> +	/* Applicable to SDCC v5.1 onwards only */
> +	if (priv->uses_tassadar_dll && var_info->core_dll_usr_ctl) {
> +		config = DLL_USR_CTL_POR_VAL | FINE_TUNE_MODE_EN |
> +			 ENABLE_DLL_LOCK_STATUS | BIAS_OK_SIGNAL;
> +		writel(config, host->ioaddr + var_info->core_dll_usr_ctl);
> +
> +		if (var_info->core_dll_config_3) {

These extra checks feel redundant. I wouldn't expect a v4 that lacks
this to have priv->uses_tassadar_dll set.

> +			config = readl(host->ioaddr + var_info->core_dll_config_3);
> +			config &= ~0xFF;
> +			if (host->mmc->clock < 150000000)

Linux checks msm_host->clk_rate here, which is not the same as
host->mmc->clock (also see my comment above about the U-Boot clock
setup).

> +				config |= DLL_CONFIG_3_LOW_FREQ_VAL;
> +			else
> +				config |= DLL_CONFIG_3_HIGH_FREQ_VAL;
> +			writel(config, host->ioaddr + var_info->core_dll_config_3);
> +		}
> +	}
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_DLL_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CK_OUT_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);
> +
> +	ret = msm_dll_poll_lock_status(host);
> +	if (ret)
> +		return ret;
> +
> +	config = readl(host->ioaddr + var_info->core_dll_config);
> +	config |= CORE_CDR_EN;
> +	config &= ~CORE_CDR_EXT_EN;
> +	writel(config, host->ioaddr + var_info->core_dll_config);

I think you need to clear this again later somewhere for write commands,
see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a89e7bcb18081c611eb6cf50edd440fa4983a71a

> +
> +	priv->calibration_done = false;
> +
> +	return 0;
> +}
> +
> +static int msm_find_most_appropriate_phase(struct sdhci_host *host,
> +					   u8 *phase_table,
> +					   u8 total_phases)
> +{
> +	int ret;
> +	u8 ranges[MAX_PHASES][MAX_PHASES] = { {0}, {0} };
> +	u8 phases_per_row[MAX_PHASES] = { 0 };
> +	int row_index = 0, col_index = 0, selected_row_index = 0;
> +	int i, longest_range_len = 0;
> +	bool found = false;
> +
> +	if (!total_phases || total_phases > MAX_PHASES) {
> +		printf("%s: Invalid argument: total_phases=%d\n",
> +		       host->name, total_phases);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < total_phases; i++) {
> +		ranges[row_index][col_index] = phase_table[i];
> +		phases_per_row[row_index] += 1;
> +		col_index++;
> +
> +		if ((i + 1) == total_phases)
> +			continue;
> +
> +		if (phase_table[i] + 1 != phase_table[i + 1]) {
> +			row_index++;
> +			col_index = 0;
> +		}
> +	}
> +
> +	if (row_index == 0) {
> +		ret = phase_table[total_phases / 2];
> +		goto exit;
> +	}
> +
> +	for (i = 0; i <= row_index; i++) {
> +		if (phases_per_row[i] > longest_range_len) {
> +			longest_range_len = phases_per_row[i];
> +			selected_row_index = i;
> +			found = true;
> +		}
> +	}
> +
> +	if (found) {
> +		ret = ranges[selected_row_index][longest_range_len / 2];
> +	} else {
> +		ret = -EIO;
> +		printf("%s: Failed to find a valid phase\n", host->name);
> +	}
> +
> +exit:
> +	return ret;
> +}

This looks similar to the Linux implementation, but then some minor
implementation details differ and the phase selection is not the same.
Did you implement this differently on purpose?

Thanks,
Stephan
