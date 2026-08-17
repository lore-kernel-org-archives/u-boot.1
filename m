Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC08C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 16:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFE51407AF;
	Mon, 17 Aug 2026 16:15:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ezoWGK63r7Aa; Mon, 17 Aug 2026 16:15:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E0AF40756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786983326;
	bh=eDuJNA0wlmHPqhuGhMJ4fgN4ptRobP/6Ihpe+icRQuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O+8Op1dzNdiC/9fVoKUCh5H3kCwMxFKmqfw4F1kSRjoMrZqYBDW74jx78nSZ0RLg4
	 t5nS3YihDXu67LpKiOyT15v4k9w11wr5F4/hOyIkeWpYYp02jGoGqMjYCd4Ps6GGLf
	 b6jmRPzBGLoSJ6tFrJqo5dgD7hmuS7QPooYLg92puoNZ013XwRqOfO0kj4w02FzpfF
	 qTre1EN+vv5V1mLv3F51Y2ajx41NkgjDm3JX2I/S0+Ze5JrLX28B0v6rdWX8B2SljD
	 Hbn/YxpfDeg3hu6W6+ggirsaVqi5aAFvI/PcNVYIywindRBpDer2yAPlkmr3olRU+m
	 yr6B7FFy++nCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E0AF40756;
	Mon, 17 Aug 2026 16:15:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 14783337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06797607AF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:15:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M9VGN6Ru1OQD for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:15:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EC69960790
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC69960790
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FHMSAFnR
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC69960790
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:15:23 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so671425e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786983322; x=1787588122;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eDuJNA0wlmHPqhuGhMJ4fgN4ptRobP/6Ihpe+icRQuA=;
 b=FHMSAFnR0R262l8SFG4/3v0SUFmheMP6Gys5P4K7aG+72ns/6nu5HMpTjSd68N2NXp
 Atzd7lg6wlnRq4MnAuu2uwlEIat2jEfTJWbV6aMQtPHurzqTjXx5AQjr9fI4naZHD5qL
 RaJohytC/uu92s2IrZR0pZhDG9yY94NLMWb1udPtILe+bQRXHsNuNJKqRTGNxRasePZQ
 NpSODzoEFhl31vOTruEE4Mj91c4XeF9Svpsc3ooGwEJlZATSrFe+NCNBgry7VYngOENU
 t1fR6EI8YT0VFFiG3keZeEJMHTBu5jZbiPQwTIVwMLOaY0LFtJHw+m3v74M41uNYDEm4
 FSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786983322; x=1787588122;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eDuJNA0wlmHPqhuGhMJ4fgN4ptRobP/6Ihpe+icRQuA=;
 b=pPRV+IVeYAwS/2vL24Ce0ShozLPXh0MpDl44gGE0FU8vn1J1vCHapn3lweQElaLIKw
 LWnjrix2wSldClXy/de8Hb+A6MmvIDozJ7iz3juyjhi+HNXvfxzgQalAxRofMZ9GO5mQ
 mv19lGaD+lmw7HXl45Jk8HTjDE36h8E6/OyAX1+JqiSZVkeKjZT6t2PEslUwD6lqVTu8
 t1ifJYlZq3JjnmLipUHyTjmdeLHd/byamcVgAbCszbqTV4RS3A6bLbhUrrcj1tKhdLXX
 wpVo29+tkvUpCchz0FZhfWDXZ2wsqLP+u7yUnlbG3amNToxf6Q9wiEgjlJ312SMztZaD
 1ccw==
X-Gm-Message-State: AOJu0Yz+EMNKglhG2ubAOujLKAabpPIFVurB1hTk81GJGzQ0AFQpdIwP
 fU0wXl/BTvffclo0w2dU1y2hj+rc6Njyj+KY6t7jEe8ZoyyJEZAGYiITgt2cxggNJ9w=
X-Gm-Gg: AR+sD11WIB1uHL0RZxXbigAfcWO0QABhQXlk/NOCB4yuz9mfsi3esMaFCK+CPcQRFvJ
 ABqn+3IMR7fHGr8zx++sxCecdbeKmzL1foFDQYtQMrWkefldm7JtrGZlVWCJym1dVTPEB4i08jk
 Fq0Ok4fayACAJULupuu1dkaEclQscnrQ4w+xYMYEKsqf4Vi1UPXzOxeZF+Au9aPM0Vs7dmnbm/p
 iOWAdl8j0Zk5oC2R0ifBcs04hGEvHjk4icAO/gATvRy/VpIblSO1byox2ZuV8VZ52IiRCL5TqJ1
 XfSLFn8ENiDhrPK3kAn9cG4mv2fXaDyE9LWPYsDwcASx6Rw4YhWIXhTHmHvDcNhBzji+TL6j3rk
 kkQeW3w2QzbIm15FD/Ub5UB5voo9NJDATW3kWBBMkDWrzPuYUk8LzTPtjkYl1qB0e6iU0H4rMZI
 ZpzNICr3zc6CFxL9Jl4SyKbUagXN91iBsQoxANq+JakQdZubL+sCHwOeNiwV54q5spe/WLnqt6
