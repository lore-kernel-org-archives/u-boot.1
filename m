Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56647C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FB6E86FF4;
	Mon, 13 Nov 2023 04:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ACv5NfUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E323287044; Mon, 13 Nov 2023 04:00:15 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B3E869CA
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 04:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-359d559766cso14620835ab.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699844410; x=1700449210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qiRIa7wXelUpzKL6NWJ9vn20hbetiWwTluBhSOtUedI=;
 b=ACv5NfUdV6wS9KwIXCN87UcDNdfY6gAwVwUTyv47QXpbNUGh57lbOR+ORqQLkOEO/G
 ZRmjPnEzcurbHoNViMewaEsSieohHNk5N8hzpzR9LL2CkBgxL3A3eyrE8rc2PK0X6vH6
 cXDpBh0xmGplln//e56nwOnGPzGJtLgcgg6cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699844410; x=1700449210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qiRIa7wXelUpzKL6NWJ9vn20hbetiWwTluBhSOtUedI=;
 b=UkwR2YwQlT0uHG5NXC0QpySEvNtV/MX8zS7Pyobxk3NPFxRS1JRbVKZJqbQwvT5bqK
 LynMPUHC9zn0AA5NOALEI3WL8Xuu23FGz3LkGJ0hH4opNAmyiqDQgSTPBOua++zOKTIW
 3vkvJaBTU5J3jL9iIy2iD9kXMNCj9i8SESJ0+RurKU7RJjtx3OGKRIMlKsGihpvJZV9L
 9v+YwHkzJht8IlyJdJAjrFSvZUjFktLORh/wowQSXmtATkthy3T6sE1M7o4piqQ9zMjw
 K30KMeGlFJzIX6zwSpgDaWz3EIFsEqFnFfdCQw+YwnWjJG3DJIoRL/8LaGfV295s1nKz
 3RpA==
X-Gm-Message-State: AOJu0YyAnaPRR6JKcK9SJAD0Y0W+hOaZLNNN5A7ByEX4zgGNUSqWW2e+
 eIBsHRTJ7Oo9ORL4414JUlq4LqhO5jWB9p2oSj/zRg==
X-Google-Smtp-Source: AGHT+IHl1rhk7IhXxLtogVWDv+DGZcvLjgq9kersYauMWOyLSbwCebv6Nc9ojnwkRYHgDHN3XYOb+A==
X-Received: by 2002:a05:6e02:1986:b0:35a:b283:d167 with SMTP id
 g6-20020a056e02198600b0035ab283d167mr7343516ilf.20.1699844409695; 
 Sun, 12 Nov 2023 19:00:09 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 19:00:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH 5/9] toradex: Use checkboard() instead of show_board_info()
Date: Sun, 12 Nov 2023 19:58:25 -0700
Message-ID: <20231113030001.240020-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
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

Boards can use a sysinfo driver if a particular model name is needed.
Update this board to use checkboard() directly, rather than having a
weak function laid on top of a weak function.

Make all the checkboard() functions call the new tdx_checkboard() so
that the same information is displayed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/toradex/apalis-imx8/apalis-imx8.c         | 2 +-
 board/toradex/apalis-tk1/apalis-tk1.c           | 2 +-
 board/toradex/apalis_imx6/apalis_imx6.c         | 3 ++-
 board/toradex/apalis_t30/apalis_t30.c           | 2 +-
 board/toradex/colibri-imx6ull/colibri-imx6ull.c | 2 +-
 board/toradex/colibri-imx8x/colibri-imx8x.c     | 2 +-
 board/toradex/colibri_imx6/colibri_imx6.c       | 3 ++-
 board/toradex/colibri_imx7/colibri_imx7.c       | 2 +-
 board/toradex/colibri_t20/colibri_t20.c         | 2 +-
 board/toradex/colibri_t30/colibri_t30.c         | 2 +-
 board/toradex/colibri_vf/colibri_vf.c           | 2 +-
 board/toradex/common/tdx-common.c               | 2 +-
 board/toradex/common/tdx-common.h               | 1 +
 13 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index e2bbaba8b8c1..b351ce64abfc 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -215,7 +215,7 @@ int checkboard(void)
 	build_info();
 	print_bootinfo();
 
-	return 0;
+	return tdx_checkboard();
 }
 
 static enum pcb_rev_t get_pcb_revision(void)
diff --git a/board/toradex/apalis-tk1/apalis-tk1.c b/board/toradex/apalis-tk1/apalis-tk1.c
index 851343159186..79a1c92da0a0 100644
--- a/board/toradex/apalis-tk1/apalis-tk1.c
+++ b/board/toradex/apalis-tk1/apalis-tk1.c
@@ -95,7 +95,7 @@ int checkboard(void)
 {
 	puts("Model: Toradex Apalis TK1 2GB\n");
 
-	return 0;
+	return tdx_checkboard();
 }
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index fa6b7226fedf..dc0e09991dde 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -730,7 +730,8 @@ int checkboard(void)
 	       is_cpu_type(MXC_CPU_MX6D) ? "Dual" : "Quad",
 	       (gd->ram_size == 0x80000000) ? "2GB" :
 	       (gd->ram_size == 0x40000000) ? "1GB" : "512MB", it);
