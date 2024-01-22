Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B719DC47DDC
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C3687CAE;
	Mon, 22 Jan 2024 23:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MAEtHxLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49EA287CA1; Mon, 22 Jan 2024 23:39:36 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 354AC87949
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5ff7dd8d7ceso31627647b3.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963172; x=1706567972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPjF4zSrqGNSSRrUW25eQ094FDR+k9FCK0wytMZEwko=;
 b=MAEtHxLSPRHlUv7XthaNiekjnLg4J1AJt9+/xIjp9TXKglpSWG9ppbxHI4xHq1sRsr
 ERPLV8VGgV+abxRWn3R3m6q32QB1ilcmZ4VBQvjdcy6Q/4Rp6GXqTgP1HFgyiBNMtgDv
 e5lV7E1FU64rUfU/FzAKc84F3wc87/f1qilDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963172; x=1706567972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPjF4zSrqGNSSRrUW25eQ094FDR+k9FCK0wytMZEwko=;
 b=edsprT5niOw7fVbt44EyVR82weLL8dr8lhrpgSHpQtB93uG1HBIKbq1M1f6XSsRMNV
 +RqRjAGQnT1ltWO0ohGoC3NwMeleQiMlwCw6gbXmMD9Nu0vZOX83cFGdhmB2IlqBS04r
 7PL8aWSyczafd/ZNtE7FuRvULy92Ch3bg/rqNKMXtKtI0Wg3PxsUdY75YLrGo2EqinEF
 8kzjMmNMeczToG25KKD3MnZYPrVrHuXM9GV4IqqWXJQ9qV/Aa7zrvApMaMSV6sHHS0cH
 C+7QXcWrTx1CQadJnXWW/tG895Qpuzepx9iGdHB23QFzVEt1MNNfBfAsi8kdYWgLyd2+
 wTDg==
X-Gm-Message-State: AOJu0YwUNrv0iNYjgk9vG7kv9ghkrfV4pvYjTjvlMEb1olNjts3x0jAc
 NLY8n+2GYkmDQbXnh+Z0Xj6vuP/iwJWol7x2g2VaqVWyM7438MOZeHqhrxppIOX97vyD3azuxk5
 n
X-Google-Smtp-Source: AGHT+IFoaZB2NzIjOU9mAN9NEjnrR793E9JPqiblUHCGLHjR/+y5SiuDM16gnZZtEj04w6lEOfEXdA==
X-Received: by 2002:a5b:1cf:0:b0:d80:68d1:b826 with SMTP id
 f15-20020a5b01cf000000b00d8068d1b826mr2659943ybp.6.1705963172070; 
 Mon, 22 Jan 2024 14:39:32 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 13/16] qemu-x86*: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:17 -0500
Message-Id: <20240122223920.3630168-13-trini@konsulko.com>
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
lack of board.h file, unset this on the qemu-x86* platforms and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 board/emulation/qemu-x86/Kconfig     | 3 ---
 board/emulation/qemu-x86/MAINTAINERS | 2 --
 include/configs/qemu-x86.h           | 4 ----
 3 files changed, 9 deletions(-)
 delete mode 100644 include/configs/qemu-x86.h

diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
index 01dc1d497aec..9a0611820ce1 100644
--- a/board/emulation/qemu-x86/Kconfig
+++ b/board/emulation/qemu-x86/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "qemu"
 
-config SYS_CONFIG_NAME
-	default "qemu-x86"
-
 config TEXT_BASE
 	default 0xfff00000 if !SUPPORT_SPL
 	default 0x01110000 if SUPPORT_SPL
diff --git a/board/emulation/qemu-x86/MAINTAINERS b/board/emulation/qemu-x86/MAINTAINERS
index e62585a65d7d..efb8b46daaf4 100644
--- a/board/emulation/qemu-x86/MAINTAINERS
+++ b/board/emulation/qemu-x86/MAINTAINERS
@@ -3,7 +3,6 @@ M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 F:	board/emulation/qemu-x86/
 F:	board/emulation/common/
-F:	include/configs/qemu-x86.h
 F:	configs/qemu-x86_defconfig
 
 QEMU X86 64-bit BOARD
@@ -11,5 +10,4 @@ M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 F:	board/emulation/qemu-x86/
 F:	board/emulation/common/
-F:	include/configs/qemu-x86.h
 F:	configs/qemu-x86_64_defconfig
diff --git a/include/configs/qemu-x86.h b/include/configs/qemu-x86.h
deleted file mode 100644
index 9b0f5cedcd79..000000000000
--- a/include/configs/qemu-x86.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
- */
-- 
2.34.1

