Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC439C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 12:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477CD817D8;
	Tue, 18 Mar 2025 13:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VwiR6VkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC2D810E8; Tue, 18 Mar 2025 09:31:41 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14018805D7
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so1190729866b.1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742286698; x=1742891498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/rbDTXfYX5XiimyFx4aDsUpA5GqVeq4MVFLJXJHQFE=;
 b=VwiR6VkXQmPgRr+ZgUJ3ek+rZ1eFQCO/6FRxLbACOSNR839INoAPO/xeHxzgqBjOYT
 /tuJdkEA3lozjBiFSvZLWim0GN29uQFG1YAbXxPlr8W6oP2kuuOZPS84PV66ZcHkxrFz
 I87VkJ52ToBlSasFcgfwQePyLXH85IdsVqP1/Iq9jQzsTLA3TPB9Q6DC7yRL6Jf1vhIi
 0WiFvHiKC5pmot8bhYkYs1OhFljCum2uhLNruavFlWlYjA7Qo7KtP1VPgy7VGZvW7ExP
 sU4MO2MxkMSxz8bExQNOvkOsiDV/SvlAKHZa89chqAE18OlLMNinLa2CD55I4xVV+xFV
 eJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742286698; x=1742891498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/rbDTXfYX5XiimyFx4aDsUpA5GqVeq4MVFLJXJHQFE=;
 b=ApS7z3gTbnd3t48ONfep1D2p8B3vLqj0gJJPPxMNs6GVs6hLNqKvq00RoulJBYdFoH
 SeMvXv8OU9wbWag/n1ifGixYg4GF7o6OFmNAY0mo9RP3U9tUWfqtryPVZQF8I9O/4aGZ
 QQUjE+T07z/Y+lw8SBOL4EvHNrWaVP/xwNHh9+yXUGrWmqIrHz229NkYWkWCf6OGvImP
 ZnYOeRSLEkQiIOX2H6YUW9vTGJbeH5jsUyOAJWB5JALjTA1ufVuBD9NNJxxLvqdCFIbQ
 CdxGWz83CxS0I7uABvp9Y0LeuYCR2L6xvbj9nf7J0gSQ7sPgLqs3J5YdfIoJKqHdKMGm
 RTEw==
X-Gm-Message-State: AOJu0YxnpeEoGJPVj7LjyVEh6vKZ9HOor+sBtJPEYFKYaaFE+DL1C8/b
 d/MNi/T9NLJ1XTwlLsTecmx63p+hJ2zBAN5Bn4OVK0PLjYfiOOtfMMSgHkiV
X-Gm-Gg: ASbGnctHLyMLHAU3J6ugo/eT/0WUjKOap76A3t1A3Eps+Km2jljHbsR0d3gyCPTq4PG
 w5VBezBij7P+OP9P79sxfGI0dNprjwPd8cmVOCnyvGM/MNc9ZL5TNV3emb8BhVxHZKxdKD/3R/x
 e7/J5GfZfYH97nUS/UNUrOTBphwO40E0LpTNgn2RV4FR6jYvOI6ZZ87DrEweJq/+FSaD3DEpeGG
 iQhrfJE2Vut5eUnAqi40fRj9eM3kH5DV9Jpgwtt+d+dHClnIycAB9hJZiJyrwclYmf9I3EInKYn
 MloZFyTnqY6SZtymTtjeLKI9vYihRgkmzWyeyaoTJBaqcHrZ7NnT
X-Google-Smtp-Source: AGHT+IE5BloK7cxJNIIWqUk9JJaogNyU7e9kxYnsTtRnAIaLGUnOEQ5/3dDJjaqvBOPaSBJ54M51zg==
X-Received: by 2002:a17:907:3e08:b0:ac3:f95:dbd4 with SMTP id
 a640c23a62f3a-ac38d51502fmr293568166b.42.1742286697772; 
 Tue, 18 Mar 2025 01:31:37 -0700 (PDT)
Received: from eta.play.pl ([2a02:a312:c49b:a180:4e11:d045:a94e:c696])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a3e0acsm816189366b.142.2025.03.18.01.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 01:31:37 -0700 (PDT)
From: Artur Kowalski <arturkow2000@gmail.com>
To: u-boot@lists.denx.de
Cc: Artur Kowalski <arturkow2000@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH 1/4] tegra: add funcmux for exposing UART over uSD slot on
 Tegra 20
