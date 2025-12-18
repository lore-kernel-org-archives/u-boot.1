Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D551D6ACE6
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 11:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE0FF83D71;
	Thu, 18 Dec 2025 12:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Srzte9aY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6F0683DA8; Thu, 18 Dec 2025 12:17:12 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1D083C54
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 12:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so3482715e9.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 03:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766056630; x=1766661430;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BiLBQtc68JLc4djYm1anPNIWN1eh6hnbQf51fNuoAVE=;
 b=Srzte9aYX2Mu4TBa5fVtPJgpzdnvX3lJSjFiLPHVKeAkILRTjASYp5/yIc0iLIIFp1
 gEHzO9ZvSeCYJwgB+/QTfmbbNzEzJ3Uny1x/ZcPzGvnOE/Lz2wsTP8lmskg0KJ9hvldk
 fMSt5XWxiIj05bRSzOM1s7M2wTzAb0nN3wCnwfFI5kCHJcYJ/CqwDG2ZrZZkFtacztnA
 8MfeQ6ZbpD8jj3ulHvzyGgoPUfXpVZwI1JLQhDSwrjDCi7ePSbyTcsunoTnofAUamtH2
 qMQtYKoULaaVq4DxzgKeeg4GY1sQYzGYnOngnc6lIaqdKs8pXR41K5vOmimqII9IE+rU
 zP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766056630; x=1766661430;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BiLBQtc68JLc4djYm1anPNIWN1eh6hnbQf51fNuoAVE=;
 b=tKWwx/OkNhGwuC5PP9Lto+zEGY5Dkl4fA4L3s9i39SYBdn7F/4OKhLtiyFUPhokYHj
 oHoO7kvFm3W7DBqeyfmFn9hSoFnWJUUjV0hXGsYn+YyxilaFocflfnpuMKvp0AmLIr1r
 N7HTF1s6fyrJk09dkqF5UsDmguwJ7PjWcU0Ib1aLuPDBqUsJdpv06aNpsLwDBh/X4cJS
 toprFTepnYnilK2V7yNZO5+R4c/RUwpU/MuRcjskqbXhsfGAZVswMeTIEVG2kuJmZfqa
 Fn2SE2OlfUVpBocP3rdoRdP+GysAsZefcr+YVhbqFTXx+KCnxqj0GBfT+CqyG7yBR26f
 uxoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU92OoeWu78RQ4WMANIM2sXnWHyZ/shozdJ/whDfE+XtVmVHEgIGONg9k70lBnSqtCkYjezBds=@lists.denx.de
X-Gm-Message-State: AOJu0YzurPshKpWsvl7iRxvLWl0FQtiUYm9FEk2Drz0DmmFUugQUhVnL
 xCsmmYKPCRZScfrF+lfhvu1ZjYJeQs0fnlCh60G4G3NxNeyDLnmW8ug0OzSm6/YJv+0=
X-Gm-Gg: AY/fxX4wL4hb8i1qAHGPtSpIiLR1ZHNgb7geWREcYU9xJ5g+xsiKSV7sm1cMAVkX63w
 XLRy9vIX2tFew5aUESXyKfusfeoocwJM3GwsWZeXga9TSVOwvG2W/uhBSSv7puGSCdnsLCOJrwo
 9WHpvpZ1wP3EkI4ah/PI9kEHBHFAzmPMFyuKifjrzQ2IXSfJZjf9MMwE8UBcwbCz2sVYK+W7cdP
 u9QoUFsO0mPlwaBcICkINUtd48ttnkqOAIp0CPmGXWOk8cWvY7WtsIBMI5BLYWnr17SZbphiqPJ
 CgNvAw0yfNDESXAH7Cnsb1f7Hlg/xvuld/R9dDqB1CO8wTr8/Xb19cwTC4s4hkfiPvUboCH6enu
 aXGXQoao8m2G6o5491cKsMVvbCQPYmx4Nv31UBjCJkam9qhjKXmcGFhQCzc3av0zz75smhGTE4x
 yh0yfTj1zWJNKntA==
X-Google-Smtp-Source: AGHT+IEZKuG46QUDa2aiwNOpIDkLxnlPR5RsnmyIIb4aP9K1LRhFR75ZZoyb7IJKNZAgZ44kTxCqUA==
X-Received: by 2002:a05:600c:3146:b0:479:3a88:de5f with SMTP id
 5b1f17b1804b1-47a8f9174f3mr194719265e9.36.1766056629912; 
 Thu, 18 Dec 2025 03:17:09 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:3734:1277:36b8:3f57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm38070965e9.7.2025.12.18.03.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 03:17:09 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Thu, 18 Dec 2025 12:16:58 +0100
Subject: [PATCH v4 3/5] boot: android: Add bootconfig support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-bootconfig-v4-3-5bbbdb0be1dc@baylibre.com>
References: <20251218-bootconfig-v4-0-5bbbdb0be1dc@baylibre.com>
In-Reply-To: <20251218-bootconfig-v4-0-5bbbdb0be1dc@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>
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
index 48886f39e4c..76600aec863 100644
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

