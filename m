Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFD7C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E188D87754;
	Sun, 12 Nov 2023 01:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GkhWvc/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75BC586F42; Sun, 12 Nov 2023 01:10:24 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14AA86F83
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35941fd3a60so13323275ab.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747789; x=1700352589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fccC8YYY8McipKat4XNoBcD2YlbE/oLX8xx4w632T3Q=;
 b=GkhWvc/ryKylekC9xFRO2KVl9p/497NRzENGgYTXmUSJa8VFdm0mrF+/MG1FG/9R4A
 W+glWynh4NnX2TqvjAAnP7Xvl2ajb7C8HtWl2JixqphIsGITaNIgn+aUAAF27RKaxf3M
 Uf7bhXk0omJ2XJTFmEBu/WkJIm/t6t7frnI5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747789; x=1700352589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fccC8YYY8McipKat4XNoBcD2YlbE/oLX8xx4w632T3Q=;
 b=L06qBRYyPggC8GbDbHPVtMUjLQzRdesus9hbq22nmRqEAgPWZ8Or1OV7MHLeAwka6k
 nxBKhH8pY4jBMIQgAbqMQPCaCzVW9X5VUrEY5TJG3sp86uvp6jscLCM+xj++N+fMZEls
 uzstvo51+mrQCRJ9KkdImUMfRinodGEc6uDNc+nHF8xEJnoCvN8stjZg5ma9/Xoopzk4
 ncyDii0RqnUp8ZRzzX8noNZ8Vf8F8upinYYhMghOhJLdc1lWYb6wQUs9T8WAQs36jOEz
 3XFw1k9fQKkT+Z0vq3zjZnngVfEQp5b6jsT67YGxpqxVAZls+LnVslXax6gwIUPqi035
 97Zg==
X-Gm-Message-State: AOJu0Yxl1SfHAucG9cY4lVbuFv80neqgptx8C93CyUhJszIMdTPLtS0N
 dfEEaW93M/tam4ZxH7qXksaYSo+kxlYLTxr2g/nIEA==
X-Google-Smtp-Source: AGHT+IHrX4lTlK3K+puXPDIf9xpn6i3w6ICFW5aCJyUfLijqdPj0/CBoKUTnBI8G72EU2/Jn1p6GWA==
X-Received: by 2002:a05:6e02:190f:b0:359:4048:38d2 with SMTP id
 w15-20020a056e02190f00b00359404838d2mr5055792ilu.0.1699747789525; 
 Sat, 11 Nov 2023 16:09:49 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 21/29] bootm: Reduce arguments to boot_get_fdt()
Date: Sat, 11 Nov 2023 17:09:06 -0700
Message-ID: <20231112000923.73568-22-sjg@chromium.org>
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

This function only uses one argument from bootm (argv[2]) so pass it in
directly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c     | 5 +++--
 boot/image-fdt.c | 9 +++------
 include/image.h  | 5 ++---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4959fcd91533..4d732719ad84 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -528,8 +528,9 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		buf = map_sysmem(img_addr, 0);
 
 		/* find flattened device tree */
-		ret = boot_get_fdt(buf, flag, argc, argv, IH_ARCH_DEFAULT,
-				   &images, &images.ft_addr, &images.ft_len);
+		ret = boot_get_fdt(buf, argc > 2 ? argv[2] : NULL,
+				   IH_ARCH_DEFAULT, &images, &images.ft_addr,
+				   &images.ft_len);
 		if (ret) {
 			puts("Could not find a valid device tree\n");
 			return 1;
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 6ff2d52d6c70..08fca08b710a 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -447,19 +447,16 @@ static int select_fdt(struct bootm_headers *images, const char *select, u8 arch,
 	return 0;
 }
 
-int boot_get_fdt(void *buf, int flag, int argc, char *const argv[], uint arch,
+int boot_get_fdt(void *buf, const char *select, uint arch,
 		 struct bootm_headers *images, char **of_flat_tree,
 		 ulong *of_size)
 {
-	ulong		fdt_addr;
-	char		*fdt_blob = NULL;
-	const char *select = NULL;
+	char *fdt_blob = NULL;
+	ulong fdt_addr;
 
 	*of_flat_tree = NULL;
 	*of_size = 0;
 
-	if (argc > 2)
-		select = argv[2];
 	if (select || genimg_has_config(images)) {
 		int ret;
 
diff --git a/include/image.h b/include/image.h
index a4555f25fb56..04f35de9d082 100644
--- a/include/image.h
+++ b/include/image.h
@@ -812,8 +812,7 @@ int fit_get_node_from_config(struct bootm_headers *images,
  * boot_get_fdt() - locate FDT devicetree to use for booting
  *
  * @buf: Pointer to image
- * @argc: command argument count
- * @argv: command argument list
+ * @select: FDT to select (this is normally argv[2] of the bootm command)
  * @arch: architecture (IH_ARCH_...)
  * @images: pointer to the bootm images structure
  * @of_flat_tree: pointer to a char* variable, will hold fdt start address
@@ -832,7 +831,7 @@ int fit_get_node_from_config(struct bootm_headers *images,
  *     1, if fdt image is found but corrupted
  *     of_flat_tree and of_size are set to 0 if no fdt exists
  */
-int boot_get_fdt(void *buf, int flag, int argc, char *const argv[], uint arch,
+int boot_get_fdt(void *buf, const char *select, uint arch,
 		 struct bootm_headers *images, char **of_flat_tree,
 		 ulong *of_size);
 
-- 
2.42.0.869.gea05f2083d-goog

