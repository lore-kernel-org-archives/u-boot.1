Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1387DC47DDC
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB0387CBC;
	Mon, 22 Jan 2024 23:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xv8iLdKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D04F87BA2; Mon, 22 Jan 2024 23:39:37 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2075D87BC1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-600094c5703so11401987b3.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963173; x=1706567973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icM+91pkd3CoFnnz40NSeg55O0GPOA7wAZ5c6Zf3HGE=;
 b=Xv8iLdKHQKBlJIpaVyurqMuIlGXykzpQCa5qrGbE3/gFXR5u03twNR8hxPFGTJfU3Q
 tI8QLgWHebtiZvO75s4OJ+o50y6o9GmDI9METaBLO0PhQZdcyulLiUfaa2glQY2oTlOR
 Kg6y9okdCdmEzucPx47x5ijwFMSTcdFWKE+4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963173; x=1706567973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=icM+91pkd3CoFnnz40NSeg55O0GPOA7wAZ5c6Zf3HGE=;
 b=fn4sH3hyo290M5x02rwTlyBsH67BIriAAXsHDgJ7QVWQd3FZdn3JRAk/ULD2FqVvbm
 U21aNxXplXzsWdxPIoEbJyWINkHSQMFza3uKWHJ7gep4pduu5WbHeoEOewjVK6PbpRn5
 Qrr2p9lfyWyuTh8WRizqpbz63INvT9VvW1RncKoMmpEkzz2ct075c0a7e/wTOuy6z6H9
 BugiQNFkV1f3u+V2UhqhOkpNs/4AKYwOsKm4BpB5Zw3/ZbYkAdgCe6PZ15kDPAdwi8TF
 JhdJ3XHVuRmO6hinW7GRS5KQmBwQQMP+U8bA8UG8d1J6vM8JNUmmc3+J4d3z6PP1I0jC
 S9XA==
X-Gm-Message-State: AOJu0YxoXUSRiNm2Tc4qUi+16AgKHuyqDAsKgvOoAvrMjUCibqw7PY4C
 6MUoHkbU1FGqywaDjnfptBb6X+pWJVwWeTtUbjiTj1OcC7cTuQuyTWyezskD4kVTIHcm+qULo5h
 D
X-Google-Smtp-Source: AGHT+IEgJEsILyGU0HQoLk07ZixCzEKKso+jmOhvevC3VmE7WOLOWRXTRjJ5BpQqhcx0W+/lsi3rrQ==
X-Received: by 2002:a25:e0d7:0:b0:dc2:56f0:faf7 with SMTP id
 x206-20020a25e0d7000000b00dc256f0faf7mr2423817ybg.10.1705963173543; 
 Mon, 22 Jan 2024 14:39:33 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Yang Xiwen <firbidden405@outlook.com>
Subject: [PATCH 15/16] hc2910-2aghd05: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:19 -0500
Message-Id: <20240122223920.3630168-15-trini@konsulko.com>
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
lack of board.h file, unset this on the hc2910-2aghd05 platform and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Yang Xiwen <firbidden405@outlook.com>
---
 board/skyworth/hc2910-2aghd05/Kconfig     | 3 ---
 board/skyworth/hc2910-2aghd05/MAINTAINERS | 1 -
 include/configs/hc2910-2aghd05.h          | 6 ------
 3 files changed, 10 deletions(-)
 delete mode 100644 include/configs/hc2910-2aghd05.h

diff --git a/board/skyworth/hc2910-2aghd05/Kconfig b/board/skyworth/hc2910-2aghd05/Kconfig
index f85f1f2631de..620a3177f488 100644
--- a/board/skyworth/hc2910-2aghd05/Kconfig
+++ b/board/skyworth/hc2910-2aghd05/Kconfig
@@ -9,7 +9,4 @@ config SYS_VENDOR
 config SYS_SOC
 	default "hi3798mv200"
 
-config SYS_CONFIG_NAME
-	default "hc2910-2aghd05"
-
 endif
diff --git a/board/skyworth/hc2910-2aghd05/MAINTAINERS b/board/skyworth/hc2910-2aghd05/MAINTAINERS
index 2c1e750018e1..13915556bc5e 100644
--- a/board/skyworth/hc2910-2aghd05/MAINTAINERS
+++ b/board/skyworth/hc2910-2aghd05/MAINTAINERS
@@ -2,5 +2,4 @@ HC2910 2AGHD05 BOARD
 M: Yang Xiwen <firbidden405@outlook.com>
 S: Maintained
 F: board/skyworth/hc2910-2aghd05
-F: include/configs/hc2910-2aghd05.h
 F: configs/hc2910_2aghd05_defconfig
diff --git a/include/configs/hc2910-2aghd05.h b/include/configs/hc2910-2aghd05.h
deleted file mode 100644
index 3db9a474ec7f..000000000000
--- a/include/configs/hc2910-2aghd05.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-
-#ifndef __HC2910_2AGHD05_CONFIG_H__
-#define __HC2910_2AGHD05_CONFIG_H__
-
-#endif
-- 
2.34.1

