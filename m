Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885D1C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 12:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D9F98376C;
	Tue, 27 May 2025 14:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OsfRd80e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A70836C8; Tue, 27 May 2025 14:41:08 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D01D8373D
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 14:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3da73df6c4eso23956785ab.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 05:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748349664; x=1748954464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pr842DZPF0ydSM1KIukKDJXD3q5aQuIsSQzLUh/FKI=;
 b=OsfRd80eXV6et7JxubFLeFLSIDI14qiHgeVlu/6AOY0zZXFBzUL3qvcFv++WiSoFXB
 203Rt0p+N99/TPvFEpxVveJ1qSag412BxpYyt7Mlh1kQkfBI1LyiQUpbSFJ3151m6Gjs
 XEGgWuioxMQgUJmiTZ1Yiv82DG/IV67rizaVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748349664; x=1748954464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pr842DZPF0ydSM1KIukKDJXD3q5aQuIsSQzLUh/FKI=;
 b=HtCJVA4G4smcx/ianVia2km1HokstR0vQG62BHuE2goj9EOcYaa9eJCowqm+SDcTxp
 BFDkMJBSrCPBOnMa9r4vL3/q9uNAtMGrZAlD+Dyv5BsB1g4BagyKNGxrpbx5uEK4xV/1
 OSDm9DgMnX/KJ697pxvRLOWmyoeNpdkWYqOznBIIwzru2/wl2zYyXH+wqMR3iXbjnFNo
 yQU+jncb5SEhQl84OpCq0hYKdSFrptdfsVntV1Z2kFt+IsTL6v33G6aQTcwhkOoMykuQ
 qQlD7Ejw1XUYXVv/7xcKfrWK3voVfFYomY620F39S4xmeCyIYrHXaz99u0JjCvbYneQx
 h4Sw==
X-Gm-Message-State: AOJu0Yzv/0o9pCOF9QBK5GytR4HgFaZP5GnD0q6OLQT1o7uQQAazTaK3
 98MZagBH5INngWUvFvcu7B1QTdOZ67n1rB0dCO+d6EEbjn3ccYXrJNv9xYddwbaI7f6xOOUmT0J
 jaEYc7BvB
X-Gm-Gg: ASbGnctk2Srfqp1crYPB73XE4WKyKNZ7Azpajg97dJghRWnClwCDwgtzVvaxqbA9Fj0
 bebSiE8yL2xC/jY0jmDnYm0au/cvTE1JhDzeeS9ztcmFzZTLJQ6OwY0KROgdyfB902toVg4gzGw
 Sh5Zm8Z3qNpwi1CRRcZCj0xwxP71gKYoG+p/8f8MT4Ti0G9tOhzhIBv9SuiKPE1RbuyqNKsJfOS
 ze0ZiWqiFOwX7iT+HqC8VuUox3nnv7UOYNGoDP4hjAE8ytgg4sLmVisBtDQRAm+WsZJ8254vYZk
 aZ5HoZUs8PFywSVzz0nNyD+Fz5ylvjGRRp/k3HBIaj8yU8yg9F1xKVX5kt2JO8H3AvPLe/DZG2p
 OQOTc0GNUQG8f
X-Google-Smtp-Source: AGHT+IGtTEdTq40utZa45FJVR3vynLc0Kn4R8CUeVV5aAWaS00kmWl5BkNjQbPasL4ScdegQv6HGOA==
X-Received: by 2002:a05:6e02:3a03:b0:3d4:3db1:77ae with SMTP id
 e9e14a558f8ab-3dc9b71375dmr143451535ab.18.1748349664325; 
 Tue, 27 May 2025 05:41:04 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdadebd440sm266176173.50.2025.05.27.05.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 05:41:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] bool: Convert BOOTMS to and enum and document it
Date: Tue, 27 May 2025 06:40:35 -0600
Message-ID: <20250527124038.3633270-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527124038.3633270-1-sjg@chromium.org>
References: <20250527124038.3633270-1-sjg@chromium.org>
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

These stages are not well documented. Add comments to describe what each
stage does and any important requirements. Use an enum so that we can
look up the type. Sort the states in the order of execution. Provide a
BIT() macro so that host tools can still compile the header file.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

 include/image.h | 73 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/include/image.h b/include/image.h
index 44bc8fb9fa0..e21bd3be9b0 100644
--- a/include/image.h
+++ b/include/image.h
@@ -27,6 +27,7 @@ struct fdt_region;
 #include <linux/kconfig.h>
 
 #define IMAGE_INDENT_STRING	""
+#define BIT(nr)			(1UL << (nr))
 
 #else
 
@@ -34,6 +35,7 @@ struct fdt_region;
 #include <asm/u-boot.h>
 #include <command.h>
 #include <linker_lists.h>
