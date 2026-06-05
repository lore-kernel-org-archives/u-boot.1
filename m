Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFFECD6E5D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 10:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F367B84879;
	Fri,  5 Jun 2026 12:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bAOb7f9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5335848BC; Fri,  5 Jun 2026 12:31:22 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE8268486D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 12:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49068493267so13024835e9.1
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780655478; x=1781260278; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U37IwVJsIVQS31OiD0vY3X6W2M1K5SRPDcdX8bWl264=;
 b=bAOb7f9iZzEnxirU5xn6bISNojxDHCw4PmwlKJY6gOQ+ijw39LGs4b8OHeJ20j7isl
 QNJXNhaVG/5+6aA/UuqRNOFEEyqyZ2/eIdNlceu9n6G+zZEwzYI7z2IKi6fTwXX0IvRw
 PW4bJbjSCofa7l8iEY6TkzTOzXFr50HpqQy+BxllUVp3Vf45CIIUot719ZWrowVjsShF
 0DWl+HhyVERw7GNh/ZGRbSYd6+Rgsnu+5shivAiJ2nV+7yVVke0dO8naJBsrxPM1Zl3u
 ugl23XbiOGJvx9gzPvQza7pHDuvij5PrQe3/zcgPu1qL3stolO5rqjQSrZaCeTdSQws6
 9/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780655478; x=1781260278;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U37IwVJsIVQS31OiD0vY3X6W2M1K5SRPDcdX8bWl264=;
 b=MlZaquw8EW43Tackipyj3uMHkjBpZsB7iIJNmaEbaX/yY4IGrkJFIlWbfyfcytSx3o
 /C44llmObMH0sH0EbIW00GIYrTZU+AbCxgVEGOvnbmUo1qYp0GBJ8AG7QXVZCDgyEueS
 /+zUWbSMf/Ki3SXMdwqZ2DKRnGMvN1L7B/LQwRLSmrEFsNrYl1dINxRuYxif6xug5aBr
 MccYPG85OG2AgLYmlubrFrKnm99GJnvfLp8NNEmQ1QZA2NP9j6Y5g7qAd/g98ty0aJL/
 vIt6ghTLwD+13BZqaYF6JFEbaBtWg35Bkof6g0/V4uV2glZn/WBoES5vysIK1K6U7P8n
 qjnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ89PrvSQuDihdP1/F84F6i2qHI1znS3NBN4twmG83v4sZKh5e+wLn9vIDA/SICRraRMlYnF43I=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+lDO5NfMbASeE1wOYnCFmT8EWFMCZt8fYvlsxpBzeZFKkOtX1
 SIGRe+hAI8cX8XSXj+WMcPwMwPVdj6azej7d9yfER5pUdo3rVvz9BsSRDU5yrvEjmVQ=
X-Gm-Gg: Acq92OE61voqoIR5c2gvmho3YkXfpswLk24OkkwWIY8wt+FeTBVYWHAsZfBTt3R0M8M
 ge6qoUnHQRvu9QsbtvYwLSEXGX//UUjRaTpkfrXI+NPabUJhbByTDNxIZrdH5sNi4cukEkxMNA3
 HQ/tsLbwtZ21d8lhdeFqM4UCzRbOvYdxMHU9i957hQNAgFpnZJNowdgjEBbN4niI3AoVU63zP8t
 CNa2VqwxDjJNyrMHZ9K+/ZryaR/96AUkYOwIEA7+FpGtdbQCdpa6keYnM5KzMKX16dhhP044wAw
 HQxTwCjLfgWLhqD0brwZI6TafgXK2b2M757tlMQT0OGNoB6iArMg2NTslW9LMPlJQN7ZE6Uppa4
 c5Y1ShGbunteh4GX3ZXt6Csx/nm1ML+aOBXlq9CbWzYrE3LhONljV8KsE6We5igv1P4eW14xVsv
 6jv+81764lqYWJ+sveKJY7+FSdYCFr4L1VR+sORBAxqbBWXvul0bOV1FAN4tXi20lJ0WbByyJKS
 i31LY3GghmVLsn1wTvIXxaW1RiNQAuyD9tLo34TT2pDcc2Ss1oGoPsZ50rsD4LzkDSTiv0QuF4H
 y2M/JvUGfeVS8GLxYqMNYEpVunlsKFvLwO7grYnxt5bxp5tMab35ADU4f3xZw6NELNxWLM5YyTJ
 ZrPrWBhay7FXWWp43R/1JCoh6VkzdQspdaZlrP9KPAoTikIJL4kYYjC+fI/1ssxwwzQk5LCHP1D
 Ft0cjAylMJ52xQF7O+8ZTG0ndHcGQLuybSxuVHZ8Jz95wFjVIi1AipIoxmjcfEnYJ8WLFIVvw95
 kBFAmDzQlHgy070Y2Y8z2z6seA1he9EDYIlSGSJpINpC8bX9lzgrA==
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1ec with SMTP id
 5b1f17b1804b1-490c260f3cdmr41580475e9.27.1780655478145; 
 Fri, 05 Jun 2026 03:31:18 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fd502sm141617005e9.11.2026.06.05.03.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 03:31:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 13:31:16 +0300
