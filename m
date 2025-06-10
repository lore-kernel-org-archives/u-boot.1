Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ABCC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 12:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7EA82B97;
	Tue, 10 Jun 2025 14:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FmScguvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C05E80C83; Tue, 10 Jun 2025 09:41:41 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91F0805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-235a3dd4f0dso35289995ad.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749541297; x=1750146097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1qrMkP/A3+uOFsGKXef5584Qw8vBH9255OQWPyPZXU=;
 b=FmScguvABUn7siLig5KIA7i7auaHOWT3Pmik/4eFQlmdpYvcn5Gdb0Gfw9hBSUi/LQ
 1Xbfx0N29axEDWogpW51sCZ3FKLLrHZfL2Iw5V+2URxOXrGa4xfpHPhcxqdlkg4Vx2u4
 bGV63/MJIUKQjtCXSS9C3XU30QMIzyS1vU2LdsdmF2wCNN/0vBsag49/YTSE9tplKG/z
 6hRyYFyRQCr/38P4UwYgNRxVILOgYbrIPoY0ZbrMMysmPRhtkJO4mtT8msRJOw+LBn6k
 yHLXO8P0/38QhJk9WIZwNs1FUXHezA0/N8muiy1tHERqEoCheSq0T6ypzM3wEimJ1/gE
 PPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749541297; x=1750146097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1qrMkP/A3+uOFsGKXef5584Qw8vBH9255OQWPyPZXU=;
 b=uyVJTXKi07PA1c7c8B4B6RknMotQVYnaDVHWun4Dp6Uheninj9D0ywt/DgAN8Cj8mn
 OF90WIOuX/CYDoL/iI+U5a0s5rJj/TmDdTpliQ50rJinMHCc8VLkMfQU4ENGAOGJeZjF
 zUcvYNFyCX6jzbUkXBfrpw/oGaXnfsF0MPklsNfFjm++dTzKC99KWVlhB3Qa+kpS44kN
 rxHzBeCnqU4bkm/yLSmWoAm9H2nIDTBZjX2Lkz34UU3Uq5arwGKgN785X7pkuj0UaY0A
 8jDXOUycrlyz1gBxFKs47MQOgTTFO6tedNDz/qyE0gjvduOPE+ktmzdM1Op1vd0Zm3Tp
 l/Gg==
X-Gm-Message-State: AOJu0YzJH4108oLFDBflMzAzbu/sI8E9+6KOD50RA4y0r48HKYUQE8+B
 Yvg1l5nRfoaFz50iZRx6ksM/7K+udUFiWOYIew0ZVUc46vypocYuVweLNEBJWMON
X-Gm-Gg: ASbGncteIbbLrxrkBid1dnScOQCwhHcKfCZuRdohCHfHkfaQkjESCoazHZJwZI7Mb8T
 PPlUCXWaLtu+rRx9VZQ0drYen2gjo+FDgtSPpT8vMww3a5AjXL8zvgIererTX0Zlv+tsd013YPH
 5yljcG7psjH6B0YCk9as3Ng32wqHFOejfTILDQkCTw8w9iIm2eJbfHIxalCgolZCwrBtcORDUEp
 7HIPddQaq7rKrYkLgUFSjV06WEBFW+W59Cn5PGg2HIn4sbO7MfNj5jgKaKYpGy/CeRmVnMZoqVQ
 5PyIjICn9jE10B9j4kc4UMwEnTf5+7sMaGGGN6hU6gQZpQa/ljty3oujV3fpfiel5X8Z8Xtv3/I
 0cHwAMdshK2oXRiim2TjM4rhhdu/OGkRsv9w=
