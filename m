Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3E8C46CD2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AADDC87B93;
	Mon, 22 Jan 2024 23:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Aun0TUA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 393C987BC9; Mon, 22 Jan 2024 23:39:29 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04D7F879ED
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dc261316b0dso2704225276.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963165; x=1706567965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEQaeksex4jpEZckud7+vAwgTRE6cHmMjKpwkv+ZP/w=;
 b=Aun0TUA3QcAr+HFIo+tZ+OgRuGBD1jbBi22DzI4WTodW5wQRekjg7N3eoN5GPZPwKN
 k/G5XcpWlGLnag6tfYJMPka3i1XdM2bh2VS1fmdoutXl+BSFCL2H6vNLy3n8HRIqPmtr
 iYUAsm69s4+ytx5kXPZXydKAOzQqr6UqPHUqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963165; x=1706567965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEQaeksex4jpEZckud7+vAwgTRE6cHmMjKpwkv+ZP/w=;
 b=lPymDHffbg8P7AVdKtC25jHGkCIdzKOy4l5pRrbBXyrJzNqKlcyP3wHq87DEPZZHqy
 YRj6vOB2yCJ1W9PjMGhnrNuWeAQbwCXhvln1x3gZiWaBHs6lCxc9QBU3J+zuWU0/q+0O
 i/uRuUeSJhkV3Ro9N+DMyzMlaWqCUQUHxGjM+/mxJ3yXwgPJ4ch9/b+XYkWoCfLKNDis
 3MkSEzPryt/Xe+YK94hObyV8+wjhbHbVm7XBB16kvKQyThVcf/XNQLBX4ttfXPRQAm1x
 r8d9x2nTl9SS1Pj0tUz4DlLXl3cxqqld+iRIJa0SfIyv+0HMJNBvSR3AEaIyoF+2Xakd
 MQxA==
X-Gm-Message-State: AOJu0Yzgbsj/aTKeh+F3C8G/kJjrjCCL8DrsKidFOE7w2uIy/RJzf7kT
 1thjmzjp4LaGfDwKf0TJYK39fGfmrraf4JIB7UcPUMILVKVMVMJNBmZm2YacTwWywzjPO9Fs3XM
 7
X-Google-Smtp-Source: AGHT+IEGYt5sZ26WeO2m1Xsr7pMAbGFogGlQWRj1t13Cy9wmBkN6OPAjKMvQG7zZXb+SHpH87S4eeg==
X-Received: by 2002:a25:c705:0:b0:dc2:526b:7949 with SMTP id
 w5-20020a25c705000000b00dc2526b7949mr2581198ybe.76.1705963165600; 
 Mon, 22 Jan 2024 14:39:25 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 05/16] cherryhill: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:09 -0500
Message-Id: <20240122223920.3630168-5-trini@konsulko.com>
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
lack of board.h file, unset this on the cherryhill platform and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 board/intel/cherryhill/Kconfig     | 3 ---
 board/intel/cherryhill/MAINTAINERS | 1 -
 include/configs/cherryhill.h       | 4 ----
 3 files changed, 8 deletions(-)
 delete mode 100644 include/configs/cherryhill.h

diff --git a/board/intel/cherryhill/Kconfig b/board/intel/cherryhill/Kconfig
index 009cd93b6d44..28e4735e4d65 100644
--- a/board/intel/cherryhill/Kconfig
+++ b/board/intel/cherryhill/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "braswell"
 
-config SYS_CONFIG_NAME
-	default "cherryhill"
-
 config TEXT_BASE
 	default 0xffe00000
 
diff --git a/board/intel/cherryhill/MAINTAINERS b/board/intel/cherryhill/MAINTAINERS
index 6e90f642125e..7c1b311990c4 100644
--- a/board/intel/cherryhill/MAINTAINERS
+++ b/board/intel/cherryhill/MAINTAINERS
@@ -2,5 +2,4 @@ INTEL CHERRYHILL BOARD
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 F:	board/intel/cherryhill/
-F:	include/configs/cherryhill.h
 F:	configs/cherryhill_defconfig
diff --git a/include/configs/cherryhill.h b/include/configs/cherryhill.h
deleted file mode 100644
index a3009571de98..000000000000
--- a/include/configs/cherryhill.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017, Bin Meng <bmeng.cn@gmail.com>
- */
-- 
2.34.1

