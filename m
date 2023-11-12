Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F106C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C3EC87203;
	Sun, 12 Nov 2023 16:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ayh7xrt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C3D87203; Sun, 12 Nov 2023 16:28:02 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF2A5871D7
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a93b7fedb8so127794739f.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699802878; x=1700407678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPGP1TZ9QIqGUDTmpEGWLB2w5O9FFQrvz5a1h2ZC024=;
 b=Ayh7xrt9G3PS7w7jAoer1WUuEMCyilYzx2MFG73vPKn7875sgZmj2btPOKehsSTIdt
 oJoLK8IkxROPSSCYU5XjQ8ZnQHdOjaDXdOIhea6FL79L4GB8sErmMdgSlPjkoWzlOy0Q
 ZwEp28+hMkZyvttRirhilqdiYH851m7hQHl0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699802878; x=1700407678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPGP1TZ9QIqGUDTmpEGWLB2w5O9FFQrvz5a1h2ZC024=;
 b=WquL/BV5FOBgU367QQX5pGzCAHahvk038Tw3a82bN/K76PfXeSHMOL/sBDci/8DX6D
 iKeT56N4gF0TC1MPd7ht2f0JaTgz/ZAIFEwgclKbYJpCCxJavgPHRZlHKoI4pXCNRfiC
 ZQUwE+GUbYICwc6Jrw7z6nOrvVyagpgdZv9VLCdMsS+aFUWozB6Gh993lSWlYbPwg8ET
 BkATFHoBTy+HaDz9M8JrODETvcO+jc2TAANWGxOqatsCJJmRKeumxsd146lfvW1wbBVN
 jfBuizg748VyC3BwH6dqqeqX9DGrTnLzr8WNKySsT+5iyF3FvLqJs4OcXUceJbxIsYnO
 4Kcw==
X-Gm-Message-State: AOJu0YyCr1tL7GvLDE+4WkK/jHkfbnFVJE20tb1lzd/ChdS+ZJTSyDMf
 qmOUeiRfweQp+sEycflu6hfV3Z34z2dD3Wg8WoD3Uw==
X-Google-Smtp-Source: AGHT+IHfW/oiJCXOVjCx5kNONZCtmT5qkjCPZneUkqKYUz6STG6UzVA6A0T1GNSAQICFW9QGO5MKfA==
X-Received: by 2002:a05:6602:4185:b0:79f:a25b:51c with SMTP id
 bx5-20020a056602418500b0079fa25b051cmr6744476iob.11.1699802878354; 
 Sun, 12 Nov 2023 07:27:58 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 76-20020a6b144f000000b0079fdbe2be51sm1226241iou.2.2023.11.12.07.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:27:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Edmond <seanedmond@microsoft.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 1/7] boot: Drop size parameter from image_setup_libfdt()
Date: Sun, 12 Nov 2023 08:27:44 -0700
Message-ID: <20231112152754.130399-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112152754.130399-1-sjg@chromium.org>
References: <20231112152754.130399-1-sjg@chromium.org>
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

The of_size parameter is not used, so remove it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/mips/lib/bootm.c         | 4 ++--
 boot/image-board.c            | 2 +-
 boot/image-fdt.c              | 3 ++-
 cmd/bootefi.c                 | 2 +-
 include/image.h               | 3 +--
 lib/efi_loader/efi_dt_fixup.c | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index d6d2f7d9d031..f1cff691f4fe 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -246,8 +246,8 @@ static int boot_setup_fdt(struct bootm_headers *images)
 {
 	images->initrd_start = virt_to_phys((void *)images->initrd_start);
 	images->initrd_end = virt_to_phys((void *)images->initrd_end);
-	return image_setup_libfdt(images, images->ft_addr, images->ft_len,
-		&images->lmb);
+
+	return image_setup_libfdt(images, images->ft_addr, &images->lmb);
 }
 
 static void boot_prep_linux(struct bootm_headers *images)
diff --git a/boot/image-board.c b/boot/image-board.c
index d500da1b4b91..893eaf935137 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -959,7 +959,7 @@ int image_setup_linux(struct bootm_headers *images)
 	}
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && of_size) {
-		ret = image_setup_libfdt(images, *of_flat_tree, of_size, lmb);
+		ret = image_setup_libfdt(images, *of_flat_tree, lmb);
 		if (ret)
 			return ret;
 	}
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index f10200f64743..54d219da7da1 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -604,12 +604,13 @@ __weak int arch_fixup_fdt(void *blob)
 }
 
 int image_setup_libfdt(struct bootm_headers *images, void *blob,
-		       int of_size, struct lmb *lmb)
+		       struct lmb *lmb)
 {
 	ulong *initrd_start = &images->initrd_start;
 	ulong *initrd_end = &images->initrd_end;
 	int ret = -EPERM;
 	int fdt_ret;
+	int of_size;
 
 	if (fdt_root(blob) < 0) {
 		printf("ERROR: root node setup failed\n");
diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 20e5c94a33a4..2809f599011f 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -309,7 +309,7 @@ efi_status_t efi_install_fdt(void *fdt)
 		return EFI_OUT_OF_RESOURCES;
 	}
 
-	if (image_setup_libfdt(&img, fdt, 0, NULL)) {
+	if (image_setup_libfdt(&img, fdt, NULL)) {
 		log_err("ERROR: failed to process device tree\n");
 		return EFI_LOAD_ERROR;
 	}
diff --git a/include/image.h b/include/image.h
index 2e3cf839ee36..c7ec83b4e638 100644
--- a/include/image.h
+++ b/include/image.h
@@ -953,12 +953,11 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
  *
  * @images:	Images information
  * @blob:	FDT to update
- * @of_size:	Size of the FDT
  * @lmb:	Points to logical memory block structure
  * Return: 0 if ok, <0 on failure
  */
 int image_setup_libfdt(struct bootm_headers *images, void *blob,
-		       int of_size, struct lmb *lmb);
+		       struct lmb *lmb);
 
 /**
  * Set up the FDT to use for booting a kernel
diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 838023c78ff7..a0c889cf9867 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -173,7 +173,7 @@ efi_dt_fixup(struct efi_dt_fixup_protocol *this, void *dtb,
 		}
 
 		fdt_set_totalsize(dtb, *buffer_size);
-		if (image_setup_libfdt(&img, dtb, 0, NULL)) {
+		if (image_setup_libfdt(&img, dtb, NULL)) {
 			log_err("failed to process device tree\n");
 			ret = EFI_INVALID_PARAMETER;
 			goto out;
-- 
2.42.0.869.gea05f2083d-goog