+#include <linux/bitops.h>
 
 #define IMAGE_INDENT_STRING	"   "
 
@@ -343,6 +345,61 @@ struct image_info {
 	uint8_t		arch;			/* CPU architecture */
 };
 
+/**
+ * enum bootm_state - States which the bootm machine goes through (in order)
+ *
+ * @BOOTMS_START: Set up the state structure (struct bootm_headers)
+ * @BOOTMS_PRE_LOAD: Do any neceessary processing before images are read. For
+ *	now this just implements a whole-image signature, if enabled. See
+ *	CONFIG_IMAGE_PRE_LOAD_SIG
+ * @BOOTMS_FINDOS: Determine the operatiing system to be loaded
+ * @BOOTMS_FINDOTHER: Find any other images to be loaded, e.g. device tree /
+ *	ramdisk
+ *
+ * Note: After this state the OS, ramdisk, devicetree, etc. should be determined
+ * and be present in struct bootm_headers, i.e. from now on the state should
+ * only consider those images.
+ *
+ * @BOOTMS_MEASURE: Measure images to the TPM, if enabled
+ * @BOOTMS_LOADOS: Load the OS into the correct place in memory
+ * @BOOTMS_RAMDISK: Relocate any ramdisk into the correct place in memory
+ * @BOOTMS_FDT: Load any device tree into the correct place in memory
+ * @BOOTMS_OS_CMDLINE: Set up the command line for the OS
+ *
+ * Note: After this state all images should be in the correct place in memory,
+ * ready for execution. This includes decompression, relocations, etc. From now
+ * only images can be modified but not loaded/moved.
+ *
+ * @BOOTMS_OS_BD_T: Write U-Boot's bd_info information so the OS can use it;
+ *	Only used on PowerPC
+ * @BOOTMS_OS_PREP: Set up tables needed by the OS: this includes devicetree
+ *	fix-ups and moving to the final location, command line (if not done in
+ *	the @BOOTMS_OS_CMDLINE state), setting up ATAGS (only used with very old
+ *	kernels). After this point, we should be ready to jump to the OS without
+ *	any further changes to images in memory
+ * @BOOTMS_OS_FAKE_GO: Fake a jump to the OS; this does everything except
+ *	actually jumping to the OS. It can be useful for tracing or for
+ *	bootstage timing, but is not used in production code.
+ * @BOOTMS_OS_GO: Jump to the OS. Note that this stage should *only* shut down
+ *	any active drivers and do the actual jump. Loading and relocating images
+ *	must have happened in earlier stages
+ */
+enum bootm_state {
+	BOOTMS_START		= BIT(0),
+	BOOTMS_PRE_LOAD		= BIT(1),
+	BOOTMS_FINDOS		= BIT(2),
+	BOOTMS_FINDOTHER	= BIT(3),
+	BOOTMS_MEASURE		= BIT(4),
+	BOOTMS_LOADOS		= BIT(5),
+	BOOTMS_RAMDISK		= BIT(6),
+	BOOTMS_FDT		= BIT(7),
+	BOOTMS_OS_CMDLINE	= BIT(8),
+	BOOTMS_OS_BD_T		= BIT(9),
+	BOOTMS_OS_PREP		= BIT(10),
+	BOOTMS_OS_FAKE_GO	= BIT(11),	/* 'Almost' run the OS */
+	BOOTMS_OS_GO		= BIT(12),
+};
+
 /*
  * Legacy and FIT format headers used by do_bootm() and do_bootm_<os>()
  * routines.
@@ -397,21 +454,7 @@ struct bootm_headers {
 #endif
 
 	int		verify;		/* env_get("verify")[0] != 'n' */
-
-#define BOOTMS_START	0x00000001
-#define BOOTMS_FINDOS	0x00000002
-#define BOOTMS_FINDOTHER	0x00000004
-#define BOOTMS_LOADOS	0x00000008
-#define BOOTMS_RAMDISK	0x00000010
-#define BOOTMS_FDT		0x00000020
-#define BOOTMS_OS_CMDLINE	0x00000040
-#define BOOTMS_OS_BD_T	0x00000080
-#define BOOTMS_OS_PREP	0x00000100
-#define BOOTMS_OS_FAKE_GO	0x00000200	/* 'Almost' run the OS */
-#define BOOTMS_OS_GO	0x00000400
-#define BOOTMS_PRE_LOAD	0x00000800
-#define BOOTMS_MEASURE	0x00001000
-	int		state;
+	enum bootm_state state;
 };
 
 extern struct bootm_headers images;
-- 
2.43.0

base-commit: 36c8798ae6013c8fb784eec1dacf1652e91aecfb
branch: booa