X-Google-Smtp-Source: AGHT+IH1wUm1/i4P3aQqfgQpMGJoMHLB7iAHoxTYPIRZEMVb1Hkmi3N8vs4h7xPdpsIqjU6jNepRMQ==
X-Received: by 2002:a17:902:d489:b0:235:6aa:1675 with SMTP id
 d9443c01a7336-236383b383emr21679415ad.52.1749541297073; 
 Tue, 10 Jun 2025 00:41:37 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603092640sm65201945ad.54.2025.06.10.00.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 00:41:36 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com,
 paul.henrys_ext@softathome.com, d-gole@ti.com, afd@ti.com,
 d.schultz@phytec.de, nm@ti.com, n-francis@ti.com, alpernebiyasak@gmail.com
Subject: [PATCH v4 2/5] tools: mkimage: validate image references in FIT
 configurations
Date: Tue, 10 Jun 2025 07:41:18 +0000
Message-ID: <20250610074121.8308-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610074121.8308-1-aristo.chen@canonical.com>
References: <20250610074121.8308-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Jun 2025 14:57:04 +0200
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

When parsing a FIT image source (ITS), mkimage does not currently check
whether the image names referenced in the /configurations section (e.g.
"kernel", "fdt", "ramdisk", "loadables") actually exist in the /images
node.

This patch introduces a validation step during FIT import that iterates
over each configuration and verifies that all referenced image names are
defined under /images. If a missing image is detected, an appropriate
error is reported and mkimage exits with FDT_ERR_NOTFOUND.

This ensures that configuration integrity is validated at build time.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/fit_image.c | 38 ++++++++++++++++++++++++++++++++++++++
 tools/mkimage.c   |  7 ++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 3d2fbad3853..8fdde012bda 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -627,6 +627,7 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 	struct stat sbuf;
 	int ret;
 	int images;
+	int confs;
 	int node;
 
 	fd = mmap_fdt(params->cmdname, fname, 0, &old_fdt, &sbuf, false, false);
@@ -695,6 +696,43 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 		}
 	}
 
+	confs = fdt_path_offset(fdt, FIT_CONFS_PATH);
+	static const char * const props[] = { FIT_KERNEL_PROP,
+					      FIT_RAMDISK_PROP,
+					      FIT_FDT_PROP,
+					      FIT_LOADABLE_PROP,
+					      FIT_FPGA_PROP,
+					      FIT_FIRMWARE_PROP,
+					      FIT_SCRIPT_PROP};
+
+	fdt_for_each_subnode(node, fdt, confs) {
+		const char *conf_name = fdt_get_name(fdt, node, NULL);
+
+		for (int i = 0; i < ARRAY_SIZE(props); i++) {
+			int count = fdt_stringlist_count(fdt, node, props[i]);
+
+			if (count < 0)
+				continue;
+
+			for (int j = 0; j < count; j++) {
+				const char *img_name =
+					fdt_stringlist_get(fdt, node, props[i], j, NULL);
+				if (!img_name || !*img_name)
+					continue;
+
+				int img = fdt_subnode_offset(fdt, images, img_name);
+
+				if (img < 0) {
+					fprintf(stderr,
+						"Error: configuration '%s' references undefined image '%s' in property '%s'\n",
+						conf_name, img_name, props[i]);
+					ret = FDT_ERR_NOTFOUND;
+					goto err_munmap;
+				}
+			}
+		}
+	}
+
 	munmap(old_fdt, sbuf.st_size);
 
 	/* Close the old fd so we can re-use it. */
diff --git a/tools/mkimage.c b/tools/mkimage.c
index 2954626a283..361711c53b2 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -519,8 +519,13 @@ int main(int argc, char **argv)
 			 */
 			retval = tparams->fflag_handle(&params);
 
-		if (retval != EXIT_SUCCESS)
+		if (retval != EXIT_SUCCESS) {
+			if (retval == FDT_ERR_NOTFOUND) {
+				// Already printed error, exit cleanly
+				exit(EXIT_FAILURE);
+			}
 			usage("Bad parameters for FIT image type");
+		}
 	}
 
 	if (params.lflag || params.fflag) {
-- 
2.43.0

