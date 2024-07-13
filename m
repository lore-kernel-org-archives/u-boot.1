Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6293C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4418886A;
	Sat, 13 Jul 2024 09:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ldqqnp23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4D988861; Sat, 13 Jul 2024 09:04:02 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A22BB88859
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52ea2f58448so3758050e87.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854239; x=1721459039; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFgTqhymdsA59TInJYjd2lbJmXZLU5QrVc/VNTrVs9I=;
 b=ldqqnp23ml+yBOYjyyaD3O6kvOyIeAc5j2jZi4H9n3M+BXc+9m4iHpXyfFgi1dl6M8
 iGccli7DD1xmWzxrG30p+men1s5LJINVJjeFwvgKwjWrLozlmKoMK5ous40eB2V259zL
 D7wsMumjlTA9Xz+eiyoLouTYehYP+7fs4XJwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854239; x=1721459039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFgTqhymdsA59TInJYjd2lbJmXZLU5QrVc/VNTrVs9I=;
 b=NjIxYRD+h1B43CDob35K9GrSWDISOrTmVZzXTojKhb11vKJs0zJZyxwKhWfjOzrtM3
 F/UUoS3Unx4yF+bJUiSYUjBEhOYkCkNjEDGsOsS4b711PoCQ19efL9hVGZVW0iRYNmCO
 uETkrxZeJljkHoGZxNBNgJxzY8ffU1RfPEr9SAE5a58n1OQvNuJuD3k0QvDqsdJ1Puhn
 e2OVVkOo5PRh1IMhwzkiEmRC9Gfi80Kp3atAm6uh5Y8AUAJvWySI29bd7tSKbYYKPUjK
 qOmnoKXf44sG1lxyfHVPfWTcyVwBSxsOM8o5FLQEOH0wIbNvgMGfqxH0K1I4IJjV8Sft
 BBqQ==
X-Gm-Message-State: AOJu0Yx+uYkhLonjkyHSPCaUVW9UJBJcVUiZb7YY04f+E8aBEyWN+lyV
 5MkRvEbZFvxLvMQtNjZtwj7FKLfkFn6yX3GNhkakddimsgf/UpFIK7ouBzoDpep5gIberabnCT4
 =
X-Google-Smtp-Source: AGHT+IG4tylesrITcYMsoJfYZPZ87S4y2GTcq+BOEqy6HMKvbVt3/3tTPCYlRTP3xDiM1/LOCBi+RQ==
X-Received: by 2002:a05:6512:110e:b0:52d:b1e4:b337 with SMTP id
 2adb3069b0e04-52eb999165cmr11054384e87.21.1720854238743; 
 Sat, 13 Jul 2024 00:03:58 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/21] sandbox: Add an SPL loader for UPL
Date: Sat, 13 Jul 2024 08:00:54 +0100
Message-Id: <20240713070055.2172883-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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
index 39869f27a7b..f665f86d64c 100644
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
@@ -246,3 +251,45 @@ int sandbox_spl_load_fit(char *fname, int maxlen, struct spl_image_info *image)
 
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

