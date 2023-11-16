Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF52C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56067874FB;
	Thu, 16 Nov 2023 05:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cN0KPqso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C323874D6; Thu, 16 Nov 2023 05:11:43 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2645F87463
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7a93df91813so11956839f.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107899; x=1700712699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vpq6knSvFxEqNqq/uhUxOqqdespU4DG3W09CTCEmwik=;
 b=cN0KPqsoopMRlUSzMf5WMCK/73qNj3NihOAHemYYMuvGEoBaGJnHTu7Xa1Uc7LhVz1
 Yfhyr/jBpBwy1U/mkJNUmyevbTpTS2UtUjK8jqBorIKjsw27QC66SOUrAGwc8eOFaSS0
 g0SnyNwh5Q7oH3r1tkpodwhqOGm14N1oUPWlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107899; x=1700712699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vpq6knSvFxEqNqq/uhUxOqqdespU4DG3W09CTCEmwik=;
 b=sgOGx2GN0zUSlQGG4mXuj+wn8Vn0eNRFbc1VI1cusxru8SgGay53xA/mrzcxzPQZRX
 PZtE48RnQA2vwjD5UI5VIHAhFqRyBtpvk+Or7kvRfmd+I855JVSQ37jVmoqjJzCYIT/s
 KpGnhsrINFSZzZlsc+AUs16pxfRSVXQLg/oBNOyHaCw95e+SPoLImey/hoFCcQ4XLU7t
 M+CfrJ6cTkfnKYfArFuFhOeYIuidyk7zleG7+fk2x8aFxAdyQxKEmFTPfsU3E3wlUQf2
 J7+gOzUBawW2iygBuO50hftOQlwZ5WHj60ru5BD2NStOyM04g54NjI/91sJo+dDPmj30
 Vdnw==
X-Gm-Message-State: AOJu0YwR5J00Qj2wEclvivh46mvPM3ia6I8d05bJYaziCebZ6Ovrfb7V
 4T3l1oraqGaqlvEdS+/2CQvy56RAYQeRdyzRJIySHw==
X-Google-Smtp-Source: AGHT+IHgdyNWgima/RithC56pteI7WOolHfHTS0Gf+Cp+2jAr/wZKPoUfOFWzKsI9ZEOR1XJntolJA==
X-Received: by 2002:a6b:91a:0:b0:7a6:7bbe:5aa0 with SMTP id
 t26-20020a6b091a000000b007a67bbe5aa0mr14937779ioi.0.1700107899581; 
 Wed, 15 Nov 2023 20:11:39 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 23/32] bootm: Reduce arguments to boot_get_fdt()
Date: Wed, 15 Nov 2023 21:10:23 -0700
Message-ID: <20231116041043.362055-24-sjg@chromium.org>
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

This function only uses one argument from bootm (argv[2]) so pass it in
directly.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c     | 5 +++--
 boot/image-fdt.c | 9 +++------
 include/image.h  | 5 ++---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index cd11994e21ce..5dc9cdeb244f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -529,8 +529,9 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
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
2.43.0.rc0.421.g78406f8d94-goog

