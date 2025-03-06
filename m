Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3EAC19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A099E81877;
	Thu,  6 Mar 2025 01:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IgJafC0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8325380805; Thu,  6 Mar 2025 01:27:12 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 918728144F
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85ae131983eso9682239f.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220828; x=1741825628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3rb4weDIJtHBUrqHCrTEKGVYsCEuduE3O/LJGqgNvM=;
 b=IgJafC0rJAUUF9NzEbQbPp6a7aM/quoG8SB68lZm54/mVjub30LmaZD0TahJwGaRFc
 NErNPZyYZJH+y1Sva5VpHlrXIH2/uk/CSX57V/xflArzq9hmy6n6m+lU8Sl2rFKtuH5J
 bwsPR04hecDXcd+L21UTp47g2fra6+iuteqRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220828; x=1741825628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3rb4weDIJtHBUrqHCrTEKGVYsCEuduE3O/LJGqgNvM=;
 b=sELidAm+XGw9bjdBBRNBRESvT2V9JjZ1ADgB8APciToikwqvaLgm7MC7psKQtHNhL2
 1FBolxelWIEsw9gzcv2JzJrVfKAudLmVbuTZ3OB74A0zepyITJv5I8GHRX1jN/44cEdu
 Um7Q4//qpHIGmzz02qaRqXht50cz9WKIFLTXswtCHDoWK72RRVx08QYYwQqkeNNPrrCl
 G+G6DzN/pJ5ApnqeMxZ5jOg4vPqyFtUmDgQ1V6IyAvx1vJtmRvtshcvChUPwAVwxbsGc
 YSsSBNU9dWUzv8sqxjgxsQL7MuWhTAtSqGsRlPHYCZVBpunCpEIz/QC0h3y5SFxBfK2A
 op/w==
X-Gm-Message-State: AOJu0YxuTTqpbdM23bm1sb5yc5vx3m7Wg2LF4b8HRplSkZIRe+uwQww8
 BTcpXQQvCHuub2EQURG09rOdjBLdgvzMvz3kBQOx/5QajR7BFLfxhIge4oWGtBD6VaF+yTjLRVA
 =
X-Gm-Gg: ASbGnctpmp6h3LkXcRXrYmnLCB1VkSLcqa/wckBLWVcOUI42Lj9LQJwxUyVWNNDPBeb
 hn/LAebmcH7L8a476OfArpM8sckEacEC0TdpEVU6DiVQH1Y8cIdeVCSHd6UoPbrI5BWJmxZVPq7
 ZJ50qqV+VDZfIlTSXrGDSsF7dNvStGzLaPWJn226ChSFx7RPMmFxS2XhcxtQHR2m9XV+CplRRSd
 VIeJRgmNN/mAsZmRtUEP9Ue3hIkUESft7sxOjbUs/qlZxqnEFl3E/Cnyp9TK9g/VLRFFVzt9x8W
 gspgEmbRi2Bl8ae7aWtpFiOavlzrBkQKaPGeMtqs94C0Gi0lPqJz4ZIu5kjsH0/36JnGn5d2hEt
 Nw1gmSg==
X-Google-Smtp-Source: AGHT+IH8i0NzpB8m/A76y2QcRnMt1+ft6+eSNZdo4mcCQWpDMcLHrqonHos+doHKsmOmGP0y7olbog==
X-Received: by 2002:a6b:cf12:0:b0:85b:e62:6113 with SMTP id
 ca18e2360f4ac-85b0e626262mr156690639f.9.1741220827718; 
 Wed, 05 Mar 2025 16:27:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 16/29] boot: Support booti format in bootm
Date: Wed,  5 Mar 2025 17:25:10 -0700
Message-ID: <20250306002533.2380866-17-sjg@chromium.org>
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

At present the booti format is handled separately, in its own command.
Provide a way to boot uncompressed booti images within the bootm code,
so that eventually we can boot these images without CONFIG_CMDLINE

Update bootm_init() to attach the images for all formats which use them.

Add some debugging while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to support booti format in bootm

 boot/bootm.c    | 42 +++++++++++++++++++++++++++++++++++++++++-
 include/image.h |  2 +-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index c719a50ef9a..272623c9258 100644
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
@@ -1110,6 +1145,10 @@ int boot_run(struct bootm_info *bmi, const char *cmd, int extra_states)
 		states |= BOOTM_STATE_RAMDISK;
 	states |= extra_states;
 
+	log_debug("cmd '%s' states %x addr_img '%s' conf_ramdisk '%s' conf_fdt '%s' images %p\n",
+		  cmd, states, bmi->addr_img, bmi->conf_ramdisk, bmi->conf_fdt,
+		  bmi->images);
+
 	return bootm_run_states(bmi, states);
 }
 
@@ -1166,7 +1205,8 @@ void bootm_init(struct bootm_info *bmi)
 {
 	memset(bmi, '\0', sizeof(struct bootm_info));
 	bmi->boot_progress = true;
-	if (IS_ENABLED(CONFIG_CMD_BOOTM))
+	if (IS_ENABLED(CONFIG_CMD_BOOTM) || IS_ENABLED(CONFIG_CMD_BOOTZ) ||
+	    IS_ENABLED(CONFIG_CMD_BOOTI) || IS_ENABLED(CONFIG_PXE_UTILS))
 		bmi->images = &images;
 }
 
diff --git a/include/image.h b/include/image.h
index f8f2c887a4b..5b9bd6a9649 100644
--- a/include/image.h
+++ b/include/image.h
@@ -244,7 +244,7 @@ enum image_type_t {
  * New IDs *MUST* be appended at the end of the list and *NEVER*
  * inserted for backward compatibility.
  */
-enum {
+enum image_comp_t {
 	IH_COMP_NONE		= 0,	/*  No	 Compression Used	*/
 	IH_COMP_GZIP,			/* gzip	 Compression Used	*/
 	IH_COMP_BZIP2,			/* bzip2 Compression Used	*/
-- 
2.43.0

