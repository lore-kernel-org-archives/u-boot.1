Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42342C46CD2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3428798B;
	Mon, 22 Jan 2024 23:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DDoD6o24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FC1C87B36; Mon, 22 Jan 2024 23:39:27 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A24879CC
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dafe04717baso2951361276.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963164; x=1706567964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0w+RdzDLffUGtGcsPjk5G1U7QCUCwuzHY/b2XJIFHrI=;
 b=DDoD6o24SWBUZoYlaAVQDcMCELfhxmZICrVSEgaWBQIOjAdTkY2GmGf5GPiUhaqcJg
 LGkp2AKolxMH/5+RhAG5xg8yKkPRbXnM0tfW/5XwSXB23Ve10BZQ+JsylB69yzCTOm0Y
 04hdqOIGAdf0nUIIRHqDtMJIQdg8JJeMAKgLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963164; x=1706567964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0w+RdzDLffUGtGcsPjk5G1U7QCUCwuzHY/b2XJIFHrI=;
 b=LxoQR3tD7nHRIPYXUUCuCtR/cAQGVa6IRX/Iq12HF58mx/lb8T0I0qU+06GGCmvDCK
 jDoOuhCj77QLwRu8LSwoxC9lA6KBC7zIsX9tLYw4PpO+YoiWC8jBGbTOLdWvoGIROZN+
 /bihYPfIspDvm9WB4WGDDlqlgFDLRJaa+PVyqt5S3j+L1mxBTCopIAmgiDOq+fmvZWRb
 WA6cwyy2tqrdGpAB8xdd+1vYGtzHsVBiuro74Ip5GuIK3reflQbciAGMCcfBqGs1Agl9
 66z8hXZlerItae0s9ridwdIYcdCZDa5gpWKBPXofwXoe4UOxeBgNcjRcz+0KioUST03i
 I/ng==
X-Gm-Message-State: AOJu0Yz/PqYBBea/seZ1vxiUJo1nL7/N7zthLKQsjOsEOsCi794cfA9L
 6KfMDcIoxju3TAulLDkCu3meIH2+V+i6T7cfAN1ZRMx79orf/f41ghJMvSWiyVazoICqzD79iIe
 5
X-Google-Smtp-Source: AGHT+IF6N9NhCYMqm+SoveVS59QKL8lY4LPqFg3zrlWAjYMNxcTv3TuWutQBOcDmuHbpJ73Ir0pjSQ==
X-Received: by 2002:a5b:70b:0:b0:dc2:3af4:4a18 with SMTP id
 g11-20020a5b070b000000b00dc23af44a18mr2870400ybq.20.1705963163824; 
 Mon, 22 Jan 2024 14:39:23 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 03/16] coreboot: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:07 -0500
Message-Id: <20240122223920.3630168-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122223920.3630168-1-trini@konsulko.com>
References: <20240122223920.3630168-1-trini@konsulko.com>
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

Now that we support having CONFIG_SYS_CONFIG_NAME be unset to indicate a
lack of board.h file, unset this on the coreboot platform and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 board/coreboot/coreboot/Kconfig     | 7 -------
 board/coreboot/coreboot/MAINTAINERS | 1 -
 include/configs/coreboot.h          | 4 ----
 3 files changed, 12 deletions(-)
 delete mode 100644 include/configs/coreboot.h

diff --git a/board/coreboot/coreboot/Kconfig b/board/coreboot/coreboot/Kconfig
index 4f41ce1abf10..abbf08ac695e 100644
--- a/board/coreboot/coreboot/Kconfig
+++ b/board/coreboot/coreboot/Kconfig
@@ -29,10 +29,3 @@ config SYS_CAR_SIZE
 	  This option specifies the board specific Cache-As-RAM (CAR) size.
 
 endif  # CONFIG_VENDOR_COREBOOT
-
-if TARGET_COREBOOT
-
-config SYS_CONFIG_NAME
-	default "coreboot"
-
-endif
diff --git a/board/coreboot/coreboot/MAINTAINERS b/board/coreboot/coreboot/MAINTAINERS
index f77736580006..d97383c030cd 100644
--- a/board/coreboot/coreboot/MAINTAINERS
+++ b/board/coreboot/coreboot/MAINTAINERS
@@ -2,7 +2,6 @@ COREBOOT BOARD
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	board/coreboot/
-F:	include/configs/coreboot.h
 F:	configs/coreboot_defconfig
 
 COREBOOT64 BOARD
diff --git a/include/configs/coreboot.h b/include/configs/coreboot.h
deleted file mode 100644
index e00c408f29a5..000000000000
--- a/include/configs/coreboot.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
- */
-- 
2.34.1

