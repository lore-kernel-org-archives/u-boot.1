Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54760C46CD2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F4F87BFD;
	Mon, 22 Jan 2024 23:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tLxiYOuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAAC987C08; Mon, 22 Jan 2024 23:39:31 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA5E187BF6
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5ff88cbbcceso28858267b3.2
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963168; x=1706567968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0h/E/soSVngWQTI2UyOFcYX19QLzklxMOULj1K/Goa4=;
 b=tLxiYOuh/HFVNSfgbEqd7CGOXTdg6rdwJ38waGOYnqFu3Yf/BYa+DoN0F63DhEaLV3
 xjTyNd37u8lViuMX13ca5jw8/j0TdC4PF2BV6/RawmyEBm6yHexPU5q5SsGDM+Bim3+g
 LBqHLoDVoW9CklQ474NC2kwzPOpCKAwLyigPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963168; x=1706567968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0h/E/soSVngWQTI2UyOFcYX19QLzklxMOULj1K/Goa4=;
 b=d0+eNevkYBAkR+lo+BJgZlFohy8hS43iw9djzrBxBD2gUf1CEpBG0TWXBK3Z70DYMl
 AGkZC4w33hFkFEbH2kUwbMcAyd/AjX0vVmHkxZrGgK+nEBKWFT4GE+2ddEnVVnV2hAGK
 0hZFoU8nICQ8+56L1A4io4kuPdp5QLb5RN5hhhvmN2rD7vRCZ+MxZvSwTNc9ubDOaNoS
 Rtm1Kj+HUVa2O98vu6nOtLRZ7WNG+og03Esrib9Yi48WtHqxfgnIwdZbsQiSK3NP65cy
 n4asU15ezDyUYRt+hrTplWzFFajh0T4h9mOL0zN+X6FfX3rY5FPKYLhCPEWBNhFL8coz
 FSUA==
X-Gm-Message-State: AOJu0Yy55eRE0bCxlOjpwp4/zAJi9YeCdd1WUGqi6UiKbheOV0Z6q6fE
 q/W5Y7jXMTteCgS8wmQhg0PlSJ5v9NAR2EXQDsvxGTGZfGSxrwChLYn0gD477WKT+YqzR4tlJel
 Z
X-Google-Smtp-Source: AGHT+IHWQrIMUaDZ3MIgEaiLZ1yCv8lasIWPvRPtq8bI3HaRIDOKw8SeEG8l6+6EhsoIXn0iq+5h0A==
X-Received: by 2002:a05:6902:2185:b0:dc2:239d:b01c with SMTP id
 dl5-20020a056902218500b00dc2239db01cmr3024474ybb.3.1705963168103; 
 Mon, 22 Jan 2024 14:39:28 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 08/16] edison: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:12 -0500
Message-Id: <20240122223920.3630168-8-trini@konsulko.com>
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
lack of board.h file, unset this on the edison platform and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 board/intel/edison/Kconfig     | 3 ---
 board/intel/edison/MAINTAINERS | 1 -
 include/configs/edison.h       | 4 ----
 3 files changed, 8 deletions(-)
 delete mode 100644 include/configs/edison.h

diff --git a/board/intel/edison/Kconfig b/board/intel/edison/Kconfig
index 5efda4b3a554..daa8d2035cd5 100644
--- a/board/intel/edison/Kconfig
+++ b/board/intel/edison/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "tangier"
 
-config SYS_CONFIG_NAME
-	default "edison"
-
 config SYS_MALLOC_LEN
 	default 0x08000000
 
diff --git a/board/intel/edison/MAINTAINERS b/board/intel/edison/MAINTAINERS
index 4bc4a00c8ad8..26b27c5dfe15 100644
--- a/board/intel/edison/MAINTAINERS
+++ b/board/intel/edison/MAINTAINERS
@@ -2,5 +2,4 @@ Intel Edison Board
 M:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 S:	Maintained
 F:	board/intel/edison
-F:	include/configs/edison.h
 F:	configs/edison_defconfig
diff --git a/include/configs/edison.h b/include/configs/edison.h
deleted file mode 100644
index 127c2c4546e0..000000000000
--- a/include/configs/edison.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2017 Intel Corp.
- */
-- 
2.34.1

