Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A29EC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0532C82F6F;
	Fri,  4 Jul 2025 14:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IDnjUz93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBE9800D7; Fri,  4 Jul 2025 14:32:48 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A48F800D7
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 14:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so1323423f8f.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751632366; x=1752237166; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=18y+4wPvGTmPWtYk4qNcUyF+qty9nygpIL0DaNBUHD0=;
 b=IDnjUz93/jw1MK/9sV4qTs6V8hibDkWP7XGRhw1Ka7zOasipmZfjoGUU4M1Jcinygx
 vGV6CUipU1c9VoCQLmVFoXMcodPnEXuZz5biAhcGgC4Qli/Nc1QBRGo3WQLOMBIxLd5Y
 V8BtDaTlU4eVZG0GlXWJ95CQkLG3XhIz79YhrtOMr6/YKDuEvgraYEmIZNO8EiaHjU/u
 0vlRvIS6nljIDjKpaXk1gS58GfUOVQzLDIjrSxdi6psBJOYLb5ZTBZ6GY/qETFtxxy45
 WWA8M9Cw0sY1XOJLPitgszGPzxMprcru7Qx60XS/GvEGXdZUP7U7i3S9no3J7VoO5Rcc
 M6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751632366; x=1752237166;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18y+4wPvGTmPWtYk4qNcUyF+qty9nygpIL0DaNBUHD0=;
 b=AcIJxqSgVB12ZZX/ureDC6un2KVL3DltMWRHrp65bfpwoXta+Ttg+z18BW+T/P+IVB
 JM15XuzMSmEvSZJTB4fV86AOYUJRvVbbhn5QL+8Jn7UthWk1nKgbykOw+PnL4t6qtboT
 y5xHcvaYdJPd6tQrAjX1z1YIo0Zbk3obVzvI2472CtJHQ3c7pNmKIBXE7ZQr61xcxQdy
 0pLgGbn/kUPy3niGnN29P3q19YHuobvAkrQJU8v/mZff9aZ5OBl0cHHb8JmxFmFxc2wp
 js6wZd0iD5jNB/1IP/iSzRWugfIbItjFOH4wn9tcXUQ85oEWL3PG78EHoWjgLIc/BcdT
 c9TA==
X-Gm-Message-State: AOJu0Yz7156tqfnfN+R1/l7dgiubu1hsPfJFs1ZsPK74lTVhANq2k0UF
 cG8VpKX8JNzUAj+X4fWPcC8evhr4J98hmyXLTbVFIueAhTNJSuBJdF/o7UlVnntxYpk=
X-Gm-Gg: ASbGncuDL1HwQnRqS+QNPNiBQTDqjDIdgtIarEkdXFH+H3D2zassncHF54FKnSZjj2Y
 WDW5+F4OzDZ6gf6ewfKhiV9pv8PCnTR1pWtqON4i8swFs607WZBxTN92IuIbNOV6/HjQuk0mC5s
 CKa1ZCQkUjUWMJzEp7/W4sSm+nNg+fcxxX0wGlzpgcHlzM27te0BGgcPN6C4AxxGSenuFqdMCEo
 mnvV4fvn+rXB+XlaTzTHiNky3jhqEdp9LXgyj5WBgiw4nd5wkRNtF42+cfuykwgiko/IVksg60R
 kBt68K8NdHd6w0pP8ALXU7W6TK6C36exFuLialITBmP2nWxHPA+Td2gFxWbeZ+8wcUqwf9wxIXa
 vtKxuXGQuRvwwnQ==
X-Google-Smtp-Source: AGHT+IF+SiYNYa1TbyqDRlqbo/bKfvh9BFW3iJMDbRR34ewScxb+675cntCVDkZc5I9SDmW/bHHd/A==
X-Received: by 2002:a05:6000:2508:b0:3a4:ebfc:8c7 with SMTP id
 ffacd0b85a97d-3b495b9440emr2493335f8f.8.1751632365658; 
 Fri, 04 Jul 2025 05:32:45 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:2854:bc73:8076:c06f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030bc5asm2367760f8f.20.2025.07.04.05.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 05:32:45 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 04 Jul 2025 13:32:44 +0100
Subject: [PATCH 3/3] fs: ext4fs: Perform NULL check before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-ext4fs_fix-v1-3-5c6acf4bf839@linaro.org>
References: <20250704-ext4fs_fix-v1-0-5c6acf4bf839@linaro.org>
In-Reply-To: <20250704-ext4fs_fix-v1-0-5c6acf4bf839@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In the function put_ext4 there is a NULL check for fs->dev_desc but this
has already been derefenced twice before this happens. Refactor the code
a bit to put the NULL check first.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/ext4/ext4_common.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index cc150cf824f..8e6531fa3f0 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -198,16 +198,18 @@ void put_ext4(uint64_t off, const void *buf, uint32_t size)
 	uint64_t remainder;
 	unsigned char *temp_ptr = NULL;
 	struct ext_filesystem *fs = get_fs();
-	int log2blksz = fs->dev_desc->log2blksz;
+	int log2blksz;
+
+	if (!fs->dev_desc)
+		return;
+
 	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, sec_buf, fs->dev_desc->blksz);
 
+	log2blksz = fs->dev_desc->log2blksz;
 	startblock = off >> log2blksz;
 	startblock += part_offset;
 	remainder = off & (uint64_t)(fs->dev_desc->blksz - 1);
 
-	if (fs->dev_desc == NULL)
-		return;
-
 	if ((startblock + (size >> log2blksz)) >
 	    (part_offset + fs->total_sect)) {
 		printf("part_offset is " LBAFU "\n", part_offset);

-- 
2.39.5