Date: Tue, 18 Mar 2025 09:30:44 +0100
Message-ID: <20250318083103.63250-2-arturkow2000@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318083103.63250-1-arturkow2000@gmail.com>
References: <20250318083103.63250-1-arturkow2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Mar 2025 13:47:17 +0100
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

UART-A can be exposed through uSD, this was tested on Transformer T20
but should work on all Ventana-based boards.

TX is exported on SDD pingroup corresponding to uSD CLK pin
RX is exported on SDB which is CMD pin in uSD slot

Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---

 arch/arm/include/asm/arch-tegra20/funcmux.h | 1 +
 arch/arm/mach-tegra/board.c                 | 4 +++-
 arch/arm/mach-tegra/tegra20/Kconfig         | 3 +++
 drivers/pinctrl/tegra/funcmux-tegra20.c     | 9 ++++++++-
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra20/funcmux.h b/arch/arm/include/asm/arch-tegra20/funcmux.h
index e9e96c1f933..bafcf857620 100644
--- a/arch/arm/include/asm/arch-tegra20/funcmux.h
+++ b/arch/arm/include/asm/arch-tegra20/funcmux.h
@@ -19,6 +19,7 @@ enum {
 	FUNCMUX_UART1_UAA_UAB,
 	FUNCMUX_UART1_GPU,
 	FUNCMUX_UART1_SDIO1,
+	FUNCMUX_UART1_SDB_SDD,
 	FUNCMUX_UART2_UAD = 0,
 	FUNCMUX_UART4_GMC = 0,
 
diff --git a/arch/arm/mach-tegra/board.c b/arch/arm/mach-tegra/board.c
index 7ca56a3b081..d34152723b0 100644
--- a/arch/arm/mach-tegra/board.c
+++ b/arch/arm/mach-tegra/board.c
@@ -169,7 +169,9 @@ static int uart_configs[] = {
 	FUNCMUX_UART1_GPU,
  #elif defined(CONFIG_TEGRA_UARTA_SDIO1)
 	FUNCMUX_UART1_SDIO1,
- #else
+#elif defined(CONFIG_TEGRA_UARTA_SDB_SDD)
+	FUNCMUX_UART1_SDB_SDD,
+#else
 	FUNCMUX_UART1_IRRX_IRTX,
 #endif
 	FUNCMUX_UART2_UAD,
diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra/tegra20/Kconfig
index e2735d93e28..3349f1e2786 100644
--- a/arch/arm/mach-tegra/tegra20/Kconfig
+++ b/arch/arm/mach-tegra/tegra20/Kconfig
@@ -17,6 +17,9 @@ config TEGRA_UARTA_GPU
 config TEGRA_UARTA_SDIO1
 	bool
 
+config TEGRA_UARTA_SDB_SDD
+	bool
+
 choice
 	prompt "Tegra20 board select"
 	optional
diff --git a/drivers/pinctrl/tegra/funcmux-tegra20.c b/drivers/pinctrl/tegra/funcmux-tegra20.c
index 951ae196161..f60d5aad3a4 100644
--- a/drivers/pinctrl/tegra/funcmux-tegra20.c
+++ b/drivers/pinctrl/tegra/funcmux-tegra20.c
@@ -62,8 +62,15 @@ int funcmux_select(enum periph_id id, int config)
 			pinmux_tristate_disable(PMUX_PINGRP_SDIO1);
 			bad_config = 0;
 			break;
+		case FUNCMUX_UART1_SDB_SDD:
+			pinmux_set_func(PMUX_PINGRP_SDB, PMUX_FUNC_UARTA);
+			pinmux_set_func(PMUX_PINGRP_SDD, PMUX_FUNC_UARTA);
+			pinmux_tristate_disable(PMUX_PINGRP_SDB);
+			pinmux_tristate_disable(PMUX_PINGRP_SDD);
+			bad_config = 0;
+			break;
 		}
-		if (!bad_config) {
+		if (!bad_config && config != FUNCMUX_UART1_SDB_SDD) {
 			/*
 			 * Tegra appears to boot with function UARTA pre-
 			 * selected on mux group SDB. If two mux groups are
-- 
2.48.1

