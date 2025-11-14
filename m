Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE891CE8D44
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C37F84167;
	Fri, 14 Nov 2025 16:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UyjrNB57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C381F8416C; Fri, 14 Nov 2025 16:28:48 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 745DC84150
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4710022571cso20265945e9.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763134126; x=1763738926;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q3bCKChn0zIEME7z6wBTfoX8kw1DdkHUSzEDiKu2EmA=;
 b=UyjrNB57/eU51FRQOSYrkNjsFCTtwI4hP6jjW2GLqXcxBEn1y0a7H4g+aWgnK8d9R5
 rp4KZUjyITIrroY/1F9OK2CyGimV2Te7pA06AJYJEINFWA47SpXGtJ7slztg79G9oJlm
 opVq2WuPo7aeivoTot7BB7QL+DUcSmJEXNlAOoOyI7RT932KymPpyqh03ezp21GLGm0h
 gfwjrzfYwQQZuHgD5zJ/1LITtwmlK9cFtn4UERuGSmLnFpeaMMdxHslbEYc2NkM0TOj2
 aBymSmj4MAo3fDl1ElyQpy2pDfIafuuo1R0n1HDTHDaZkWUGhz3nb7yBOEGP9ZooNiZ6
 R+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763134126; x=1763738926;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q3bCKChn0zIEME7z6wBTfoX8kw1DdkHUSzEDiKu2EmA=;
 b=TvjDqvJNg7w8DNWY1QC8MRBielFAG24VrbtPpWwqvchtKlgl0CAbLJFI660RcOTCMW
 nRXYqqN4y6FiwdLnRzzoUMA/WXkv2oJq4lYtJK1yJqLuLTw1/vJwRQuQZyJMIbt//+kB
 mhejJ6Y3f99u19dFEpBB/2b7lo6mtNSYNCuRnqrnKuf1ti38CxhNtYVlSuqQzmdbVksD
 beln+Xsyn2wDNxk25gKHqt6ZDW/kzgJCY7DtSlQV/w/0tU33A4R86/Eb3sN0b1zRUu+L
 IfJOfIuNS7vKEz4ANAPkWcUJ4B4YC66+6UdKzkJhar5rocyagAQJtvkOEkzzdEbkWpBp
 bfag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPGDJGUqPPQ3seBHj0RnyeLQmbTH1n6ahhqL8aDvZ+TJUF0P763SZnMpaN4SvnQsvUvF+SGJA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9NB1v+GdLPpd2iihZuu1nn2KHjj0ueKwDxQlBLPnUE2LwyHcJ
 rCs94bTuLWu2ZEjnFNk7rszDtVNTDVoR7Z2flfYCnz1tV3+3THtA0CgeWUJIWkpIz18=
X-Gm-Gg: ASbGncvRk1v+6HSm3YGXzstaw+o5QEJ1aEX/0agyZk1acT/2wtDGJFdYiuZrAHkZofZ
 Jq97U3S3XlbEeb6roJFiJ+ixKYPaFQ9/biVvMpsu6USfOguA9SP6l3jwOgXtfTTggZra1ojtVr/
 EaUnpcm+40nSQoFce1thZy33tzJUAltg8S80gN0xdCjOSr/2amF23An2fCWfBalnEd0peD0Gqvf
 UHLRUeO18oFQCxMEzMySTndHCrX/4FKSOD7U0a/ZR9wjcop+lfA8UFZpKz31HhpyYY2zHYsY45/
 i1+ygwiTXngJQwhXCf8jADlb2ItHupBkrxu8zLzf4u/8F5L+GKAy8fATtnim+Wu+0pnhXvuVB7r
 BxZtxX3ndtR6GdyfdAu4JOaib4D2jh2WQxoyKfjabkF5hA/89CHoPi/tHbPbGzvnltZ7YqVZwpE
 G6+e87so5pOYLl
