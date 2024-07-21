Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E20C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2D7884C3;
	Sun, 21 Jul 2024 12:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aRxqwyp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3AD87DDF; Sun, 21 Jul 2024 12:10:17 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96ECB88481
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so27290775e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556613; x=1722161413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7yfQJnzerRMJjIcRrPROZ+EQrjMmQNkFPp8FD+m5Z8=;
 b=aRxqwyp2bR+crRA3zHc9hkhq8aRES5MH6qlWRZWDUhW9pxX7QgsSmm1rJi73ki8s4O
 7mE/3reAZbHIJsnZCxNcsg6BEDhpU3tYSxixFi2ME/HwwLPkxXo1Kikhgr0zPHLrb+kM
 US6GbXvsPdKTTJvkG0Jf+kqzTJKNZK0VJGE2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556613; x=1722161413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7yfQJnzerRMJjIcRrPROZ+EQrjMmQNkFPp8FD+m5Z8=;
 b=MD1HZy6j6PB+d8dD+8DzqQO2snaDQf9BsehLBM5konLM+WodEZkQ24JRW7p2Rg3T9t
 TTMKmx9r6i875xshPgi+DyB6UuFlQQCMrdkqr9iyajJna0CzZ2Wlu7WnT+tD3mIUyxrP
 9Me/br3/n4TUVhKlCNxQpzzxaQkMXaFGf3DPw0W8FyEurRNd5HUBzsUy7TtPgADewh+b
 fLIOFCmxW7O0Z752WS7q19KRNh12APXl5j9ETcnXKWDuq1w35EBcUgB/RXTIyzfyHjGZ
 MP2wArPbIBFPAJddJLkd8CRaxWFP3Yp6qYdfNxuJhLhxhMIagD3JA7HiGEvktnX1e/EH
 Q85w==
X-Gm-Message-State: AOJu0YzP8CZmf7NqF4ORQF1nNmTZAPaURUiZ3w1XRXwNGwhJewV/Js3a
 dtYx8Wgk7HBg2HDUE0MYTX2y48Wi3YYWnrdANfZuwI8IbJv0Ridg+3WI/92vl+1v/baBCst4VDY
 =
X-Google-Smtp-Source: AGHT+IFElwJdQaaJjyuKNAu5VdnQUCOSWWiD+d4mewUnSxk1I1T1wOcTsGWYcDUtwMgEWsOJeqKWRA==
X-Received: by 2002:a05:600c:4f86:b0:425:81bd:e5ee with SMTP id
 5b1f17b1804b1-427dc520ae2mr26294615e9.16.1721556613733; 
 Sun, 21 Jul 2024 03:10:13 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:10:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 20/21] sandbox: Add an SPL loader for UPL
Date: Sun, 21 Jul 2024 11:09:38 +0100
Message-Id: <20240721100940.3202027-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

Add support for loading a UPL image from SPL. This uses the simple FIT
implementation, but also loads the full FIT just to permit more testing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/spl.c         | 49 +++++++++++++++++++++++++++++++++-
 arch/sandbox/include/asm/spl.h |  1 +
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index e86193de419..bcb1ca10a51 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -3,14 +3,18 @@
  * Copyright (c) 2016 Google, Inc
  */
 
+#define LOG_CATEGORY	LOGC_BOOT
+
 #include <dm.h>
 #include <hang.h>
 #include <handoff.h>
 #include <image.h>
 #include <init.h>
 #include <log.h>
+#include <mapmem.h>
 #include <os.h>
 #include <spl.h>
+#include <upl.h>
 #include <asm/global_data.h>
 #include <asm/spl.h>
 #include <asm/state.h>
@@ -52,7 +56,8 @@ void board_init_f(ulong flag)
 void board_boot_order(u32 *spl_boot_list)
 {
 	spl_boot_list[0] = BOOT_DEVICE_VBE;
-	spl_boot_list[1] = BOOT_DEVICE_BOARD;
+	spl_boot_list[1] = BOOT_DEVICE_UPL;
+	spl_boot_list[2] = BOOT_DEVICE_BOARD;
 }
 
 static int spl_board_load_file(struct spl_image_info *spl_image,
@@ -250,3 +255,45 @@ int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image)
 
 	return 0;
 }
+
+static int upl_load_from_image(struct spl_image_info *spl_image,
+			       struct spl_boot_device *bootdev)
+{
+	long long size;
+	char *fname;
+	int ret, fd;
+	ulong addr;
+
+	if (!CONFIG_IS_ENABLED(UPL_OUT))
+		return -ENOTSUPP;
+
+	spl_upl_init();
+	fname = os_malloc(256);
+
+	ret = sandbox_spl_load_fit(fname, 256, spl_image);
+	if (ret)
+		return log_msg_ret("fit", ret);
+	spl_image->flags = SPL_SANDBOXF_ARG_IS_BUF;
+	spl_image->arg = map_sysmem(spl_image->load_addr, 0);
+	/* size is set by load_simple_fit(), offset is left as 0 */
+
+	/* now read the whole FIT into memory */
+	fd = os_open(fname, OS_O_RDONLY);
+	if (fd < 0)
+		return log_msg_ret("op2", -ENOENT);
+	if (os_get_filesize(fname,  &size))
+		return log_msg_ret("fis", -ENOENT);
+
+	/* place it after the loaded image, allowing plenty of space */
+	addr = ALIGN(spl_image->load_addr + size, 0x1000);
+	log_debug("Loading whole FIT to %lx\n", addr);
+	if (os_read(fd, map_sysmem(addr, 0), size) != size)
+		return log_msg_ret("rea", -EIO);
+	os_close(fd);
+
+	/* tell UPL where it is */
+	upl_set_fit_addr(addr);
+
+	return 0;
+}
+SPL_LOAD_IMAGE_METHOD("upl", 4, BOOT_DEVICE_UPL, upl_load_from_image);
diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
index d50d9ad6b48..d824b2123a2 100644
--- a/arch/sandbox/include/asm/spl.h
+++ b/arch/sandbox/include/asm/spl.h
@@ -18,6 +18,7 @@ enum {
 	BOOT_DEVICE_NOR,
 	BOOT_DEVICE_SPI,
 	BOOT_DEVICE_NAND,
+	BOOT_DEVICE_UPL,
 };
 
 /**
-- 
2.34.1

