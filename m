Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C044FC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C204588BC9;
	Thu,  8 Aug 2024 00:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JrvGz+01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EFE688B6B; Thu,  8 Aug 2024 00:48:24 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21AF788A77
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39b3cae5675so1226225ab.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070901; x=1723675701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7yfQJnzerRMJjIcRrPROZ+EQrjMmQNkFPp8FD+m5Z8=;
 b=JrvGz+01OglsfaugFGTW3YhENAvtX5tll4cOHHtoG6IsXRv3p2cWN7B5KWFtoXL5h2
 2jDCYo4gJ2F7O4WxOibrJCS/26iuaK/aBoyuOz+hGtI/ENgaeV7Bp5GokugUK+UmkVIY
 QR8B/OnReDjRMly7wqtF1eK1KyMejPiJ5rFVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070901; x=1723675701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7yfQJnzerRMJjIcRrPROZ+EQrjMmQNkFPp8FD+m5Z8=;
 b=suyEtCTZPfRor4TkSiqw4I31UGT+cZHnziZtd1Bzi0BHfZls3+N8ZihQqh6Lx0UFcn
 8LWSWU1MOd6wpHEp6NCXz8V8G6sPgS3YzdAR3jCXCbVk11zNbJ2igTCeNLd5QzxsvaxJ
 7UP8XXPSUuN5aIV7fvi6qYyafvqcN5hPt4GwxHHIBW82NkBAVzY0Q5SWSx7GXlr16Fcl
 OdZR0v0bfl48QxRJEUmOYdgGAtm1mSOcf4RoZ8mbYGuScz/ryqBc8GJ1HSn4Z68WhWKD
 1P89lf9dYqMg9OO8s0hKd28jMZkZ4O6BKMGKZ+7w/PrNvtJoHCV8Y2dW+BEaU4VEXVgW
 JSdA==
X-Gm-Message-State: AOJu0Yxnip3K77SxoHbcjezGMlr0qGnaUl7oKkoLv4gktpuuMPt6X30g
 NeTnbYlokTLsqOmuqd0UHdonOny5XvegpxugtGKr+WgY2yyWC0J2krR808ll9UjyKemvYkumJbY
 =
X-Google-Smtp-Source: AGHT+IE6CsE+I/LZDFBuOugHpd5ScSLP0Fop+bG/tHgKcJEa/JsRJ9cct5rZ1JONTjfJkTRSITaRqQ==
X-Received: by 2002:a05:6e02:1d95:b0:39a:16b2:7290 with SMTP id
 e9e14a558f8ab-39b5ef1979fmr63195ab.9.1723070900784; 
 Wed, 07 Aug 2024 15:48:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 20/21] sandbox: Add an SPL loader for UPL
Date: Wed,  7 Aug 2024 16:47:38 -0600
Message-Id: <20240807224739.3858517-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

