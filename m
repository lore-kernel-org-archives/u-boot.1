Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419F9C3DA6E
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 16:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6F08772E;
	Sat, 23 Dec 2023 17:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L9Pvqfqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 944C28772E; Sat, 23 Dec 2023 17:45:53 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EF38772E
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 17:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a2339262835so293021866b.3
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 08:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703349951; x=1703954751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrioXIPSJtRBEeCwlqLJLz18T5G55RXvXYBRuVCAIUc=;
 b=L9Pvqfqkj3oiB+f88TumTwA35TOO1SPP/a3Zcomv6m0G+miBijMLz73Fog1u6X2fDP
 RXEJ2WuQ1mrxQxB2Ig3uKewqop+gL7sRPklnJIY56OOnNvj/sGAHDHJaLijZkBziGjdW
 W+wZrbrvFF5JFvpR1XR4O7DL9oyLVXApqYpVYMowmTZu8dCWpSlgvSDK0kMuKCTvnITE
 22+xkztAq1zV9Al3DG4vW8EwM9sCUSkbLkbPy1pyZWPUO2PzRPJqA9Ng+i2iPBnfL2En
 Npn9HqebEJkz0/Uszv970yl0CI/s6Yg8ataYu26YJxcxy3j6OxeiXsRvH9V0m5cMjeGp
 LnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703349951; x=1703954751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrioXIPSJtRBEeCwlqLJLz18T5G55RXvXYBRuVCAIUc=;
 b=hhxDkp/svj2Wuq953MrkrNg8VDMDpreSLv2wiV8A9+LV6zKBBAH9rUmJBxKCPgk30G
 lbbylBe8adLmM2qE7jIuPIznr37MDKvNKUwFXJ3Dv2/lOcS4gyJHdBaoQRfqtostgIin
 KXEC0FstXxhwxWdjBrn3/xGeSsV0tytPhbsvTWhvm4GFRDWY0tD8gtR3dCu948TXCYXB
 4Hkn+L8/5mMurZ/03FTc/BnTyGsY2qlJdKVXg53I7RzeNe5JjG9wqgzpv7tF9n+1ihaH
 wcdAyzagKTsg0NqFxPQVgPe8y6sN7r+HCafK3ptds6ZEC1+FCPBs8dS7Yx2CkZIgY0DW
 h0hA==
X-Gm-Message-State: AOJu0Yxx9ktYZhWfrEKsPwsUyvB7Kk5KNOL4a87HEWwLZFyF5IuEVRaq
 arFL5SRukgRotT9cJ28M55c=
X-Google-Smtp-Source: AGHT+IHwHMEu7Ii/IVOvmH+B2aCDBHHKHSEtKAbjTYnSeB9Z8fSTKIyUyIqqiTqD6wD6010fFBcnVw==
X-Received: by 2002:a17:906:1099:b0:a23:4540:1570 with SMTP id
 u25-20020a170906109900b00a2345401570mr1471398eju.104.1703349950846; 
 Sat, 23 Dec 2023 08:45:50 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 h1-20020a17090791c100b00a235e5139d5sm3221139ejz.110.2023.12.23.08.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Dec 2023 08:45:50 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Sean Anderson <seanga2@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] ARM: tegra124: convert TEGRA_SUPPORT_NON_SECURE into
 Kconfig
Date: Sat, 23 Dec 2023 18:45:23 +0200
Message-Id: <20231223164525.3660-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231223164525.3660-1-clamor95@gmail.com>
References: <20231223164525.3660-1-clamor95@gmail.com>
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

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 README                      | 7 -------
 arch/arm/mach-tegra/Kconfig | 7 +++++++
 arch/arm/mach-tegra/board.c | 3 ---
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/README b/README
index 805c06598d..b940fae706 100644
--- a/README
+++ b/README
@@ -300,13 +300,6 @@ The following options need to be configured:
 		different from COUNTER_FREQUENCY, and can only be determined
 		at run time.
 
-- Tegra SoC options:
-		CONFIG_TEGRA_SUPPORT_NON_SECURE
-
-		Support executing U-Boot in non-secure (NS) mode. Certain
-		impossible actions will be skipped if the CPU is in NS mode,
-		such as ARM architectural timer initialization.
-
 - Linux Kernel Interface:
 		CONFIG_OF_LIBFDT
 
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index b18885f4c1..fb1a46b780 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -176,6 +176,13 @@ config TEGRA_DISCONNECT_UDC_ON_BOOT
 	  USB controller when U-Boot boots to avoid leaving a stale USB device
 	  present.
 
+config TEGRA_SUPPORT_NON_SECURE
+	bool "Support executing U-Boot in non-secure (NS) mode"
+	depends on TEGRA124
+	help
+	  Certain impossible actions will be skipped if the CPU is in NS mode,
+	  such as ARM architectural timer initialization.
+
 config CI_UDC_HAS_HOSTPC
 	def_bool y
 	depends on CI_UDC && !TEGRA20
diff --git a/arch/arm/mach-tegra/board.c b/arch/arm/mach-tegra/board.c
index 9224743d0e..327d70bd4c 100644
--- a/arch/arm/mach-tegra/board.c
+++ b/arch/arm/mach-tegra/board.c
@@ -77,9 +77,6 @@ bool spl_was_boot_source(void)
 }
 
 #if defined(CONFIG_TEGRA_SUPPORT_NON_SECURE)
-#if !defined(CONFIG_TEGRA124)
-#error tegra_cpu_is_non_secure has only been validated on Tegra124
-#endif
 bool tegra_cpu_is_non_secure(void)
 {
 	/*
-- 
2.40.1

