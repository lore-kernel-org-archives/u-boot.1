Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E8EC982E6
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A98B183B0B;
	Fri, 16 Jan 2026 19:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bvwI+v3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92AC836AC; Fri, 16 Jan 2026 19:03:26 +0100 (CET)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E45F838BB
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-64d02c01865so3932668a12.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586604; x=1769191404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+xT4rdhZ+wGBwhwZHCqSij46GFrHdDERaVCPRAifLo=;
 b=bvwI+v3n0LxPQ6RVaRaMXSwgsTOToJ3sR62ImY0LdNCZpWDTWU7Asyr4kz5dEeD7wt
 ui44E9BUU6jNa582DaeY9Es0APdymFshJTUwJWFbdG7zLNtfUT42BDxxIiUcur9rCN3g
 XA8CW68m3RH9fpz1G8N77RoTcZFLFFGSQ22zLklu8VKW3P13z1TnypiTwsk9vlgN4JY+
 QEpc2TRJWg+/2QePLdsUOoBiFNbV0VnQ04Etu9O97kdn2EZ0GKsGtlzOHs9GrnqH96BI
 Kr3qmWCPLm/7AHJokW2VOp+X16Dff80+9nCieLaCgDB65AVVj2L6ggxK+qdEHTJK++tZ
 Ci+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586604; x=1769191404;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P+xT4rdhZ+wGBwhwZHCqSij46GFrHdDERaVCPRAifLo=;
 b=dUsIhuG60fO42hZHeTxNw4tMSHmcn7HztZl+1RdXx/+NZzbMGvsCimuFd27q85GbrH
 CVUqCvzYmgd1XzsDTrNwa9ClyJXSoVAhfAAXVbyjoKdr8Z85RhmTpBTPJoblHgYzHmgr
 h9DvZhwWTyQkabGC4Vnx1+cevSLIlw85mJTStS02Ig6DvWNh22lr3fDEUtJJlI6+g0vA
 ZqochIco/+gsya+c+I7yKdDwelz22JRfAo8MN31ymc8GKAlMHbyxUaAxy5E2HTCNLBZ9
 RnvxoMfykkZjt8k/7jgC8KwY+yzhqAeMVuBu6Y/yRkdPnZyBG4UrFxtsGXGLrMkB4iuE
 KO5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFEmzs6VkqNHz6Q4O3KGWS+ATt5emD+3JujYyiQKggtNwoig3W3Urv1bInZBhakiiK+/y4pGs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4tCy9sujMW/AxISkvER6LbcGIjhkTsRo+Xh/BgMsPUG2WTCzG
 W+T9Q6cMQc3kcOUBsLOXJ48zyMMF5HPbmF3bOt5HUqKqNBvHEDtmuJjJPmvtarMMMew=
X-Gm-Gg: AY/fxX5hc3uGt/8ApLLA1aGcmdxD+vkYiuuOqrxmxynm7gA07ryGFe7dFd5KZLTAUZr
 eb8juDLuyfyp0MLhQ/ePbSVkRyq012VyP9MP5z0zX8YPlT2pquL5G7uRLceoAQxxN3Ts7rAzVaI
 wO1JQ52wMiK//jaia4JNJ1XY9rJhFoynCUjvEoWe/6QCgL9fROMP9vbaAv+hZs1pHW1hkycW4/n
 40+FpWSgjs3Yiazb0uE/eaW63Rr36ksHgGdxJnNZQtqWV8HyXOBvUI81Q/MOus0m2HUpCSY4bN7
 2X2eso3p0+KJI2mQZbqnSfVq0cArbpYDUGXvO+dHHf8DRwx/FSE8uruC01t06vRmvLFH+wafusb
 HPhCNINkEEOHB0cXJb5e/F/NrRc8sCRBrljO/p8PcNPhpme0OzKhXVBn2POJTyi7uja6XbHkttq
 J2UB/V+NZm6ukKxdp7j5O4EUCCegD5+uI19D/b3NgWfph+Y52b7b+7Zg==
X-Received: by 2002:a05:6402:1d51:b0:650:883a:8896 with SMTP id
 4fb4d7f45d1cf-654bb70f670mr2630480a12.29.1768586603608; 
 Fri, 16 Jan 2026 10:03:23 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:22 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: lukma@denx.de, neil.armstrong@linaro.org, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com, 
 jh80.chung@samsung.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20251210155454.1561611-1-loic.poulain@oss.qualcomm.com>
References: <20251210155454.1561611-1-loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] mmc: msm_sdhci: Fix incorrect divider calculation
 for SDCLK
Message-Id: <176858660241.3399278.4720786409416851363.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Wed, 10 Dec 2025 16:54:52 +0100, Loic Poulain wrote:
> When 'max-clk' is not specified, the SDHCI core retrieves the base clock
> from the SDHCI_CAPABILITIES register (bits [15:8]). However, this field
> is unreliable on MSM SDHCI controllers, as noted by the Linux driver
> using the SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN flag. In addition, the field
> is only 8 bits wide and cannot represent base clocks above 255 MHz.
> 
> On platforms like Agatti/QCM2290, the firmware sets the SDHCI clock to
> 384 MHz, but the capabilities register reports 200 MHz. As a result,
> the core calculates a divider of 4, producing a 96 MHz SDCLK instead of
> the intended ~52 MHz. This overclocking can cause sporadic CRC errors
> with certain eMMC.
> 
> [...]

Applied, thanks!

[1/3] mmc: msm_sdhci: Fix incorrect divider calculation for SDCLK
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/edd1fb0c3695
[2/3] clk/qcom: qcm2290: Add SDCC1 apps clock frequency table
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3ddc67573fab
[3/3] mmc: msm_sdhci: Add DLL control hook to disable DLL below 100 MHz
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/338c4b820804

Best regards,
-- 
// Casey (she/they)


