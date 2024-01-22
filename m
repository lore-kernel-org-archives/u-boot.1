Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04343C46CD2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3635D87CB5;
	Mon, 22 Jan 2024 23:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BAhreXag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DBE287CA9; Mon, 22 Jan 2024 23:39:36 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50BEE879CC
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc2308fe275so3025119276.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963173; x=1706567973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKAI56ItCRu4KrbnqF2IrEkApEqGAIEN14Sg+3f2B1g=;
 b=BAhreXag854DsdTeuv4CyH/o4jOSOGTnHCp4DPyYF5CK4jbvob3DekKuhZ5wFC2RGc
 eFK5p/XqKuD8YUdi4Kpoc89F3KnJmq8iALmw9y0IPlWUmUeNAfENiHj9+qe2v+eFtxp8
 25tbNNUatd6n/CQ35TpEH5RNg8VgJMF2HG3J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963173; x=1706567973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eKAI56ItCRu4KrbnqF2IrEkApEqGAIEN14Sg+3f2B1g=;
 b=hfYXJRMNPmxDEuQhNMMnR59+dMjo4RcMuR7wLPBDUeVeXvMZh4F5de/NTxdlZdCW9P
 uTbUmJDo+4ipLkvMAbdIB0ESaw7Z4ihBNTpD4AQnW/ke2Bex7v6EAQ/zD53Ls9UWFqUp
 bjffzlrUMPhIJXam3bC/3gEvqkWxw9Xkksuh1P1nZ6SFZx+o1ZFF5Hnwtg+XOi3xucYO
 EbtByJoKoa9pC8fTLBwsdQsrOKFSNcDHlSGHS+GJteuP979N01SbBqYtnBX8vp8Fdue1
 qJNZ1Qg5qrle+VFbX80kHSkRdkSd5tjyfDgj2q8Qll9jNIPZSILkCwWn2vdBYioebKMY
 vNDw==
X-Gm-Message-State: AOJu0Yy8pfl+oahIZh7xPHy+Pjx+raXpyCo4gcUF93JPO7md47FThEiX
 XmVHb4Ox2gBET13pPTT9/x9Kw1vjcmnXbHXSHXpjOD9sr1SdUTWDsjnEBSj/iif3Xs2TF/VUEW7
 o
X-Google-Smtp-Source: AGHT+IFs2ARAJiEnc+XA2cI2tYnYuHykYL9BZuAU4Z1dTXbchE2tSA2YnWVz3BtX4mn6NZyvP6n11A==
X-Received: by 2002:a5b:c4b:0:b0:dc2:294e:fd02 with SMTP id
 d11-20020a5b0c4b000000b00dc2294efd02mr2608563ybr.38.1705963172643; 
 Mon, 22 Jan 2024 14:39:32 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Aiden Park <aiden.park@intel.com>
Subject: [PATCH 14/16] slimbootloader: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:18 -0500
Message-Id: <20240122223920.3630168-14-trini@konsulko.com>
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
lack of board.h file, unset this on the slimbootloader platform and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Aiden Park <aiden.park@intel.com>
---
 board/intel/slimbootloader/Kconfig     | 3 ---
 board/intel/slimbootloader/MAINTAINERS | 1 -
 include/configs/slimbootloader.h       | 4 ----
 3 files changed, 8 deletions(-)
 delete mode 100644 include/configs/slimbootloader.h

diff --git a/board/intel/slimbootloader/Kconfig b/board/intel/slimbootloader/Kconfig
index 015ed51dc89c..11e6cb37bd85 100644
--- a/board/intel/slimbootloader/Kconfig
+++ b/board/intel/slimbootloader/Kconfig
@@ -13,9 +13,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "slimbootloader"
 
-config SYS_CONFIG_NAME
-	default "slimbootloader"
-
 config TEXT_BASE
 	default 0x00100000
 
diff --git a/board/intel/slimbootloader/MAINTAINERS b/board/intel/slimbootloader/MAINTAINERS
index e6935517e01a..0208a382ac6b 100644
--- a/board/intel/slimbootloader/MAINTAINERS
+++ b/board/intel/slimbootloader/MAINTAINERS
@@ -2,5 +2,4 @@ Intel Slim Bootloader Payload
 M:	Aiden Park <aiden.park@intel.com>
 S:	Maintained
 F:	board/intel/slimbootloader
-F:	include/configs/slimbootloader.h
 F:	configs/slimbootloader_defconfig
diff --git a/include/configs/slimbootloader.h b/include/configs/slimbootloader.h
deleted file mode 100644
index 85f6a968e040..000000000000
--- a/include/configs/slimbootloader.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2019 Intel Corporation <www.intel.com>
- */
-- 
2.34.1

