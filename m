Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66549C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 19:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38E04881EA;
	Sun, 19 May 2024 21:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WPOyxkSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94BC882AA; Sun, 19 May 2024 21:19:16 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8505881EA
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 21:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41dc9c83e57so9014735e9.0
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716146354; x=1716751154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SqQwjbaY8E+m6FLQfScMC/zMS5tWjuvslo7ETSjsMus=;
 b=WPOyxkSVzwjUez4VLpwB9STEKMmgzIKX52RONTyKCwNPD39dRUDN87Av4jVu+G/yOg
 47kxO6KFluIj0Sa5lGnMfV0+vzUOhbLSiFOya1tUY8DSOHB+OAvn2eyw28J9B3Q3uMxo
 Ii0nEyCoSF6IHobHNN/kdKw4GHrj5SV5SaD/RYowwDK0UYlCCHNMQQAYcpoyc1D/NZMc
 CQ0P1+q67cSKM+iCMkDZIoah6FmYVCrXprgoVPFkpz0nR/fjBNFwNeYcxlZ21AU1PJCi
 jTXeGMpQr0YQltFglADIAVCGuI3/cutYiuvytu4y9m6XWIeEG9qrZeq5KRqPddqvnSC4
 NvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716146354; x=1716751154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqQwjbaY8E+m6FLQfScMC/zMS5tWjuvslo7ETSjsMus=;
 b=jxFnsJtctliPb3Rc2Ze+QYohWhBQAvCTmaHWjDGp8Y2nMzgHkcP6ZQH2svoLunEY+S
 Y8x0FjmCjA9XR/Q/djQXv9oo65FuQuzwi+4P67C0NiSzfnImJwqC0K09Sb/tKxCM2SQU
 p3HygRw2uj+DmQrprZw0J7FHMmi6jaP727HNyJJXfXMz0PrTvtD5eNBnUOt2Qpj3saz+
 o07pslu/S2GqXN7fIzhddpOj9A5Jqa8tiqF50j+SN2bWERNKueCJK3n3QTyeFrLqIBuJ
 ywov2kp3D54fjFSAazjWuBGEkyl7UzzqAev3unvAoqRYAdXAEnfDvS1U2vx50273Ne2m
 TA8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf3tifPzjW3zhOedkB4053E5Q2cNz0gI9baI8qS6suKjMCydZP0XKADzGQ6424FrpuBuO87+Mc7q+1qKilznlXgK++7Q==
X-Gm-Message-State: AOJu0YwMD7Dw/CtrBmF+DvRubxqMksvNPL4ZP9SH+R9jbi/hFCF/XCUa
 ebahdlB95WGKhbxzmOF4MLRwFVc3hBviZw8Phg8FqU3bxEpsycR01JieuQ==
X-Google-Smtp-Source: AGHT+IGjIE1rZD9Vw046WejE7q4LiZJ0tTwUHso1n1U6WiDU/vfn5ZcA27zRrmrjlXnSfTJJElqw/w==
X-Received: by 2002:adf:e8d0:0:b0:34d:93c1:c7d8 with SMTP id
 ffacd0b85a97d-354b8deaf60mr4167408f8f.4.1716146353981; 
 Sun, 19 May 2024 12:19:13 -0700 (PDT)
