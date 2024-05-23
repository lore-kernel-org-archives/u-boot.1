Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB39AC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 07:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D619884D5;
	Thu, 23 May 2024 09:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M1C8VI3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064A7884D5; Thu, 23 May 2024 09:06:37 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4DA88311
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 09:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42011507a57so53026065e9.1
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 00:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716447994; x=1717052794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=96HdcaiyT2BFMdG0K6ujroSV8yXNCtnJwndaGl3F/Hc=;
 b=M1C8VI3PDxssZMxH9SJufjJxX2SqtW43yeus5UXGcwxQbgDevaqMK9h26GJoJ7s5ja
 EoX+3WzYepRGPUpVYI6tCeMdKXRYLOt5H4iitN/PAQ6c+RQncma0uuXetuE3lyUtKpEA
 iY26/g15eAAuxfm4OCxWlkB8pxdDWAGyX+bg3jWG3FD012KbdnXPmVACX/Rj8udOUsYJ
 ji861S2dNpYoDic8v6GEWpz87c8SDNJ+Y73NuV0QjW0EzAqrdsjPZao1llnJMXF58OPn
 4+z/qAque2Orz01xDmw7+y/KCWwHr3BmUs/k398iR9yOhwGjgP3u1DYHIgjF7fsDOL6i
 G6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716447994; x=1717052794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=96HdcaiyT2BFMdG0K6ujroSV8yXNCtnJwndaGl3F/Hc=;
 b=Jw0di0cSD2Tph5XuE7pWyP46g9KvqZux0OaYLYKyku3n3oL8OI4XKplDyHStE6rDQw
 EPnEGp71LIpAfBUwE9rUe+AEU13oAWiSsumhFa8JU6aCWMMb9CRZAUEW2NN8jBwOmiOu
 pTpYkLIInGXaZupY0358nqNCcfAfsWY3HUNnPStH3X9UfstYTIoeAAgy6gX8MSDlUNUe
 MXJpKEtethH0J5zbS17VHW5C80UGR2MazUWY/LL4zICGwIbKLspAwm8GwlvHtPR/GK/V
 umEUmzapVlG8JFsaYptp10WM7CBRDqCUhyPf4K9XoZrLcGkxGLq+dqpzr97ckJImPX2C
 SwbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm0PxbE+aANqIUNSoMNJF+j0uQBJ8jb/1lADV2Or7S+1waGuZHpwXxG+ax3JXU5tViCbRoIecsEKddXogvYZ7AkMQNrQ==
X-Gm-Message-State: AOJu0YwEs57ENhwzJt1mM+c7wxsT25urWSSuZTjEYQ8cxujtAPkHtSnc
 R6hsC6vjMgKD5yUacMbVaYKC5aOy3wXuZIsTbMzRRyXYfS6iI0wLn/rEWA==
X-Google-Smtp-Source: AGHT+IEpp9khebPvcYkHb5FlmcIgw5Rvu6kPjNlAdT3dCTKi8rrIjcqqzPOITW2fl+g78m9xYPusVQ==
X-Received: by 2002:a05:600c:2245:b0:41b:855b:5d26 with SMTP id
 5b1f17b1804b1-420fd2dd906mr31451685e9.2.1716447993945; 
 Thu, 23 May 2024 00:06:33 -0700 (PDT)
