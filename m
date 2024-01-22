Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040FFC46CD2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB89487BAF;
	Mon, 22 Jan 2024 23:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tk+2v3hz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B431879FB; Mon, 22 Jan 2024 23:39:31 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D139F87B93
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-db3fa47c2f7so3121303276.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963167; x=1706567967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JjVzuNe+XBRDPxd0SzTX5rePdsheyqesXWCQI2ZQa4=;
 b=tk+2v3hzmyM3yTWmB1hJAbu/Y/znmWviyfNImhT96azJ8stGv075NvkNNuzOdX96h3
 7mllzRuFUqMqwjv5rvDiAjNpGXyJn6PZfQBc6XdWDz9wFNHFvqBm/ZVNzm3iPqm6NMUG
 n2GEhFjZfKtbqKfX/tDZz481BYr6v/vwyPsQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963167; x=1706567967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JjVzuNe+XBRDPxd0SzTX5rePdsheyqesXWCQI2ZQa4=;
 b=V6v9BPzebFhNyjij7ju0k+AjF550vAZlS1rW5aSockROs4B3r2AtiOI0NXQ2wL3Lzr
 vXzuhLiSGsPR0VMpFiJ42ICFYYvDOmZDc25NIs+9E42KiEEC/1fYLKY4htEEPfRn8KAJ
 GtGXm7AppF7c/M4r1bY5Yg1JiOsBwNs4Jq2Hx1QlSVpDxVukbQlXjgCr5oy0R1tnroMT
 rL9CfRc4lsvqEUo26bIaH6x7eeaPXc95exNctWFUdiOkBjiVIDst7P2+UzI9Y8zyq26A
 addAFq2PkjcanZ1DjH5nMbjIl9rCLTDpGLZD8tx5FEnq62dJZHAg2qlAK6KADhuuX5f7
 Wyvg==
X-Gm-Message-State: AOJu0YxyNsZpYt7ZWDODorrSX385rqvFkRrgfBtjLEuGKwIYZ2OVYlY2
 T4EhFM4GyHeIm8jkLBZMQrXeU+Tk8X/toaFYhaX0XrdWssQRlU6XG+qNfqMPta9hDxCVQu/4wBy
 4
X-Google-Smtp-Source: AGHT+IE8n/FiMcUMf7s/ITg3ezLd0XtKjbC9nBxnz4rd92/7PFEqVKnhSYmdtkOpjsL5lQz2UkxPqQ==
X-Received: by 2002:a25:bfcb:0:b0:dc2:331e:48bd with SMTP id
 q11-20020a25bfcb000000b00dc2331e48bdmr2873402ybm.44.1705963167234; 
 Mon, 22 Jan 2024 14:39:27 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 07/16] crownbay: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:11 -0500
Message-Id: <20240122223920.3630168-7-trini@konsulko.com>
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
lack of board.h file, unset this on the crownbay platform and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 board/intel/crownbay/Kconfig     | 3 ---
 board/intel/crownbay/MAINTAINERS | 1 -
 include/configs/crownbay.h       | 4 ----
 3 files changed, 8 deletions(-)
 delete mode 100644 include/configs/crownbay.h

diff --git a/board/intel/crownbay/Kconfig b/board/intel/crownbay/Kconfig
index eb2290cfafbe..09614ab8d155 100644
--- a/board/intel/crownbay/Kconfig
+++ b/board/intel/crownbay/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "queensbay"
 
-config SYS_CONFIG_NAME
-	default "crownbay"
-
 config TEXT_BASE
 	default 0xfff00000
 
diff --git a/board/intel/crownbay/MAINTAINERS b/board/intel/crownbay/MAINTAINERS
index 1eb68693df3e..e2d8e6bc1d0d 100644
--- a/board/intel/crownbay/MAINTAINERS
+++ b/board/intel/crownbay/MAINTAINERS
@@ -2,5 +2,4 @@ INTEL CROWNBAY BOARD
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 F:	board/intel/crownbay/
-F:	include/configs/crownbay.h
 F:	configs/crownbay_defconfig
diff --git a/include/configs/crownbay.h b/include/configs/crownbay.h
deleted file mode 100644
index 0c842dd01ebe..000000000000
--- a/include/configs/crownbay.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
- */
-- 
2.34.1

