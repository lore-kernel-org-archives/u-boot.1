Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF41D6ED02
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 11:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C0EC89739;
	Thu, 21 Nov 2024 12:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GjPofj5n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 653E38973A; Thu, 21 Nov 2024 12:00:28 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3061389736
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 12:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38230ed9baeso517275f8f.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 03:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732186825; x=1732791625;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pAXABHQ/j3+N90IGk6ex/JQLni1M4jFvqW43ixl+FBk=;
 b=GjPofj5ngf7TSd6MjUHOY5zciW8vDOJX3+VGehhMEJONXgabeTXSPv9kxJTrjatXJt
 slUVhMTMFIExB6pA+OAiqw6LwEFFKFtrdD4lBsfACL5SYieAI/1N2mQKdZOclyPM56m5
 a0oBmTNDKXLKixYe0bFTOrZSYk4lK0st+56ZqqxLZWgxv9a7eg1uElGKVF8m2ojOOxDw
 yxneqeIWUeXSa3BtylS+mVgNWh4Pgj5N3xqHXJmKDl1rOhv9yP3NKMZ4i+kWRf/vlhNc
 DkyXQR39IJZ9CHlI//qu5q4RgCglkeF7C12mF0b5WxWvgV1znAh+HsmOzDJo+9ntnaG8
 RtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732186825; x=1732791625;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pAXABHQ/j3+N90IGk6ex/JQLni1M4jFvqW43ixl+FBk=;
 b=CH6+OZfmbVx4lHLhm7cLh+9FV4o1mcJLJ9askIReTOBY0PWZc4CvyMPfyuokUHx0aO
 cUlwegUhaSalCFr3YqwRPPBR6VQun178fPLTgGwv8rHUTNU/SkfvNLwcccOlkDCBROft
 hCVcm3g4CAPPw7tz/ScL0+QQkLo5bpekBBIh48cSJ1ougAPny+JIITe3hsgwQAIDynpW
 vugooFXRZ5z7pqYMvCSbF+SLcbPwl/QWh2lQA1Lczb4AZ4NaFbLJX/zQruTsDj17E1SR
 FyBWn60PTOKAJcTagrIPFnRPHGpqMhebNsrieCIP7i0qt2rmp3LLgz2blQiL+LjA0BSF
 yEPA==
X-Gm-Message-State: AOJu0Yxl97kvxmny1e7877YKjXOxG6h/mJtKP9MDKE4oF5gTAQRccoPU
 za55NXLIQSq9A7gHdkRVZ1fflfMj4zvwTxSCHiiua0BvTquc9EnmiS4BuhDKjOlNnn00NLrv3ZF
 W4Bk=
X-Google-Smtp-Source: AGHT+IEgRLXp9qOc2gmUchMEsKd4YlhXfrFwx3holiF4Tro5YzK+6+wyMcK//+t+aXyIcp05Dm//Kg==
X-Received: by 2002:a5d:6dab:0:b0:382:4f9e:711f with SMTP id
 ffacd0b85a97d-38254adee04mr3984011f8f.6.1732186825267; 
 Thu, 21 Nov 2024 03:00:25 -0800 (PST)
Received: from [192.168.1.127] ([2a04:cec2:a:dda0:7e93:703a:331e:b018])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38254933c32sm4789484f8f.70.2024.11.21.03.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 03:00:24 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
Date: Thu, 21 Nov 2024 11:59:55 +0100
Subject: [PATCH] bootstd: android: don't read whole partition sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-bootmeth-android-part-sizes-v1-1-25760bbd0f08@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKoSP2cC/x3MwQqDMAwA0F+RnA20ZTjdrwwPnU01B1tJiojiv
 1t2fJd3gZIwKXyaC4R2Vs6pwrYNTItPMyGHanDGvax1Fn85l5XKgj4FyRxw81JQ+STFGF3fdWS
 CeQ9Qh00o8vHfv+N9PyYWVdxtAAAA
