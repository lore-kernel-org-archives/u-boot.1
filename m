Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFD3C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 390F78168B;
	Thu,  6 Mar 2025 01:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qp/KzeEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35BA38168B; Thu,  6 Mar 2025 01:27:15 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC0BE80805
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85aec8c95c4so9480339f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220831; x=1741825631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IgQxSEdXlHU+4kRrg5gL/hXMwNi3JRJaoAZMlpHs9qk=;
 b=Qp/KzeEySupjSl3dw5yADo+EkRnXkbfmB3vySOZyKVb0X0G8IciHZhN/jn10k7nrDL
 LWh5goSWgB2njzlwBK4rfS2ftLF70FpeTyow5Z/oNgdud5AKLJWuW0ag5n05Z3lLcGeY
 BBsBzSJhD4eyjH2Rh3zstB6zcWbW3U7jMEJaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220831; x=1741825631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IgQxSEdXlHU+4kRrg5gL/hXMwNi3JRJaoAZMlpHs9qk=;
 b=vcVEM4xg6sykKutgW08pKVKa0Nui+uVtoYRBAu/nw/EBxR3T9lQeyG0NlKubzRsWwc
 DwGC6BxXOTpQDEp5sOv+sZ7lJiiupU05RQ1KqFeTpb2/uZi4A9886cMmcC6V6GPAI//Z
 Fna0s91VPDHQlJmz81cA363O9LFT9Vvn81bur1hTPA2Xqv4c7VxCg8G009iyY4WJqgve
 9eLgPVxx0Bikdof41zZ0dJxd9A/UQQHJKUM279zHOO1Ap1nmTVW32u5SF/vZz6TPpvQv
 JW8gSbVFMAifju00SGLQM690pWWcaJWXfbCivXnoGYfToMslxwsEknPxr7c4VMzVBE6m
 WlFg==
X-Gm-Message-State: AOJu0YzimUGkUF+B/HbHL9XnkR+qonTkpMSjqd4TU+03uLQsacm74uR+
 /By5Lb4b6wiVyrEsNPXKR9INgb01ZCGmXpfEz6OSHhN2U9D3keQDfNvDgDh5S1CkMftGv0Nu7Hw
 =
X-Gm-Gg: ASbGncs9ffwGkdJiUvkZlkg3UrGhsF3babo5zBgLCHdGoWwr5qBvPWK/CTjaZrWrriq
 wSgt648kDQ6tEqsdYadrKAFS7C3YX0SC/GDr3e3pXoyM3rWjvsf2ANw+HGuQk+e8ieXUNNie0VG
 7r/V7dvdPyshmed0i0unmXtEQGCTgIQcsQPvoh3ShtdQULiqE5Am3X4ot32EzYjnXR1hnk5IMvw
 hZmQRSfJ4FhnRmZGlsq5ryT9UW9l5Gx9A5UzvqEi2OdH17JW3E92nhoW5Wl2o/SBwvUWX0r2HEL
 ERftUDHKwmS33toMrOEG7QlBudl4uY8UjLE4H4R/V0h4dHiSxNRpZXVOZMOB1IN8jN9XLMDoGkv
 PsX0/NQ==
X-Google-Smtp-Source: AGHT+IHFjSnxtkS5Ow8pSF3rF2ut4s2hW8jktJ1qdKwHHCDXkgu6pSKIUZ957lF+mM6CK0k9cEstqg==
X-Received: by 2002:a05:6602:4086:b0:855:b345:4897 with SMTP id
 ca18e2360f4ac-85affb2d4f3mr665792539f.9.1741220830851; 
 Wed, 05 Mar 2025 16:27:10 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 17/29] boot: Support compressed booti images in bootm
Date: Wed,  5 Mar 2025 17:25:11 -0700
Message-ID: <20250306002533.2380866-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

A compressed booti image relies on the compression-format's header at
the start to indicate which compression algorithm is used.

We don't support this elsewhere in U-Boot, so assume that a compressed
file is always a booti file. Once it is compressed, a check is made to
make sure that it actually is.

Simplify the implementation by adding a new function which returns the
booti image-type if compression is detected.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Correct for updated lmb_reserve() call

Changes in v3:
- Add new patch to support compressed booti images in bootm

 boot/bootm.c       | 37 ++++++++++++++++++++++++++++++-------
 boot/image-board.c | 13 ++++++++++++-
 include/image.h    | 11 +++++++++++
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 272623c9258..8a1aac7515f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -146,7 +146,7 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 	/* check image type, for FIT images get FIT kernel node */
 	*os_data = *os_len = 0;
 	buf = map_sysmem(img_addr, 0);
