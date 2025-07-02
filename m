Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CAFC83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40AB982F30;
	Wed,  2 Jul 2025 03:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rpHlqY0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 420BC82F5D; Wed,  2 Jul 2025 03:04:13 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2138382EB8
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2eacb421554so1146082fac.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418250; x=1752023050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cneBCC6Bd5qhG5mhbRLHDMbyWw8RLDPlwhnTXVswQfY=;
 b=rpHlqY0hy94XqX1gYSRWLcEHRynph0dSOqQxT2kRYeJZ+LncUkW9hyCnmBmquS1fZC
 QcIUy45QO2JNintdRSiZbSh3tEwSvwWjxCmSUAvoA2IMGPXy7mAGOf0LOWfxWdhWBBLc
 PZ1hkZ4YzjPKrRYq+dR6/VnIX1c/R3uzKW1EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418250; x=1752023050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cneBCC6Bd5qhG5mhbRLHDMbyWw8RLDPlwhnTXVswQfY=;
 b=wlpM+G0pHIvT0wAwaf94tWfAURkrX4wrbHnJkLZBUI1byontio6zv97czY/pixOmh6
 /hyWF0czgt5wdH7oEJT1JG61pmzNXDQUUKQupDtr0VmZqjvu9VJUW7kCs/QNw0XZ9ZXY
 yeJqP5sS+00UV/2y3rPq5F3/p8Urj+sT0XyaGkPzI6vvVeLT0RNeJV34C2yEvVCFcSkH
 VhvgX1BUXaLQFjsibXVerI8BbXt+BGpcN0gqFHCK262vTUwdXwOlWfoGWJKHv9gl8tSG
 +k5OuxNBw1/IHFgyBB8rYrWtpjRDW9380WBqKlu6qiGNABp2FvNF4YU3h6dTNfVHnFou
 Z8wg==
X-Gm-Message-State: AOJu0YyOW5QYga+DsTUfZAFWPv7owRFZ/KWcTjBGlkJJO3jKy1mVCEG7
 jDqWxVkSHlALH+QhoDyHFKIJ53pntQzAxqbtbO0n9CbuTNd3xSKqOqpLtbxXzrJ18bZGRHXG5K6
 inqTukUw=
X-Gm-Gg: ASbGncviTopfuyNtVutZsFJ3xHeWhJAIVKCzIQEfKYyNLCg6hrkIZuGIeleZB0KHkSw
 xSLM9vXZMFLQHYiSQa1+xNhYIo+aCMCp/55nPV1JSl3V+G3VD1C2zPsKxEDTkS3guVrZH0WKmLP
 4QYyeDSk37rFWBajVwwFkR3SDrlk/Cy676MdTyBVQOnjFa/owC6AO9ujpyWMqn/FQOiZw/eg/xQ
 q42kKJ1Ybt27keJGx3XxYsS53sDEJCYPZV0s3mWNLvvdX5o0qf8P1TcOrzUIaihZg5grMjcZZIY
 u78DVKVxYNicX67fQw1q9DCkkRgIZDawrh+12+UhV1Oe8N5PVYtM8yNxtWh2pKqf6W2chTVlDzw
 0ZVNPbpNn9jgu4Td7qTUUHdo=
X-Google-Smtp-Source: AGHT+IG/PY9uDqA31mIaFfQlpLjNHHd1TYS8ReMcxBnqYp6wBQHJErxR5IvMkoQKPl0zv3TV7rXzmQ==
X-Received: by 2002:a05:6870:1b18:b0:2ea:6f56:5c1d with SMTP id
 586e51a60fabf-2f588923c2dmr839678fac.0.1751418249770; 
 Tue, 01 Jul 2025 18:04:09 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ef71e3sm3551937fac.19.2025.07.01.18.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] nand: raw: Kconfig: Correct some dependency issues
Date: Tue,  1 Jul 2025 19:04:07 -0600
Message-ID: <20250702010407.18808-1-trini@konsulko.com>
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

The hidden symbol SPL_SYS_NAND_SELF_INIT was not being used correctly
leading to Kconfig dependency issues seen with "make allyesconfig". As
it's a select'd symbol we don't need to have a depends line on it, and
then in turn we need to also update the logic on SYS_NAND_PAGE_SIZE and
SYS_NAND_OOBSIZE.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/mtd/nand/raw/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index adb271dfb8fb..c9b4450aafa1 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -11,7 +11,6 @@ config SYS_NAND_SELF_INIT
 
 config SPL_SYS_NAND_SELF_INIT
 	bool
-	depends on !SPL_NAND_SIMPLE
 	help
 	  This option, if enabled, provides more flexible and linux-like
 	  NAND initialization process, in SPL.
@@ -689,7 +688,6 @@ config SYS_NAND_PAGE_SIZE
 		MVEBU_SPL_BOOT_DEVICE_NAND || \
 		(NAND_ATMEL && SPL_NAND_SUPPORT) || \
 		SPL_GENERATE_ATMEL_PMECC_HEADER || NAND_SANDBOX || NAND_CADENCE
-	depends on !NAND_MXS && !NAND_DENALI_DT && !NAND_LPC32XX_MLC && !NAND_MT7621
 	help
 	  Number of data bytes in one page for the NAND chip on the
 	  board, not including the OOB area.
@@ -699,7 +697,6 @@ config SYS_NAND_OOBSIZE
 	depends on ARCH_SUNXI || NAND_OMAP_GPMC || NAND_LPC32XX_SLC || \
 		SPL_NAND_SIMPLE || (NAND_MXC && SPL_NAND_SUPPORT) || \
 		(NAND_ATMEL && SPL_NAND_SUPPORT) || SPL_GENERATE_ATMEL_PMECC_HEADER
-	depends on !NAND_MXS && !NAND_DENALI_DT && !NAND_LPC32XX_MLC
 	help
 	  Number of bytes in the Out-Of-Band area for the NAND chip on
 	  the board.
-- 
2.43.0

