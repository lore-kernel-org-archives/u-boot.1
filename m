Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E500C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0576C8750C;
	Sat, 18 Nov 2023 22:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XEsRAHmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C132386FC9; Sat, 18 Nov 2023 22:06:37 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE218713D
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7b0683ff3c8so110130939f.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341582; x=1700946382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NYNUaqaaJsn2D5stahdQhlfjdH3OArSjtyP9cy03y8=;
 b=XEsRAHmF0RPMp7fq5ky1rLccAn7fRWrAbxKPhjdKYTUjUBnWwmYJGUXXuEgyzxSFyP
 XRE8omciIrzaEWQRTSe9si0b7kGiVgxLEicGPotBbmnAG2DLJUokYrbRg5mTBjxm/Lq/
 TiqnRE6gaaHa34HlJsZ7fR09npkctHDw4hFaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341582; x=1700946382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NYNUaqaaJsn2D5stahdQhlfjdH3OArSjtyP9cy03y8=;
 b=Bf0mXdvWNAPYp1hY6XD6lkGGsh3Ta4xxloJn8W7eK4xX3v5zKao9RQFPv+EgYOy7V4
 43Qfl6KrCqcccFO5dJcNh45ltllKFWPfHC+fy8eIkfbuhfVXyNKtQFEzGZ8WWcswiBwk
 jK/1Zmx2JlOja+t2SFVvpN/XV/uCdsW2ByCWfIM2ltpYvf4u83DmQyw8haO747m0juoj
 +xgq7PX5mW/6jsFDq5QSmX+sMgLdV+jZILKfZIpawqEsHHGcmYfS5d99wDtfgmjMX0Iv
 2RHnbkktb7PfS50q6QLW30qpdPZBQzCnjSfJglR5gN6v4XJngyoxRuu3AFgYS3jzv4/W
 jdZQ==
X-Gm-Message-State: AOJu0YzANgN2hQ1Kv1iApPhP+P8RBiwfvJfjAKiZCOUrpAjLpSHJ9M4h
 YDr8MdgrsV5+FyOihN6XUr2Hg0qP5xajoK2IsSas/Q==
X-Google-Smtp-Source: AGHT+IHUNmk2lC+O/NQrY1ATFFKC47ZfrqldNID6T59TvozgrHjK848DNAodMPvRJVwYbetKlFBvwg==
X-Received: by 2002:a05:6602:81:b0:7a6:7bbe:5aa0 with SMTP id
 h1-20020a056602008100b007a67bbe5aa0mr3251792iob.0.1700341582492; 
 Sat, 18 Nov 2023 13:06:22 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 29/32] bootm: Add a function to check overlap
Date: Sat, 18 Nov 2023 14:05:17 -0700
Message-ID: <20231118210547.577026-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

Move this code into a function to reduce code size and make it easier
to understand. Drop the unnecessary 0x to help a little with code size.

Use this in bootm_find_images()

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index fe6e84601f58..371f404a02a5 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -468,6 +468,37 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 	return 0;
 }
 
+/**
+ * check_overlap() - Check if an image overlaps the OS
+ *
+ * @name: Name of image to check (used to print error)
+ * @base: Base address of image
+ * @end: End address of image (+1)
+ * @os_start: Start of OS
+ * @os_size: Size of OS in bytes
+ * Return: 0 if OK, -EXDEV if the image overlaps the OS
+ */
+static int check_overlap(const char *name, ulong base, ulong end,
+			 ulong os_start, ulong os_size)
+{
+	ulong os_end;
+
+	if (!base)
+		return 0;
+	os_end = os_start + os_size;
+
+	if ((base >= os_start && base < os_end) ||
+	    (end > os_start && end <= os_end) ||
+	    (base < os_start && end >= os_end)) {
+		printf("ERROR: %s image overlaps OS image (OS=%lx..%lx)\n",
+		       name, os_start, os_end);
+
+		return -EXDEV;
+	}
+
+	return 0;
+}
+
 int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
 		      const char *conf_fdt, ulong start, ulong size)
 {
@@ -497,16 +528,8 @@ int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
 	}
 
 	/* check if ramdisk overlaps OS image */
-	if (images.rd_start && (((ulong)images.rd_start >= start &&
-				 (ulong)images.rd_start < start + size) ||
-				((ulong)images.rd_end > start &&
-				 (ulong)images.rd_end <= start + size) ||
-				((ulong)images.rd_start < start &&
-				 (ulong)images.rd_end >= start + size))) {
-		printf("ERROR: RD image overlaps OS image (OS=0x%lx..0x%lx)\n",
-		       start, start + size);
+	if (check_overlap("RD", images.rd_start, images.rd_end, start, size))
 		return 1;
-	}
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT)) {
 		buf = map_sysmem(img_addr, 0);
@@ -520,15 +543,9 @@ int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
 		}
 
 		/* check if FDT overlaps OS image */
-		if (images.ft_addr &&
-		    (((ulong)images.ft_addr >= start &&
-		      (ulong)images.ft_addr < start + size) ||
-		     ((ulong)images.ft_addr + images.ft_len >= start &&
-		      (ulong)images.ft_addr + images.ft_len < start + size))) {
-			printf("ERROR: FDT image overlaps OS image (OS=0x%lx..0x%lx)\n",
-			       start, start + size);
+		if (check_overlap("FDT", map_to_sysmem(images.ft_addr),
+				  images.ft_len, start, size))
 			return 1;
-		}
 
 		if (IS_ENABLED(CONFIG_CMD_FDT))
 			set_working_fdt_addr(map_to_sysmem(images.ft_addr));
-- 
2.43.0.rc0.421.g78406f8d94-goog

