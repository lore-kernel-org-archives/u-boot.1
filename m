Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1F1E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E567F89633;
	Fri,  6 Dec 2024 03:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T5Rd9gBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F8C089633; Fri,  6 Dec 2024 03:37:17 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F1D8918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-841d8dec299so99955139f.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452633; x=1734057433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrmmRHWxXfjE5EdNZV8YHp4vl8W+tY0XBnPDSK1K+PI=;
 b=T5Rd9gBBJxNTNfw51JM0wJOfJJDRFTntw2h2Kf9F0KxtCYqKRXPX5u9MUX6IxqlP6X
 4Rl2hcCo1B9tLVACL1rv7RaoRHubuRkK24tYc2UNSObEOk+OLHyZYO53p0xTfPMmp0bb
 3FAcGk6wA8FrUpo33sZuEqG+33qFKPLDYQrDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452633; x=1734057433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VrmmRHWxXfjE5EdNZV8YHp4vl8W+tY0XBnPDSK1K+PI=;
 b=l5FcpvV1INNbHFQc0mipQyaDGdKgsT+xtPnfh+JZMqz60IO/HMm11e92h4806s9Nho
 cGbMA22YjZ0DxY9eKPvG8Itl6YKn1JB6FjFiEifkoobtk4Y1XHPwS+vm5+EJ/donkxAV
 7YVRIBgVSAEEDTktAUhw2Xoby9NcfAMvTGsP47lqyb0mEeQEnBNBvn/Y43K2fWDplRTW
 s1FdMiu0h9yyMWM7pziLZsd5zNOuPd5j8fOZD5YtsQ0U4ao7yO3gXElDsxGwMaemPI4Y
 Ua46udw+feBKRxDP0UaNXboTv78g+m4Zpa35bPErXpQgop+OSXI62BXNrjqSc1kiEgcH
 jlNQ==
X-Gm-Message-State: AOJu0Yx69xM6G4UJ1LZoFfUqtSK34kHhhPj/NFJNL/aq26E+YPvBkkeP
 oTu458wMZMYFKsosawh2bThUlsJ9fYOUUTuKUhnwfM4xrK9/djxB0XlrKVXcSEwsRZbQObkl3Ck
 =
X-Gm-Gg: ASbGnctbCjbwLKyD9rewRjvkzCmOm6wT2+Eo2BWrxAJjpv8JZpdR+n/2fkFqFpKeZTP
 8zYvE9k2t3M2jw6ekNHmBf1vFC4bJFaai7voS+TKwZ/aWZbTrwZqaVC5WMn8mQUbSltfJxfb4Vw
 ANmYhaNn+zHSdAqS1t3sfX8NBnebdhld1zcw/XbJHDLn8I0Ex1ahRXlIk6m5vUUrouGicdtbu+j
 CfioBxhtB5Y/0LN22k+iQSgsjremrT0aIqd0TXLd1kgxlTEBrtT1JwrzP2L+SSFM7EDX9AskYgW
 F2XIeMlf4Fs=
X-Google-Smtp-Source: AGHT+IH9bszyiBoWMpt81o9x4idqvtN0s2WM8HRC2y25OItT02z01NLHb/OT4jFT7d5NvSAZEID7fQ==
X-Received: by 2002:a05:6602:6011:b0:842:ff2d:c3d9 with SMTP id
 ca18e2360f4ac-8447e204c01mr214671539f.4.1733452633329; 
 Thu, 05 Dec 2024 18:37:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 16/46] boot: Support booti format in bootm
Date: Thu,  5 Dec 2024 19:35:55 -0700
Message-Id: <20241206023626.2456858-17-sjg@chromium.org>
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

At present the booti format is handled separately, in its own command.
Provide a way to boot uncompressed booti images within the bootm code,
so that eventually we can boot these images without CONFIG_CMDLINE

Update bootm_init() to attach the images for all formats which use them.

Add some debugging while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to support booti format in bootm

 boot/bootm.c    | 42 +++++++++++++++++++++++++++++++++++++++++-
 include/image.h |  2 +-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 0a1040ef923..6fafa354732 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -227,6 +227,12 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 		break;
 	}
 #endif
