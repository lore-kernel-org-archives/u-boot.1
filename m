Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86356C61D88
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436458759F;
	Tue, 21 Nov 2023 02:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tdSWpJjR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D70187594; Tue, 21 Nov 2023 02:30:42 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F9687574
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ca85ff26afso8802145ad.1
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530234; x=1701135034; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0WEP5AXjHAZm/oKDWY7reBF0PdcawUlf+/Ln7Vx3Gk=;
 b=tdSWpJjRI5jbe3xbYk9NXBQiiDoyvfF8Tjb+eec8xrvTy1GgqnMZtuyTjzdSonzHHg
 A/rHy5hn3X9hMdf++t3cnIZiI967xrmXzhA1aOJA2RcLEqmry7at+zt6ta8cGTbKs05x
 YW+u5wTFYGTpQx/ggk0ntAEGxNSSiIX1r9EVQg8tIM0gRqT1bZKVlJn/amneygHd8Bhj
 V/rUbydj27HUXhy6pPdFo+N0Z+tHJni07VuOl1Kn3oDM7pKs5eakHJov9jlOKp+YezEh
 94k1v/xAtT59ryH2UM/50blqpTmdHjQn1lRIlfILnsNtwutVRCa0Qpg40I7VIwJ1u2aa
 +Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530234; x=1701135034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0WEP5AXjHAZm/oKDWY7reBF0PdcawUlf+/Ln7Vx3Gk=;
 b=ZnIrLq7+3vR80+YoS4875cqHmzKaDxvasLpBGA63jdt4zPFn64xPjrmAdE3XOlaWVo
 agNLvyh2i/vx/OvejFDwSiQF0vyiR9ZyITq2GL5D0Y875jz4OxQ469BqKlowPpxFRBeR
 zcBgsm3xV3kCjsxLJwDATmwoI8yxgaX5mjaQq0r7HPuVguumqQgnQS/O62RQAdxFqYYA
 qsCEJKaBS8LggaACeBZHDpFDrMFfAjaO5gvJrvdSY3zKmCgxkoKQ4ygcIyosPKjisIZF
 7OIK5sXKFqc3xm2ZBoVH5Rp0PGdQX3BdRWYVuw/846QrveSv4ecAcLhOAgCfldCOxpXF
 Ilag==
X-Gm-Message-State: AOJu0Yw9AdlvCDkmDlzeZNtTXdMnemXhQPOZbqujc5JcmoNNgQdL19VF
 vWlBJya2ALfyBQ6KIOoGeBQfOw==
X-Google-Smtp-Source: AGHT+IHNwiHS0GPKP9/KolZ4u7IXF6WDEKqSKo4mwZ1CLYi/H3FN1+2hM7EhAqTUqdun8p47BPlfBQ==
X-Received: by 2002:a17:902:e749:b0:1ce:63bf:e4c9 with SMTP id
 p9-20020a170902e74900b001ce63bfe4c9mr11604986plf.0.1700530233602; 
 Mon, 20 Nov 2023 17:30:33 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:33 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 01/12] cmd: bootefi: unfold do_bootefi_image()
Date: Tue, 21 Nov 2023 10:29:39 +0900
Message-Id: <20231121012950.156539-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121012950.156539-1-takahiro.akashi@linaro.org>
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
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

Unfold do_bootefi_image() into do_bootefi() in order to make it easier
to re-organize do_bootefi() in the next commit.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/bootefi.c | 101 ++++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 64 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 4d74969ad621..190ccba260e0 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -437,58 +437,6 @@ static int do_efibootmgr(void)
 	return CMD_RET_SUCCESS;
 }
 
-/**
- * do_bootefi_image() - execute EFI binary
- *
- * Set up memory image for the binary to be loaded, prepare device path, and
- * then call do_bootefi_exec() to execute it.
- *
- * @image_opt:	string with image start address
- * @size_opt:	string with image size or NULL
- * Return:	status code
- */
-static int do_bootefi_image(const char *image_opt, const char *size_opt)
-{
-	void *image_buf;
-	unsigned long addr, size;
-	efi_status_t ret;
-
-#ifdef CONFIG_CMD_BOOTEFI_HELLO
-	if (!strcmp(image_opt, "hello")) {
-		image_buf = __efi_helloworld_begin;
-		size = __efi_helloworld_end - __efi_helloworld_begin;
-		efi_clear_bootdev();
-	} else
-#endif
-	{
-		addr = strtoul(image_opt, NULL, 16);
-		/* Check that a numeric value was passed */
-		if (!addr)
-			return CMD_RET_USAGE;
-		image_buf = map_sysmem(addr, 0);
-
-		if (size_opt) {
-			size = strtoul(size_opt, NULL, 16);
-			if (!size)
-				return CMD_RET_USAGE;
-			efi_clear_bootdev();
-		} else {
-			if (image_buf != image_addr) {
-				log_err("No UEFI binary known at %s\n",
-					image_opt);
-				return CMD_RET_FAILURE;
-			}
-			size = image_size;
-		}
-	}
-	ret = efi_run_image(image_buf, size);
-
-	if (ret != EFI_SUCCESS)
-		return CMD_RET_FAILURE;
-
-	return CMD_RET_SUCCESS;
-}
-
 /**
  * efi_run_image() - run loaded UEFI image
  *
@@ -660,8 +608,9 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
 	efi_status_t ret;
-	char *img_addr, *img_size, *str_copy, *pos;
-	void *fdt;
+	char *p;
+	void *fdt, *image_buf;
+	unsigned long addr, size;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
@@ -696,18 +645,42 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!strcmp(argv[1], "selftest"))
 		return do_efi_selftest();
 #endif
-	str_copy = strdup(argv[1]);
-	if (!str_copy) {
-		log_err("Out of memory\n");
-		return CMD_RET_FAILURE;
+
+#ifdef CONFIG_CMD_BOOTEFI_HELLO
+	if (!strcmp(argv[1], "hello")) {
+		image_buf = __efi_helloworld_begin;
+		size = __efi_helloworld_end - __efi_helloworld_begin;
+		efi_clear_bootdev();
+	} else
+#endif
+	{
+		addr = strtoul(argv[1], NULL, 16);
+		/* Check that a numeric value was passed */
+		if (!addr)
+			return CMD_RET_USAGE;
+		image_buf = map_sysmem(addr, 0);
+
+		p  = strchr(argv[1], ':');
+		if (p) {
+			size = strtoul(++p, NULL, 16);
+			if (!size)
+				return CMD_RET_USAGE;
+			efi_clear_bootdev();
+		} else {
+			if (image_buf != image_addr) {
+				log_err("No UEFI binary known at %s\n",
+					argv[1]);
+				return CMD_RET_FAILURE;
+			}
+			size = image_size;
+		}
 	}
-	pos = str_copy;
-	img_addr = strsep(&pos, ":");
-	img_size = strsep(&pos, ":");
-	ret = do_bootefi_image(img_addr, img_size);
-	free(str_copy);
+	ret = efi_run_image(image_buf, size);
 
-	return ret;
+	if (ret != EFI_SUCCESS)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
 }
 
 U_BOOT_LONGHELP(bootefi,
-- 
2.34.1

