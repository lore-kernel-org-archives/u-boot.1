Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755CCC19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 395EA8169D;
	Thu,  6 Mar 2025 01:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aK1e1jJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C5808144F; Thu,  6 Mar 2025 01:27:09 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4278817D3
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85afcb0c18fso3484339f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220822; x=1741825622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAM3l4Tgn8pMW4tIX5Fr5oxJbF12VmXUhcpEOi6QB2I=;
 b=aK1e1jJi3vo9jOp0rUd5lQtakUPsi4ASTOZFv4vgEeao1ijTPeylm2QFvj8/JPUP+7
 FGP+6PH9v5rzCCG0XjwpaPvayrGjZV7qS2+5pKulsKiA1JCzq5o1Jq13sei/9b7HiFrv
 jIt163dJbmvzc2alN4ZQ/Zbnol+XCfxKML1ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220822; x=1741825622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAM3l4Tgn8pMW4tIX5Fr5oxJbF12VmXUhcpEOi6QB2I=;
 b=fN1qPnLmxn4j5JS1nTdOvlTUPIji6heXZ9ibKOaI/GYD3warV1HogWqUNnd9R9rZyS
 ocXSF8HdHSe2VZR8Mfj31Q1UOWqOBxTst1f+khZIulgX5gINNJuYt+PXtvuNoMcne8uB
 /ZFtY9lKmixWPxcfV1OSy6dU9MXzYPCCWWx7Bgb3W5a+c2MFfPvQLh/NZbuuDXdJK+mq
 EWc8wcWJjC2xOVjkElIcMJO0VyT1USnAFQqwgozBVZrPtnTZm0oYmas9ql5J6TLrw6X5
 KdGROQwrl48Pm77DfBf7OwnxgFSlEHiev5BoH0zfMXoTVc32aoGUowflg5zqqOSh85ZP
 t2wg==
X-Gm-Message-State: AOJu0YxT5Zvcx97ufH5coFJBApe54adnWj+4ZdKkd2ORV7FSXgOLp9W+
 fQA0MXr8s8ZlE2EV2OPXKKDQdKJ3SgcicUfMI+cfD85CKuq7rSbg4g+LLqZwHFCPPr4CcI6WLRM
 =
X-Gm-Gg: ASbGnctmLUqM4pkOwsiEnxOO9cZo/XS6w08aOuIPEos9G2c+aG8nnGLhF7yX+DNSUYD
 znRXwyDSIUa5+vKEIBZsa3hYWfy+95xkFLjOVQBBdRLePwRXodHAm9Xcc32iofhpVEteadTQU97
 lgSSM9dqtOCS38N/icrMgl2Ne/1c4hem8maQwk9l/lpEYhI9E8xPj9E7cxY3PipFbn2s6jo/e2u
 kJDybKaTutsHCX90faHF9zM+5O2wp6TkgtdD76/IRv4nfVDzbD6aDMcEId6wpCAXo6JFs8I74Rn
 3RhqggXohcFt3BwAX1hw+Bb//k5WewpVYpQHY6Hr8ZpCLu3yLzadxll/uXvuAveUyu9pf6FgMMs
 Ud/2JNQ==
X-Google-Smtp-Source: AGHT+IG2tWVaZBVihSccr9TpShZrabeQZG3dRrFTPAqXGlejNWmZcPakdGgKXubnUR4HbC5U/QRepg==
X-Received: by 2002:a05:6602:b8a:b0:855:9c88:788f with SMTP id
 ca18e2360f4ac-85affaebd8fmr627550939f.8.1741220822060; 
 Wed, 05 Mar 2025 16:27:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:01 -0800 (PST)
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
Subject: [PATCH v5 14/29] boot: Convert IMAGE_FORMAT into an enum
Date: Wed,  5 Mar 2025 17:25:08 -0700
Message-ID: <20250306002533.2380866-15-sjg@chromium.org>
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

Use an enum so it is clearer that these options are related. Update
genimg_get_format(), tidy up the function comment and move it to the
header file, since it is exported.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to convert IMAGE_FORMAT into an enum

 boot/image-board.c | 18 +++---------------
 include/image.h    | 26 +++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 514f8e63f9c..addccf87c80 100644
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
index c1db8383459..dc1a7c307cc 100644
--- a/include/image.h
+++ b/include/image.h
@@ -598,10 +598,12 @@ int boot_get_setup(struct bootm_headers *images, uint8_t arch, ulong *setup_star
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
@@ -630,7 +632,21 @@ ulong genimg_get_kernel_addr_fit(const char *const img_addr,
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
2.43.0

