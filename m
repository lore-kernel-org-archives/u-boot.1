Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD33C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E273C877F9;
	Sun, 12 Nov 2023 01:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YIR+8Ssd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A61C0803AE; Sun, 12 Nov 2023 01:10:55 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C60086FE9
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3576e74ae9dso13203245ab.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747796; x=1700352596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2F6Y7rf6MLudML0UnF2PECTiI0lJfYuEFpDW5LucHdM=;
 b=YIR+8SsdX6Sl4HYzGgNcuiz719MhR/EUPKRgshDDPXGSthhbSk6E70xdyIibCQrENM
 1r8hvdaINMWfl9xM7/T55vse4UHfUMGe2HFh8KK2xN7sQo3boZn+vCcOsyKknrzynaOs
 a8VEOlsBWzKw39pkB7vkRhDjU+maOeeJ0lhXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747796; x=1700352596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2F6Y7rf6MLudML0UnF2PECTiI0lJfYuEFpDW5LucHdM=;
 b=IjPoPB49eZ3U+B1XYGfPAVSm4qVQB1NSfmO9pYH/Uxh8iX84GSjIgm/bfsqFpoCYtR
 V8miD9BqwuzApkwuN74nFZLog2XsDanaxjGcuFtIibj2Fs5qB5IsGftc+bVGC4LqvD4f
 CCVh9KPoiNMx1WzC8NFuzVbb/xcD09EgZ3pbht5PMe/sl7Yok1u+ZFJ+W5gBhg3TO2ag
 h6KheAuiZPQDUkyvX/2dmp81MGDfmaEaU9c/p+0q1H3B84XA3O+y0DqbgyCowXQflKzN
 Vk3e805+SKjcXueB8yJDaEf0ZVasbVfS1eJYdUiXeaB9041VAXbwIPTNnTayXsIsjASQ
 Puvg==
X-Gm-Message-State: AOJu0Yy2NmtbjKPC/5Q/EV/P8da1uro8zl4PbLe6iFu5eMByq2t3jkAU
 Mv2JjaPJUDkbca7ke1oQ36wD2DUpDwFs+oB5Zx62GQ==
X-Google-Smtp-Source: AGHT+IHc252LAa4TKPhQYUzxiieIaw/XeBvS6V8tE542nLF+3XVVpA5D26jusDIW5mCl2HT9jJAuFQ==
X-Received: by 2002:a05:6e02:152c:b0:357:ca98:3db2 with SMTP id
 i12-20020a056e02152c00b00357ca983db2mr4665922ilu.21.1699747796136; 
 Sat, 11 Nov 2023 16:09:56 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 28/29] bootm: Add a function to check overlap
Date: Sat, 11 Nov 2023 17:09:13 -0700
Message-ID: <20231112000923.73568-29-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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
---

 boot/bootm.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 54e4b48e907c..a803b0749be0 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -467,6 +467,37 @@ static int bootm_find_os(const char *addr_fit)
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
@@ -496,16 +527,8 @@ int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
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
@@ -519,15 +542,9 @@ int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
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
2.42.0.869.gea05f2083d-goog

