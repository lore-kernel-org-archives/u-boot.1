Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6444DC36010
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 19:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E8A81F30;
	Sun, 30 Mar 2025 21:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PE2gaIhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C03E81A0C; Sun, 30 Mar 2025 21:27:13 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 189B5812BC
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 21:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so5738344a12.2
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743362830; x=1743967630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TuIUBhgXMXzIX4RyBDlfrUGqGYG9VKplADMo98c/7g8=;
 b=PE2gaIhPyqpeuYeOHr3NQKqmiPZomYwOn5vqFXlv8KvXVRqX2sEEsAYfauKL1OxyPM
 MGh0D8/p48D+SSE6qo3YT/17I421TahYv12opcrXBOjahtx6G5aVjPhZJjMr+9UBBMyh
 T/9xVJS1pEEjFjxd13iY+GSXNSKcCCOAvEcmNgAObGmuTQEjCj2FJDwAizlaZLeqw/Zj
 WRO65dKDZPU8XkIwGuvR9R5YoSbF83a8CYklVySxpwFa8Cm3fornEhxEChk/54xQRztM
 /vmZYkFxrY2bawQ0m7VTRc3OhyVH/ta/rSR0a5la/ZO2p8oaO2/ToMGz+d7EMo9UJoNU
 px9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743362830; x=1743967630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TuIUBhgXMXzIX4RyBDlfrUGqGYG9VKplADMo98c/7g8=;
 b=KYWMbDPjx4MSqfvN5Oms1kIxlMq6bmVoZcicFiXSpYxr44WUVrDp80hpNl6Zfo8TZs
 Urn9Pb3mB34hhyi9pCWWfElieap4AB/kZ+QQpCmM/6v1yOlDL4msQoxcjHAKmBrUYJxJ
 422i2TVlSH7PIM0Z+4ZThJ+AempnSwUYRmuMbljEUyeM72oLwwDbm4E4ZpQES/ztdKAn
 e6WzFFVsAMUy2s5CkItUiaZRjsAP41l0tX1Kk7RLa7MXFq8TF/LW7gkgEwe5oCbSwbTn
 2vGMeH1hZ57eyMuLgs0r745kE5IhKqhHTOb6OJVzmwYHjJs8AukKp15vGk1WBou0G78z
 BHZw==
X-Gm-Message-State: AOJu0YyUlm0Bhs0ryw7TgP2hT5D4LJn0iFTaaZ2CmTtPZ42e/snMnAdH
 vXPm7qTeoqfcLOmQWhbU7kcf2n/87gRS5H2U7vqeLNPcfrJeWFs1pMmcFHLH
X-Gm-Gg: ASbGncsgUXNso04NCYiLHeRobmCgB8Yzecnx+fhqc/Xwc1t82ZNrqNXtu3/NdXgd9SW
 tMoO/JCchL7iBX3ObzjT3YPdYpLEh4umeFsdIAPi5UNXiJQInOQm7MyR/3BhPpFsckUFkirGTvw
 CJG6irL9mbAe3rhWC0XueNwJmK7OdX45g76sWRJUtAy4i9nf1mxexRJ/BiwT7B3HNcd4mhEWy6y
 68L/5u/jp3CqFAclB2sdbaNcuM3D++Ft3qiiZFTFrhd5YsAZeE9e58KRP6QeL0y+3UfiQL93BbT
 wN5aEANI2GXuDn7D3b1CIRwqnWdYHbYbPfdYr9vfh6I8hkbLsaI=
X-Google-Smtp-Source: AGHT+IFbCekIOsJscUDhKWkGExUMCgW3J+K48tOh5my7Ln2wv3jLkcaxOqUY5Vk5bcB4eaEr8SKjzA==
X-Received: by 2002:a17:907:d25:b0:abf:4708:8644 with SMTP id
 a640c23a62f3a-ac738bbebedmr536602166b.43.1743362829359; 
 Sun, 30 Mar 2025 12:27:09 -0700 (PDT)
