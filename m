Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA041C4167D
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6EA3877C2;
	Sun, 12 Nov 2023 01:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bDHEFNkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39E7F86F83; Sun, 12 Nov 2023 01:10:30 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB40E86F84
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7a69a71cc1dso125146239f.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747790; x=1700352590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ys8BgabllUBkv29Wx1X4gCwJ48+djkXm3XXWvP0oK20=;
 b=bDHEFNkToN4APzdtQy8sAJRAnkDjFB2YJxizVPLHz5VuDqk9bMNli9Y0FOnHOgka/y
 1f1bRtvWAugXCnJ4SIg80iNIl14ERLC+k311ce1VLRkV4uLBA5QSscAhvzY64yIdaqCx
 ScLRNgGpxOwTaQxYYMYebAvGjznC+BwHnJD8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747790; x=1700352590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ys8BgabllUBkv29Wx1X4gCwJ48+djkXm3XXWvP0oK20=;
 b=KKcIXFkQLE5cIbrfA+nYvc9dI0sUSBMQoXUt7ilvrhtIYhgcfFJH8ZvdlCPMOsGCTx
 rQ2Aa3NlU8sTmZN3cTQZxlKbH70yXoqHbcZAsi6A9E3Jq0cy0faYVXIzAfLOUH0srVEK
 wulVUhfUg47UqhKRAaPnsmPKnT1be4IE7LBWnQkrHZZCDBeMT8nH915we0gk0AZ4iejU
 p71JzFSjZHR3iPe/De6do37p7OeWQoGE1d2Iif7dv6ARJdZsz7EIy5wxpDdwlN5WM4Zr
 7V2EHkiYELn8XY33mLXp8UyRnlCvyISg2O37OELOdPo3b609xYD2WG+dW7UL7CBsh2TI
 5P7w==
X-Gm-Message-State: AOJu0YxghPVsUI7q5o2DzBgtdBfKH4ZoHtQn4xymmS8t8OgjQ5N5IL1g
 xdw2AJwxxKy6STg1OZYWfAm6aHsbiBpAbBkmSo2znw==
X-Google-Smtp-Source: AGHT+IFRLlszJ8NLK9IYh9oLEOc6/KdPBlJA5W5B1OHsOP3IvEfGUvXrh87BDvn6qkZUYQYFlFPAKw==
X-Received: by 2002:a05:6e02:2148:b0:35a:b337:6f58 with SMTP id
 d8-20020a056e02214800b0035ab3376f58mr1861284ilv.16.1699747790434; 
 Sat, 11 Nov 2023 16:09:50 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 22/29] bootm: Reduce arguments to boot_get_fpga()
Date: Sat, 11 Nov 2023 17:09:07 -0700
Message-ID: <20231112000923.73568-23-sjg@chromium.org>
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

This function only uses two arguments. The 'arch' always has a constant
value, so drop it. This simplifies the function call.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c       | 3 +--
 boot/image-board.c | 5 ++---
 include/image.h    | 9 +++++++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4d732719ad84..4bfa28f4377a 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -554,8 +554,7 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
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
2.42.0.869.gea05f2083d-goog