X-Google-Smtp-Source: AGHT+IG+wn1d4/nrOG6VlTED+Ag6KODKfU0HplTzA57rq5ppN4N3vyNH6/W2WCedCB0Q13xzk9Ig8Q==
X-Received: by 2002:a05:600c:1c20:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-4778fe4f635mr34226475e9.5.1763134125822; 
 Fri, 14 Nov 2025 07:28:45 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:1ab:5fd8:dd9b:8e8b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779524d2ffsm15741035e9.3.2025.11.14.07.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:28:45 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 14 Nov 2025 16:28:42 +0100
Subject: [PATCH v3 3/5] boot: android: Add bootconfig support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-bootconfig-v3-3-a28b813dba90@baylibre.com>
References: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
In-Reply-To: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>
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
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 boot/image-android.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 109 insertions(+), 11 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 613f2aa4b9e..94c2879dcd6 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -503,6 +503,112 @@ ulong android_image_get_kcomp(const void *hdr,
 		return image_decomp_type(p, sizeof(u32));
 }
 
+static u32 android_image_set_bootconfig(const void *hdr,
+					const void *vendor_boot_img,
+					ulong ramdisk_ptr)
+{
+	/* Extract androidboot.* parameters from bootargs */
+	const char *bootargs = env_get("bootargs");
+	char *androidboot_params = NULL;
+	char *new_bootargs = NULL;
+	size_t androidboot_params_len = 0;
+	struct andr_image_data img_data;
+	u32 bytes_added = 0;
+
+	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
+		return 0;
+
+	if (bootargs && img_data.bootconfig_size) {
+		size_t len = strlen(bootargs);
+
+		androidboot_params = malloc(len + 1);
+		new_bootargs = malloc(len + 1);
+		if (!androidboot_params || !new_bootargs) {
+			free(androidboot_params);
+			free(new_bootargs);
+			printf("Error: malloc failed\n");
+			return -ENOMEM;
+		}
+
+		/* Extract androidboot.* and build new bootargs in one pass */
+		const char *src = bootargs;
+		char *bc_dst = androidboot_params;
+		char *args_dst = new_bootargs;
+
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
+				if (bc_dst != androidboot_params)
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
+		androidboot_params_len = bc_dst - androidboot_params;
+
+		/* Update bootargs if we extracted any androidboot params */
+		if (androidboot_params_len > 1)
+			env_set("bootargs", new_bootargs);
+	}
+
+	/* Map addresses for memcpy operations */
+	void *ramdisk_dest = map_sysmem(ramdisk_ptr, img_data.ramdisk_size);
+	void *vendor_ramdisk_src =
+		map_sysmem(img_data.vendor_ramdisk_ptr, img_data.vendor_ramdisk_size);
+	void *boot_ramdisk_src =
+		map_sysmem(img_data.ramdisk_ptr, img_data.boot_ramdisk_size);
+
+	memcpy(ramdisk_dest, vendor_ramdisk_src, img_data.vendor_ramdisk_size);
+	memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size, boot_ramdisk_src,
+	       img_data.boot_ramdisk_size);
+
+	if (img_data.bootconfig_size) {
+		void *bootconfig_src =
+			map_sysmem(img_data.bootconfig_addr, img_data.bootconfig_size);
+		memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size +
+			img_data.boot_ramdisk_size,
+		bootconfig_src, img_data.bootconfig_size);
+		unmap_sysmem(bootconfig_src);
+
+		/* Add androidboot.* parameters to bootconfig */
+		if (androidboot_params && androidboot_params_len > 1) {
+			ulong bootconfig_ptr = (ulong)ramdisk_dest +
+					img_data.vendor_ramdisk_size +
+					img_data.boot_ramdisk_size;
+			bytes_added =
+				add_bootconfig_parameters(androidboot_params,
+							  androidboot_params_len,
+							  bootconfig_ptr,
+							  img_data.bootconfig_size);
+		}
+	}
+
+	free(androidboot_params);
+	free(new_bootargs);
+
+	unmap_sysmem(boot_ramdisk_src);
+	unmap_sysmem(vendor_ramdisk_src);
+	unmap_sysmem(ramdisk_dest);
+	return bytes_added;
+}
+
 int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 			      ulong *rd_data, ulong *rd_len)
 {
@@ -534,17 +640,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
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