Received: from roman-envy-fast.. ([46.172.77.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b89583dsm27411682f8f.33.2024.05.19.12.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 12:19:13 -0700 (PDT)
From: Roman Stratiienko <r.stratiienko@gmail.com>
To: r.stratiienko@gmail.com, mkorpershoek@baylibre.com, igor.opaniuk@gmail.com,
 dsimic@manjaro.org, sjg@chromium.org, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, eajames@linux.ibm.com, marek.vasut+renesas@mailbox.org,
 paulerwan.rio@gmail.com, u-boot@lists.denx.de
Subject: [PATCH 3/3] abootimg: Implement smart image load feature
Date: Sun, 19 May 2024 19:18:56 +0000
Message-Id: <20240519191856.2582174-4-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240519191856.2582174-1-r.stratiienko@gmail.com>
References: <20240519191856.2582174-1-r.stratiienko@gmail.com>
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

Load only part of the boot partition that contains valuable
information, thus improving the boot time.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 boot/image-android.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 cmd/abootimg.c       | 40 ++++++++++++++++++++++---
 include/image.h      | 12 ++++++++
 3 files changed, 118 insertions(+), 4 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index da8003f370..d00a896a40 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -204,6 +204,76 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 	return true;
 }
 
+/**
+ * android_image_get_valuable_size() - get the size of the android image
+ *
+ * This function checks if the image is Android boot image and returns the
+ * valuable size of the image.
+ *
+ * @hdr_addr: Boot image header address (boot or vendor_boot)
+ *
+ * @return size of the image on success, 0 on failure
+ */
+size_t android_image_get_valuable_size(const void *hdr_addr)
+{
+	int version, size;
+
+	if (is_android_boot_image_header(hdr_addr)) {
+		const struct andr_boot_img_hdr_v0 *hdr = hdr_addr;
+
+		version = ((struct andr_boot_img_hdr_v0 *)hdr_addr)->header_version;
+		if (version > 2) {
+			const struct andr_boot_img_hdr_v3 *hdr = hdr_addr;
+
+			size = ALIGN(hdr->header_size, ANDR_GKI_PAGE_SIZE);
+			size += ALIGN(hdr->kernel_size, ANDR_GKI_PAGE_SIZE);
+			size += ALIGN(hdr->ramdisk_size, ANDR_GKI_PAGE_SIZE);
+
+			if (version > 3)
+				size += ALIGN(hdr->signature_size, ANDR_GKI_PAGE_SIZE);
+
+			return size;
+		}
+
+		size = hdr->page_size;
+		size += ALIGN(hdr->kernel_size, hdr->page_size);
+		size += ALIGN(hdr->ramdisk_size, hdr->page_size);
+		size += ALIGN(hdr->second_size, hdr->page_size);
+
+		if (version > 0)
+			size += ALIGN(hdr->recovery_dtbo_size, hdr->page_size);
+
+		if (version > 1)
+			size += ALIGN(hdr->dtb_size, hdr->page_size);
+
+		return size;
+	}
+
+	if (is_android_vendor_boot_image_header(hdr_addr)) {
+		const struct andr_vnd_boot_img_hdr *hdr = hdr_addr;
+
+		version = ((struct andr_vnd_boot_img_hdr *)hdr_addr)->header_version;
+		if (version < 3) {
+			printf("Vendor boot image header version %d is not supported\n", version);
+
+			return 0;
+		}
+
+		size = ALIGN(hdr->header_size, hdr->page_size);
+		size += ALIGN(hdr->vendor_ramdisk_size, hdr->page_size);
+		size += ALIGN(hdr->dtb_size, hdr->page_size);
+
+		if (version > 3) {
+			size += ALIGN(hdr->vendor_ramdisk_table_size, hdr->page_size);
+			size += ALIGN(hdr->bootconfig_size, hdr->page_size);
+		}
+
+		return size;
+	}
+
+	return 0;
+}
+
 static ulong android_image_get_kernel_addr(struct andr_image_data *img_data)
 {
 	/*
diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index 808c9c4941..fe7c5c5e2c 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -182,6 +182,35 @@ static int abootimg_get_dtb(int argc, char *const argv[])
 	return CMD_RET_USAGE;
 }
 
+static int abootimg_smart_load(struct blk_desc *desc, struct disk_partition *info, void *addr)
+{
+	int ret, size;
+
+	ret = blk_dread(desc, info->start, 4096 / info->blksz, addr);
+	if (ret < 0) {
+		printf("Error: Failed to read partition\n");
+		return CMD_RET_FAILURE;
+	}
+
+	size = android_image_get_valuable_size(addr);
+	if (size == 0)
+		return 0;
+
+	ret = blk_dread(desc, info->start, DIV_ROUND_UP(size, info->blksz), addr);
+	if (ret < 0) {
+		printf("Error: Failed to read partition\n");
+		return CMD_RET_FAILURE;
+	}
+
+	memset(addr + size, 0, info->size * info->blksz - size);
+
+	printf("Loaded Android boot image using smart load (%d/%d MB)\n",
+	       (int)DIV_ROUND_UP(size, 1024 * 1024),
+	       (int)DIV_ROUND_UP(info->size * info->blksz, 1024 * 1024));
+
+	return size;
+}
+
 static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
 			    char *const argv[])
 {
@@ -299,10 +328,13 @@ static int do_abootimg_load(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_FAILURE;
 	}
 
-	ret = blk_dread(desc, info.start, info.size, addr);
-	if (ret < 0) {
-		printf("Error: Failed to read partition %s\n", buf);
-		goto fail;
+	ret = abootimg_smart_load(desc, &info, addr);
+	if (ret <= 0) {
+		ret = blk_dread(desc, info.start, info.size, addr);
+		if (ret < 0) {
+			printf("Error: Failed to read partition %s\n", buf);
+			goto fail;
+		}
 	}
 
 	sprintf(buf, "abootimg_%s_ptr", argv[3]);
diff --git a/include/image.h b/include/image.h
index c5b288f62b..7d8ff40c3f 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1826,6 +1826,18 @@ struct andr_image_data;
 bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 			    struct andr_image_data *data);
 
+/**
+ * android_image_get_valuable_size() - get the size of the android image
+ *
+ * This function checks if the image is Android boot image and returns the
+ * valuable size of the image.
+ *
+ * @hdr_addr: Boot image header address (boot or vendor_boot)
+ *
+ * @return size of the image on success, 0 on failure
+ */
+size_t android_image_get_valuable_size(const void *hdr_addr);
+
 struct andr_boot_img_hdr_v0;
 
 /**
-- 
2.40.1

