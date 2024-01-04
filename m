Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF533C3DA6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 01:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439C3876FF;
	Thu,  4 Jan 2024 02:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iWGyTA4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B969876F6; Thu,  4 Jan 2024 02:49:26 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEFA8876FF
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 02:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7b7a9f90f34so805539f.2
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 17:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704332962; x=1704937762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cMvA6i5vJg3KqzltALIcm/N9z8r9WfYE9Wsfhry5Pas=;
 b=iWGyTA4r2es9KjO9s6GfJtCLNvYt2XkY/CbkFrV+nTrqy3gn4INlbHNn/+M5lUBq3l
 2k1CMSNb11G71VO6mg8Fif7gpHMlLnXS9aMRMRMuv3dtXWSmYO8Bb+U1L0DYayOCeWo0
 KApmnoHnFnONt6sc1b6m9r78v3ESUEZRM38SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704332962; x=1704937762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cMvA6i5vJg3KqzltALIcm/N9z8r9WfYE9Wsfhry5Pas=;
 b=g3Gm/Bp3+3Aih3HjyaKKe9rNPG34IlkM9Wm43UdJPNVpPQZqdMYxovJeJQHCD/x+Xy
 HdVojyHny8et0CW0HMwe6aaq+YFRXsurhoRwvmgs/d6/JjLKCpXkGxLrGz+A86ljC7/i
 oEOgzDFNwbJTpNUJ+hzsiwwUAWFIIwBXmBqrQ8Ay3+/kLCLmG4/CfpSh26t1HwF2I0nS
 kk6nTot3uSrY5nseiWnDRcuLId5K6IA4RFepDa/ofeWUq46U9g6s/Ae624Iw9khHspET
 NRSIUKv+OiecjiwZc1LOnwng4BekuA1WU5/8B9e0VG6BPlrm8fDIHFwePZu0MEwLlLSG
 HtgQ==
X-Gm-Message-State: AOJu0YzWL67AkXg1OOzfK0CX1PHkpQZgvtzf/TYYqTHFW/ynetl2GVYU
 A62cEEY15KsASBqbuHnCeocJ9QcC+4azOAXCvgkojahGx2t8sTA=
X-Google-Smtp-Source: AGHT+IGcug6wFQR7Lji+VJj+9YlO/aesrLIHizjUfP+9Wpr4uHpzMle9BMYCxMJXPJmFV8F1PLv8ng==
X-Received: by 2002:a05:6602:e46:b0:7ba:9b51:413d with SMTP id
 gq6-20020a0566020e4600b007ba9b51413dmr16361784iob.8.1704332962333; 
 Wed, 03 Jan 2024 17:49:22 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bv13-20020a056638448d00b0046b68ee8fd6sm7524003jab.116.2024.01.03.17.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 17:49:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Samuel Holland <samuel@sholland.org>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v7] fdt: Allow the devicetree to come from a bloblist
Date: Wed,  3 Jan 2024 18:49:19 -0700
Message-Id: <20240104014919.413568-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

Standard passage provides for a bloblist to be passed from one firmware
phase to the next. That can be used to pass the devicetree along as well.
Add an option to support this.

Tests for this will be added as part of the Universal Payload work.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
The discussion on this was not resolved and is now important due to the
bloblist series from Raymond. So I am sending it again since I believe
this is a better starting point than building on OF_BOARD

Changes in v7:
- Drop use of OF_BLOBLIST

Changes in v6:
- Don't allow bloblist with OF_EMBED

Changes in v5:
- Make OF_BLOBLIST default y
- Make OF_BLOBLIST optional at runtime

Changes in v4:
- Rebase to -next

 doc/develop/devicetree/control.rst |  3 ++
 include/fdtdec.h                   |  6 ++--
 lib/fdtdec.c                       | 44 +++++++++++++++++++++++-------
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index cbb65c9b177..11c92d440f4 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -108,6 +108,9 @@ If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
 devicetree at runtime, for example if an earlier bootloader stage creates
 it and passes it to U-Boot.
 
