Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D551AC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 12:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48DB2800B6;
	Tue, 18 Mar 2025 13:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RML04iAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3156780F4C; Tue, 18 Mar 2025 13:00:29 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20592800B3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 13:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so4563039f8f.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 05:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742299226; x=1742904026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MvOShMefT1SlgXwLakUhcs8vVDHUPgJB4O/8uaWlm9Q=;
 b=RML04iAjwuC7skKetRAyKg3i7+SFTgG8zf0vrlWCgYNrDp1qUhGHySfKnDnQOpIUys
 DfnNUvKwTMc4/QWWRYe5urWuZllQBHYCp+cncMmD37q4jqwsLGeK+FtDxwo/EAzVOyKk
 ZJeOP91eFu1X9Figi79w19O4YZbJRb6WLGuHyr25p9UUHOX0J8eSME4NPjpSdO15lvzT
 wKaw+9+1AfmRvy2poT9zl6NXo4HQg3H7/BC5c8tZMRy/YfPzfzYdzxtpYIhImixExKqu
 hYkT5SuRTcECzOJCzBc55DTEasMy0Nt8uK8nvs2XWSzc1Nw0J3GeGE3SeTx5/4bhmvx+
 Jagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742299226; x=1742904026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MvOShMefT1SlgXwLakUhcs8vVDHUPgJB4O/8uaWlm9Q=;
 b=p1NMUo+XihTv5kmX060lp+Ed896voEUNgutMJzFShsci53ZJImVV7PzJIih+zQmITl
 z3yujJrOcIza5Og6+rPKAloORgOiZja2l+g/To/U8kaJwwwzQKHXAJX1zYTCsP+jHrdc
 S6EfdO/2YKiIMsqWCasAtlw8/GJz3QjhrU7VJxH4pPTjGsjntz/Qhlv9S3zOYl8WOm4O
 WGxFr2PSxzSv0e4i6LKTlOghIrjZ+y4f4jpdcydhMKIWoAVIQJ9r0j812krFDzbx+7TL
 +cOWhxBlYMZytbY8nWAuuArXRvezMj3xmPIC7pjB/SMOdJXZim9ZRPSFawzSnUnCUud2
 0c+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXetyB6tcdAfd431i0NNtzzWYNGOrzHVTtgCPuvNz4fD8mfs1Kuu3uZuJhUFA9B3aaAOWMouh0=@lists.denx.de
X-Gm-Message-State: AOJu0YzXZiVn5SM7GZXLIWBvwSi0+sRNlF6G6IPlXWIl3oja9uGzRJ9b
 kQj6WM111UZJILtv08mz9iW79IbRmi53pmb21+IZX808s201Te4JWcFh+5jtSHo=
X-Gm-Gg: ASbGncu4DP09AQhzjL1sNhjms4vrjsdLdPld9kmTfA6PaqnucwmpwaF0IsfPvq2+R8F
 ikTP/LKkV5apCow2/32owzX0Jnp0meiONvxG8eVxvZxmjzSA7KkK3D1bdjlmSJvP4xKMXQad3Z8
 399a4XYwHC2AhbxfwBZ1UbANtXiZ5a40IvdVTeMXMELVWPFANPq7O4R79la7WPdDzW92i59dKxJ
 IOoZ5KqdvEvbAspgdT05cWHTiai8jQ6c4JOEmQL0l4gFoUSw8dHyNCVEj8Z+SnPmKqn1IPTFOY7
 zShfvtEUJyUBPiWuizQtShm6ihUW5N5i7/8eSewV+ptdnro/067ORgtxB17E
X-Google-Smtp-Source: AGHT+IFMQKDmBR2IlTdtpj7AMB0fbLltbv0MZ0BBaNdSTWf0+CJPLxP2KMe6hWKjSit/u/FI1Oymxw==
X-Received: by 2002:a5d:5982:0:b0:390:f552:d291 with SMTP id
 ffacd0b85a97d-3971d80226bmr15473752f8f.22.1742299226479; 
 Tue, 18 Mar 2025 05:00:26 -0700 (PDT)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:2c08:4dd1:926c:85e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb8c2sm17525469f8f.85.2025.03.18.05.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 05:00:25 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] mach-snapdragon: always select SYSRESET_PSCI for
 ARCH_SNAPDRAGON
Date: Tue, 18 Mar 2025 11:58:45 +0000
Message-ID: <20250318115850.464140-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.48.1
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

Since removing reset_cpu() in mach-snapdragon, all Qualcomm platforms
now depend on CONFIG_SYSRESET and will fail to build without it.

Move the dependency from qcom_defconfig to kconfig so that we use
SYSRESET for all platforms.

This fixes compilation on the dragonboard410c, 820c, and hmibsc boards.

Fixes: 61a1a1b8ca73 ("mach-snapdragon: use PSCI sysreset driver")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/Kconfig       | 2 ++
 configs/qcom_defconfig | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf08fe63f1e7..32b80da9869a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1116,8 +1116,10 @@ config ARCH_SNAPDRAGON
 	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
+	select SYSRESET
+	select SYSRESET_PSCI
 	imply OF_UPSTREAM
 	imply CMD_DM
 
 config ARCH_SOCFPGA
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 82bbdc996675..ba4d38d100e0 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -120,10 +120,8 @@ CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_QCOM_PSHOLD=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-- 
2.48.1