+	case IMAGE_FORMAT_BOOTI:
+		if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
+			*os_data = img_addr;
+			break;
+		}
+		fallthrough;
 	default:
 		bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
 		return -EPROTOTYPE;
@@ -286,6 +292,24 @@ static int bootm_pre_load(const char *addr_str)
 	return ret;
 }
 
+static int found_booti_os(enum image_comp_t comp)
+{
+	images.os.load = images.os.image_start;
+	images.os.type = IH_TYPE_KERNEL;
+	images.os.os = IH_OS_LINUX;
+	images.os.comp = comp;
+	if (IS_ENABLED(CONFIG_RISCV_SMODE))
+		images.os.arch = IH_ARCH_RISCV;
+	else if (IS_ENABLED(CONFIG_ARM64))
+		images.os.arch = IH_ARCH_ARM64;
+
+	log_debug("load %lx start %lx len %lx ep %lx os %x comp %x\n",
+		  images.os.load, images.os.image_start, images.os.image_len,
+		  images.ep, images.os.os, images.os.comp);
+
+	return 0;
+}
+
 /**
  * bootm_find_os(): Find the OS to boot
  *
@@ -390,6 +414,14 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 		}
 		break;
 #endif
+	case IMAGE_FORMAT_BOOTI:
+		if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
+			if (found_booti_os(IH_COMP_NONE))
+				return 1;
+			ep_found = true;
+			break;
+		}
+		fallthrough;
 	default:
 		puts("ERROR: unknown image format type!\n");
 		return 1;
@@ -541,6 +573,7 @@ int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
 static int bootm_find_other(ulong img_addr, const char *conf_ramdisk,
 			    const char *conf_fdt)
 {
+	log_debug("find_other type %x os %x\n", images.os.type, images.os.os);
 	if ((images.os.type == IH_TYPE_KERNEL ||
 	     images.os.type == IH_TYPE_KERNEL_NOLOAD ||
 	     images.os.type == IH_TYPE_MULTI) &&
@@ -629,6 +662,8 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		debug("Allocated %lx bytes at %lx for kernel (size %lx) decompression\n",
 		      req_size, load, image_len);
 	}
+	log_debug("load_os load %lx image_start %lx image_len %lx\n", load,
+		  image_start, image_len);
 
 	load_buf = map_sysmem(load, 0);
 	image_buf = map_sysmem(os.image_start, image_len);
@@ -1109,6 +1144,10 @@ int boot_run(struct bootm_info *bmi, const char *cmd, int extra_states)
 		states |= BOOTM_STATE_RAMDISK;
 	states |= extra_states;
 
+	log_debug("cmd '%s' states %x addr_img '%s' conf_ramdisk '%s' conf_fdt '%s' images %p\n",
+		  cmd, states, bmi->addr_img, bmi->conf_ramdisk, bmi->conf_fdt,
+		  bmi->images);
+
 	return bootm_run_states(bmi, states);
 }
 
@@ -1165,7 +1204,8 @@ void bootm_init(struct bootm_info *bmi)
 {
 	memset(bmi, '\0', sizeof(struct bootm_info));
 	bmi->boot_progress = true;
-	if (IS_ENABLED(CONFIG_CMD_BOOTM))
+	if (IS_ENABLED(CONFIG_CMD_BOOTM) || IS_ENABLED(CONFIG_CMD_BOOTZ) ||
+	    IS_ENABLED(CONFIG_CMD_BOOTI) || IS_ENABLED(CONFIG_PXE_UTILS))
 		bmi->images = &images;
 }
 
diff --git a/include/image.h b/include/image.h
index b2699ecff3d..6dd7373c7ba 100644
--- a/include/image.h
+++ b/include/image.h
@@ -243,7 +243,7 @@ enum image_type_t {
  * New IDs *MUST* be appended at the end of the list and *NEVER*
  * inserted for backward compatibility.
  */
-enum {
+enum image_comp_t {
 	IH_COMP_NONE		= 0,	/*  No	 Compression Used	*/
 	IH_COMP_GZIP,			/* gzip	 Compression Used	*/
 	IH_COMP_BZIP2,			/* bzip2 Compression Used	*/
-- 
2.34.1