Received: from eta.play.pl ([2a02:a312:c49b:a180:1d7c:64d:f4dd:a029])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71922029fsm522118966b.11.2025.03.30.12.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 12:27:08 -0700 (PDT)
From: Artur Kowalski <arturkow2000@gmail.com>
To: u-boot@lists.denx.de
Cc: Artur Kowalski <arturkow2000@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH v2 3/3] tegra: allow to expose UART on microSD slot
Date: Sun, 30 Mar 2025 21:26:41 +0200
Message-ID: <20250330212638.v2.3.I45a1ec3470905b1a7313ef907a83999f1163bb3b@changeid>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250330192656.1280403-1-arturkow2000@gmail.com>
References: <20250330192656.1280403-1-arturkow2000@gmail.com>
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

Tegra20 has mux allowing to repurpose microSD as UART on boards which
use sdmmc3 controller for microSD. Add TEGRA_UARTA_MICROSD to enable
this feature. It is currently supported on Transformer T20, support for
other boards may require Device Tree changes.

Update Transformer T20 DTS to select correct pinmux and stdout-path
based on TEGRA_UARTA_MICROSD.

Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---

Changes in v2:
- added TEGRA_UARTA_MICROSD Kconfig option
- removed .dtsi for enabling UART over microSD
- modified transformer DT to use UARTA and correct pinmux when
  TEGRA_UARTA_MICROSD is enabled; it is enough to flip a single
  switch to enable/disable UART over microSD

 arch/arm/dts/tegra20-asus-transformer.dtsi | 24 ++++++++++++++++++++++
 arch/arm/mach-tegra/tegra20/Kconfig        | 15 ++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/dts/tegra20-asus-transformer.dtsi b/arch/arm/dts/tegra20-asus-transformer.dtsi
index 49efabbfd92..9ea323c81f3 100644
--- a/arch/arm/dts/tegra20-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra20-asus-transformer.dtsi
@@ -5,7 +5,13 @@
 
 / {
 	chosen {
+#if CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTA)
+		stdout-path = &uarta;
+#elif CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTD)
 		stdout-path = &uartd;
+#else
+#error Unsupported UART
+#endif
 	};
 
 	aliases {
@@ -195,10 +201,17 @@
 				nvidia,function = "i2c1";
 			};
 
+#if CONFIG_IS_ENABLED(TEGRA_UARTA_SDB_SDD)
+			dbguart {
+				nvidia,pins = "sdb", "sdd";
+				nvidia,function = "uarta";
+			};
+#else
 			sdb {
 				nvidia,pins = "sdb", "sdc", "sdd", "slxc", "slxk";
 				nvidia,function = "sdio3";
 			};
+#endif
 
 			sdio1 {
 				nvidia,pins = "sdio1";
@@ -376,7 +389,13 @@
 		};
 	};
 
+#if CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTA)
+	uarta: serial@70006000 {
+#elif CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTD)
 	uartd: serial@70006300 {
+#else
+#error Unsupported UART
+#endif
 		status = "okay";
 		clock-frequency = <216000000>;
 	};
@@ -434,7 +453,12 @@
 	};
 
 	sdmmc3: sdhci@c8000400 {
+#if CONFIG_IS_ENABLED(TEGRA_UARTA_MICROSD)
+		/* Can't use both at the same time */
+		status = "disabled";
+#else
 		status = "okay";
+#endif
 		bus-width = <4>;
 
 		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra/tegra20/Kconfig
index 3349f1e2786..c2c51660216 100644
--- a/arch/arm/mach-tegra/tegra20/Kconfig
+++ b/arch/arm/mach-tegra/tegra20/Kconfig
@@ -77,6 +77,21 @@ endchoice
 config SYS_SOC
 	default "tegra20"
 
+config TEGRA_UARTA_MICROSD
+	bool "UARTA on MicroSD breakout board"
+	default n
+	depends on TEGRA_ENABLE_UARTA && TARGET_TRANSFORMER_T20
+	select TEGRA_UARTA_SDB_SDD
+	help
+	  Repurpose the SD card slot for getting access to the UARTA serial
+	  console. Primarily useful only for low level u-boot debugging on
+	  tablets, where normal UARTD is difficult to access and requires
+	  device disassembly and/or soldering. Enabling this option causes
+	  UARTA TX to become exposed on SDD and RX on SDB pins which correspond
+	  to microSD CLK and CMD pins respectively. Currently this is supported
+	  only on Transformer T20, support for other platforms may require DT
+	  and configs (from include/configs/*) updates.
+
 source "board/nvidia/harmony/Kconfig"
 source "board/avionic-design/medcom-wide/Kconfig"
 source "board/compal/paz00/Kconfig"
-- 
2.48.1

