Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECECC47DDC
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4655787C9D;
	Mon, 22 Jan 2024 23:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vpzhi14h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EF687C0F; Mon, 22 Jan 2024 23:39:35 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA38087C8A
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dc236729a2bso3040068276.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963171; x=1706567971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3QagKw3wlyjULW5cVlUT3X/49Xox5eRTzUyp+3tOG8=;
 b=Vpzhi14hy2/kGGWQCTnaG/9bq9BXhv01EBiilr3wmzZ4e5mYT+i5N7a2/O0uY8qc+Z
 gspQnXZilNL/mQ2EVwzPP0pnLZyP+62y6H/KVbL0/vf+FXSAQsdLtnjlVehqTls8+ygy
 OONpbsn9/1PchwlcP50a/Vju/zK3ForWoacwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963171; x=1706567971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3QagKw3wlyjULW5cVlUT3X/49Xox5eRTzUyp+3tOG8=;
 b=iaQ8ZmuX3aSIKkZAC+CJireZc234mkRILcDEKMue5XczOTTjaCGbq2yzEkJfW7mpVo
 aD2pSbJvRzDcUvLODVfVDOCYvdN7bASB7MJ3128ckulla6zkr85vJ7oegw4lHNO4TSp0
 6HHyPHfBqxUdlpiO3k1uVY89XOlq33iAstO1G/eRv/NP+UCBrCVjbFLPTiW8Nxgxp+ur
 OnilTgXobUNAtLe7SB7EySu0QJW6Yfiuu055PFjrTRGxl8l5Y5GuxVjaGikLqEM0lzRo
 IAR8bjv6SSHFuzSaH72iggglf7Zt6PZ4XA82wGqKnbmVXYPrj5uz3FxhLmGcpeYwZNs9
 IE6g==
X-Gm-Message-State: AOJu0YxowMel9QS8b41rigbMGPl9kEYdJ07QLpYNMrRXZ29cqSkrVAh9
 AKPHIxGIhQTMiun6furh5aFZpMRAbGHWQhOi+fGBneBZJ9gMDlkoaUIEUaFH1fZP0wj4rgU4cHq
 m
X-Google-Smtp-Source: AGHT+IElkh11UuTNPGUyYUIsk2L6sp98VkfZyUwMtjJFJF7J+77CExRx+GCXMTOk4LPY4Vf5oSNU2w==
X-Received: by 2002:a25:ef51:0:b0:dc2:4126:fc63 with SMTP id
 w17-20020a25ef51000000b00dc24126fc63mr2864707ybm.91.1705963171417; 
 Mon, 22 Jan 2024 14:39:31 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 12/16] minnowmax: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:16 -0500
Message-Id: <20240122223920.3630168-12-trini@konsulko.com>
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
lack of board.h file, unset this on the minnowmax platform and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 board/intel/minnowmax/Kconfig     | 3 ---
 board/intel/minnowmax/MAINTAINERS | 1 -
 include/configs/minnowmax.h       | 4 ----
 3 files changed, 8 deletions(-)
 delete mode 100644 include/configs/minnowmax.h

diff --git a/board/intel/minnowmax/Kconfig b/board/intel/minnowmax/Kconfig
index a03ef8678014..abb1d45ff614 100644
--- a/board/intel/minnowmax/Kconfig
+++ b/board/intel/minnowmax/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "baytrail"
 
-config SYS_CONFIG_NAME
-	default "minnowmax"
-
 config TEXT_BASE
 	default 0xfff00000
 
diff --git a/board/intel/minnowmax/MAINTAINERS b/board/intel/minnowmax/MAINTAINERS
index d655761d5783..5cb94b0f36c6 100644
--- a/board/intel/minnowmax/MAINTAINERS
+++ b/board/intel/minnowmax/MAINTAINERS
@@ -2,5 +2,4 @@ CircuitCo Minnowboard Max
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	board/intel/minnowmax
-F:	include/configs/minnowmax.h
 F:	configs/minnowmax_defconfig
diff --git a/include/configs/minnowmax.h b/include/configs/minnowmax.h
deleted file mode 100644
index 068a2af2c1fc..000000000000
--- a/include/configs/minnowmax.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2015 Google, Inc
- */
-- 
2.34.1

