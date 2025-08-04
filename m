Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532D8C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D881583D40;
	Mon,  4 Aug 2025 23:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lty3oRo0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D9883F56; Mon,  4 Aug 2025 23:52:59 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3667583B1B
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3e3e926fdeaso19827825ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344376; x=1754949176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Rhr07X4/Juf99f8Vp6zurj3LfMSrihS0nxCw0Qtr2E=;
 b=Lty3oRo0JS5Ck6Tx/naELXGTMrjnQ27ggjwJX+UkwrlcREALYh6m8YFREpJQ4fybbT
 g9hRo5xx/HxD2O8HLfwVqFgq1FyE5WIkduUX4RBYW2DjcWK1YpVRppfT8VOfPglyKSM+
 cKG52Ro46SDE4Iz2xy1PLzb48unBDxA4ATsOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344376; x=1754949176;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Rhr07X4/Juf99f8Vp6zurj3LfMSrihS0nxCw0Qtr2E=;
 b=P5V60vauFObNLhDZgecrpt+DhnOqrxYZRGN5zVDdDsI5jzTlVACFUucyrrbOr7V8SF
 MP83U48RaQn7pRpofhoXai6eYEw2KfAvrFON/qbcaA6HqKmOjxmy9jkq5kaAq3uLIGLn
 L9k+kkl/6pioaubD4iNuKekeTAFyR2Yshm7PpuuIggO01d15lhxCp9fA9/lA8Kvy10Wr
 cVADwU/ayPCc7aGLCLLG4W5EEMnNdF7MnBqv0E7G2b42m3SixBnsvyMp5eSyyajhtyYr
 Dqt6XPnhLIAR2LePOkkmkgQpQFdPmuPRdIODCdpdKrcHiLdVjOYM+iltBcbIGC4153JI
 HQrw==
X-Gm-Message-State: AOJu0YzYiaAetktUnTWRy+hTm6mA9BWIRMJIE8ZcaxX4DqVj7rxp2mcU
 C/4Ak4sK78nl+H1TSEL8zhjFunPeuRV2nDFhNZiuoA9VVWqWLdf8R6ynWBLDfc4iJj+pAtLWi7s
 PbNjG2GI=
X-Gm-Gg: ASbGncu7zk8tm5koKdtOZXBxXDc3I5lMZmJWEGWf7g7Wmmt0A2Nclc54kalcTDFQ5fd
 sJ+hZnoj4pN0JBPnnLyYDJa6kzQEnHx5yBT7mxSmlwwSiiE9YaZFkK14cruzXgd7vyfW4KjIb3t
 xH+uQ1o3Vvvon5vuZRt9aYvaQhGGffyQyj88tXL/qap40si9dTkbuP1A702N/tuF0aeXiNtRQc0
 7/3QTtPooMNJP3pFnkIsyO3bmEo1h3efcNs5z+XFuYjRtOW0TLFOPLAu23QQ+CIvLoiQWMm79cU
 8stsBOZbi9ZNN33gjpoctHdOBJ7XbRXZevj/yF3HjnYPlBu/Uedgkxq+3e0/gcW+o3YseibXkBo
 5qwPfRoQjVW4y6gjb1nVSQ3zyDevq+iRpGhQO9llelL+HKJQXyP8l3qzTPmuQ4udRaWEv
X-Google-Smtp-Source: AGHT+IHFKw/cvcpAuipXCLgzY+lQzQQakNWLnBsKHlSazUJq4UmY9iaKeM4zE63WFueQMVvViTwM/w==
X-Received: by 2002:a05:6e02:1f85:b0:3e3:e78e:4e0a with SMTP id
 e9e14a558f8ab-3e41610d65cmr223392975ab.1.1754344375892; 
 Mon, 04 Aug 2025 14:52:55 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a87e70c37sm1724279173.35.2025.08.04.14.52.54
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:52:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] pinctrl: Tighten some pinctrl driver dependencies
Date: Mon,  4 Aug 2025 15:52:53 -0600
Message-ID: <20250804215253.1412420-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

A few pinctrl drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/pinctrl/Kconfig       | 7 ++++---
 drivers/pinctrl/tegra/Kconfig | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 5e2808abc8a9..48119694031d 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -197,7 +197,7 @@ config PINCTRL_AR933X
 
 config PINCTRL_AT91
 	bool "AT91 pinctrl driver"
-	depends on DM
+	depends on DM && ARCH_AT91
 	help
 	  This option is to enable the AT91 pinctrl driver for AT91 PIO
 	  controller.
@@ -213,13 +213,14 @@ config PINCTRL_AT91
 
 config PINCTRL_AT91PIO4
 	bool "AT91 PIO4 pinctrl driver"
-	depends on DM
+	depends on DM && ARCH_AT91
 	help
 	  This option is to enable the AT91 pinctrl driver for AT91 PIO4
 	  controller which is available on SAMA5D2 SoC.
 
 config PINCTRL_INTEL
 	bool "Standard Intel pin-control and pin-mux driver"
+	depends on X86
 	help
 	  Recent Intel chips such as Apollo Lake (APL) use a common pin control
 	  and GPIO scheme. The settings for this come from an SoC-specific
@@ -248,7 +249,7 @@ config PINCTRL_QCA953X
 
 config PINCTRL_QE
 	bool "QE based pinctrl driver, like on mpc83xx"
-	depends on DM
+	depends on DM && MPC83xx
 	help
 	  This option is to enable the QE pinctrl driver for QE based io
 	  controller.
diff --git a/drivers/pinctrl/tegra/Kconfig b/drivers/pinctrl/tegra/Kconfig
index 669d8e258e43..d2630289d750 100644
--- a/drivers/pinctrl/tegra/Kconfig
+++ b/drivers/pinctrl/tegra/Kconfig
@@ -2,7 +2,7 @@
 
 config PINCTRL_TEGRA
 	bool "Nvidia Tegra pinctrl driver"
-	depends on DM
+	depends on DM && ARCH_TEGRA
 	help
 	  Support pin multiplexing control on Nvidia Tegra SoCs.
 	  The driver is an overlay to existing driver and allows
@@ -11,7 +11,7 @@ config PINCTRL_TEGRA
 
 config SPL_PINCTRL_TEGRA
 	bool "Nvidia Tegra SPL pinctrl driver"
-	depends on SPL_PINCTRL
+	depends on SPL_PINCTRL && ARCH_TEGRA
 	help
 	  Enables support of pre-DM version of pin multiplexing
 	  control driver used on SPL stage for board setup and
-- 
2.43.0