Received: from roman-envy-fast.. ([46.172.77.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a89sm35650035f8f.31.2024.05.23.00.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 00:06:33 -0700 (PDT)
From: Roman Stratiienko <r.stratiienko@gmail.com>
To: sjg@chromium.org, marek.vasut+renesas@mailbox.org, r.stratiienko@gmail.com,
 laurent.pinchart@ideasonboard.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, eajames@linux.ibm.com, paulerwan.rio@gmail.com,
 u-boot@lists.denx.de, mkorpershoek@baylibre.com
Subject: [PATCH v3] abootimg: Add init_boot image support
Date: Thu, 23 May 2024 07:06:07 +0000
Message-Id: <20240523070606.91108-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Quote from [1]:

"For devices launching with Android 13, the generic ramdisk is removed
from the boot image and placed in a separate init_boot image.
This change leaves the boot image with only the GKI kernel."

While at it, update wrong error handling message when vendor_boot
cannot be loaded.

[1]: https://source.android.com/docs/core/architecture/partitions/generic-boot
Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

Changes in v2:
- Addressed review comments v1

Changes in v3:
- Rebased on top of latest u-boot/next

 boot/image-board.c | 13 ++++++++++---
 cmd/abootimg.c     | 26 +++++++++++++++++++++-----
 include/image.h    |  7 +++++++
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index b7884b8c5d..f212401304 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -406,13 +406,20 @@ static int select_ramdisk(struct bootm_headers *images, const char *select, u8 a
 		if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE)) {
 			int ret;
 			if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
-				void *boot_img = map_sysmem(get_abootimg_addr(), 0);
+				ulong boot_img = get_abootimg_addr();
+				ulong init_boot_img = get_ainit_bootimg_addr();
 				void *vendor_boot_img = map_sysmem(get_avendor_bootimg_addr(), 0);
+				void *ramdisk_img;
 
-				ret = android_image_get_ramdisk(boot_img, vendor_boot_img,
+				if (init_boot_img == -1)
+					ramdisk_img = map_sysmem(boot_img, 0);
+				else
+					ramdisk_img = map_sysmem(init_boot_img, 0);
+
+				ret = android_image_get_ramdisk(ramdisk_img, vendor_boot_img,
 								rd_datap, rd_lenp);
 				unmap_sysmem(vendor_boot_img);
-				unmap_sysmem(boot_img);
+				unmap_sysmem(ramdisk_img);
 			} else {
 				void *ptr = map_sysmem(images->os.start, 0);
 
diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index 88c77d9992..327712a536 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -14,6 +14,7 @@
 
 /* Please use abootimg_addr() macro to obtain the boot image address */
 static ulong _abootimg_addr = -1;
+static ulong _ainit_bootimg_addr = -1;
 static ulong _avendor_bootimg_addr = -1;
 
 ulong get_abootimg_addr(void)
@@ -21,6 +22,11 @@ ulong get_abootimg_addr(void)
 	return (_abootimg_addr == -1 ? image_load_addr : _abootimg_addr);
 }
 
+ulong get_ainit_bootimg_addr(void)
+{
+	return _ainit_bootimg_addr;
+}
+
 ulong get_avendor_bootimg_addr(void)
 {
 	return _avendor_bootimg_addr;
@@ -179,7 +185,7 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
 	char *endp;
 	ulong img_addr;
 
-	if (argc < 2 || argc > 3)
+	if (argc < 2 || argc > 4)
 		return CMD_RET_USAGE;
 
 	img_addr = hextoul(argv[1], &endp);
@@ -190,16 +196,26 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	_abootimg_addr = img_addr;
 
-	if (argc == 3) {
+	if (argc > 2) {
 		img_addr = simple_strtoul(argv[2], &endp, 16);
 		if (*endp != '\0') {
-			printf("Error: Wrong vendor image address\n");
+			printf("Error: Wrong vendor_boot image address\n");
 			return CMD_RET_FAILURE;
 		}
 
 		_avendor_bootimg_addr = img_addr;
 	}
 
+	if (argc == 4) {
+		img_addr = simple_strtoul(argv[3], &endp, 16);
+		if (*endp != '\0') {
+			printf("Error: Wrong init_boot image address\n");
+			return CMD_RET_FAILURE;
+		}
+
+		_ainit_bootimg_addr = img_addr;
+	}
+
 	return CMD_RET_SUCCESS;
 }
 
@@ -243,7 +259,7 @@ static int do_abootimg_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 static struct cmd_tbl cmd_abootimg_sub[] = {
-	U_BOOT_CMD_MKENT(addr, 3, 1, do_abootimg_addr, "", ""),
+	U_BOOT_CMD_MKENT(addr, 4, 1, do_abootimg_addr, "", ""),
 	U_BOOT_CMD_MKENT(dump, 2, 1, do_abootimg_dump, "", ""),
 	U_BOOT_CMD_MKENT(get, 5, 1, do_abootimg_get, "", ""),
 };
@@ -271,7 +287,7 @@ static int do_abootimg(struct cmd_tbl *cmdtp, int flag, int argc,
 U_BOOT_CMD(
 	abootimg, CONFIG_SYS_MAXARGS, 0, do_abootimg,
 	"manipulate Android Boot Image",
-	"addr <boot_img_addr> [<vendor_boot_img_addr>]>\n"
+	"addr <boot_img_addr> [<vendor_boot_img_addr> [<init_boot_img_addr>]]\n"
 	"    - set the address in RAM where boot image is located\n"
 	"      ($loadaddr is used by default)\n"
 	"abootimg dump dtb\n"
diff --git a/include/image.h b/include/image.h
index acffd17e0d..c5b288f62b 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1970,6 +1970,13 @@ bool is_android_vendor_boot_image_header(const void *vendor_boot_img);
  */
 ulong get_abootimg_addr(void);
 
+/**
+ * get_ainit_bootimg_addr() - Get Android init boot image address
+ *
+ * Return: Android init boot image address
+ */
+ulong get_ainit_bootimg_addr(void);
+
 /**
  * get_avendor_bootimg_addr() - Get Android vendor boot image address
  *
-- 
2.40.1