+If CONFIG_BLOBLIST is defined, the devicetree may come from a bloblist passed
+from a previous stage, if present.
+
 If CONFIG_SANDBOX is defined, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
 default and -T for the test devicetree, used to run sandbox unit tests.
diff --git a/include/fdtdec.h b/include/fdtdec.h
index bd1149f46d0..e80de24076c 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -72,7 +72,7 @@ struct bd_info;
  *	U-Boot is packaged as an ELF file, e.g. for debugging purposes
  * @FDTSRC_ENV: Provided by the fdtcontroladdr environment variable. This should
  *	be used for debugging/development only
- * @FDTSRC_NONE: No devicetree at all
+ * @FDTSRC_BLOBLIST: Provided by a bloblist from an earlier phase
  */
 enum fdt_source_t {
 	FDTSRC_SEPARATE,
@@ -80,6 +80,7 @@ enum fdt_source_t {
 	FDTSRC_BOARD,
 	FDTSRC_EMBED,
 	FDTSRC_ENV,
+	FDTSRC_BLOBLIST,
 };
 
 /*
@@ -1190,7 +1191,8 @@ int fdtdec_resetup(int *rescan);
  *
  * The existing devicetree is available at gd->fdt_blob
  *
- * @err internal error code if we fail to setup a DTB
+ * @err: 0 on success, -EEXIST if the devicetree is already correct, or other
+ * internal error code if we fail to setup a DTB
  * @returns new devicetree blob pointer
  */
 void *board_fdt_blob_setup(int *err);
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 4016bf3c113..b2c59ab3818 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -7,6 +7,10 @@
  */
 
 #ifndef USE_HOSTCC
+
+#define LOG_CATEGORY	LOGC_DT
+
+#include <bloblist.h>
 #include <boot_fit.h>
 #include <display_options.h>
 #include <dm.h>
@@ -86,6 +90,7 @@ static const char *const fdt_src_name[] = {
 	[FDTSRC_BOARD] = "board",
 	[FDTSRC_EMBED] = "embed",
 	[FDTSRC_ENV] = "env",
+	[FDTSRC_BLOBLIST] = "bloblist",
 };
 
 const char *fdtdec_get_srcname(void)
@@ -1662,23 +1667,42 @@ static void setup_multi_dtb_fit(void)
 
 int fdtdec_setup(void)
 {
-	int ret;
+	int ret = -ENOENT;
+
+	/* If allowing a bloblist, check that first */
+	if (CONFIG_IS_ENABLED(BLOBLIST)) {
+		ret = bloblist_maybe_init();
+		if (!ret) {
+			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+			if (gd->fdt_blob) {
+				gd->fdt_src = FDTSRC_BLOBLIST;
+				log_debug("Devicetree is in bloblist at %p\n",
+					  gd->fdt_blob);
+			} else {
+				log_debug("No FDT found in bloblist\n");
+				ret = -ENOENT;
+			}
+		}
+	}
 
-	/* The devicetree is typically appended to U-Boot */
-	if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
-		gd->fdt_blob = fdt_find_separate();
-		gd->fdt_src = FDTSRC_SEPARATE;
-	} else { /* embed dtb in ELF file for testing / development */
-		gd->fdt_blob = dtb_dt_embedded();
-		gd->fdt_src = FDTSRC_EMBED;
+	/* Otherwise, the devicetree is typically appended to U-Boot */
+	if (ret) {
+		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
+			gd->fdt_blob = fdt_find_separate();
+			gd->fdt_src = FDTSRC_SEPARATE;
+		} else { /* embed dtb in ELF file for testing / development */
+			gd->fdt_blob = dtb_dt_embedded();
+			gd->fdt_src = FDTSRC_EMBED;
+		}
 	}
 
 	/* Allow the board to override the fdt address. */
 	if (IS_ENABLED(CONFIG_OF_BOARD)) {
 		gd->fdt_blob = board_fdt_blob_setup(&ret);
-		if (ret)
+		if (!ret)
+			gd->fdt_src = FDTSRC_BOARD;
+		else if (ret != -EEXIST)
 			return ret;
-		gd->fdt_src = FDTSRC_BOARD;
 	}
 
 	/* Allow the early environment to override the fdt address */
-- 
2.34.1

