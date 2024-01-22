Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC110C47DDC
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0A387CA7;
	Mon, 22 Jan 2024 23:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qMFMwCe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86EB3879FB; Mon, 22 Jan 2024 23:39:33 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A9F87949
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dbedb1ee3e4so3262472276.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963170; x=1706567970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XL8m8MSlA/b6/iFQY4g2PE2JVw8Ea39v6Lj3WM1biuE=;
 b=qMFMwCe80occi0IoVOk3P5CUegG2hNo97oTPzmAoLasJN/tBjxTvOyMT3EYjH92F+7
 oLijzwMjXVDeT6TNXOKFbs5kokQkw54Dh9VAkrz2uROxMLuRk67lcoRCb7MOpHwlWT6X
 NYgpcXLIm73gfOZDbOsd+J6OKca051F2CotgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963170; x=1706567970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XL8m8MSlA/b6/iFQY4g2PE2JVw8Ea39v6Lj3WM1biuE=;
 b=hzGr3PMmLhY4043c2VcuukCwVnwP8eeRPnOr3VCmtbPRXsObaBzwOL03z3mDuXOZbQ
 YIDQoDjbFFljqu42GBQeiUPt4+5hNzAKUnojkQdjX27YRKIfEvG6v0cfjENXhaF5Vte0
 gsnjyb8MsswCZ3xwHhlM6WBu4GRXADmGX++Z8V7DcDUQl9MNB4Q36IKFA7AToJamMwA5
 GjzHjCdJuw/Uouo1EjFht5Bp+QHDWes5BF1ubrPTFb05SqiGlbYQHBWFkF3NYs1iDfNC
 GFwTufJTwgyeqLfKMIMY00ZF8XT540N3NI3FNSP11aZWi08HoLNsTfyOzgLqq64Xp1Zk
 q4XQ==
X-Gm-Message-State: AOJu0YzvKgtV1NKoNQNXxluv1mfmX46xKVpOUtBdhFP+YYpQzHpk5M6M
 APiMajhPiw+gdqVGaA4qeWoW2bk7+ykMBua2Q1NkTuzp2KhJyAq/h97grWhzb+lbR/cLRVe+Gul
 f
X-Google-Smtp-Source: AGHT+IEJGY7SbUK/Kkn5EfoSv7hZl6JPliK6ajZkiMsg86RSJWAOw5CxMfbigcqMfrfwddloLGKfyw==
X-Received: by 2002:a25:c788:0:b0:dc2:40d8:ac5e with SMTP id
 w130-20020a25c788000000b00dc240d8ac5emr2854927ybe.1.1705963169955; 
 Mon, 22 Jan 2024 14:39:29 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 10/16] efi-x86_payload: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:14 -0500
Message-Id: <20240122223920.3630168-10-trini@konsulko.com>
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
lack of board.h file, unset this on the efi-x86_payload* platforms and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 board/efi/efi-x86_payload/Kconfig     | 3 ---
 board/efi/efi-x86_payload/MAINTAINERS | 1 -
 include/configs/efi-x86_payload.h     | 4 ----
 3 files changed, 8 deletions(-)
 delete mode 100644 include/configs/efi-x86_payload.h

diff --git a/board/efi/efi-x86_payload/Kconfig b/board/efi/efi-x86_payload/Kconfig
index 6d062499346d..c500ca02ebf5 100644
--- a/board/efi/efi-x86_payload/Kconfig
+++ b/board/efi/efi-x86_payload/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "efi"
 
-config SYS_CONFIG_NAME
-	default "efi-x86_payload"
-
 config TEXT_BASE
 	default 0x00200000
 
diff --git a/board/efi/efi-x86_payload/MAINTAINERS b/board/efi/efi-x86_payload/MAINTAINERS
index d795d60e09e4..3c5d48aa84cc 100644
--- a/board/efi/efi-x86_payload/MAINTAINERS
+++ b/board/efi/efi-x86_payload/MAINTAINERS
@@ -3,6 +3,5 @@ M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 F:	board/efi/Kconfig
 F:	board/efi/efi-x86_payload/
-F:	include/configs/efi-x86_payload.h
 F:	configs/efi-x86_payload32_defconfig
 F:	configs/efi-x86_payload64_defconfig
diff --git a/include/configs/efi-x86_payload.h b/include/configs/efi-x86_payload.h
deleted file mode 100644
index e00c408f29a5..000000000000
--- a/include/configs/efi-x86_payload.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
- */
-- 
2.34.1

