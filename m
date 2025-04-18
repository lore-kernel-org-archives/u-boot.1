Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71A6C369CF
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 12:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476C7831C3;
	Fri, 18 Apr 2025 14:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YZI9lpkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2215B82C15; Fri, 18 Apr 2025 14:51:29 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590F1831E4
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 14:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-85dac9729c3so146061039f.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 05:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744980684; x=1745585484; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ji7ouPOmrY5yXeFOaG6cGOuD0t4OdbfXcw41HvPwmEA=;
 b=YZI9lpkMnMMbuTx7l9vkBDPFGlma6g9D6MDFck2ZFLJsGZLd0D1ZEYueKhs8uoLjNf
 cVEwokUsxpXCtZ1/bJi/+gS1ubSP+UKS4OyHZhFD6qtmRekuwNayOGVnN3aRDhhpetQq
 BlWyTi0hq4jlWfJeGGFRV7kdI6SBxbmtUsFlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744980684; x=1745585484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ji7ouPOmrY5yXeFOaG6cGOuD0t4OdbfXcw41HvPwmEA=;
 b=u9qJygjd+pl146K3ngN7bmOtKXs+sd9UMpNUfjRR/76lps4m3Hyqw6+TfTw/AK9VPA
 +RHxfTmrNiZLP3Ugm6/wpPNL/l9J0AXcBBfg3XVjMBoCmy/P5z+ig5UbdcDT2hazSb9J
 NfDBNw9D7PGNDMIDm/cGw4Vug+V4IFMdFEW+eSK2qOunDhUdsBugv9XbCnAxyJJDMSpx
 d4GnSeIKbH5N4wnzZ21541gsfVnfnnrlqIVVzfY/b9POiXMITYOmZskaf6/hI4qYkhU8
 iJLCZhvD29W39yCziXIgKoZFB7qch0rUJkH7PvKCN3/32rZ6ay1Z4BVbtFGdTP3mJJwi
 0ERw==
X-Gm-Message-State: AOJu0YzSCmAyclSLBaR4SPzQ17+kCXBSDEKr5qivFGEUZ/7ArrRSQyVy
 csvWfn4qQ1vkBb1Ijr2r8Enq43PxsjBI1HM742Ees9kkRYDoeafSv/uAWTbcKm6OkAB797pMbvU
 =
X-Gm-Gg: ASbGncvpBzNFFx3Fjg70nF6dahvXL5eVwuw9Lcbf8VX4LCqNBQ2tUtPdhbBNBQJOIc2
 9OOTYfiLXkNucboWgpLuMnC8cJ/zdjHQ1qPXToXlTI3LDvgYz1lPo8+KDBce8zO5RIgbrmwunUw
 1DWX0+yGt8qSeHk4BgIGxBVgoSEKvz/wpPJ/utvNJ2Fqa5snKWLu6zRSugHWOitlyIf9svG7nIS
 6nSwJ4nkd7vBeg/Z9OulTqFPyyuIj0zWapRUGBeSQ75ydLUEJB4QIRqxdBvQ9EuTZr+Ogz81DRp
 KeIGuir+5VeWZTzwk935z5wHrvSnZJRo3FRJeJcMi5UH59RjrvrSdomDiw6BtK1YuRv1dX0KM8H
 EnsmBAx6Z+tKI
X-Google-Smtp-Source: AGHT+IHf3ZK0VrlkzEVlOdWyttXQxskZLEVPug7CZkaMr8cU0nhHGmU/EdefOnAml0Cx63X47uj/TA==
X-Received: by 2002:a05:6602:4809:b0:85b:43a3:66b2 with SMTP id
 ca18e2360f4ac-861dbe22a33mr247509139f.7.1744980684549; 
 Fri, 18 Apr 2025 05:51:24 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cc0a3sm427555173.20.2025.04.18.05.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 05:51:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 3/3] booti: Allow ignoring SYS_BOOTM_LEN with the booti command
Date: Fri, 18 Apr 2025 06:51:02 -0600
Message-ID: <20250418125111.2193434-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418125111.2193434-1-sjg@chromium.org>
References: <20250418125111.2193434-1-sjg@chromium.org>
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

The booti command does not use the CONFIG_SYS_BOOTM_LEN value and
instead sets a maximum decompression-buffer size of 10x the size of the
compressed data.

