Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3D6C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3BE481F64;
	Fri, 14 Mar 2025 17:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hWIRZ7D1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D4D81F44; Fri, 14 Mar 2025 17:11:25 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 306FF81F0B
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e4d50ed90aso2931091a12.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741968683; x=1742573483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ct/wYrvgvwv8tzO9UJ45fWGO1RvlkJm/dw+6dXWmDOU=;
 b=hWIRZ7D1vGF1FlPWmQ210px9TCJfMXL80qCCOqyrVGVcp9neEEOsUYF3p/6JOIuwit
 S+YJJTpW7/MP2MoTo2R4gXbSOnnBC5fPN228IIJa7bwfkPlAY1WY82Gnl5JGWo/LUbYl
 xMRU3ViKZGA0QRbXUHabPJ1WzQab7dgXQR1o5ZCQGU5/kiNPjw7Dn48t+EnFpH2VbqRM
 5oLcBDajasXAIvXpFmb8fNjOVi/m3LpjRt5KjOjidJXiJf71tajGd9iYpHhY/P2qrdWE
 6Jv1YUQZJMNorC7TgMi//HWbH1H2zO40Xebffyi28J4b9PtvQZR32iBuKZiUXteHw4lm
 nqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968683; x=1742573483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ct/wYrvgvwv8tzO9UJ45fWGO1RvlkJm/dw+6dXWmDOU=;
 b=Xukazr+1xqaTP3FTP+3HfR4Uw66XnUmQP8YOZ+e5mG4LS+OyNxnX06L6PNr8W1RmRW
 40K9fqpvpHglTJbBwuBOXPWvWed7fu7f7BxAfwBBT0YosqDEqmXjyp5QrVxiUxoK3DvM
 W+x8HLBE4DG/0ZU62/aXVo5IFmZBlcJ1Dee8jFSMaKTDoRdF1qsibMLmyBa+sEl/Ph0f
 fKzmeBhJ7uH61SQ6C2kYNgj4gRSyaomjBow8OBfwKSdKgvZHgpugXWURmZ3VNyW4YyHF
 dBTiMJL9WPqXYAWYtu2sDpgCdSrv8UBEmdIovJsXVYmypQtFzj/3R7hRwgc22E6/IZfJ
 pP2g==
X-Gm-Message-State: AOJu0YzTcrAb8mnG3qKEIj4G95Cc/6ER8iyaswNwdOcCMj88Y5wmhB2r
 +asfMmUEMhDma5pypvLUE+o8gIwXMZ+lGfnDTCVhST8aZQBRkaRy
X-Gm-Gg: ASbGncsKHSFzutBuuixcpH9M0aPswD+VtPjQF/nB1jKB+O92t/eNSTXdd+lXFQuGnEX
 XAry8/uDvZ1YSaeataDMJPAi/YX5XaH/G1qFDZPjmDUFvgZG5odoa3Lj3mpY6xR73rSB+2z5QXv
 1+tsMPqmqn93bq3VOZG8j/aXg3oLTCYXxIGMYGBBM3DdXxLuCGt3/rAD8tE7g+Vay5sn1bryM6H
 apK/clHSXI+/5lC/xLA99g9H2Xa0LpeqVxXyQGbbUypCoeQpH4i8PhV4GY2x2jbJNu5p5k/Zpjy
 oYi7bnL+oJWciKAjYQeIUugPNMyiZYEmuefqTheJa9EUxdU=
X-Google-Smtp-Source: AGHT+IEKvrbD4O0DXc/pYiu69xS2QZinoD0LoPJPM81jC3uni1ZcD6o7GdVPaPyrNcdEDAAspR4COw==
X-Received: by 2002:a05:6402:1e88:b0:5e5:dea5:3eb2 with SMTP id
 4fb4d7f45d1cf-5e89fa27ff5mr3592050a12.11.1741968682204; 
 Fri, 14 Mar 2025 09:11:22 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e8169bcdb3sm2161904a12.43.2025.03.14.09.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:11:21 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/4] pinctrl: tegra20: fix function naming mismatches
Date: Fri, 14 Mar 2025 18:10:59 +0200
Message-ID: <20250314161100.36894-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314161100.36894-1-clamor95@gmail.com>
References: <20250314161100.36894-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The names used for displaya, displayb and i2c1 do not align with their
corresponding Linux counterparts. This inconsistency can cause pins to be
configured incorrectly, potentially breaking existing functionality.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra20/pinmux.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra20/pinmux.h b/arch/arm/include/asm/arch-tegra20/pinmux.h
index 8c8579e87e3..9598851b100 100644
--- a/arch/arm/include/asm/arch-tegra20/pinmux.h
+++ b/arch/arm/include/asm/arch-tegra20/pinmux.h
@@ -467,14 +467,14 @@ static const char * const tegra_pinctrl_to_func[] = {
 	[PMUX_FUNC_DAP3] = "dap3",
 	[PMUX_FUNC_DAP4] = "dap4",
 	[PMUX_FUNC_DAP5] = "dap5",
-	[PMUX_FUNC_DISPA] = "dispa",
-	[PMUX_FUNC_DISPB] = "dispb",
+	[PMUX_FUNC_DISPA] = "displaya",
+	[PMUX_FUNC_DISPB] = "displayb",
 	[PMUX_FUNC_EMC_TEST0_DLL] = "emc_test0_dll",
 	[PMUX_FUNC_EMC_TEST1_DLL] = "emc_test1_dll",
 	[PMUX_FUNC_GMI] = "gmi",
 	[PMUX_FUNC_GMI_INT] = "gmi_int",
 	[PMUX_FUNC_HDMI] = "hdmi",
-	[PMUX_FUNC_I2C] = "i2c",
+	[PMUX_FUNC_I2C] = "i2c1",
 	[PMUX_FUNC_I2C2] = "i2c2",
 	[PMUX_FUNC_I2C3] = "i2c3",
 	[PMUX_FUNC_IDE] = "ide",
-- 
2.43.0

