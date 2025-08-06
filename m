Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1567C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDE4083A5B;
	Wed,  6 Aug 2025 16:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uN0D5ggv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA8D783721; Wed,  6 Aug 2025 16:55:15 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD6683A44
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-619bc5f638aso758139eaf.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492106; x=1755096906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UtDPmtq2mYJ4Sk1BGqWn3+sgixp2JuDLp4yMFfgKAJE=;
 b=uN0D5ggv4XMGvH1lF51jq7MlP72JzkVJIgt/CVc92PEsrpPaXTApQs4uvA4IlCQvH7
 tztf/dyQG6q2cvbUFRMUvr/OMHVqkINEmv+vhj6fTULFdi+heZfMZuzS0e7bc+P0XuIJ
 HFFaED+AuZJ8bqvW6rZP1gBX9FRKqkoMDVTFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492106; x=1755096906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UtDPmtq2mYJ4Sk1BGqWn3+sgixp2JuDLp4yMFfgKAJE=;
 b=eHMx34S+8hMzIE2tLOGRsnIp9CI4Iud2IQg86Hzj8cAeygJZlWtYvnBnmsn/Oi52bD
 qCo2zIOSMGkVOXpzrHgav/UAewq7M90MXil5RAz6e+sKlMQranauBDSSeaCoZnEk0bBG
 2VzImdXYqbHOcdeIJZRURC3cVvXx0eVo+yd3e9k0M0ushYzWrYisUx0GOLHmCuzLI+11
 AA5J6D2FllEFmvWUOVbI6OILuYbHQLgsHflqzgH7lhxmoSeOD3X2U1e2CGf97YnkZlNX
 kCuRJAwN3odJUjv04fBBFLmS/NYPYMNP24elbfkE6gaIKQ19GbC8zKp+O/q0sraN8s5+
 4HRA==
X-Gm-Message-State: AOJu0YzYxHtsY/9qcqC6YosE+SsAGjYVYwGQKEMLZUT+MrwuQpMHKEhh
 OClCPlEXQ7Obe7CyFbEzE3prqOx1AAxu2qmgzLvuiu4jwr1imvKJjl8iet3vrY2hA39+Md5D2an
 cf/bExWg=
X-Gm-Gg: ASbGncuYrW6MBpCM4/vxxFXDd7erIauAcr5tGB0aP4QTJOjFVLYYPcN2/HqBKqeZny4
 gYolFBSt41TKB7neOX5scK99kGcGKV180FG2su3i6gY2QCoqI2gEoWknBKZR3j2sBhuSSf06idm
 20g7veptnFHPHiM+aOEXiPzk/XH0I5QieCCFHCPXEiujLLJE37iGlWtoDEx29/9urvF4JSrBYF8
 QaHT9xv3nFPPbmlJip/dKHckwVl+3rAUWw7EsdleA/Cdji5JAoHJwKiGcPO6XCP1AHWvFGzfSft
 QhageWGCBItmnHpectkXQWUJ6/m9GjQqRl8pJngLBoOe9HxjpXGX9HFx5/CmMpVDm77EYVdhe6r
 3NBLtqDjpp+5u473WtTT9LC/DqYytu5D2fEgZIbZ+gyzH5OSQmmuVCJKXM38=
X-Google-Smtp-Source: AGHT+IGQLWnEfvnvYlRp9YPbua4vQ99PKqtoYDniXmYJtBUKZHYE6HwMisDPT9j/sT5Vkcg3vGLFmQ==
X-Received: by 2002:a4a:e915:0:b0:619:9530:87e3 with SMTP id
 006d021491bc7-61b5f2c8a08mr2502469eaf.1.1754492106507; 
 Wed, 06 Aug 2025 07:55:06 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970528732sm2491311eaf.13.2025.08.06.07.55.05
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:55:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] timer: Tighten some timer driver dependencies
Date: Wed,  6 Aug 2025 08:55:03 -0600
Message-ID: <20250806145503.1664386-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145503.1664386-1-trini@konsulko.com>
References: <20250806145503.1664386-1-trini@konsulko.com>
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

A few timer drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/timer/Kconfig | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index d3231441b13e..81c154b378a6 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -96,8 +96,8 @@ config ARM_TWD_TIMER
 
 config AST_TIMER
 	bool "Aspeed ast2400/ast2500 timer support"
-	depends on TIMER
-	default y if ARCH_ASPEED
+	depends on TIMER && ARCH_ASPEED
+	default y
 	help
 	  Select this to enable timer for Aspeed ast2400/ast2500 devices.
 	  This is a simple sys timer driver, it is compatible with lib/time.c,
@@ -108,17 +108,10 @@ config AST_TIMER
 
 config AST_IBEX_TIMER
 	bool "Aspeed ast2700 Ibex timer"
-	depends on TIMER
+	depends on TIMER && RISCV
 	help
 	  Select this to enable a timer support for the Ibex RV32-based MCUs in AST2700.
 
-config ATCPIT100_TIMER
-	bool "ATCPIT100 timer support"
-	depends on TIMER
-	help
-	  Select this to enable a ATCPIT100 timer which will be embedded
-	  in AE3XX, AE250 boards.
-
 config ATMEL_PIT_TIMER
 	bool "Atmel periodic interval timer support"
 	depends on TIMER
@@ -161,7 +154,7 @@ config CADENCE_TTC_TIMER
 
 config DESIGNWARE_APB_TIMER
 	bool "Designware APB Timer"
-	depends on TIMER
+	depends on TIMER && (ARCH_SOCFPGA || ARCH_ROCKCHIP)
 	help
 	  Enables support for the Designware APB Timer driver. This timer is
 	  present on Altera SoCFPGA SoCs.
@@ -175,7 +168,7 @@ config GXP_TIMER
 
 config MPC83XX_TIMER
 	bool "MPC83xx timer support"
-	depends on TIMER
+	depends on TIMER && PPC
 	help
 	  Select this to enable support for the timer found on
 	  devices based on the MPC83xx family of SoCs.
@@ -217,14 +210,14 @@ config NPCM_TIMER
 
 config OMAP_TIMER
 	bool "Omap timer support"
-	depends on TIMER
+	depends on TIMER && (ARCH_OMAP2PLUS || ARCH_K3)
 	help
 	  Select this to enable an timer for Omap devices.
 
 config ORION_TIMER
 	bool "Orion timer support"
-	depends on TIMER
-	default y if ARCH_KIRKWOOD || (ARCH_MVEBU && ARMADA_32BIT)
+	depends on TIMER && (ARCH_KIRKWOOD || (ARCH_MVEBU && ARMADA_32BIT))
+	default y
 	select TIMER_EARLY if ARCH_MVEBU
 	help
 	  Select this to enable an timer for Orion and Armada devices
@@ -239,7 +232,7 @@ config RISCV_TIMER
 
 config ROCKCHIP_TIMER
 	bool "Rockchip timer support"
-	depends on TIMER
+	depends on TIMER && ARCH_ROCKCHIP
 	help
 	  Select this to enable support for the timer found on
 	  Rockchip devices.
@@ -268,14 +261,14 @@ config SP804_TIMER
 
 config STM32_TIMER
 	bool "STM32 timer support"
-	depends on TIMER
+	depends on TIMER && ARCH_STM32
 	help
 	  Select this to enable support for the timer found on
 	  STM32 devices.
 
 config TEGRA_TIMER
 	bool "Tegra timer support"
-	depends on TIMER
+	depends on TIMER && ARCH_TEGRA
 	select TIMER_EARLY
 	help
 	  Select this to enable support for the timer found on
-- 
2.43.0

