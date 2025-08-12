Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B158CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 17:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961B882F03;
	Tue, 12 Aug 2025 19:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iRB22a/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F3582F30; Tue, 12 Aug 2025 19:56:39 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D4C82F00
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 19:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-61b8cb58f21so1645666eaf.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755021396; x=1755626196; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QTXNK/Myvgajjx7w0eID4gJ0GRuaUsO4BdpqqkdOU/M=;
 b=iRB22a/Zx3jsli8mJ8u0QDVDhxAPsHoiB2KYKpo302tMKSkSyj6256YGelOi+bWN9h
 rN72crAjpcHpNTHVIoY1ysOzMe+CnuSEpv7kqJIyIW98GQfxnYZPMb3JBxItEbXKNvMt
 tgWJb9oOam+CfdrsfUUf49UIY8wmn1zXrttZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755021396; x=1755626196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QTXNK/Myvgajjx7w0eID4gJ0GRuaUsO4BdpqqkdOU/M=;
 b=GC1g8Y0l1JW+ti8Wzi5mJRKoLfFacIE1cJ5rOJQndrANp56DoEe3AA1fdOzKKfnqAt
 O6qrXh48gpHkR1VohkoAF3LUrQYcxwSl/B9F/I41hUW7a0zoGRDC52YzgLxlfNQKoafu
 3mXbLnYngwVZDowVlDL88GGCsb3R92vL0jhr5dp+ZmwiT5lEB+ynVbff+SprEHfe+0kx
 8E4Yetxw/49wQofC6ZroegKOVjZ12pRzWmmGvcqM+dK7jv7QgA3mHZCBEnocnt9+a00q
 3sfkZ/ZW3uBcTLL9RGBKSKfJ9I+0tFdWl9FSbsVplL60Q21r6IVlWC0TihI+CqNNAQN8
 LiqQ==
X-Gm-Message-State: AOJu0YyOHFcU7tj3GL2zz5vWFQ4P1sN7KXavuhTzsB7aLb7YzLtnbSUU
 d1jENBxlu4P0MXOUebUVOvnEB6OHu9ATk2tkfRzEmKrb3JLVNFcfTShXBTW/VH5OBxje9ROViS1
 Zgge0rOE=
X-Gm-Gg: ASbGnctIOLNFN5iQjV5dtJOZbZg+pIC/9ysGpd0c2ivV79dytkM4Ae+n6OUrj+1JffF
 Mf0DGUlY809O9wyNupZRSrt6LUm7H6eiPoVnuLt9e1Y0GIq+gzTL19aqDXlQC58l8RdInps13bu
 dUCCiR+ymQ/T5woBc5tosjytOkfgJpDGpzYdXjgIuNIeCny/hNIDlNAgMA6lGI20F82aeTlLdA4
 uiMlwE+Xiz+7VPwF3j7kr24PNVPwztxb6Mr8H61NcKk0YIDVIAkEa2mrO/L12aoonde64gx4Q7N
 y6pzwesxy4AMYvRVXbQKF/60ljOQ9T2/hMNFdgcDX7T5LLKWe+IFo4aOYGw96gM2hPXodr0VcHU
 D02QtK+gGpU94uagz7bQE4sfZrNkyOTyneImXeyZNE5mtR62gaMwC/JEz9T3nj6cFCBtCWw==
X-Google-Smtp-Source: AGHT+IGsieicxoQVqNgDWO5MmOrrsKGhegXaKvZobiHuA6iZYNOkoTmiUNjVYh9LGL3gbtHZa1j4IQ==
X-Received: by 2002:a05:6871:62c4:b0:2ff:96c6:f712 with SMTP id
 586e51a60fabf-30cb5c7eff2mr54492fac.26.1755021395758; 
 Tue, 12 Aug 2025 10:56:35 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30ba8228a79sm6356726fac.35.2025.08.12.10.56.34
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 10:56:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] net: Add SYS_FAULT_MII_ADDR to Kconfig
Date: Tue, 12 Aug 2025 11:56:33 -0600
Message-ID: <20250812175633.3056595-1-trini@konsulko.com>
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

The support found under SYS_FAULT_ECHO_LINK_DOWN requires that the
SYS_FAULT_MII_ADDR symbol also be set. This wasn't previously found in
Kconfig, so add it now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This was found as part of testing "allyesconfig". I'm not sure if
there's anything useful that could be put in the "help" text here.
---
 README      | 3 ---
 net/Kconfig | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 65305e6a0371..7808af528625 100644
--- a/README
+++ b/README
@@ -1249,9 +1249,6 @@ Note: once the monitor has been relocated, then it will complain if
 the default environment is used; a new CRC is computed as soon as you
 use the "saveenv" command to store a valid environment.
 
-- CONFIG_SYS_FAULT_MII_ADDR:
-		MII address of the PHY to check for the Ethernet link state.
-
 - CONFIG_DISPLAY_BOARDINFO
 		Display information about the board that U-Boot is running on
 		when U-Boot starts up. The board function checkboard() is called
diff --git a/net/Kconfig b/net/Kconfig
index 24508026200d..6d5de9a675e4 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -60,6 +60,10 @@ config SYS_FAULT_ECHO_LINK_DOWN
 	  this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
 	  be configured.
 
+config SYS_FAULT_MII_ADDR
+	hex "MII address of the PHY to check for the Ethernet link state"
+	depends on SYS_FAULT_ECHO_LINK_DOWN
+
 config TFTP_PORT
 	bool "Set TFTP UDP source/destination ports via the environment"
 	help
-- 
2.43.0