X-Change-ID: 20241121-bootmeth-android-part-sizes-ff2866e0d079
To: Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Julien Masson <jmasson@baylibre.com>
X-Mailer: b4 0.14.2
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

The current implementation is reading the whole partition for boot and
vendor_boot image which can be long following the size of the
partition or the time to read blocks (driver/SoC specific).

For example with mediatek mt8365 EVK board, we have a 64MiB boot
partition and the boot image flashed in this partition is only 42MiB.
It takes ~8-9 secs to read the boot partition.

Instead we can retrieved the boot image and vendor boot image size
with these new functions:
- android_image_get_bootimg_size
- android_image_get_vendor_bootimg_size
Use these information and read only the necessary.

By doing this with mt8365 EVK board, we read boot image in ~5 secs.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
Changes have been tested with:
$ ./test/py/test.py --bd sandbox --build -k ut_bootstd_bootflow_android_image_v4
$ ./test/py/test.py --bd sandbox --build -k ut_bootstd_bootflow_android_image_v2
---
 boot/bootmeth_android.c | 28 +++++++++++++++++++++++-----
 boot/image-android.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/image.h         | 24 ++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 2aac32331d3c28853bc87d05a8c76ae868ea97c7..3a5144aaa3b0125cf13ff1805b05e87385263308 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -45,6 +45,8 @@ struct android_priv {
 	enum android_boot_mode boot_mode;
 	char *slot;
 	u32 header_version;
+	u32 boot_img_size;
+	u32 vendor_boot_img_size;
 };
 
 static int android_check(struct udevice *dev, struct bootflow_iter *iter)
@@ -98,7 +100,13 @@ static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
 		return log_msg_ret("header", -ENOENT);
 	}
 
+	if (!android_image_get_bootimg_size(buf, &priv->boot_img_size)) {
+		free(buf);
+		return log_msg_ret("get bootimg size", -EINVAL);
+	}
+
 	priv->header_version = ((struct andr_boot_img_hdr_v0 *)buf)->header_version;
+
 	free(buf);
 
 	return 0;
@@ -138,6 +146,12 @@ static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
 		free(buf);
 		return log_msg_ret("header", -ENOENT);
 	}
+
+	if (!android_image_get_vendor_bootimg_size(buf, &priv->vendor_boot_img_size)) {
+		free(buf);
+		return log_msg_ret("get vendor bootimg size", -EINVAL);
+	}
+
 	free(buf);
 
 	return 0;
