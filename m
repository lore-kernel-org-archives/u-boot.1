Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A878CC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871E987564;
	Sat, 18 Nov 2023 22:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oJONTLCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D79870C3; Sat, 18 Nov 2023 22:06:46 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E670787533
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7a94c5538aeso109665539f.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341575; x=1700946375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vpq6knSvFxEqNqq/uhUxOqqdespU4DG3W09CTCEmwik=;
 b=oJONTLCpMoSfUu8Yqx5XjelJPH1qf+WFJvcEjArT5dr6SfZievBOw7v/cLmvnrcO+F
 0qnio0nHq7O8R/vqOw/709KBo5wGBmqt4a0L4MGG0QF9jt6/kMXtcySfqnT4tkqT7osM
 q28Vltw5F0Q97+fksHU/3Wb4y0TWGDsYha2lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341575; x=1700946375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vpq6knSvFxEqNqq/uhUxOqqdespU4DG3W09CTCEmwik=;
 b=UjXuXoSIDQ2+eRxauGnDgd6s1jPoT9aqC3VNDlUXGyZmypb5w2nP79ty2GidxzO9Ka
 ahZYPLX+8LizyQ3emGOZdLeIeNMCokTXdaySKYV16cWSBaPPlUPSg2SH6u+KiPs8Mi4o
 cPWveYpcLqIoLTlqEvLsvBLnUHENSAFg8/GWYBcfdEMnlXPyEMtLUDkzKVohyt97wYeB
 CsQKbQAr2gRxmGRW+TraCccmfl92FMY6jaWKN7kWfz4XDey0pZS9EFNjQOUgfuobyb4M
 8WX3lwJAiAtJzP/h6lJKlADYZUKNNJ4HxWx0w/GhYTI2AuLn4R5WyI5oxydv1NKNwMsI
 9O0A==
X-Gm-Message-State: AOJu0YwMyLcBenTYPYWrC164xPo898amHyNTArJEp9aWNifHCstAMht5
 DjHZFWXXml0cE67pVbg0ubzDId6mMHQdwZed4xei/Q==
X-Google-Smtp-Source: AGHT+IGxhcHu/Cz6+f4Fsj0Lmu9VAAaB+CFhO8t4TmoVcv4YTW8wutEfvb8Qf3syXMXbb0M0B21qIw==
X-Received: by 2002:a5e:c74a:0:b0:780:bf50:32ce with SMTP id
 g10-20020a5ec74a000000b00780bf5032cemr3451052iop.19.1700341575557; 
 Sat, 18 Nov 2023 13:06:15 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 22/32] bootm: Reduce arguments to boot_get_fdt()
Date: Sat, 18 Nov 2023 14:05:10 -0700
Message-ID: <20231118210547.577026-23-sjg@chromium.org>
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

