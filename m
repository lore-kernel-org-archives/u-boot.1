Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DA2C46CD2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37FDD87A01;
	Mon, 22 Jan 2024 23:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FJF8a9G1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB61879A8; Mon, 22 Jan 2024 23:39:26 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F66787949
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc223f3dd5eso3005914276.2
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963163; x=1706567963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIdpqxiNrJlth5EQvoFmw6yvKZN89UVwL9hcVrDZZuI=;
 b=FJF8a9G1GAf+EXoGVovPGkLlkkAXt2jiDEHHlz0/nkAIvOgvHR3ISW0Kcl//V536d5
 KjmmtAQzcOjNDzsk6z1UxDYoBw+Bordcyc6tTg2ZXo7PQ6dpy94evIwjFyv0FvvfEaWC
 crdOSMmkLFDMZ2vjyWxhc/aSFch2vF3vZj50U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963163; x=1706567963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIdpqxiNrJlth5EQvoFmw6yvKZN89UVwL9hcVrDZZuI=;
 b=ct3cBf/NhNuULlf92qcqYB31XJtJgctqbWkxF/wBHhsA0VNztJaOFW2j/divDS0KkW
 xZnrAXYtOhKFsd7Zk7PP4KTucFIlCxjd6+u/JxVn1agFgt9rVu2/xoy0C97q8GOOPh+X
 hm31qp+eDw6LsjVZ+YosSZ7uyC1SZXPQXUE6EA1wQ7z4Qd7ZhQkhwock265LJJZ1E8/I
 6NDoVzo4zsPmfYhQj0Tl607imvblso8vqRf4rFAlJMgiRZrHbvYIjuEbzOh0/wJQMoP0
 VG2vvBnV34a65rQ7cUoBjn6+R0EnJd2U69yXYE7Yom5N9ZtU7ZJHpMQM4e7DK+6hycMA
 qZIg==
X-Gm-Message-State: AOJu0YwbKswEaqAVmWg+u+Z33xFBTQ5WwvORyrpwge0l/ZqPVc/mnUxT
 wnMUrjKBHhZji2C/cp1nlwgWKM9a1LsjQoOB4xjyYEwlXEPi2DoA8qCH7jfZZrPbffbWyWPHkIC
 p
X-Google-Smtp-Source: AGHT+IFFgy1XpxxP7EBAE5A3KMAXTLVUr6xzbuu9msP1kiN9GHgcP4HjvvWEwRRiqL3Qswt7SzE+cw==
X-Received: by 2002:a5b:bcc:0:b0:db3:64d3:b6b6 with SMTP id
 c12-20020a5b0bcc000000b00db364d3b6b6mr3247631ybr.28.1705963162451; 
 Mon, 22 Jan 2024 14:39:22 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH 02/16] xilinx_mbv: Remove empty config header
Date: Mon, 22 Jan 2024 17:39:06 -0500
Message-Id: <20240122223920.3630168-2-trini@konsulko.com>
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
lack of board.h file, unset this on the xilinx_mbv platforms and remove
the otherwise empty file.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
---
 board/xilinx/mbv/Kconfig     | 3 ---
 board/xilinx/mbv/MAINTAINERS | 1 -
 include/configs/xilinx_mbv.h | 6 ------
 3 files changed, 10 deletions(-)
 delete mode 100644 include/configs/xilinx_mbv.h

diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig
index 4bc9f72c541b..d2dec397ed6f 100644
--- a/board/xilinx/mbv/Kconfig
+++ b/board/xilinx/mbv/Kconfig
@@ -9,9 +9,6 @@ config SYS_VENDOR
 config SYS_CPU
 	default "generic"
 
-config SYS_CONFIG_NAME
-	default "xilinx_mbv"
-
 config TEXT_BASE
 	default 0x80000000 if !RISCV_SMODE
 	default 0x80400000 if RISCV_SMODE && ARCH_RV32I
diff --git a/board/xilinx/mbv/MAINTAINERS b/board/xilinx/mbv/MAINTAINERS
index 445654fe740e..db9f03388df9 100644
--- a/board/xilinx/mbv/MAINTAINERS
+++ b/board/xilinx/mbv/MAINTAINERS
@@ -4,4 +4,3 @@ S:	Maintained
 F:	arch/riscv/dts/xilinx-mbv*
 F:	board/xilinx/mbv/
 F:	configs/xilinx_mbv*
-F:	include/configs/xilinx_mbv.h
diff --git a/include/configs/xilinx_mbv.h b/include/configs/xilinx_mbv.h
deleted file mode 100644
index dba398aeec49..000000000000
--- a/include/configs/xilinx_mbv.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * (C) Copyright 2023, Advanced Micro Devices, Inc.
- *
- * Michal Simek <michal.simek@amd.com>
- */
-- 
2.34.1

