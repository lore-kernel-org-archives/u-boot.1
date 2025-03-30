Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88CBC36010
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 19:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27DA68144A;
	Sun, 30 Mar 2025 21:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JNTlMdjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEB4681E47; Sun, 30 Mar 2025 21:27:09 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89E081879
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 21:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so499650166b.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743362826; x=1743967626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvhMQIH4Jc1X4zgQd+6BrSur/Dx5rnAfPnp3z44t0Lc=;
 b=JNTlMdjgo6/UJFnxXOLRS4Rk5n+RufxKfupuQkRUtEecakIMlliVkxkt6pwkPMmbNV
 KYTtgiLu7S+L+HzpEZA9U5CGhjP33ItUlAbZyaBtlzkZ9Q6a6jVCd5mfUqjHdQty/2zl
 iGJWmppNcR/pXTn6dPjl/kZq2qM+/zi282E0BxQsiK075hdOtZGFh/DMQkFsfBHPbrji
 15mOCr5A3xByCIH30rVk28owDtLYqzmcDlzTkmWR8klYoPqLCrzoO6ww52LJWI4XI4pS
 wcrsf6KK/OHfCwjM77BhBuucqZK+OnKC3VXF7c0vceD3U4J4dUh02eGuCqCRovr56hyu
 tbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743362826; x=1743967626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JvhMQIH4Jc1X4zgQd+6BrSur/Dx5rnAfPnp3z44t0Lc=;
 b=nWDFGKAIjplXStEfVvCvF+sr2xn+cMFK7MUZiKDPMR9CUQOyPP6NxV3awKKHEVqBOA
 6Xjnmo02RTuGVxaaYD36s7BDRHpnwdJsbTYFNPc6XJ0ZbNw5afbrmYPhyYGC7R/HzICS
 xcS9MweKWsg0XV53KfUjJvJA4twoDrC61Cqiir9nX0MPt8af4hGiaxMbvcXBw9Pva//A
 MmGf6s6s8AbxupxMM8HdYN363aAzvtVVZ6xwPvhpuyjTto4hRhYTIcvfZC8j3Bz2rRMu
 ID9EMExQdTbML9c/4uOawLxR1cbCIws0XeGleZwwFLQNfZ8TY++0Zh+7xuN1slXMLexp
 u8Rw==
X-Gm-Message-State: AOJu0YxXuOXQas3PrGSLlh0j+p3ls5RWDlr4aDXN9toYMqxaPTvRkvbw
 L0p84X1IFLwd2jJHrFWLD49W1yj8dNoANHobfxid09eAbrEG3bJv6mXBibF4
X-Gm-Gg: ASbGncvfmjAEc7jV4kKXN2RY1jgGJbaWRPARthD4CpON5PTNu7QRkN4tZf3Uc0ds048
 4MKqwhPYIkKYgdvZnI7WX4Xg/yYeOlUPKdt0afABWCcIv50hCdzqOQa+30JMnpV9ueB+lLFPMRo
 XCJnHMe4tOK9EScC6mrtMNHrry2vF4vMHgt4pYSVryfIkA+/OmvqBKkrMY6UjHxk1wn+RQn+8Zo
 /Vu0+7vxBU7XmBljQJ3loXTTfYPgv+L80OshJitkTrLbw01JVNE+YKGatC8uUInfnrfv0KVXtHD
 GeFJjgQwlAeu+VURZgKJv16xBL0QHrTnDW4kOx9l0H6LLuQGlHpf3T2+xDkEZw==
X-Google-Smtp-Source: AGHT+IH0QJyogSHdgqIm6EJISrxr8+uOtjsIkKxm659p/ecZBsvO1mtY8RWG+whSdT0+fs+wMp4qvw==
X-Received: by 2002:a17:906:250a:b0:abf:7af6:ea64 with SMTP id
 a640c23a62f3a-ac738b61ea2mr470846466b.45.1743362826405; 
 Sun, 30 Mar 2025 12:27:06 -0700 (PDT)
Received: from eta.play.pl ([2a02:a312:c49b:a180:1d7c:64d:f4dd:a029])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71922029fsm522118966b.11.2025.03.30.12.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 12:27:06 -0700 (PDT)
From: Artur Kowalski <arturkow2000@gmail.com>
To: u-boot@lists.denx.de
Cc: Artur Kowalski <arturkow2000@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH v2 1/3] tegra: add funcmux for exposing UART over uSD slot on
 Tegra 20
Date: Sun, 30 Mar 2025 21:26:39 +0200
Message-ID: <20250330212638.v2.1.Ib55fe26f355e42f7853676779e89e22356bd7230@changeid>
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

UART-A can be exposed through uSD, this was tested on Transformer T20
but should work on all Ventana-based boards.

TX is exported on SDD pingroup corresponding to uSD CLK pin
RX is exported on SDB which is CMD pin in uSD slot

Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---

Changes in v2:
- fixed indentation of preprocessor directives

 arch/arm/include/asm/arch-tegra20/funcmux.h | 1 +
 arch/arm/mach-tegra/board.c                 | 2 ++
 arch/arm/mach-tegra/tegra20/Kconfig         | 3 +++
 drivers/pinctrl/tegra/funcmux-tegra20.c     | 9 ++++++++-
 4 files changed, 14 insertions(+), 1 deletion(-)

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
index 7ca56a3b081..7597034fa48 100644
--- a/arch/arm/mach-tegra/board.c
+++ b/arch/arm/mach-tegra/board.c
@@ -169,6 +169,8 @@ static int uart_configs[] = {
 	FUNCMUX_UART1_GPU,
  #elif defined(CONFIG_TEGRA_UARTA_SDIO1)
 	FUNCMUX_UART1_SDIO1,
+ #elif defined(CONFIG_TEGRA_UARTA_SDB_SDD)
+	FUNCMUX_UART1_SDB_SDD,
  #else
 	FUNCMUX_UART1_IRRX_IRTX,
 #endif
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