@@ -330,15 +344,17 @@ static int android_read_file(struct udevice *dev, struct bootflow *bflow,
  * @blk: Block device to read
  * @name: Partition name to read
  * @slot: Nul-terminated slot suffixed to partition name ("a\0" or "b\0")
+ * @image_size: Image size in bytes used when reading the partition
  * @addr: Address where the partition content is loaded into
  * Return: 0 if OK, negative errno on failure.
  */
 static int read_slotted_partition(struct blk_desc *desc, const char *const name,
-				  const char slot[2], ulong addr)
+				  const char slot[2], ulong image_size, ulong addr)
 {
 	struct disk_partition partition;
 	char partname[PART_NAME_LEN];
 	size_t partname_len;
+	ulong num_blks = DIV_ROUND_UP(image_size, desc->blksz);
 	int ret;
 	u32 n;
 
@@ -364,8 +380,8 @@ static int read_slotted_partition(struct blk_desc *desc, const char *const name,
 	if (ret < 0)
 		return log_msg_ret("part", ret);
 
-	n = blk_dread(desc, partition.start, partition.size, map_sysmem(addr, 0));
-	if (n < partition.size)
+	n = blk_dread(desc, partition.start, num_blks, map_sysmem(addr, 0));
+	if (n < num_blks)
 		return log_msg_ret("part read", -EIO);
 
 	return 0;
@@ -498,12 +514,14 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read slot", ret);
 
-	ret = read_slotted_partition(desc, "boot", priv->slot, loadaddr);
+	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
+				     loadaddr);
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
 	if (priv->header_version >= 3) {
-		ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
+					     priv->vendor_boot_img_size, vloadaddr);
 		if (ret < 0)
 			return log_msg_ret("read vendor_boot", ret);
 		set_avendor_bootimg_addr(vloadaddr);
diff --git a/boot/image-android.c b/boot/image-android.c
index cd01278f211d63262f2bdad7aa1176e2c1bbfedd..93b54bf8d7936862693d56d5b75343575f3e6293 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -178,6 +178,51 @@ static void android_boot_image_v0_v1_v2_parse_hdr(const struct andr_boot_img_hdr
 	data->boot_img_total_size = end - (ulong)hdr;
 }
 
+bool android_image_get_bootimg_size(const void *hdr, u32 *boot_img_size)
+{
+	struct andr_image_data data;
+
+	if (!hdr || !boot_img_size) {
+		printf("hdr or boot_img_size can't be NULL\n");
+		return false;
+	}
+
+	if (!is_android_boot_image_header(hdr)) {
+		printf("Incorrect boot image header\n");
+		return false;
+	}
+
+	if (((struct andr_boot_img_hdr_v0 *)hdr)->header_version <= 2)
+		android_boot_image_v0_v1_v2_parse_hdr(hdr, &data);
+	else
+		android_boot_image_v3_v4_parse_hdr(hdr, &data);
+
+	*boot_img_size = data.boot_img_total_size;
+
+	return true;
+}
+
+bool android_image_get_vendor_bootimg_size(const void *hdr, u32 *vendor_boot_img_size)
+{
+	struct andr_image_data data;
+
+	if (!hdr || !vendor_boot_img_size) {
+		printf("hdr or vendor_boot_img_size can't be NULL\n");
+		return false;
+	}
+
+	if (!is_android_vendor_boot_image_header(hdr)) {
+		printf("Incorrect vendor boot image header\n");
+		return false;
+	}
+
+	android_vendor_boot_image_v3_v4_parse_hdr(hdr, &data);
+
+	*vendor_boot_img_size = data.vendor_boot_img_total_size;
+
+	return true;
+}
+
 bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
 			    struct andr_image_data *data)
 {
diff --git a/include/image.h b/include/image.h
index c52fced9b409b1f963daa4ab6c266909ca035aff..9be5acd8158f00930ab1f3988b8f577817acd1fe 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1801,6 +1801,30 @@ int fit_image_cipher_get_algo(const void *fit, int noffset, char **algo);
 struct cipher_algo *image_get_cipher_algo(const char *full_name);
 struct andr_image_data;
 
+/**
+ * android_image_get_bootimg_size() - Extract size of Android boot image
+ *
+ * This is used to extract the size of an Android boot image
+ * from boot image header.
+ *
+ * @hdr: Pointer to boot image header
+ * @boot_img_size: On exit returns the size in bytes of the boot image
+ * Return: true if succeeded, false otherwise
+ */
+bool android_image_get_bootimg_size(const void *hdr, u32 *boot_img_size);
+
+/**
+ * android_image_get_vendor_bootimg_size() - Extract size of Android vendor-boot image
+ *
+ * This is used to extract the size of an Android vendor-boot image
+ * from vendor-boot image header.
+ *
+ * @hdr: Pointer to vendor-boot image header
+ * @vendor_boot_img_size: On exit returns the size in bytes of the vendor-boot image
+ * Return: true if succeeded, false otherwise
+ */
+bool android_image_get_vendor_bootimg_size(const void *hdr, u32 *vendor_boot_img_size);
+
 /**
  * android_image_get_data() - Parse Android boot images
  *

---
base-commit: acaa7f35a33146f887948d34130229388280844a
change-id: 20241121-bootmeth-android-part-sizes-ff2866e0d079

Best regards,
-- 
Julien Masson <jmasson@baylibre.com>

