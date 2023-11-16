Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79783C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB88C87504;
	Thu, 16 Nov 2023 05:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AWp5w6FY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE49874E1; Thu, 16 Nov 2023 05:11:44 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0280787452
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-35aa43c92daso4364205ab.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107900; x=1700712700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ts/Rv8vsm/SVViLuiBjqqHUONkbgC/0iZxKoqgUdwVE=;
 b=AWp5w6FYsmhD6tULne4bbwHfJswur5oIfRZSwi+zUPciW4Lkfim6PGgnJ8HN0Egjfk
 C1TmCgedowb4HYGGuHu3ameQBIphSGJZDdsjT0+ntET7rDaauSou7iebigzJ2jrmM/LM
 04JKYll3BpymuJ8h6NOOFWXsOGDRYnwgPiCIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107900; x=1700712700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ts/Rv8vsm/SVViLuiBjqqHUONkbgC/0iZxKoqgUdwVE=;
 b=Bgux4do+wbfUGrqxb9ZBffCOB6fqiTHwvAI7+lev6KxasokwsxkqgzQufS3/gTMWcs
 vKFmGi30XlvQp2gVQUvR8aoyxEoE5U2sko0IGfrNzGWtPJY1fjRC7L0+Zh6Q8xjunUrC
 dCQFI1a9EGoKW18qfuAnycMpALXhpY0wV7GfS/4n0ZLT5SX67d4UjuT941TrqTpXM9+F
 bK3OG1Xto49qr+3mhw1Op6A6o4Jap8EodunTXu5TCHC04tOnJgyzNddJqGTY38CtKGLJ
 5bXtqMD8cuxl+QBBVza1BWD0vy9hn1cj9MurNkfneEnriuHW6Yp4ox7BL7ZGEcWzLCI/
 viQw==
X-Gm-Message-State: AOJu0YwDCUp+BZPNKrEsJCyvV+kW1NH758D3O2XovbEPWk0qZOcdvXsE
 cqDCjQjQO9IlnxoVd4BVy7sXYeKzWWvTJi3rK1zltw==
X-Google-Smtp-Source: AGHT+IHUMoeu57uHESPCEI/pjXCOmHWMavKgJLNT8+cCCUIdIqvs0OR0j6zQ6Ufp1H9aiAAFvGWqyA==
X-Received: by 2002:a92:ccd1:0:b0:357:9ea1:ed94 with SMTP id
 u17-20020a92ccd1000000b003579ea1ed94mr392526ilq.16.1700107900546; 
 Wed, 15 Nov 2023 20:11:40 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v2 24/32] bootm: Reduce arguments to boot_get_fpga()
Date: Wed, 15 Nov 2023 21:10:24 -0700
Message-ID: <20231116041043.362055-25-sjg@chromium.org>
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

This function only uses two arguments. The 'arch' always has a constant
value, so drop it. This simplifies the function call.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c       | 3 +--
 boot/image-board.c | 5 ++---
 include/image.h    | 9 +++++++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 5dc9cdeb244f..ae3fceb392da 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -555,8 +555,7 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 #if CONFIG_IS_ENABLED(FIT)
 	if (IS_ENABLED(CONFIG_FPGA)) {
 		/* find bitstreams */
-		ret = boot_get_fpga(argc, argv, &images, IH_ARCH_DEFAULT,
-				    NULL, NULL);
+		ret = boot_get_fpga(&images);
 		if (ret) {
 			printf("FPGA image is corrupted or invalid\n");
 			return 1;
diff --git a/boot/image-board.c b/boot/image-board.c
index 60e514fc150e..b926275ec917 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -616,8 +616,7 @@ int boot_get_setup(struct bootm_headers *images, u8 arch,
 	return boot_get_setup_fit(images, arch, setup_start, setup_len);
 }
 
-int boot_get_fpga(int argc, char *const argv[], struct bootm_headers *images,
-		  u8 arch, const ulong *ld_start, ulong * const ld_len)
+int boot_get_fpga(struct bootm_headers *images)
 {
 	ulong tmp_img_addr, img_data, img_len;
 	void *buf;
@@ -659,7 +658,7 @@ int boot_get_fpga(int argc, char *const argv[], struct bootm_headers *images,
 						tmp_img_addr,
 						(const char **)&uname,
 						&images->fit_uname_cfg,
-						arch,
+						IH_ARCH_DEFAULT,
 						IH_TYPE_FPGA,
 						BOOTSTAGE_ID_FPGA_INIT,
 						FIT_LOAD_OPTIONAL_NON_ZERO,
diff --git a/include/image.h b/include/image.h
index 04f35de9d082..63f2bd3b3713 100644
--- a/include/image.h
+++ b/include/image.h
@@ -642,8 +642,13 @@ ulong genimg_get_kernel_addr(char * const img_addr);
 int genimg_get_format(const void *img_addr);
 int genimg_has_config(struct bootm_headers *images);
 
-int boot_get_fpga(int argc, char *const argv[], struct bootm_headers *images,
-		  uint8_t arch, const ulong *ld_start, ulong * const ld_len);
+/**
+ * boot_get_fpga() - Locate the FPGA image
+ *
+ * @images: Information about images being loaded
+ * Return 0 if OK, non-zero on failure
+ */
+int boot_get_fpga(struct bootm_headers *images);
 
 /**
  * boot_get_ramdisk() - Locate the ramdisk
-- 
2.43.0.rc0.421.g78406f8d94-goog