X-Received: by 2002:a05:600c:3f0e:b0:499:90d0:4906 with SMTP id
 5b1f17b1804b1-499a08b9461mr5124125e9.5.1786983321565; 
 Mon, 17 Aug 2026 09:15:21 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:ee4a:c814:cb38:c5b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0876b8sm74677605e9.8.2026.08.17.09.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:15:21 -0700 (PDT)
Date: Mon, 17 Aug 2026 18:15:19 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v2 3/8] mmc: arm_pl180: Set initial supply voltages
Message-ID: <aoMzl111991B-VLV@linaro.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-3-ca9a110bd9c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-ux500-external-sdcard-v2-3-ca9a110bd9c6@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, Aug 17, 2026 at 11:31:52AM +0200, Linus Walleij wrote:
> Obtain the optional vmmc and vqmmc regulators and configure them for
> the normal SD voltage range before card initialization.
> 
> The Ux500 boards supply their SD cards from AB8500 or AB8505 AUX3,
> whose highest voltage selector is 2.91 V. Request that exact voltage
> for the Ux500 MMCI variant while retaining the normal 3.3 V target for
> other PL180 implementations.
> 
> Ignore the unsupported set-value operation for fixed regulators; their
> voltage is already described by their fixed constraints.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/mmc/arm_pl180_mmci.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
> index af21b814641e..654608b7e74c 100644
> --- a/drivers/mmc/arm_pl180_mmci.c
> +++ b/drivers/mmc/arm_pl180_mmci.c
> @@ -16,6 +16,7 @@
>  #include <log.h>
>  #include <malloc.h>
>  #include <mmc.h>
> +#include <power/regulator.h>
>  #include <dm/device_compat.h>
>  #include <dm.h>
>  
> @@ -28,11 +29,22 @@
>  #define MMC_CLOCK_MAX	48000000
>  #define MMC_CLOCK_MIN	400000
>  
> +#define SD_VOLTAGE_MIN_UV	2700000
> +#define SD_VOLTAGE_UV		3300000
> +#define SD_VOLTAGE_MAX_UV	3600000
> +#define UX500_SD_VOLTAGE_UV	2910000
> +
>  struct arm_pl180_mmc_plat {
>  	struct mmc_config cfg;
>  	struct mmc mmc;
>  };
>  
> +static int arm_pl180_set_supply_voltage(struct udevice *supply, int target_uV)
> +{
> +	return regulator_set_value_clamp(supply, SD_VOLTAGE_MIN_UV,
> +					 target_uV, SD_VOLTAGE_MAX_UV);
> +}
> +
>  static int wait_for_command_end(struct mmc *dev, struct mmc_cmd *cmd)
>  {
>  	u32 hoststatus, statusmask;
> @@ -385,6 +397,7 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
>  	struct pl180_mmc_host *host = dev_get_priv(dev);
>  	struct mmc_config *cfg = &pdata->cfg;
>  	struct clk clk;
> +	int supply_uV = SD_VOLTAGE_UV;
>  	u32 periphid;
>  	int ret;
>  
> @@ -422,6 +435,7 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
>  		cfg->voltages = VOLTAGE_WINDOW_MMC;
>  		cfg->f_min = host->clock_in / (2 + SDI_CLKCR_CLKDIV_INIT_V2);
>  		host->version2 = true;
> +		supply_uV = UX500_SD_VOLTAGE_UV;
>  		break;

Do we need to differentiate between MMC and SD here and for the voltage
below? There seems to be the magic number VOLTAGE_WINDOW_MMC /
VOLTAGE_WINDOW_SD here, which I have set to MMC in the Ux500 case above.
The other platforms have it set to VOLTAGE_WINDOW_SD...

If I'm reading this correctly this voltage is sent to the card to let
it pick the preferred voltage, but it doesn't look like U-Boot is
designed to act on that signal...

Thanks,
Stephan
