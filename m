Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879CFC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95B5B8843A;
	Sat, 27 Apr 2024 16:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iLNdmoNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D678988422; Sat, 27 Apr 2024 16:11:19 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A446388413
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78f02298dc6so264211485a.1
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227076; x=1714831876; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lNdGC4VP60zRDZ338f8B5jsIMs0fk6cuGwoB7L26obM=;
 b=iLNdmoNf+de9oyP+wv64Ri4v6FSBijxM1WV/8p5APVC2oKYyF54wOhy1wBCo9o4HAc
 4QrF9rntqmUdoxbseBhXic6vE0WtXX8L2rBpJMSADKb9kHv9N6pkvKeiH8jz2jGq8khw
 Uki/H4FW66RpakI3vlBoyKR14Kww2l2EsxzBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227076; x=1714831876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNdGC4VP60zRDZ338f8B5jsIMs0fk6cuGwoB7L26obM=;
 b=RBO0uOkO/AfR8Y+79bYNNwLZTc/oyPiJVxlDCjQlGkhEXEydSYQVeBk78vkvpzjWsQ
 P74fsqLRNKdJrIVbfhrKmqwBT4bZ8gU9Kh+feVQOR3mkPLlekxJLcQZ+a7206bfkMb1/
 dj4NJe7Z0P5xmwsffnSFVrd4DTmHMFoKHq7QJBfyS0MUbRm7U7R+7wliUE1t/gjKeRw0
 qWoqtKkXial3R/M6cxmsrUo0CGHpds4Vyc9cCZzcThstHF/WqvieadfXpEkbM3unfvll
 trKUancRZW/h2WpRiCu+661qY4/b3X8QD0dHyiuCcxGN2m6uziVe4+RGHepg9c2JMoJi
 iQ8g==
X-Gm-Message-State: AOJu0YxtRoAMYzR52j2I48k08Ig+Hk+tszLtMCM4ZgFSAaFQMC/E+ctG
 p2O2xfmQs7AQLisA+l96LZHW4SGRdg06wTVKcCHrpIVZL7tZ6UeQl1YbjM2mAgzHAhv0iP5rmtr
 p8g2SIg==
X-Google-Smtp-Source: AGHT+IFgIhycDm1qh/8+JJ8Hmk+k0bbYFrcN8QhfPuexG+Fpnt9wX3iNAgyBTgxRPgmvj6Q0hfE2Gw==
X-Received: by 2002:a05:620a:1095:b0:790:a3ce:a761 with SMTP id
 g21-20020a05620a109500b00790a3cea761mr9228874qkk.2.1714227076134; 
 Sat, 27 Apr 2024 07:11:16 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 04/18] cmd/Kconfig: Add some missing dependencies
Date: Sat, 27 Apr 2024 08:10:52 -0600
Message-Id: <20240427141106.3406000-5-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
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

With the migration to Kconfig complete, we can now add some previously
missing dependencies to some commands.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig | 8 ++++++--
 env/Kconfig | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c182d73ddbd7..d9df34942d4f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -539,6 +539,7 @@ config CMD_IMI
 
 config CMD_IMLS
 	bool "imls"
+	depends on MTD_NOR_FLASH || FLASH_CFI_DRIVER
 	help
 	  List all images found in flash
 
@@ -830,7 +831,7 @@ config SYS_EEPROM_SIZE
 
 config SYS_EEPROM_PAGE_WRITE_BITS
 	int "Number of bits used to address bytes in a single page"
-	depends on CMD_EEPROM
+	depends on CMD_EEPROM || ENV_IS_IN_EEPROM
 	default 8
 	help
 	  The EEPROM page size is 2^SYS_EEPROM_PAGE_WRITE_BITS.
@@ -1022,8 +1023,8 @@ config CMD_ARMFFA
 		- Displaying the arm_ffa device info
 
 config CMD_ARMFLASH
-	#depends on FLASH_CFI_DRIVER
 	bool "armflash"
+	depends on FLASH_CFI_DRIVER
 	help
 	  ARM Ltd reference designs flash partition access
 
@@ -1166,6 +1167,7 @@ config CMD_FPGA_LOAD_SECURE
 
 config CMD_FPGAD
 	bool "fpgad - dump FPGA registers"
+	depends on GDSYS_LEGACY_DRIVERS
 	help
 	  (legacy, needs conversion to driver model)
 	  Provides a way to dump FPGA registers by calling the board-specific
@@ -1601,6 +1603,7 @@ config CMD_TEMPERATURE
 
 config CMD_TSI148
 	bool "tsi148 - Command to access tsi148 device"
+	depends on DM_PCI_COMPAT
 	help
 	  This provides various sub-commands to initialise and configure the
 	  Turndra tsi148 device. See the command help for full details.
@@ -1614,6 +1617,7 @@ config CMD_UFS
 
 config CMD_UNIVERSE
 	bool "universe - Command to set up the Turndra Universe controller"
+	depends on DM_PCI_COMPAT
 	help
 	  This allows setting up the VMEbus provided by this controller.
 	  See the command help for full details.
diff --git a/env/Kconfig b/env/Kconfig
index 1f8e90af55e5..9641abe371a0 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -312,7 +312,7 @@ config ENV_IS_IN_NVRAM
 
 config ENV_IS_IN_ONENAND
 	bool "Environment is in OneNAND"
-	depends on !CHAIN_OF_TRUST
+	depends on !CHAIN_OF_TRUST && CMD_ONENAND
 	help
 	  Define this if you want to put your local device's environment in
 	  OneNAND.
-- 
2.34.1

