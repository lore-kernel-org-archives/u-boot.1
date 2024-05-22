Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F147C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 21:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D3F87C7E;
	Wed, 22 May 2024 23:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eYuS2hT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61FB388459; Wed, 22 May 2024 23:26:56 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B45A87C75
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 23:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4202ca70289so46818915e9.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716413213; x=1717018013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mjr+1c7EaKXHBlIF9oH+HqSVGufWrJWNbiUNaSaCmd4=;
 b=eYuS2hT9oRvnteN6smfMrOQPu9Ok3hp74+i/CJu58ji4mCT8277NQ/9p4UN3Ve0CpZ
 +o17OUKop04xIr25OeQG64InJfzTFBp4qvjxSBlLntWMw/bY2GeS2dDNWNQ3dGGDzI5w
 VXZl9J4g1r4n7zWuRtzeTtnvbUk7XMocDvT5RC64EUC2M2qKENs6914i7n01b/vzlnNR
 KMPBvxrV9XjIg3MJVmmf3ZMsMzwS/cl6E1zUofwZMHlvdNmoav0qAuwBelLd+kc01MgJ
 /yRTkmFi6q5hri+3J4Rop1eYN4l5F7yfahjJ3ZsJmhvUY/MTkq3C+mGZh5jCtXQVnA4Z
 G+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716413213; x=1717018013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mjr+1c7EaKXHBlIF9oH+HqSVGufWrJWNbiUNaSaCmd4=;
 b=A+29/SviszjlK9vff3JstoVjc3gIsoPyeaWw4e8ddcjtItKinDyWRfN6G7BpDsGhIz
 zlr3bhcTiZzTUK+pXU1tPu2YTFAaI6w/Ag3c7/8+YtDAt59R+sbRWGkgnzzRJO18tpBT
 x269ja92SOFzSGbMAnqN0MsX800U2UQw/m/nGqmqmNdX9T5Hhm+6WKJ6Q25W/ND/TI7y
 ceVzvE+Rlo1SFOFslv3l3G2g/7uyO22TcIczZFLsMn/EbJsPz1WL3nKMwoDhOihpzxSN
 58ix9nAWfcE9Y0UDsiP0MqMpbuJdEAtkuxPQwwNWaQmQI161hkJTOwAH6h1vkjpqCFzC
 d/kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeMmkaDoiVMc82yAM9z9D/8MMmUEn8/YFkayD1J7dxVdk7Rfo1MnEmSQ258RqZaKhW6pEhScmM3F0EnMvPFrbAJ912JA==
X-Gm-Message-State: AOJu0YxYf/Fam7a/pvypBVRUIRBw/TsEzte424pVcH7moaC5GesjTxuA
 qCmn31zFzBESPljOHwLXQtnSX+nYPlFBQbk/mkcqPpanvcnRNYOX
X-Google-Smtp-Source: AGHT+IHjtevz4lMPRuQTwYVOWEgs7kHMEnG07huWmzh0TM0KDEUHNE7s+z179YjWkSVTy2VkFeWOGA==
X-Received: by 2002:a5d:558d:0:b0:349:8ae9:b030 with SMTP id
 ffacd0b85a97d-354d8cc8f7amr2485186f8f.10.1716413213153; 
 Wed, 22 May 2024 14:26:53 -0700 (PDT)
Received: from roman-envy-fast.. ([46.172.77.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f163a8sm5569325e9.13.2024.05.22.14.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 14:26:52 -0700 (PDT)
From: Roman Stratiienko <r.stratiienko@gmail.com>
To: sjg@chromium.org, marek.vasut+renesas@mailbox.org, r.stratiienko@gmail.com,
 laurent.pinchart@ideasonboard.com, eajames@linux.ibm.com,
 paulerwan.rio@gmail.com, xypron.glpk@gmx.de, u-boot@lists.denx.de,
 mkorpershoek@baylibre.com, igor.opaniuk@gmail.com
Subject: [PATCH v2] abootimg: Add init_boot image support
Date: Wed, 22 May 2024 21:26:45 +0000
Message-Id: <20240522212645.87250-1-r.stratiienko@gmail.com>
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
---
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
index 69c7390dbe..9e965c1fb7 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -16,6 +16,7 @@
 
 /* Please use abootimg_addr() macro to obtain the boot image address */
 static ulong _abootimg_addr = -1;
+static ulong _ainit_bootimg_addr = -1;
 static ulong _avendor_bootimg_addr = -1;
 
 ulong get_abootimg_addr(void)
@@ -23,6 +24,11 @@ ulong get_abootimg_addr(void)
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
@@ -210,7 +216,7 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
 	char *endp;
 	ulong img_addr;
 
-	if (argc < 2 || argc > 3)
+	if (argc < 2 || argc > 4)
 		return CMD_RET_USAGE;
 
 	img_addr = hextoul(argv[1], &endp);
@@ -221,16 +227,26 @@ static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
 
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
 
@@ -347,7 +363,7 @@ fail:
 }
 
 static struct cmd_tbl cmd_abootimg_sub[] = {
-	U_BOOT_CMD_MKENT(addr, 3, 1, do_abootimg_addr, "", ""),
+	U_BOOT_CMD_MKENT(addr, 4, 1, do_abootimg_addr, "", ""),
 	U_BOOT_CMD_MKENT(dump, 2, 1, do_abootimg_dump, "", ""),
 	U_BOOT_CMD_MKENT(get, 5, 1, do_abootimg_get, "", ""),
 	U_BOOT_CMD_MKENT(load, 5, 1, do_abootimg_load, "", ""),
@@ -376,7 +392,7 @@ static int do_abootimg(struct cmd_tbl *cmdtp, int flag, int argc,
 U_BOOT_CMD(
 	abootimg, CONFIG_SYS_MAXARGS, 0, do_abootimg,
 	"manipulate Android Boot Image",
-	"addr <boot_img_addr> [<vendor_boot_img_addr>]>\n"
+	"addr <boot_img_addr> [<vendor_boot_img_addr> [<init_boot_img_addr>]]\n"
 	"    - set the address in RAM where boot image is located\n"
 	"      ($loadaddr is used by default)\n"
 	"abootimg dump dtb\n"
diff --git a/include/image.h b/include/image.h
index 96df2b99a7..7d8ff40c3f 100644
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

