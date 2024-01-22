Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763A0C47DDC
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A6287C8A;
	Mon, 22 Jan 2024 23:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rq6i1pE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFEC287C97; Mon, 22 Jan 2024 23:39:32 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB2DF87BFD
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dbed0710c74so3298368276.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963169; x=1706567969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSWmxN4PZUsy5m1VPE5GWVk//BCRKJkgXHNv6QOq1F8=;
 b=Rq6i1pE4Nx8gIYtawgHBofyJhrVDdeHo070Wta6JQy8F08yD7ThSvQCKeeRHxGT4JS
 E4vrsi3SrKpd8qeC9xqbz9haI7vJAPjo5luAvJrlEbmC3shydHkq/Sg7bHjP8bzj6CLl
 2fKHJ23NJRBdw645Qu1TnPoDFU25B85Dbg/do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963169; x=1706567969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSWmxN4PZUsy5m1VPE5GWVk//BCRKJkgXHNv6QOq1F8=;
 b=un9BqtQTuPaET7RKUhn0tk9/HBrjgd3c1sikeG1ZFGCPJIm3jeGt/DNDY67dLPbDzS
 BQVvmWg3jqnDhHNICyf2ElJEgzhBdq7t1s3HOJQVBmEc+hROExEQjz2g3MYnO+O0ACWa
 U6U7y86g90vB/zJXGkdtCQu3cXztXAWx5X82Ot7IEhNalidC3fnsOMqgULV+oJOwtOHG
 ru7lUSgr3szUwQMXbIeR4lOmmjqkg5OgM7Y/iuY34a7R//4F99Fee/XlieuHzcwLVYGk
 4vEDE55ZqR/gHsn9Id0Ryyzo19ZmiEm5tOdiOJ1xt+uS1OJUt9oNkG0iqOLIYJvbRLvq
 ZWnQ==
X-Gm-Message-State: AOJu0Yy6ptt11e8Wc9JqIaQHcPhedpwv1VNGb0vbKUP4XVWzSEm9NzWt
 KqkecwQsUYxpE5eefQyjG6NqPvx3c1PY/nJvt1d92uqbfTErtjJYWxtlLo7p0z9j4nbbhHD3//v
 p
X-Google-Smtp-Source: AGHT+IGOglM+jU530IwIp0kOsJUkNtNp7Z9l4rzxMrF40J3lsoeevxEmb48o4D9Mq607EOplTXRKAw==
X-Received: by 2002:a25:9243:0:b0:dc2:2327:fcff with SMTP id
 e3-20020a259243000000b00dc22327fcffmr3044963ybo.29.1705963169070; 
 Mon, 22 Jan 2024 14:39:29 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 09/16] efi-x86_app: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:13 -0500
Message-Id: <20240122223920.3630168-9-trini@konsulko.com>
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
lack of board.h file, unset this on the efi-x86_app* platforms and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 board/efi/efi-x86_app/Kconfig     | 3 ---
 board/efi/efi-x86_app/MAINTAINERS | 2 --
 include/configs/efi-x86_app.h     | 4 ----
 3 files changed, 9 deletions(-)
 delete mode 100644 include/configs/efi-x86_app.h

diff --git a/board/efi/efi-x86_app/Kconfig b/board/efi/efi-x86_app/Kconfig
index ecd08d73146a..f9cbef0a864c 100644
--- a/board/efi/efi-x86_app/Kconfig
+++ b/board/efi/efi-x86_app/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "efi"
 
-config SYS_CONFIG_NAME
-	default "efi-x86_app"
-
 config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
 	imply VIDEO_EFI
diff --git a/board/efi/efi-x86_app/MAINTAINERS b/board/efi/efi-x86_app/MAINTAINERS
index 584619c51dff..693f367311bc 100644
--- a/board/efi/efi-x86_app/MAINTAINERS
+++ b/board/efi/efi-x86_app/MAINTAINERS
@@ -3,7 +3,6 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	board/efi/Kconfig
 F:	board/efi/efi-x86_app/
-F:	include/configs/efi-x86_app.h
 F:	configs/efi-x86_app32_defconfig
 
 EFI-X86_APP64 BOARD
@@ -11,5 +10,4 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	board/efi/Kconfig
 F:	board/efi/efi-x86_app/
-F:	include/configs/efi-x86_app.h
 F:	configs/efi-x86_app64_defconfig
diff --git a/include/configs/efi-x86_app.h b/include/configs/efi-x86_app.h
deleted file mode 100644
index d5824049d697..000000000000
--- a/include/configs/efi-x86_app.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2015 Google, Inc
- */
-- 
2.34.1