Message-Id: <DJ11OP03ERX3.OQJE3XQ1QJ3F@linaro.org>
Subject: Re: PATCH mmc: sunxi: fix MACH_SUN9I typo in get_mclk_offset()
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Omar Ivan Fardjoume" <ivan.fardjoume@gmail.com>,
 <andre.przywara@arm.com>, <u-boot@lists.denx.de>
Cc: "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>
X-Mailer: aerc 0.21.0
References: <CAM+fx6Ny0ncWr=6nxTWpy_VpaRj-R4pkU_fNcVEdK-B35O4GSg@mail.gmail.com>
In-Reply-To: <CAM+fx6Ny0ncWr=6nxTWpy_VpaRj-R4pkU_fNcVEdK-B35O4GSg@mail.gmail.com>
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

Andre,
this has been assigned to me by mistake in patchwork.

I guess Tom can pick it up directly after the reviews etc?

Thanks
/Ilias
On Wed May 27, 2026 at 12:28 AM EEST, Omar Ivan Fardjoume wrote:
> Hi, first thanks for everything you do.
> I was working on reviving a cubieboard4 a80 board and I found and fix
> two issues that prevented eMMC from working on sun9i-A80 boards:
> 1. The get_mclk_offset() function used the non-existent Kconfig symbol
>    CONFIG_MACH_SUN9I_A80 instead of CONFIG_MACH_SUN9I, causing the
>    MMC2 clock register to be written at 0x06000090 instead of
>    0x06000418. This corrupted the CMD2 response and made eMMC
>    completely unresponsive.
> 2. The legacy (SPL) sunxi_mmc_init() did not include CONFIG_MACH_SUN9I
>    in the 8-bit bus width condition, so MMC2 (eMMC) would only use
>    4-bit mode in the SPL, which is insufficient for reliable boot.
> Tested on a Cubieboard4 A80: with both fixes, SPL loads U-Boot proper
> and boots Debian 12 from eMMC with no SD card present.
> Signed-off-by: Omar Ivan Fardjoume <ivan.fardjoume@email.com>
> ---
>  drivers/mmc/sunxi_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index 4c5fbf8960f..3d5e7c1a234 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -546,7 +546,7 @@ struct mmc *sunxi_mmc_init(int sdc_no)
>   cfg->voltages =3D MMC_VDD_32_33 | MMC_VDD_33_34;
>   cfg->host_caps =3D MMC_MODE_4BIT;
>
> - if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I) ||
> + if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I)
> || IS_ENABLED(CONFIG_MACH_SUN9I) ||
>       IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
> IS_ENABLED(CONFIG_MACH_SUN55I_A523)) &&
>       (sdc_no =3D=3D 2))
>   cfg->host_caps =3D MMC_MODE_8BIT;
> @@ -663,7 +663,7 @@ static const struct dm_mmc_ops sunxi_mmc_ops =3D {
>
>  static unsigned get_mclk_offset(void)
>  {
> - if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
> + if (IS_ENABLED(CONFIG_MACH_SUN9I))
>   return 0x410;
>
>   if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCA=
T2))

