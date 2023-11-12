Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14304C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1576887017;
	Sun, 12 Nov 2023 01:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dy+mhdu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB3C875AA; Sun, 12 Nov 2023 01:10:13 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DCBE87049
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a94c5538aeso123823739f.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747780; x=1700352580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ul8Cpr42ZDTJkt5eGOUNBK7mkjMdp/5SBdfY8JL4uGM=;
 b=Dy+mhdu9X0dSAm0WSn/jeEuursV7A89XR1XgVww9XoiKS/BDHRRY6mD55GxvMI2in1
 Tkx3MH3MZq5HeS1nNky+UM00+9D8lsQkINKRe/wfKQT1hPtZKKnlQuwjyx8eV7ARmRIY
 PnXS6XMVKXjbXWhlO3P8vFINNw1dqC7Jf0esM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747780; x=1700352580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ul8Cpr42ZDTJkt5eGOUNBK7mkjMdp/5SBdfY8JL4uGM=;
 b=UqA2jD89m+8Wf4GRqefz9SXS9fDGjQ+v0Ol2xRq0rgVriUX6yU7mtmJI/81z7uTdNQ
 9vH5E9FvvsQyelCKS+L4pLhYA2qi8zIJ85m3ZVkAfffwQfuLQa3ZnTKtn3F5LmRRCyEn
 rY+b2yiLITw36XD5MVRltlkhJaHE2ItZpsu7jjDrDCaruv7mYp1MscAY91WQ5Tq4ngYO
 Wr38Zgzo7uEfBlH73B95u9mqDvTrwGyM0XKXPh9s2xTWrZX2QwvWtw1sba5r/lKWlXUw
 O9lVnWK7fixSGJTlrFvDOhd5J8pIglEYUbrA404XbsQKFuGBSuWwG+luzz3rAryFOTsz
 tOVQ==
X-Gm-Message-State: AOJu0Yy2+ZKm6MMJByOyY9ZE52AHxoMEOqONnxLkbXJbktOJ4heaAX5u
 kBNZ6Eb5L9hKHRiNrS/7wMYZIpgjUTFjWTAhVcI9hw==
X-Google-Smtp-Source: AGHT+IFRjp5IQwtdW/OO/PnsmU/cPrMkX2iAU7s9doXQl9G1ORZBZ5jdhBBsapKaj1BXmoZEV23dVA==
X-Received: by 2002:a05:6e02:1885:b0:359:cbff:fc50 with SMTP id
 o5-20020a056e02188500b00359cbfffc50mr4802348ilu.11.1699747779910; 
 Sat, 11 Nov 2023 16:09:39 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 10/29] bootm: Reduce arguments to boot_get_kernel()
Date: Sat, 11 Nov 2023 17:08:55 -0700
Message-ID: <20231112000923.73568-11-sjg@chromium.org>
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

This function only uses one argument and just needs to know the name of
the command which called it. Adjust the function to use only what it
needs. This will make it easier to call from a non-command context.

Tidy up the function comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index e323c8b758e9..2b986ca71b92 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -102,9 +102,14 @@ static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
 #endif
 
 /**
- * boot_get_kernel - find kernel image
+ * boot_get_kernel() - find kernel image
+ *
+ * @cmd_name: Name of the command calling this function, e.g. "bootm"
+ * @addr_fit: first argument to bootm: address, fit configuration, etc.
  * @os_data: pointer to a ulong variable, will hold os data start address
  * @os_len: pointer to a ulong variable, will hold os data length
+ *     address and length, otherwise NULL
+ *     pointer to image header if valid image was found, plus kernel start
  *
  * boot_get_kernel() tries to find a kernel image, verifies its integrity
  * and locates kernel data.
@@ -113,8 +118,8 @@ static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
  *     pointer to image header if valid image was found, plus kernel start
  *     address and length, otherwise NULL
  */
-static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
-				   char *const argv[], struct bootm_headers *images,
+static const void *boot_get_kernel(const char *cmd_name, const char *addr_fit,
+				   struct bootm_headers *images,
 				   ulong *os_data, ulong *os_len)
 {
 #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
@@ -131,8 +136,7 @@ static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
 	const void *boot_img;
 	const void *vendor_boot_img;
 #endif
-	img_addr = genimg_get_kernel_addr_fit(argc < 1 ? NULL : argv[0],
-					      &fit_uname_config,
+	img_addr = genimg_get_kernel_addr_fit(addr_fit, &fit_uname_config,
 					      &fit_uname_kernel);
 
 	if (IS_ENABLED(CONFIG_CMD_BOOTM_PRE_LOAD))
@@ -169,7 +173,7 @@ static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
 			break;
 		default:
 			printf("Wrong Image Type for %s command\n",
-			       cmdtp->name);
+			       cmd_name);
 			bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
 			return NULL;
 		}
@@ -223,7 +227,7 @@ static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
 		break;
 #endif
 	default:
-		printf("Wrong Image Format for %s command\n", cmdtp->name);
+		printf("Wrong Image Format for %s command\n", cmd_name);
 		bootstage_error(BOOTSTAGE_ID_FIT_KERNEL_INFO);
 		return NULL;
 	}
@@ -312,8 +316,8 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 
 	/* get kernel image header, start address and length */
-	os_hdr = boot_get_kernel(cmdtp, flag, argc, argv,
-			&images, &images.os.image_start, &images.os.image_len);
+	os_hdr = boot_get_kernel("bootm", argv[0], &images,
+				 &images.os.image_start, &images.os.image_len);
 	if (images.os.image_len == 0) {
 		puts("ERROR: can't get kernel image!\n");
 		return 1;
-- 
2.42.0.869.gea05f2083d-goog

