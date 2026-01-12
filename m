Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A75C9EC6E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487BD83DDD;
	Mon, 12 Jan 2026 11:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QGQF+PRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F6D483DCB; Mon, 12 Jan 2026 11:55:47 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E424483DA9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so68591135e9.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 02:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768215344; x=1768820144;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aBRCBufNcZH1lm6RnFbSGW5uFod/v9ieG9g7OpHgiqQ=;
 b=QGQF+PRDWMdr3UFQLUoc7iXV7JhayJ7qeVEkLcW3Mo/PNNf+pj35zO/8kCi8B0abpx
 jtt1qNREIxDaFCXH8CO9Mw0mUMU6Ug0jrb4Nue1FS6Hk8Pj4m88np382NmrIqjDrr7EF
 W+fZkmeqrOvAF8ESuF6vy2lvj4SwBRebt35yjeG4QeClLAJs90e6ZocJA4c2/jgS8gSk
 evZLLIoqqvbCqG6zkhzUzkWI5KFFKVwPzzpGEqGDS0t4Z8gx/f470cfFCViDPWl9xVkL
 mrfj/krn7qBz3urtzWER4tG4qAGDGbEAN54EcbFft24yju46zmOJiRZZU9SY39ENoV6c
 gmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768215344; x=1768820144;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aBRCBufNcZH1lm6RnFbSGW5uFod/v9ieG9g7OpHgiqQ=;
 b=WjD6q5+UmHZ6rBeOfDBA4iGcY9YxEhm/sPmjP+eWMBThQOwHvR2aYFUetuuBpR/vyC
 tl2S6obQz83FHIIwaT0IMwyqZagPoNXvaj4lcGU9R5pcNfZflSIzJJjZ9B4L6508Fw1b
 +Na45lpaQPlFmJsMF8blniVJwSzkTwow2AIMuDnfbfW1GhEvzX9WGRU+sf8nBhgqc5YI
 O2tsbg43EoZcpkglB9rVGn3uyGGWQNto4Uk57XD9Uc086k4aJzW5KgPGglXUF8zAwoOg
 wFQhc/johJu/A3cgXLd6axSJfMRGRKGOd0mjaXxYlb4c1CCx32K4/Wo3ZSelzH0yRE/8
 /LsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa8cO36aBP+PpLnu/kQeMbFwCjvJLTTkWJPW/4bqwhXpbSwqCmnIBpWvHLFangmTiZMXEV6+8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywe4i25V106CrYZwzAHjT5VkFfageig+buvPeFhkn9cvuuv6uhV
 h70y1np0rUvNbJVciCrfES8FzK7T8JClJJzGc7/cpMEXsHSEqvtnH7C+McVZgVu3Dvo=
X-Gm-Gg: AY/fxX4QhxvQ2AGHCx8GKj0S/BzQX0MvtbY5fTAEsJW0F30WeKg7vipUIzzhpoPTML6
 yayAgwi9eWdRYJoenhX8FZtplcsYvEOF/H+80IWoXLo5bo1xTZUq3q6nsxb4FG7JmJH3J0E9T7u
 Tfmdr3vKcbsSA6CGo3D5a4TbFJzvCEATVR1xrQfJAbFCGZbSRX9X2JDxpUHmLRc1qWjSaNbAMxq
 ++6RFqltJt+Fde7c33VirP+bcfS9WY6yIJg/kZuZMu2HQ6iQ0HD48i+kl3HTrF0OHOgqalTkkOV
 sS4OBCPaDv3hcy2/k7sOJorD4K/6eM3acRFk57g8vefQ55bb7UQhKdCn4Qc5+6HzIvs6hon71oW
 8KCZhVGlbzyEPqDz7/FRHMTP852QJnoIXoUG6fhEtA7KdiZa7jnniuT08OVofY7VRymE/TvsS/O
 hSkTaw2UuwUY0reQ==