Add this as an option in bootm_load_os() so that booting without the
command-line works in the same way as the 'booti' command.

Link: https://lore.kernel.org/u-boot/2ad3b1c5-b6e7-47e2-b225-834b821cc5c4@kwiboo.se/

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Jonas Karlman <jonas@kwiboo.se>
Fixes: b13408021d3 ("boot: pxe: Use bootm_...() functions where possible")
---

 boot/bootm.c    | 13 +++++++++----
 cmd/booti.c     |  1 +
 include/bootm.h |  3 +++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 7be5ec796fc..dae09060f0f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -669,8 +669,9 @@ static bool booti_is_supported(struct image_info *os)
 	return os->arch == IH_ARCH_ARM64 || os->arch == IH_ARCH_RISCV;
 }
 
-static int bootm_load_os(struct bootm_headers *images, int boot_progress)
+static int bootm_load_os(struct bootm_info *bmi, int boot_progress)
 {
+	struct bootm_headers *images = bmi->images;
 	struct image_info os = images->os;
 	ulong load = os.load;
 	ulong load_end;
@@ -681,6 +682,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	ulong flush_start = ALIGN_DOWN(load, ARCH_DMA_MINALIGN);
 	bool no_overlap;
 	void *load_buf, *image_buf;
+	ulong decomp_len;
 	int err;
 
 	/*
@@ -706,11 +708,12 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 
 	load_buf = map_sysmem(load, 0);
 	image_buf = map_sysmem(os.image_start, image_len);
+	decomp_len = bmi->ignore_bootm_len ? image_len * 10 : bootm_len();
 	err = image_decomp(os.comp, load, os.image_start, os.type,
-			   load_buf, image_buf, image_len, bootm_len(),
+			   load_buf, image_buf, image_len, decomp_len,
 			   &load_end);
 	if (err) {
-		err = handle_decomp_error(os.comp, load_end - load, bootm_len(),
+		err = handle_decomp_error(os.comp, load_end - load, decomp_len,
 					  err);
 		bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
 		return err;
@@ -1073,7 +1076,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	if (!ret && (states & BOOTM_STATE_LOADOS)) {
 		iflag = bootm_disable_interrupts();
 		board_fixup_os(&images->os);
-		ret = bootm_load_os(images, 0);
+		ret = bootm_load_os(bmi, 0);
 		if (ret && ret != BOOTM_ERR_OVERLAP)
 			goto err;
 		else if (ret == BOOTM_ERR_OVERLAP)
@@ -1237,6 +1240,8 @@ int bootz_run(struct bootm_info *bmi)
 
 int booti_run(struct bootm_info *bmi)
 {
+	bmi->ignore_bootm_len = true;
+
 	return boot_run(bmi, "booti", BOOTM_STATE_START | BOOTM_STATE_FINDOS |
 			BOOTM_STATE_PRE_LOAD | BOOTM_STATE_FINDOTHER |
 			BOOTM_STATE_LOADOS);
diff --git a/cmd/booti.c b/cmd/booti.c
index 43e79e87201..f4f782da056 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -118,6 +118,7 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		bmi.conf_fdt = argv[2];
 	bmi.boot_progress = true;
 	bmi.cmd_name = "booti";
+	bmi.ignore_bootm_len = true;
 	/* do not set up argc and argv[] since nothing uses them */
 
 	if (booti_start(&bmi))
diff --git a/include/bootm.h b/include/bootm.h
index 82ab8e0e565..97f77bc1ded 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -44,6 +44,8 @@ struct cmd_tbl;
  * @argc: Number of arguments to the command (excluding the actual command).
  *	This is 0 if there are no arguments
  * @argv: NULL-terminated list of arguments, or NULL if there are no arguments
+ * @ignore_bootm_len: Ignore the value CONFIG_SYS_BOOTM_LEN and use 10x the
+ *	compressed length as the maximum uncompressed size
  *
  * For zboot:
  * @bzimage_addr: Address of the bzImage to boot, or 0 if the image has already
@@ -69,6 +71,7 @@ struct bootm_info {
 	const char *cmd_name;
 	int argc;
 	char *const *argv;
+	bool ignore_bootm_len;
 
 	/* zboot items */
 #ifdef CONFIG_X86
-- 
2.43.0

