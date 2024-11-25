Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED749D58D69
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49B2989559;
	Mon, 25 Nov 2024 18:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ri8xPTZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62D789A1C; Mon, 25 Nov 2024 18:13:03 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2090895A0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53de035ea13so1572630e87.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732554781; x=1733159581; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mAeXDEtmKQtx/Y4UDIV53sYZdZn3U0huEcR0YJ+ZS28=;
 b=Ri8xPTZdPmhIKZOS+eAsozYP7lZ4eBKSNHiAZv8bXhdURxVrWWr2OeleG2kRgCG8ku
 /0DHaOq4xAS+edC/pnx5sFnEQ0HJjfqCuXiveWZ9GhdDpLB2z2CiHq5pJGbIbgkZ3SyN
 410xlrb0cgkhGgKpxZfq7Ttxy2JbHf/AGy6iQYrpLPYvscicAb8nmzsUeRuN1ix4q/Qo
 yAWgZFwHso3+xIWGGBdkbamX5CynIZpbjXMlE0weIxlObUV7fIop1WQv4EDdk45M8mQy
 ZS/d96Adjh3VNjxndeutdDXA8RZcQioG1j3xLYBKnVCwNUt1l4VV4+XWZ3iCPlDOxWQs
 hbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732554781; x=1733159581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAeXDEtmKQtx/Y4UDIV53sYZdZn3U0huEcR0YJ+ZS28=;
 b=tvQIATJUfGcvSGhQVSBLEbEZEFsl+NUilgLUeTvUOSdTMq7mnSgIpZe1HBzxEst9VM
 LqQw5EdxT2Xk4N3VlOPGrP6ZwCpCs3AJuMb4daY45te836LrLDmuBfwr3biwFzN1X16I
 WXchv8m+yvOY1rWgaJSroXlQoQqL3YFez1G42fnr3wYe1RwR/06HwDEDciTPMMn8jOiT
 4v5/4yCciW2DcDRROD+XDbFKJ8dsUkTcD8741feTBAX8AFoXL0nHoIpaa5v6jI9+ADTQ
 /fzRRCjytlTv36jKO9OmulWTfXTsbRuYttv6NwHuTAf0nIpOoswEqEzEMWbePr0SdY/u
 DsGg==
X-Gm-Message-State: AOJu0Yx9l5f+Vb8OkhNM0Jr/Xs6P9Jh+pcsHK0leGJV3BIfA8/q7286C
 4MSwBv/Hy1b4Hymo3GOTzBMCKZj3xYPo8Mag2/6xdhWURUiaaVXEQkc6zzM7ess=
X-Gm-Gg: ASbGnctOwx4gncI/9hR8wvibr4CN8foKymFFb5pK88CSsqUveA/42JRRo/TSxD2jp3W
 2MulJJr7WAhkQJ5oWB1Y/HGA7lHarEuQtB5hnMxCXHpLM43ZJfpRwVAEDTOBTSrHq0P9Uy6iBzn
 DgaKieM0V5jrtw2KxdaJiVOciHjjew9BEX10sA/3o+mYfYXaL8Mjh0gzfgOE8I2fxOKsdHkckYD
 CfwEUPs+yaKNRvX3oJGf4oi1aZ7hqFzv4OIZqaIfRj901RzlPnTxyDZBWT5yPoYfCQzboE=
X-Google-Smtp-Source: AGHT+IHuzXZYgEVkiHc8pPii1U1lAtzWC9yNEkd5ZTPK1Mmo1iAWbODiXGzFnZrgyXap1XfiFmVpKw==
X-Received: by 2002:a05:6512:e83:b0:53d:df26:b782 with SMTP id
 2adb3069b0e04-53ddf26b7cbmr3107640e87.31.1732554780990; 
 Mon, 25 Nov 2024 09:13:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fcff017sm10919419f8f.108.2024.11.25.09.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:13:00 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Nov 2024 18:12:57 +0100
Subject: [PATCH 2/2] configs: qcom_defconfig: enable RNG driver and command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-topic-sm8x50-rng-v1-2-52b72821c3e9@linaro.org>
References: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
In-Reply-To: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
To: Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=886;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vJUMWPzm73V7xONpa/LBdHLuHJz/FIZN+BIAep3WR6k=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRLAaNHxCmx/v8Pl5nXeZALJ1WZOxv71MInIy+lQC
 TNPnw42JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0SwGgAKCRB33NvayMhJ0SexEA
 CcHpaURqF6VWqarEPsbUenYGAPA+EK1GJJxDPS89BXo8M7LPeQtqlqfNWI9zpb0UTJSFk86YFXBN28
 Lx1vcCWEIDbK1IYOwqiSiqFJ3EM9c2/T9MRLpnDrmutnggmm6FmskGzIpHoipQlRk86dohcKQh0t6F
 RzVhGuMkYx+MtpIDh9M3yAWp3AW4inPjFs/2AQLDgTHyrxpsre9yegjRimNR2IRsmnqmVTdBEzx7jK
 EMR2z8mnrwWhdVlQ3ydd7pWikZRf+jA1ns0vTYPvbLa05GmtTwMrYqXCktctv6b3WGNivBCVPm1cML
 LCxtnYEMqBsgYuRg87oPLfCpBpLkp5n2TqVwO8kbThW5adLAMahNrioBYHkqhHtmuBZ+SGw0Rlj/7i
 z81E0xlPxUilVo2OwDI5gG+yR+CBY6A8saw7ZBqQXGJrKq3WXK3rtdc5thqS/uoEExYzcBNskC8XtE
 ignOld9UNJBqXKhrt0TmSS+qvafi/bHrQpQz8e5aSoYUMixeic5Re0PIpNEu2dssf5/KlLyuJECGrp
 yKQkCykE0eHIKO8kuwI62BaB26jVdpfRTKWNqbbk/w2caqdD1Xhls5qpHCZTWHRv8GO8ZTOLjEOVqD
 Cnnj0OkWvv2VZSh7AC7SvSUWdRdEzj5HxhRcnt6galN9n7N1PahrLxQvhD+A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Enable the MSM RNG driver by default with the associated
command, this will fill KASLR seed when booting Linux.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ea0dd3e58018c8bf08e4a455a47e29cf1bbd3c60..fa631ea4976a2c38494832b196c60fd127288cc4 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -34,6 +34,7 @@ CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
+CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
@@ -96,6 +97,8 @@ CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_QCOM_RPMH=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_MSM=y
 CONFIG_SCSI=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y

-- 
2.34.1

