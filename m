Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A297CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459EE83847;
	Fri, 26 Sep 2025 17:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SgZ4cL8Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD24A83847; Fri, 26 Sep 2025 17:31:45 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60F4583852
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7a7c1ecd433so909516a34.3
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758900702; x=1759505502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ow9j1yRYG9JpPCE2EPhcjwS6c5g0NJ0Z2vFbXvYeBIs=;
 b=SgZ4cL8Q1YHiJEN7vb0p+Is80dafBeWOjf2IryJN6/M5LLV7M9J9MXK5udVDrV3VJx
 MAsGuSYI9I/FdH6dH92suzpRzOcZg4Z0U9NlT2rmNca2t21nTy2Rknv8Wj2HUlGk6KCn
 5zXyPFCbsnoV+ToIEWpJ2MijUI+P5hDoovOt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758900702; x=1759505502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ow9j1yRYG9JpPCE2EPhcjwS6c5g0NJ0Z2vFbXvYeBIs=;
 b=QmRpMHzoXFz73agfz22TTXF2Sg/EY0LsoJwRbGL3R5ijzxPlfRu3C7bzp9qgujAOXY
 2X/2KcTL/cK3yK2WQsGjzH6gZZcyRfeLx7H5snJElcHiFpjKkCOK2fn/baU29Sllcuvt
 tRsCTxt0zCUEXhBHngh9ZHgWl5OPGr4T8N3QQh8TQnPgOAXWKr3EKVjLJVWMUpk91sXc
 d8g/yH1GpEM7IWhvksipk9sEbhXnKdKyTs9l1gx/Y0Y54Q5pbFUIdheAePugsOS2cXJZ
 Cg2H+wzWWj7caqO7kbaeaIpvHFBFYD9T59Kcd1V+GY4XwgCFahqZNUzz7aEd1ER321Kz
 rKCw==
X-Gm-Message-State: AOJu0YyaR+KMek1jbQ9/aJsxYr2udYIh0ETdTpEHry4rJl1Hny90lRg7
 IBYOGYquFtfwZ+Z5GfRUqzyz0Q7PypNiPbs40VfScUxOdq5W+gWWCY34sCUgsCvoMV5FYJX+L5W
 RwXqVmP4=
X-Gm-Gg: ASbGncsvBVE6Klr7fU/WAfq5A/VhECA1hzWxkwekvyrGHhS1BFv6F28wxWclyVFYgxW
 DeJO0FRm4zEocYd5uMhzhAcJIVbrscSA7bRZs99KIdsXztTeWAe7FxVsLAi2MzbU7+AShZqTk99
 rEpjPPeFWQVbLkw3AD+2xqg9v4icPq/HsEb0A5EAm/682ghjMjscmlTl6q6ddidSjMVfWRx7Nm2
 gvLp5IBho2uppEjXgNiXDdcJRfqvd/ZZVvGR7ldULFjkfWqR1mSmKhP5EtRmdis8fCQ2888F68d
 mgEvOvDYpb60SfsROX3WcxHSJegXs3utMN1+Bky0EBo6AhMPCxDqCLb4yFmZV0/88Dut+/DyfQA
 uEIHsRRDIpUuymWxnKuc+N7pBqeDGL6mKJ//oss5nzJAiCggn8CmOIMAJEUEnG0KyryQR+A==
X-Google-Smtp-Source: AGHT+IGQAxY5pp9AEKT1hCI2lKL0AVoQzqoX0TBejtqPVJHRe+Xfm/hmZOw9En3LdfnpT9gzJBjCUw==
X-Received: by 2002:a05:6830:668e:b0:79b:bd93:3bae with SMTP id
 46e09a7af769-7a046e4e6cbmr4683651a34.18.1758900701980; 
 Fri, 26 Sep 2025 08:31:41 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a647dd1b3sm1970927173.5.2025.09.26.08.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:31:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] mtd: Tighten some driver dependencies
Date: Fri, 26 Sep 2025 09:31:40 -0600
Message-ID: <20250926153140.3680901-1-trini@konsulko.com>
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

The ALTERA_QSPI driver conflicts with the regular FLASH_CFI_DRIVER as
both implement the same high level functionality and so use the same
global namespace. In a similar fashion, all NAND drivers are mutually
exclusive due to namespace collisions. For the remaining drivers which
did not already have some architecture specific dependency, add them.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/mtd/Kconfig          | 2 +-
 drivers/mtd/nand/raw/Kconfig | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 86752b5926de..21b8b21f6b22 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -186,7 +186,7 @@ config FLASH_VERIFY
 
 config ALTERA_QSPI
 	bool "Altera Generic Quad SPI Controller"
-	depends on DM_MTD
+	depends on DM_MTD && !FLASH_CFI_DRIVER
 	select USE_SYS_MAX_FLASH_BANKS
 	help
 	  This enables access to Altera EPCQ/EPCS flash chips using the
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index f083113486ed..58ffa826d71b 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -218,7 +218,7 @@ config NAND_DENALI_DT
 	bool "Support Denali NAND controller as a DT device"
 	select NAND_DENALI
 	select SPL_SYS_NAND_SELF_INIT
-	depends on OF_CONTROL && DM_MTD
+	depends on OF_CONTROL && DM_MTD && (ARCH_SOCFPGA || ARCH_UNIPHIER)
 	help
 	  Enable the driver for NAND flash on platforms using a Denali NAND
 	  controller as a DT device.
@@ -400,6 +400,7 @@ endif
 
 config NAND_VF610_NFC
 	bool "Support for Freescale NFC for VF610"
+	depends on ARCH_VF610
 	select SYS_NAND_SELF_INIT
 	select SYS_NAND_DRIVER_ECC_LAYOUT
 	imply CMD_NAND
-- 
2.43.0