X-Google-Smtp-Source: AGHT+IFeYTPwRJxF7qjsOPo/u+ZdQ8ZOcq/Hd/CN0f5el/E90NKg/+Njyy3BL5r8csA/qXr0B9tfXg==
X-Received: by 2002:a05:600c:648a:b0:47a:9560:ec22 with SMTP id
 5b1f17b1804b1-47d84b17ae4mr190451355e9.14.1768215344316; 
 Mon, 12 Jan 2026 02:55:44 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:ad8e:46f0:bbfb:2e18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm36145393f8f.26.2026.01.12.02.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 02:55:43 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Mon, 12 Jan 2026 11:55:39 +0100
Subject: [PATCH v5 3/5] boot: android: Add bootconfig support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-bootconfig-v5-3-79b242159ac7@baylibre.com>
References: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
In-Reply-To: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Maxime Fournier <mfournier@baylibre.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome@forissier.org>
X-Mailer: b4 0.14.3
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

For android vendor boot image version 4 bootconfig is mandatory.[1]

In the android_image_get_ramdisk function, after copying both vendor and
boot ramdisks, we extract all androidboot.* entries from the kernel
command line. These entries are added to the bootconfig section.
We then update the sizes of the ramdisk and bootconfig.
Finally, all androidboot.* entries are removed from the kernel command
line.

[1] https://source.android.com/docs/core/architecture/partitions/vendor-boot-partitions#bootloader-support

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 boot/image-android.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 163 insertions(+), 11 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index b9e0b3f68b0..c4a0cb138eb 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -505,6 +505,166 @@ ulong android_image_get_kcomp(const void *hdr,
 		return image_decomp_type(p, sizeof(u32));
 }
 
