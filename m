Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC846E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D6FA89737;
	Fri,  6 Dec 2024 03:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eiq/ZnVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE2F89734; Fri,  6 Dec 2024 03:37:11 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B05895DE
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a7d7c1b190so5590465ab.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452628; x=1734057428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7F81TTQ7FsN/bKWTwSGEwIqM1VkNrGPAXNbGgHdyNg=;
 b=eiq/ZnVGTuRdvZhygtAz7x3RUEo3Cn+HzOl1e6m1rrizBOKHRJBIxHuYOcxw/22s0g
 4H/PO5s7MEJv8u4Z7rkaw9sop5vqBh38+aRwO3iIU2BrvO8u/HHi2w8Y9x8kssT2Ls7l
 U33CBgv/Jw1/thPeAxa9OGJ8IDzFfQCP04rNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452628; x=1734057428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7F81TTQ7FsN/bKWTwSGEwIqM1VkNrGPAXNbGgHdyNg=;
 b=EX6Ssn0T72VabephoJnp1u6UKY92ukH15fUk0n4ZqFcpo0WYXxSpVj/pT+lx/W7v8k
 GF8YUYr0cV3aKd06A5Tc2X5GpaehHJLmcUuQW4n0O3ymltfUYDgdgP22Clhk4/xJOiDy
 cm5ngy4s0qKrPVZDGIrsVxJSsEUrHlNU6Qwyt+4RYpoRnXXBiKULNW00nVxzL67tWB5n
 /h7hvQPNxlZsBTpw494DGarhVNJXaIGFIqppaIXd/qwl0xnBgUVc4wo4NM8+VFeAiyW/
 vraYzE+lYoSH2jNkHmTCfRi2P+7hbS42riI3vcBJanItxHee9PQ+RcfK8DO/C62JkUXx
 yq+A==
X-Gm-Message-State: AOJu0Yz9rNxJaL5lOYfBissZDrgQE2AXi6xepCvGLUPLHcGnX1pgV/w6
 0NZxl9YDpcD1UvpSzz79CR1dkEVhebbA10noTs2+1cVZa24RwzvTljL4gF/Cc7mgQ+30Ro7/jUE
 =
X-Gm-Gg: ASbGncvLCgXYfXBxmXWA4ydQtJ/CgIooBl4/v5ljPZYZ0uF594z4ri8Lt3N9ooBYtOH
 jUkjDfTSq3xLrg0V9KPAfDxGRNjWqu5S521cste6pjgN9CxrDuJL8lBtV72m777tZSpN2WSOQ6j
 eGbPxMLobybds/FCDdVgjVS4nUKPPcHDR13ZldRJrvbBjLm97zHVpRcUBmRHmfem6ObLKm/mzlA
 XQXGOkrzPXxBGumrmtSedV5eiZw1dd7zNlHtgnWnrTg54oI5s5mJz4ahs9p/ob6ym0J2N40Okzo
 cLB0yIDf6/M=
X-Google-Smtp-Source: AGHT+IE99RtKPWkuOZ4i3MyojiX889LIJhDeSCQtSW8sL0yrTMm/IQHteLCtzmNo90ChNMKWLBkx4Q==
X-Received: by 2002:a05:6e02:1c05:b0:3a7:1dcb:d44b with SMTP id
 e9e14a558f8ab-3a811db73d7mr15277815ab.11.1733452627874; 
 Thu, 05 Dec 2024 18:37:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 14/46] boot: Convert IMAGE_FORMAT into an enum
Date: Thu,  5 Dec 2024 19:35:53 -0700
Message-Id: <20241206023626.2456858-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Use an enum so it is clearer that these options are related. Update
genimg_get_format(), tidy up the function comment and move it to the
header file, since it is exported.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to convert IMAGE_FORMAT into an enum

 boot/image-board.c | 18 +++---------------
 include/image.h    | 26 +++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index b726bd6b303..c681972109e 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -234,21 +234,7 @@ ulong genimg_get_kernel_addr(char * const img_addr)
 					  &fit_uname_kernel);
 }
 
-/**
- * genimg_get_format - get image format type
- * @img_addr: image start address
- *
- * genimg_get_format() checks whether provided address points to a valid
- * legacy or FIT image.
- *
- * New uImage format and FDT blob are based on a libfdt. FDT blob
- * may be passed directly or embedded in a FIT image. In both situations
- * genimg_get_format() must be able to dectect libfdt header.
- *
- * returns:
- *     image format type or IMAGE_FORMAT_INVALID if no image is present
- */
-int genimg_get_format(const void *img_addr)
+enum image_fmt_t genimg_get_format(const void *img_addr)
 {
 	if (CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)) {
 		const struct legacy_img_hdr *hdr;
@@ -434,6 +420,8 @@ static int select_ramdisk(struct bootm_headers *images, const char *select, u8 a
 			done = true;
 		}
 		break;
+	case IMAGE_FORMAT_INVALID:
+		break;
 	}
 
 	if (!done) {
diff --git a/include/image.h b/include/image.h
index 9be5acd8158..e3fc4b83b1d 100644
--- a/include/image.h
+++ b/include/image.h
@@ -597,10 +597,12 @@ int boot_get_setup(struct bootm_headers *images, uint8_t arch, ulong *setup_star
 		   ulong *setup_len);
 
 /* Image format types, returned by _get_format() routine */
-#define IMAGE_FORMAT_INVALID	0x00
-#define IMAGE_FORMAT_LEGACY	0x01	/* legacy image_header based format */
-#define IMAGE_FORMAT_FIT	0x02	/* new, libfdt based format */
-#define IMAGE_FORMAT_ANDROID	0x03	/* Android boot image */
+enum image_fmt_t {
+	IMAGE_FORMAT_INVALID,
+	IMAGE_FORMAT_LEGACY,		/* legacy image_header based format */
+	IMAGE_FORMAT_FIT,		/* new, libfdt based format */
+	IMAGE_FORMAT_ANDROID,		/* Android boot image */
+};
 
 /**
  * genimg_get_kernel_addr_fit() - Parse FIT specifier
@@ -629,7 +631,21 @@ ulong genimg_get_kernel_addr_fit(const char *const img_addr,
 				 const char **fit_uname_kernel);
 
 ulong genimg_get_kernel_addr(char * const img_addr);
-int genimg_get_format(const void *img_addr);
+
+/**
+ * genimg_get_format - get image format type
+ * @img_addr: image start address
+ * Return: image format type or IMAGE_FORMAT_INVALID if no image is present
+ *
+ * genimg_get_format() checks whether provided address points to a valid
+ * legacy or FIT image.
+ *
+ * New uImage format and FDT blob are based on a libfdt. FDT blob
+ * may be passed directly or embedded in a FIT image. In both situations
+ * genimg_get_format() must be able to dectect libfdt header.
+ */
+enum image_fmt_t genimg_get_format(const void *img_addr);
+
 int genimg_has_config(struct bootm_headers *images);
 
 /**
-- 
2.34.1

