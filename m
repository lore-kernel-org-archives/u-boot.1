Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80187C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 13:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D8F88292;
	Sun, 19 May 2024 15:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SmGesjGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E908882AA; Sun, 19 May 2024 15:10:01 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FC5388286
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 15:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4202959b060so11973775e9.2
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 06:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716124199; x=1716728999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xau8kTEuANbhoDNhbo+zwN6iGY3P43NpGdFamxG4sKo=;
 b=SmGesjGkyewU9kLzUPnnEgTFsSPPzQg0hshsCOsg3vvCK+SWbsRDmkDZid4Aacv3PA
 XhsismHiB4lRGodRwKdcogc1ecHIFz/ArvblELzIjTSdwaaHWWOqzFb0W2qanlwHLFto
 1R+QsyJdbO2uWdgM0qbTNDV5DQEYpoifIMwdB5W+ISrCpahCWfEYCS1txyqxDD/cYTUk
 Vd+/nJUVKpjO4Q3f8aeSM2euF6lrxQE9T9YuxwQxb79o9kQoiUgf6bVgf3r64rWAa3nv
 EZJTcF9HzZAW/7FeSsg0ToGmwKoaFC4i192mMupUNxTjczJqvCUW3EappSLzWC4rsOA2
 h2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716124199; x=1716728999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xau8kTEuANbhoDNhbo+zwN6iGY3P43NpGdFamxG4sKo=;
 b=ppjP70rm9NZzLr5Igi//bC5Ld8FK9wv0bNhQ7EX5Sec+R3megtqmDRHc9JntYa1duo
 UeGk1Q7iNsoFtK5c4sTnrs00Rpi0aFg0zTEFyGHMTxIR4NkyqrYIzoZx0ja5OL0UsABG
 WDcIfJvU20hiZknH4xBQfE/y+J5E1fHVbRgMvWgvHUqUSOwDGQ2hPcQW7/pFt8h5yScq
 wll17WAzn6b8VjM6/macg/Nurx7HvnUUQv1Vtu9/UkvBmTHKbg3bWIE394nsOj/EFbJK
 nMdG+UxUjowPWN7TDvRtD35RTyCmlhB3J0jmYTicruPKac+4sT+F/nb/NwA/ctdleZ2L
 BQTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLpIjlBbRHyX9aD22SzOBRDcUeKu7Laomk+UyYsAR3r3M88i/LiQjvbyuYshpXxzridwwDOy+B1NWHX8q4XI8Kpll07Q==
X-Gm-Message-State: AOJu0YyGfCnrfaoK9ucDUIS1wBrZmWS9X+AakMXd/U3uGofCrZVbeevB
 eN7/qVYcsEPkKUmfGUYjie9pcA44b/CM7YplPNsrm1vimmnN3EU4
X-Google-Smtp-Source: AGHT+IGhsfd9uo35OV5G59fuD58nr5czi0ysWzTqTLaF+tGeAifUrIF8oeL/vVffNzBldSGiEOzScQ==
X-Received: by 2002:a05:600c:3509:b0:420:11cd:d302 with SMTP id
 5b1f17b1804b1-42011cdd486mr166737055e9.9.1716124198548; 
 Sun, 19 May 2024 06:09:58 -0700 (PDT)
Received: from roman-envy-fast.. ([46.172.77.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013bf1a5dsm278536165e9.30.2024.05.19.06.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 06:09:58 -0700 (PDT)
From: Roman Stratiienko <r.stratiienko@gmail.com>
To: r.stratiienko@gmail.com,
	u-boot@lists.denx.de
Cc: sjg@chromium.org, igor.opaniuk@gmail.com, mkorpershoek@baylibre.com,
 semen.protsenko@linaro.org, souajih@baylibre.com
Subject: [PATCH] android: Fix ramdisk loading for bootimage v3+
Date: Sun, 19 May 2024 13:09:51 +0000
Message-Id: <20240519130951.2558467-1-r.stratiienko@gmail.com>
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

The boot_ramdisk and vendor_ramdisk must be both concatenated together.
Without this change, Android root is missing some of the necessary tools
to complete virtual AB OTA.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 boot/image-android.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 04f2a8015e..499eae9bcd 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -64,7 +64,6 @@ static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3
 
 	data->kcmdline = hdr->cmdline;
 	data->header_version = hdr->header_version;
-	data->ramdisk_ptr = env_get_ulong("ramdisk_addr_r", 16, 0);
 
 	/*
 	 * The header takes a full page, the remaining components are aligned
@@ -75,6 +74,7 @@ static void android_boot_image_v3_v4_parse_hdr(const struct andr_boot_img_hdr_v3
 	data->kernel_ptr = end;
 	data->kernel_size = hdr->kernel_size;
 	end += ALIGN(hdr->kernel_size, ANDR_GKI_PAGE_SIZE);
+	data->ramdisk_ptr = end;
 	data->ramdisk_size = hdr->ramdisk_size;
 	data->boot_ramdisk_size = hdr->ramdisk_size;
 	end += ALIGN(hdr->ramdisk_size, ANDR_GKI_PAGE_SIZE);
@@ -462,25 +462,24 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 		return -1;
 	}
 	if (img_data.header_version > 2) {
-		ramdisk_ptr = img_data.ramdisk_ptr;
+		ramdisk_ptr = img_data.ramdisk_addr;
 		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
 		       img_data.vendor_ramdisk_size);
-		memcpy((void *)(ramdisk_ptr + img_data.vendor_ramdisk_size),
-		       (void *)img_data.ramdisk_ptr,
+		ramdisk_ptr += img_data.vendor_ramdisk_size;
+		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
 		       img_data.boot_ramdisk_size);
+		ramdisk_ptr += img_data.boot_ramdisk_size;
 		if (img_data.bootconfig_size) {
 			memcpy((void *)
-			       (ramdisk_ptr + img_data.vendor_ramdisk_size +
-			       img_data.boot_ramdisk_size),
-			       (void *)img_data.bootconfig_addr,
+			       (ramdisk_ptr), (void *)img_data.bootconfig_addr,
 			       img_data.bootconfig_size);
 		}
 	}
 
 	printf("RAM disk load addr 0x%08lx size %u KiB\n",
-	       img_data.ramdisk_ptr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
+	       img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
 
-	*rd_data = img_data.ramdisk_ptr;
+	*rd_data = img_data.ramdisk_addr;
 
 	*rd_len = img_data.ramdisk_size;
 	return 0;
-- 
2.40.1

