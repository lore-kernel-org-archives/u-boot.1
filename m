Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B39C25B77
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A7BC88292;
	Sun, 19 May 2024 14:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kNJrVVFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E778D88286; Sun, 19 May 2024 14:53:48 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9CFC882B5
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4200ee78f35so9814915e9.1
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716123224; x=1716728024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N5rfa23+5MsDNfCwjiZRXiK/j6dImDvkD/CsBC68Y30=;
 b=kNJrVVFzm5I6hq2kC6nxYnnE5KN62UH+BRIDpTpk01pwwUmjUl2PhNSrWrlnTmKjVU
 /noJsZ+iU2GqDETHiTvGQ4Yq69KqUdSyrjfxOnbGxU+e+qCQI+ESbuncKFw7Cg8m04F9
 BX/D++SV6v5+j/+zGmtwqA+rgpyg2OOrzgW9MkKv18VLgLsiSFdU1Y9sKQaSuZBasAu6
 LVNtAA/KsfCUNL/MwrLu0yIWyrUACXE7DZIt1PyjuNqAPIEKKfAbu7KioZrrynIbWHmm
 xuS+sT7UeNgM2km8XNR3NNoJVHUftxrQy0BaethyLuVW1yiuUkYbExQidp8RHHJBS3ao
 pRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716123224; x=1716728024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N5rfa23+5MsDNfCwjiZRXiK/j6dImDvkD/CsBC68Y30=;
 b=t1wftCasf4qyYtne7c+CZwpXw+LldJkpFowI9tkSU00y47g6GgT5udK6nFBF9Dtina
 3/odPYrWPfCAE5eaOpbdo3Qaf6bRI/IgI9mpVM/diOzOik/i0VJL/7seFmuNMRQ2XG3N
 70VBHPvVnL5MRC3VeLcIOzErhFEouRqarZQZdkvQ4RJ3EGPlRybYorPOAhn4OD8RGKPf
 EgG6BGhMvBeiv++dd77olt/DC+UA692C7Ah3yoDcGExm5kY65vLI90P6yJAhThMP5WBB
 DSJg0ZWKFFRJThruVkWaMRzDAmepTOmfuY1yuh7yaojSAXqlrDntrQ29x7x2KVLaG1Cb
 WCXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSIp82jM9jZrrXauus35bCEOkxX/7ux8pDSnBb48mmZU4LTILNOLn1lpLmuZTv0eZwaikTrvhTxvwNxWfBVQ6fVsXT5w==
X-Gm-Message-State: AOJu0YxJJ/681vFr23m7GTHXetSExmeQl5zoIWoLqgffl5FZzO0YDXn/
 fs4FI1MTuCfDpgkAeKpUYangMPx+T9obOTnvadhpeh8CX5OH9JD9
X-Google-Smtp-Source: AGHT+IHcYv9xm88PazP7fIHP/TKwmdYe8devBpNGHKYyM5f8Ov/LRjPu4rNFlBqSYxmt4VJu7kbpog==
X-Received: by 2002:a05:600c:3b26:b0:420:66e:4c31 with SMTP id
 5b1f17b1804b1-420066e4d6cmr228566155e9.34.1716123224179; 
 Sun, 19 May 2024 05:53:44 -0700 (PDT)
Received: from roman-envy-fast.. ([46.172.77.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fe518a8fasm357734375e9.33.2024.05.19.05.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 05:53:43 -0700 (PDT)
From: Roman Stratiienko <r.stratiienko@gmail.com>
To: sjg@chromium.org, eajames@linux.ibm.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, paulerwan.rio@gmail.com, u-boot@lists.denx.de,
 mkorpershoek@baylibre.com, igor.opaniuk@gmail.com
Cc: r.stratiienko@gmail.com
Subject: [PATCH] abootimg: Add init_boot image support
Date: Sun, 19 May 2024 12:53:37 +0000
Message-Id: <20240519125337.2557883-1-r.stratiienko@gmail.com>
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

[1]: https://source.android.com/docs/core/architecture/partitions/generic-boot
Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 boot/image-board.c |  5 ++++-
 cmd/abootimg.c     | 26 +++++++++++++++++++++-----
 include/image.h    |  7 +++++++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 75f6906cd5..715654ff01 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -414,9 +414,12 @@ static int select_ramdisk(struct bootm_headers *images, const char *select, u8 a
 			int ret;
 			if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
 				void *boot_img = map_sysmem(get_abootimg_addr(), 0);
+				void *init_boot_img = map_sysmem(get_ainit_bootimg_addr(), 0);
 				void *vendor_boot_img = map_sysmem(get_avendor_bootimg_addr(), 0);
+				void *ramdisk_img = (init_boot_img == -1) ? boot_img :
+									    init_boot_img;
 
-				ret = android_image_get_ramdisk(boot_img, vendor_boot_img,
+				ret = android_image_get_ramdisk(ramdisk_img, vendor_boot_img,
 								rd_datap, rd_lenp);
 				unmap_sysmem(vendor_boot_img);
 				unmap_sysmem(boot_img);
diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index e68c523705..7c450a3b2d 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -17,6 +17,7 @@
 
 /* Please use abootimg_addr() macro to obtain the boot image address */
 static ulong _abootimg_addr = -1;
+static ulong _ainit_bootimg_addr = -1;
 static ulong _avendor_bootimg_addr = -1;
 
 ulong get_abootimg_addr(void)
@@ -24,6 +25,11 @@ ulong get_abootimg_addr(void)
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
@@ -209,7 +215,7 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
 	char *endp;
 	ulong img_addr;
 
-	if (argc < 2 || argc > 3)
+	if (argc < 2 || argc > 4)
 		return CMD_RET_USAGE;
 
 	img_addr = hextoul(argv[1], &endp);
@@ -220,16 +226,26 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
 
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
 
@@ -346,7 +362,7 @@ fail:
 }
 
 static struct cmd_tbl cmd_abootimg_sub[] = {
-	U_BOOT_CMD_MKENT(addr, 3, 1, do_abootimg_addr, "", ""),
+	U_BOOT_CMD_MKENT(addr, 4, 1, do_abootimg_addr, "", ""),
 	U_BOOT_CMD_MKENT(dump, 2, 1, do_abootimg_dump, "", ""),
 	U_BOOT_CMD_MKENT(get, 5, 1, do_abootimg_get, "", ""),
 	U_BOOT_CMD_MKENT(load, 5, 1, do_abootimg_load, "", ""),
@@ -375,7 +391,7 @@ static int do_abootimg(struct cmd_tbl *cmdtp, int flag, int argc,
 U_BOOT_CMD(
 	abootimg, CONFIG_SYS_MAXARGS, 0, do_abootimg,
 	"manipulate Android Boot Image",
-	"addr <boot_img_addr> [<vendor_boot_img_addr>]>\n"
+	"addr <boot_img_addr> [<vendor_boot_img_addr> [<init_boot_img_addr>]]\n"
 	"    - set the address in RAM where boot image is located\n"
 	"      ($loadaddr is used by default)\n"
 	"abootimg dump dtb\n"
diff --git a/include/image.h b/include/image.h
index be3c73a72e..b1fd6b3149 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1982,6 +1982,13 @@ bool is_android_vendor_boot_image_header(const void *vendor_boot_img);
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