-	switch (genimg_get_format(buf)) {
+	switch (genimg_get_format_comp(buf)) {
 #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
 	case IMAGE_FORMAT_LEGACY:
 		printf("## Booting kernel from Legacy Image at %08lx ...\n",
@@ -228,11 +228,8 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 	}
 #endif
 	case IMAGE_FORMAT_BOOTI:
-		if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
-			*os_data = img_addr;
-			break;
-		}
-		fallthrough;
+		*os_data = img_addr;
+		break;
 	default:
 		bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
 		return -EPROTOTYPE;
@@ -306,6 +303,17 @@ static int found_booti_os(enum image_comp_t comp)
 	log_debug("load %lx start %lx len %lx ep %lx os %x comp %x\n",
 		  images.os.load, images.os.image_start, images.os.image_len,
 		  images.ep, images.os.os, images.os.comp);
+	if (comp != IH_COMP_NONE) {
+		images.os.load = env_get_hex("kernel_comp_addr_r", 0);
+		images.os.image_len = env_get_ulong("kernel_comp_size", 16, 0);
+		if (!images.os.load || !images.os.image_len) {
+			puts("kernel_comp_addr_r or kernel_comp_size is not provided!\n");
+			return -ENOTSUPP;
+		}
+		if (lmb_reserve(images.os.load, images.os.image_len, LMB_NONE)
+		    < 0)
+			return -EXDEV;
+	}
 
 	return 0;
 }
@@ -423,6 +431,19 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 		}
 		fallthrough;
 	default:
+		/* any compressed image is probably a booti image */
+		if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
+			int comp;
+
+			comp = image_decomp_type(os_hdr, 2);
+			if (comp != IH_COMP_NONE) {
+				if (found_booti_os(comp))
+					return 1;
+				ep_found = true;
+			}
+			break;
+		}
+
 		puts("ERROR: unknown image format type!\n");
 		return 1;
 	}
@@ -1166,7 +1187,9 @@ int bootz_run(struct bootm_info *bmi)
 
 int booti_run(struct bootm_info *bmi)
 {
-	return boot_run(bmi, "booti", 0);
+	return boot_run(bmi, "booti", BOOTM_STATE_START | BOOTM_STATE_FINDOS |
+			BOOTM_STATE_PRE_LOAD | BOOTM_STATE_FINDOTHER |
+			BOOTM_STATE_LOADOS);
 }
 
 int bootm_boot_start(ulong addr, const char *cmdline)
diff --git a/boot/image-board.c b/boot/image-board.c
index 07931c64198..a2bafba7ae1 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -257,6 +257,17 @@ enum image_fmt_t genimg_get_format(const void *img_addr)
 	return IMAGE_FORMAT_INVALID;
 }
 
+enum image_fmt_t genimg_get_format_comp(const void *img_addr)
+{
+	enum image_fmt_t fmt = genimg_get_format(img_addr);
+
+	if (IS_ENABLED(CONFIG_CMD_BOOTI) && fmt == IMAGE_FORMAT_INVALID &&
+	    image_decomp_type(img_addr, 2) != IH_COMP_NONE)
+		fmt = IMAGE_FORMAT_BOOTI;
+
+	return fmt;
+}
+
 /**
  * fit_has_config - check if there is a valid FIT configuration
  * @images: pointer to the bootm command headers structure
@@ -353,7 +364,7 @@ static int select_ramdisk(struct bootm_headers *images, const char *select, u8 a
 	 * check image type, for FIT images get FIT node.
 	 */
 	buf = map_sysmem(rd_addr, 0);
-	switch (genimg_get_format(buf)) {
+	switch (genimg_get_format_comp(buf)) {
 	case IMAGE_FORMAT_LEGACY:
 		if (CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)) {
 			const struct legacy_img_hdr *rd_hdr;
diff --git a/include/image.h b/include/image.h
index 5b9bd6a9649..2455baa6667 100644
--- a/include/image.h
+++ b/include/image.h
@@ -648,6 +648,17 @@ ulong genimg_get_kernel_addr(char * const img_addr);
  */
 enum image_fmt_t genimg_get_format(const void *img_addr);
 
+/**
+ * genimg_get_format_comp() - Like genimg_get_format() but adds compressed booti
+ *
+ * If a compressed file is detected (with image_decomp_type()) and
+ * CONFIG_CMD_BOOTI is enabled, then this returns IMAGE_FORMAT_BOOTI
+ *
+ * @img_addr: image start address
+ * Return: image format type or IMAGE_FORMAT_INVALID if no image is present
+ */
+enum image_fmt_t genimg_get_format_comp(const void *img_addr);
+
 int genimg_has_config(struct bootm_headers *images);
 
 /**
-- 
2.43.0