-	return 0;
+
+	return tdx_checkboard();
 }
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
diff --git a/board/toradex/apalis_t30/apalis_t30.c b/board/toradex/apalis_t30/apalis_t30.c
index ef71270d9f2d..b9a2af33f19f 100644
--- a/board/toradex/apalis_t30/apalis_t30.c
+++ b/board/toradex/apalis_t30/apalis_t30.c
@@ -50,7 +50,7 @@ int checkboard(void)
 	printf("Model: Toradex Apalis T30 %dGB\n",
 	       (gd->ram_size == 0x40000000) ? 1 : 2);
 
-	return 0;
+	return tdx_checkboard();
 }
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
diff --git a/board/toradex/colibri-imx6ull/colibri-imx6ull.c b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
index 48fdb1e09712..6c8eeff38fa5 100644
--- a/board/toradex/colibri-imx6ull/colibri-imx6ull.c
+++ b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
@@ -206,7 +206,7 @@ int checkboard(void)
 {
 	printf("Model: Toradex Colibri iMX6ULL\n");
 
-	return 0;
+	return tdx_checkboard();
 }
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/colibri-imx8x/colibri-imx8x.c
index 6c0b09787c8b..d8cc72f323c5 100644
--- a/board/toradex/colibri-imx8x/colibri-imx8x.c
+++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
@@ -121,7 +121,7 @@ int checkboard(void)
 	build_info();
 	print_bootinfo();
 
-	return 0;
+	return tdx_checkboard();
 }
 
 static void select_dt_from_module_version(void)
diff --git a/board/toradex/colibri_imx6/colibri_imx6.c b/board/toradex/colibri_imx6/colibri_imx6.c
index e6c9b10570d1..7635c5811d26 100644
--- a/board/toradex/colibri_imx6/colibri_imx6.c
+++ b/board/toradex/colibri_imx6/colibri_imx6.c
@@ -649,7 +649,8 @@ int checkboard(void)
 	printf("Model: Toradex Colibri iMX6 %s %sMB%s\n",
 	       is_cpu_type(MXC_CPU_MX6DL) ? "DualLite" : "Solo",
 	       (gd->ram_size == 0x20000000) ? "512" : "256", it);
-	return 0;
+
+	return tdx_checkboard();
 }
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index f0356af0082b..c3478b15111b 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -279,7 +279,7 @@ int checkboard(void)
 	printf("Model: Toradex Colibri iMX7%c\n",
 	       is_cpu_type(MXC_CPU_MX7D) ? 'D' : 'S');
 
-	return 0;
+	return tdx_checkboard();
 }
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
diff --git a/board/toradex/colibri_t20/colibri_t20.c b/board/toradex/colibri_t20/colibri_t20.c
index 1df9697b97ce..5861cf7dc93e 100644
--- a/board/toradex/colibri_t20/colibri_t20.c
+++ b/board/toradex/colibri_t20/colibri_t20.c
@@ -77,7 +77,7 @@ int checkboard(void)
 	       (get_nand_dev_by_index(0)->erasesize >> 10 == 512) ?
 	       ((gd->ram_size == 0x10000000) ? "1.1B" : "1.1C") : "1.2A");
 
-	return 0;
+	return tdx_checkboard();
 }
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
diff --git a/board/toradex/colibri_t30/colibri_t30.c b/board/toradex/colibri_t30/colibri_t30.c
index b6b004669c26..8cef098c8e59 100644
--- a/board/toradex/colibri_t30/colibri_t30.c
+++ b/board/toradex/colibri_t30/colibri_t30.c
@@ -32,7 +32,7 @@ int checkboard(void)
 {
 	puts("Model: Toradex Colibri T30 1GB\n");
 
-	return 0;
+	return tdx_checkboard();
 }
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
diff --git a/board/toradex/colibri_vf/colibri_vf.c b/board/toradex/colibri_vf/colibri_vf.c
index dcef2db360a3..af9f2d379cf4 100644
--- a/board/toradex/colibri_vf/colibri_vf.c
+++ b/board/toradex/colibri_vf/colibri_vf.c
@@ -373,7 +373,7 @@ int checkboard(void)
 	else
 		puts("Model: Toradex Colibri VF50\n");
 
-	return 0;
+	return tdx_checkboard();
 }
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index d1449143977b..ed8f0a6a4756 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -96,7 +96,7 @@ static const char *get_board_assembly(u16 ver_assembly)
 	return ver_name;
 }
 
-int show_board_info(void)
+int tdx_checkboard(void)
 {
 	unsigned char ethaddr[6];
 
diff --git a/board/toradex/common/tdx-common.h b/board/toradex/common/tdx-common.h
index d446e9f1d5ca..44234dc49cd7 100644
--- a/board/toradex/common/tdx-common.h
+++ b/board/toradex/common/tdx-common.h
@@ -11,5 +11,6 @@
 
 int ft_common_board_setup(void *blob, struct bd_info *bd);
 u32 get_board_revision(void);
+int tdx_checkboard(void);
 
 #endif /* _TDX_COMMON_H */
-- 
2.42.0.869.gea05f2083d-goog

