Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ED5C47E49
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F9F087C3B;
	Mon, 22 Jan 2024 23:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YVjcKW5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B4287BFD; Mon, 22 Jan 2024 23:39:30 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E00A9879CC
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dc226bad48cso2276775276.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963166; x=1706567966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaKkEWTRy7FKkqWWtCL+l1alTzGDd/6rK8fxtrxNki8=;
 b=YVjcKW5V5j8AlA8gWF9wfUmdFPsGjt6UwxV+IrdFYXfyjaOJiImsMeSv2AbmVcDBG2
 PiImji8PReHe2p78HcXvB/AcLer+dfGbEJJA3liCfjcDYrL+y47Cz1coviDnDmqjnuOE
 Pxe4JpCk42xqJdLzJPL0bpoNf/weTd3Yj/Rdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963166; x=1706567966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MaKkEWTRy7FKkqWWtCL+l1alTzGDd/6rK8fxtrxNki8=;
 b=eoF2jY06ATrIWRja6ESlzAjFsPMkOpiIrvCqDeK0xML1LqIxz0WO3vS2MCJMCSlnXa
 pv6mPcgT1hMuno1zor8I/tLK2HEBSf2IYpzy70P4Y/JvfT8iQF/NzP2glwFjlYUw/6yl
 NPhpgu+j0TVoRbAA0CcCL/PuX5RIp/TkFqC1+FwTtiQBX305USYr+nQwy7XblEZqS/Ca
 iU0i75KYWQgVXQlciIvr3DRKE+ouBxoDyaJvvNbfhW9hxv8SVLSk7r5TFMvTKF8xSIZE
 uevQiM414OvTclYfj/2G2S9DHYFBmOGaRobHgWrgULnbso4NwHF3u7XAJSzFCQ9SfcYs
 5NnA==
X-Gm-Message-State: AOJu0YznW3JpxTceEhrZ3vEIFdVYGHQLxSxE4LuENLahwMkX6+Q+RHnU
 bVwI/u5r5SmyQYUM/yLmkK1QlNgYq7m8U8A0+anXURzfCH8Zrz0r5XUT637G05Ck8BVxFD7cQaP
 Z
X-Google-Smtp-Source: AGHT+IE9L+B8GGs1LpXrwfcN0X34YldzPvn4sHunxQEbN5r2LM23mAOmNY7tAUc9MigmHjqF5dr0Hw==
X-Received: by 2002:a5b:1ca:0:b0:dbd:72cc:75d8 with SMTP id
 f10-20020a5b01ca000000b00dbd72cc75d8mr2355773ybp.71.1705963166369; 
 Mon, 22 Jan 2024 14:39:26 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 06/16] cougarcanyon2: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:10 -0500
Message-Id: <20240122223920.3630168-6-trini@konsulko.com>
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
lack of board.h file, unset this on the cougarcanyon2 platform and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 board/intel/cougarcanyon2/Kconfig     | 3 ---
 board/intel/cougarcanyon2/MAINTAINERS | 1 -
 include/configs/cougarcanyon2.h       | 4 ----
 3 files changed, 8 deletions(-)
 delete mode 100644 include/configs/cougarcanyon2.h

diff --git a/board/intel/cougarcanyon2/Kconfig b/board/intel/cougarcanyon2/Kconfig
index 32407025bc16..841e041167e8 100644
--- a/board/intel/cougarcanyon2/Kconfig
+++ b/board/intel/cougarcanyon2/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "ivybridge"
 
-config SYS_CONFIG_NAME
-	default "cougarcanyon2"
-
 config TEXT_BASE
 	default 0xffe00000
 
diff --git a/board/intel/cougarcanyon2/MAINTAINERS b/board/intel/cougarcanyon2/MAINTAINERS
index a486739b5eea..a4f465cf5df3 100644
--- a/board/intel/cougarcanyon2/MAINTAINERS
+++ b/board/intel/cougarcanyon2/MAINTAINERS
@@ -2,5 +2,4 @@ INTEL COUGAR CANYON 2 BOARD
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 F:	board/intel/cougarcanyon2/
-F:	include/configs/cougarcanyon2.h
 F:	configs/cougarcanyon2_defconfig
diff --git a/include/configs/cougarcanyon2.h b/include/configs/cougarcanyon2.h
deleted file mode 100644
index 0406786f7c66..000000000000
--- a/include/configs/cougarcanyon2.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2016, Bin Meng <bmeng.cn@gmail.com>
- */
-- 
2.34.1

