Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBF7E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 15:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0261F80141;
	Thu, 12 Dec 2024 16:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O0Nqlvwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF55801EB; Thu, 12 Dec 2024 16:11:48 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FCBD80137
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-467745731fdso4429681cf.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734016305; x=1734621105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WaMpQq23VgjvXp3hs0Tjyj1cA1i8hLg2mmBoqG4yzxw=;
 b=O0NqlvwobNqi0OCynjvxffkGhi98Oc/aVbo25Rl5cZg4Q3RxpnPSP9PC4iQDB4d62H
 MhDFrgXBsoZ3vdzFt5F6vHZAHAukdELu0VbMHFGHJPgObgJv7YQBeT6ANHohTVKj0nRP
 QrCwLiwU4GRgNTrywuj9bDPVhdb4S/9bqY04c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734016305; x=1734621105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WaMpQq23VgjvXp3hs0Tjyj1cA1i8hLg2mmBoqG4yzxw=;
 b=A4sp7vJjsIc1/qHqxiBMfKOndHAxf+LJlntqt4S39DC6nsIadbIKODsO0FM2gybKeX
 3cCtiY1+IY7Q2H9ZoTmhWRps+rgw1sSLmv8oPJTc+Ut2RjDINlZMGOU0eQYBzSifhQha
 xJ5AMNLGJx+4e4Y2r0YA1b5/79GMdbrGoc4owkaDM2DmdMAHJTin6NRzvCe+L64nH1R1
 tKhl0S5KegCmWLJ4yh+bGwpv/l76UOrd5eqzXEd/jSu+kPsCl+84zcIm2RuQ9TZU5uzQ
 OzcJuweaAL4pUATYr9vhrDpB8AFKzDY5IDg5jPD9YYnD5s83KvA4MdxoapFrknsta/07
 BW+w==
X-Gm-Message-State: AOJu0YwqY+MSUiPSWx3d5r7D53ihGRoPapze+yutdJfeOC+QuvtZwNm8
 5gNhFjqr+ondrNGqZFpXgvGAZNGVTW2aFC32uSeS90/nAlpJJFnVNNGoNyaaUxBOGzSdjx9mclZ
 SnWM=
X-Gm-Gg: ASbGncvq6dcN77fh8ayyAgovN/6/qRX2DyzLrA1nyqyXBVku3iVKWRN4/9Z4iw4p3uJ
 6LrLQKggUuO5wVGfWpq+XcF9ywUC6mU8UyFBvbWs+tG6xos3ypTRZH0fO8/nlbWi2W4RtiFxc8B
 AfUWAISjTWNXVykXCPpx4i+F+VEMhMACzzQOHQYb2Qu5kzH/jlL5q72f/AUoslWz2EQLjM4H66m
 DG8A9o0orDb0VGlbjYxRLkpFhGPUMC+SMkK7En7KZhkdDHgAWS2sLSuHAZlCNI7wMIazhAnNGuM
 jrE=
X-Google-Smtp-Source: AGHT+IFX+P1MAt+sQ/JLAtJTMRK3nl1ESZ9PxQI7UnWs0DFXW6i1NMT65kCvUSOaMXQjnG06bWxZnA==
X-Received: by 2002:a05:622a:408c:b0:467:67db:ef7f with SMTP id
 d75a77b69052e-467a1619b4amr15186511cf.39.1734016304857; 
 Thu, 12 Dec 2024 07:11:44 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467a22008c4sm543461cf.5.2024.12.12.07.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 07:11:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
Date: Thu, 12 Dec 2024 09:11:41 -0600
Message-ID: <20241212151142.1562825-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Introduce an option to control if we expect that a prior stage has
created a bloblist already and thus it is safe to scan the address. We
need to have this be configurable because we do not (and cannot) know if
the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some special
on-chip memory and so it may or may not be safe to read from this
address this early.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 common/Kconfig | 32 ++++++++++++++++++++++++++++++++
 lib/fdtdec.c   | 11 +++--------
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index e8d89bf6eb9d..e8febad0f212 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1077,6 +1077,14 @@ config BLOBLIST_SIZE
 	  is set up in the first part of U-Boot to run (TPL, SPL or U-Boot
 	  proper), and this sane bloblist is used for subsequent phases.
 
+config BLOBLIST_PRIOR_STAGE
+	bool "Bloblist was created in a stage prior to U-Boot"
+	default y
+	depends on BLOBLIST_FIXED
+	help
+	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created
+	  before U-Boot is started.
+
 config BLOBLIST_SIZE_RELOC
 	hex "Size of bloblist after relocation"
 	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
@@ -1117,6 +1125,14 @@ config SPL_BLOBLIST_ALLOC
 
 endchoice
 
+config SPL_BLOBLIST_PRIOR_STAGE
+	bool "Bloblist was created in a stage prior to SPL"
+	default y
+	depends on SPL_BLOBLIST_FIXED
+	help
+	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
+	  U-Boot SPL is started.
+
 endif # SPL_BLOBLIST
 
 if TPL_BLOBLIST
@@ -1146,6 +1162,14 @@ config TPL_BLOBLIST_ALLOC
 
 endchoice
 
+config TPL_BLOBLIST_PRIOR_STAGE
+	bool "Bloblist was created in a stage prior to TPL"
+	default y
+	depends on TPL_BLOBLIST_FIXED
+	help
+	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
+	  U-Boot TPL is started.
+
 endif # TPL_BLOBLIST
 
 if VPL_BLOBLIST
@@ -1175,6 +1199,14 @@ config VPL_BLOBLIST_ALLOC
 
 endchoice
 
+config VPL_BLOBLIST_PRIOR_STAGE
+	bool "Bloblist was created in a stage prior to VPL"
+	default y
+	depends on VPL_BLOBLIST_FIXED
+	help
+	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
+	  U-Boot VPL is started.
+
 endif # VPL_BLOBLIST
 
 endmenu
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b06559880296..29bddab4150c 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1669,15 +1669,10 @@ int fdtdec_setup(void)
 	int ret = -ENOENT;
 
 	/*
-	 * If allowing a bloblist, check that first. There was discussion about
-	 * adding an OF_BLOBLIST Kconfig, but this was rejected.
-	 *
-	 * The necessary test is whether the previous phase passed a bloblist,
-	 * not whether this phase creates one.
+	 * Only scan for a bloblist and then if that bloblist contains a device
+	 * tree if we have been configured to expect one.
 	 */
-	if (CONFIG_IS_ENABLED(BLOBLIST) &&
-	    (xpl_prev_phase() != PHASE_TPL ||
-	     !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
+	if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE)) {
 		ret = bloblist_maybe_init();
 		if (!ret) {
 			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-- 
2.43.0