+/**
+ * android_boot_append_bootconfig() - Append bootconfig parameters to ramdisk
+ * @img_data: Pointer to Android image data
+ * @params: Pointer to boot config parameters to append
+ * @params_len: Length of boot config parameters
+ * @ramdisk_dest: Destination address for the merged ramdisk
+ *
+ * This function copies the vendor ramdisk, boot ramdisk, and bootconfig to
+ * the destination. It then appends the provided bootconfig parameters.
+ *
+ * Return: Bytes added to the bootconfig on success, negative on error.
+ */
+static long android_boot_append_bootconfig(const struct andr_image_data *img_data,
+					   char *params, long params_len,
+					   void *ramdisk_dest)
+{
+	void *vendor_ramdisk_src;
+	void *boot_ramdisk_src;
+	void *bootconfig_src;
+	long bytes_added = 0;
+
+	/* Map sources */
+	vendor_ramdisk_src = map_sysmem(img_data->vendor_ramdisk_ptr,
+					img_data->vendor_ramdisk_size);
+	boot_ramdisk_src = map_sysmem(img_data->ramdisk_ptr,
+				      img_data->boot_ramdisk_size);
+
+	/* Copy Vendor Ramdisk */
+	memcpy(ramdisk_dest, vendor_ramdisk_src, img_data->vendor_ramdisk_size);
+
+	/* Copy Boot Ramdisk */
+	memcpy((char *)ramdisk_dest + img_data->vendor_ramdisk_size,
+	       boot_ramdisk_src, img_data->boot_ramdisk_size);
+
+	/* Copy Bootconfig and Append Params */
+	if (img_data->bootconfig_size) {
+		bootconfig_src = map_sysmem(img_data->bootconfig_addr,
+					    img_data->bootconfig_size);
+		memcpy((char *)ramdisk_dest + img_data->vendor_ramdisk_size +
+		       img_data->boot_ramdisk_size,
+		       bootconfig_src, img_data->bootconfig_size);
+		unmap_sysmem(bootconfig_src);
+
+		if (params && params_len > 1) {
+			void *bootconfig_ptr = (char *)ramdisk_dest +
+					       img_data->vendor_ramdisk_size +
+					       img_data->boot_ramdisk_size;
+			bytes_added = add_bootconfig_parameters(params, params_len,
+								(ulong)bootconfig_ptr,
+								img_data->bootconfig_size);
+		}
+	}
+
+	unmap_sysmem(boot_ramdisk_src);
+	unmap_sysmem(vendor_ramdisk_src);
+
+	if (bytes_added < 0)
+		return bytes_added;
+
+	return bytes_added;
+}
+
+/**
+ * android_image_set_bootconfig() - Extract androidboot.* args and append to bootconfig
+ * @hdr: Pointer to boot image header
+ * @vendor_boot_img: Pointer to vendor boot image header
+ * @ramdisk_addr: Destination address for the merged ramdisk
+ *
+ * Return: Size of the bootconfig section (including new params) on success, negative on error.
+ */
+static long android_image_set_bootconfig(const void *hdr,
+					 const void *vendor_boot_img,
+					 ulong ramdisk_addr)
+{
+	const char *bootargs = env_get("bootargs");
+	char *params = NULL;
+	char *new_bootargs = NULL;
+	long params_len = 0; /* Renamed from androidboot_params_len */
+	struct andr_image_data img_data;
+	long ret;
+	size_t len;
+	const char *src;
+	char *bc_dst;
+	char *args_dst;
+	ulong total_size;
+	void *ramdisk_dest;
+
+	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
+		return -EINVAL; /* Use errno */
+
+	/* Extract androidboot.* parameters from bootargs */
+	if (bootargs && img_data.bootconfig_size) {
+		len = strlen(bootargs);
+		src = bootargs;
+
+		params = malloc(len + 1);
+		new_bootargs = malloc(len + 1);
+		if (!params || !new_bootargs) {
+			free(params);
+			free(new_bootargs);
+			printf("Error: malloc failed\n");
+			return -ENOMEM;
+		}
+
+		bc_dst = params;
+		args_dst = new_bootargs;
+
+		/* Extract androidboot.* and build new bootargs in one pass */
+		while (*src) {
+			/* Skip leading spaces */
+			while (*src == ' ')
+				src++;
+			if (!*src)
+				break;
+
+			/* Check if this param starts with androidboot. */
+			if (strncmp(src, "androidboot.", 12) == 0) {
+				/* Copy to bootconfig (add newline if not first) */
+				if (bc_dst != params)
+					*bc_dst++ = '\n';
+				while (*src && *src != ' ')
+					*bc_dst++ = *src++;
+			} else {
+				/* Copy to new bootargs (add space if not first) */
+				if (args_dst != new_bootargs)
+					*args_dst++ = ' ';
+				while (*src && *src != ' ')
+					*args_dst++ = *src++;
+			}
+		}
+
+		*bc_dst++ = '\n'; /* Final newline for bootconfig */
+		*bc_dst = '\0';
+		*args_dst = '\0';
+		params_len = bc_dst - params;
+
+		/* Update bootargs if we extracted any androidboot params */
+		if (params_len > 1)
+			env_set("bootargs", new_bootargs);
+	}
+
+	/* Calculate total size for mapping */
+	total_size = img_data.ramdisk_size + img_data.bootconfig_size;
+	if (params_len > 1)
+		total_size += params_len + BOOTCONFIG_TRAILER_SIZE;
+
+	/* Map Dest */
+	ramdisk_dest = map_sysmem(ramdisk_addr, total_size);
+
+	/* Copy data */
+	ret = android_boot_append_bootconfig(&img_data, params, params_len,
+					     ramdisk_dest);
+
+	unmap_sysmem(ramdisk_dest);
+	free(params);
+	free(new_bootargs);
+
+	return ret;
+}
+
 int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 			      ulong *rd_data, ulong *rd_len)
 {
@@ -536,17 +696,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 			ramdisk_ptr = img_data.ramdisk_addr;
 		}
 		*rd_data = ramdisk_ptr;
-		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
-		       img_data.vendor_ramdisk_size);
-		ramdisk_ptr += img_data.vendor_ramdisk_size;
-		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
-		       img_data.boot_ramdisk_size);
-		ramdisk_ptr += img_data.boot_ramdisk_size;
-		if (img_data.bootconfig_size) {
-			memcpy((void *)
-			       (ramdisk_ptr), (void *)img_data.bootconfig_addr,
-			       img_data.bootconfig_size);
-		}
+		if (img_data.header_version > 3)
+			img_data.ramdisk_size +=
+				android_image_set_bootconfig(hdr, vendor_boot_img, ramdisk_ptr);
 	} else {
 		/* Ramdisk can be used in-place, use current ptr */
 		if (img_data.ramdisk_addr == 0 ||

-- 
2.34.1

