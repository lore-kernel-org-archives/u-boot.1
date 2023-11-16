Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AA3C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47AA38751F;
	Thu, 16 Nov 2023 05:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TLejc9dH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B870874FC; Thu, 16 Nov 2023 05:11:49 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52FAD874D0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a689bd4928so41999539f.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107906; x=1700712706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NYNUaqaaJsn2D5stahdQhlfjdH3OArSjtyP9cy03y8=;
 b=TLejc9dHdfDJ7y7/gjjWT/fUkNyZnxXbfdCT0FHMTruEK04fF6rqKHtyFLgZmdE7L7
 ayB5CUNLPL2ogidYTUTZnUfPB06mCoGX+0+WOn/+TEL10FpzZLW3FI+NAoxhxB3LtnXZ
 E2P4dwE0kCJXi709pllXBOaMkt5jeeUyzPTkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107906; x=1700712706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NYNUaqaaJsn2D5stahdQhlfjdH3OArSjtyP9cy03y8=;
 b=JPo+c69smjfsDCNTjtrmWlb8MKSl98QDflOFGJdkV0eF5Gxa7AM5sk1CI2JwopkazT
 jtuxYuVDgUoqk1Kh4udqbk8WGEvTu1kme4Wgw3PSdBMIkbwfS7WSYbRd3yvfrtJ+0p5m
 lGYTwxjy023AMfBUFKguv/2cWDjpig6Ftz1kE/2R9Gijou7Ce10/QS+WE2gqky1pzqYs
 aYSAp+y+40/xppJoWel83JSPy7u3UlUyJX8m78rrIOyD3/zkOG0FYZQ+tVAGtCCl3Wxm
 438pmwF+RCKXAbzaopy8xL2KQO7D1fRP41Fwiu2XDuhdIIc+my5ypOac2etYr/MZf0ni
 pg/Q==
X-Gm-Message-State: AOJu0YwiZC8OvK/Lyb+Gwe4K0K4ninZvEMy6qrYjg/TlkcF0/zNb5PX3
 G3RrVa2xiZO/QYbeHnLCGb5zBKBV1xmvaJxijKx9UQ==
X-Google-Smtp-Source: AGHT+IFzbjfxqeYqYeGkQHGPzBf8mMxtR8wplOeJUNrjW3+C8Icxd0uubiTL4ypstQvU/sQR+mEZnw==
X-Received: by 2002:a92:6a0d:0:b0:357:592a:8c4a with SMTP id
 f13-20020a926a0d000000b00357592a8c4amr467534ilc.12.1700107905926; 
 Wed, 15 Nov 2023 20:11:45 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 30/32] bootm: Add a function to check overlap
Date: Wed, 15 Nov 2023 21:10:30 -0700
Message-ID: <20231116041043.362055-31-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

