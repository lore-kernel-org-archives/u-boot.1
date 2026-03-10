Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D09CFD4F05
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECFC184118;
	Tue, 10 Mar 2026 17:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OZrZBY8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE9A840EE; Tue, 10 Mar 2026 17:26:16 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0FC98412C
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-464ba2bb3aeso37986b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773159972; x=1773764772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SO8SeWoi+GqxV/vt/n6dauUkMsmOF6B+5oZL/AorK+g=;
 b=OZrZBY8m/yip2fE4tdhBuROjh9CoK9PNDr+rc3ZouJ5GLCY+EghGBncgdsE3mUQjFr
 EeKCN8J4+co6NTwPstDbkzChnJzynG+Ac0IEWc5Irs92DnokCN9zcbTiKVeGEQhpyKSk
 jUUFmg7S6b6FE62mCJ8kozmAk1ymbTs7Ogtg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159972; x=1773764772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SO8SeWoi+GqxV/vt/n6dauUkMsmOF6B+5oZL/AorK+g=;
 b=giIAASCqBZxPyVNAmtpZJm8BzFGIE7nHdE0pO+UUmcKA1iJzlZekdwyx8Ey83yHOIV
 cjCMIXINbaUwdzEI3XD4y3muKYayQ1/Wfol2+2/2I91xmQzZ8FsvKKvayrZUhJnGaO9K
 u7IaJILgYlRfSOjs2qqC9qwakaEwuOjZfFWGdKpUPWnoeHFoPrZgAK50IIPm66QNwgKd
 f/B8eeMBI0Gy7DRssv4mL67T0pHrhfYWJdUZqi7eDJMW/b0ZL+4SdAWaog1OWa8HtTtr
 KwB9/BxUgiw5yYAC7y2ikjXmFUVynGcibXPRfTbOg0f26OgyZOG/ITKg+LBWJ4gJOiHR
 4U7g==
X-Gm-Message-State: AOJu0YyJxMe5QGl9yKdZ8jBvQOC4bYK/y8m8pTwNBaZM0uFGFwB83fUI
 YBg6VCrH68deen81xO0CUQEAYTtGfB7HZpLV79Q5eGcnQhD06z7vz9qg4bZ6dG7hns5y4ifdJ9f
 HXV0n42Q=
X-Gm-Gg: ATEYQzwQVZoEHACK9Ucvh3IFz8eRbH8lnAUKA3Ie6UVAufZzL9OWTwdiJgpSDFNuiMC
 JUHQalFE5FgmP1KCHkh38AYY70pjSLsBGgsrodtdfh5wGxz4Zr5gBmeZH5BTycKAKXBZqmvk8k3
 7wwlQg7PNxZjKL8UOXSBBbIa/HbmY1HTXuY+lXLfUfh/4ZTu6kXn5umKfeEDKGHlmvo5sEdqpKu
 6vl/7kOyktVMdyM+oNcD2AUUJoBg1DP1xI8zFwkzjMOJOtN0+IhxiznsBuAfRmk7/8aOl8qZce4
 naLtUoHHjxtQzPgVno2EIf7cbYq+klO7Lpri3uG8VrHi+hy3VDLDbFXG2DUlvGQ0EYTvjW2oH+A
 tJEcNnDjusPpcMBe4X3iGASIzd4omWVQC2rX7zJmxtyYfMZm6F6+xObBlHle8+i+IYIEgb5jAPM
 8fvCvXBPj0FdlE/O0vBkNcANZgMZV5eWS8l7ZHrMROrg6y4l717LvsA+FSfAQ6lSQaERsI39wiV
 kaCXtvgAmwYjMjoDYUXnRYDhZYfWCCMWYdjRba7hX/e/ovD
X-Received: by 2002:a05:6808:244d:b0:45f:103c:2483 with SMTP id
 5614622812f47-4671bf30b27mr2076585b6e.23.1773159972416; 
 Tue, 10 Mar 2026 09:26:12 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46718c843e6sm2665877b6e.12.2026.03.10.09.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:26:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] fw_loader: Introduce SUPPORTS_FW_LOADER symbol
Date: Tue, 10 Mar 2026 10:26:10 -0600
Message-ID: <20260310162610.1163833-1-trini@konsulko.com>
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

The implementation of FW_LOADER requires CMDLINE to be enabled, and
expressses this. In order to not have to have every users also depends
on CMDLINE introduce SUPPORTS_FW_LOADER. This depends on CMDLINE and
ENV_SUPPORT and then we have all users depends on SUPPORTS_FW_LOADER.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/net/phy/Kconfig          | 1 +
 drivers/net/phy/airoha/Kconfig   | 1 +
 drivers/net/phy/mediatek/Kconfig | 1 +
 lib/Kconfig                      | 8 ++++++--
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 709f1c91eb2d..5d2277a4602e 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -91,6 +91,7 @@ menuconfig PHY_AQUANTIA
 config PHY_AQUANTIA_UPLOAD_FW
 	bool "Aquantia firmware loading support"
 	depends on PHY_AQUANTIA
+	depends on SUPPORTS_FW_LOADER
 	select FW_LOADER
 	help
 	  Aquantia PHYs use firmware which can be either loaded automatically
diff --git a/drivers/net/phy/airoha/Kconfig b/drivers/net/phy/airoha/Kconfig
index 999564e48483..259ef6af005a 100644
--- a/drivers/net/phy/airoha/Kconfig
+++ b/drivers/net/phy/airoha/Kconfig
@@ -5,6 +5,7 @@ menuconfig PHY_AIROHA
 config PHY_AIROHA_EN8811
 	bool "Airoha Ethernet EN8811H support"
 	depends on PHY_AIROHA
+	depends on SUPPORTS_FW_LOADER
 	select FW_LOADER
 	help
 	  AIROHA EN8811H supported.
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index 933271f01faf..1ead391c7b6c 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -6,6 +6,7 @@ config MTK_NET_PHYLIB
 config PHY_MEDIATEK_2P5GE
 	bool "MediaTek built-in 2.5Gb ethernet PHYs"
 	depends on OF_CONTROL && (TARGET_MT7987 || TARGET_MT7988)
+	depends on SUPPORTS_FW_LOADER
 	select FW_LOADER
 	select MTK_NET_PHYLIB
 	help
diff --git a/lib/Kconfig b/lib/Kconfig
index 931d5206936a..e20519873524 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -71,10 +71,14 @@ config DYNAMIC_CRC_TABLE
 	  Enable this option to calculate entries for CRC tables at runtime.
 	  This can be helpful when reducing the size of the build image
 
-config FW_LOADER
-	bool "Enable firmware loader using environment script"
+config SUPPORTS_FW_LOADER
+	bool
 	depends on CMDLINE
 	depends on ENV_SUPPORT
+
+config FW_LOADER
+	bool "Enable firmware loader using environment script"
+	depends on SUPPORTS_FW_LOADER
 	help
 	  Enable this option to make firmware loading using user-provided
 	  U-Boot environment script functionality accessible to U-Boot code.
-- 
2.43.0

