Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59811C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6454E8214F;
	Mon,  5 May 2025 14:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCOD4J5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B5F820E1; Mon,  5 May 2025 12:09:06 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24DCA80F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 12:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so3655944b3a.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 03:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746439742; x=1747044542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mH+d8R8aWEGoefNMsHGBJI8UfOSAvc1PXAvK5PbQyJE=;
 b=gCOD4J5Iis+9OuM5D3CH4hWVt8yjarufUoYe/w2JF0rLOX9LO+qulQpBPhpbiSYH9i
 82siJKRykmrSCdyN0VytXQ0nP38V5/NQbZv2xk/oLbf7r2HuvPiMyT13b2roy9px+1BE
 uzJ7oiqcQepGdZhtLOL6aZ+vyM59QyiPVRdA35v1MlTeO+LYyUtH6QLL4TkI5ko0BzAt
 2mRpt8zo+nNGEpZFTtAWVFtDIKXYKqfRHcMdGb4KgAEJY//tOpP0CIdW6MnDyfTH0rFz
 XMpyH12UYjjwDGnNTGwnIQjBrMSEQVAnAuMS2gHDpjIYwg7W9/6HrA1oDhb5jXV5Vk3T
 sgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746439742; x=1747044542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mH+d8R8aWEGoefNMsHGBJI8UfOSAvc1PXAvK5PbQyJE=;
 b=cON6MA0c3HytBoQ6df7SGwLNKKWDQ6gKIYk8759x5VrGqrvWdrDOOjlLpAQnVBFwbM
 HDHCMCqSR6WI8eI3k6OOKUJLY3fIrK0P2K1rfEmDs4p7v04/41xD/5iEzNTA7WobQrcC
 mwlvpjH+tG0dkCcRXPBOalmem6sECtjb/rwYrWw4wgnnsBOR0ymMKCFulIFMVJ6RJtcN
 XhUYOP00vAYJD9IXhwSnmLZxu72TOnDuYidE6+w3e7j5zeyFby3R3PiIg7xJ8ZDFkc5A
 mDMzXRhLD2ur8yv60LdV5Fag51YYNdTFz64rQ/1gO6HS9Dr+vZKI7UN7lTsy9+XpH+Jc
 TO1A==
X-Gm-Message-State: AOJu0YzUnfn/w+cwIyVQ+QDbJNVJfaNbyX/qGwLgm8gpWAwFBlouQzEk
 4ENC7y1FYNNn2k4e6KyglGCuWfQUr+xlbQIbWpKU1+WLiMIyU8PiIDBXO/6Q
X-Gm-Gg: ASbGnctEVK90LurDg63JmmvEMFX6x4C5AGUfSOpSyn34bAw0N5QtmQV5t5KIE/LlLY+
 kR8K7TCJlZ5nWRZ7CK8ytSPVQByh6isb7574I9zkqhfj0H8MRgIXuBmrzFSYGFsqfBPIquqw/x9
 D6cvmKrb1E9Vniznr0lQYkcCDq0bD6O9vz2QD4gBpvPs/bcH6BWyiqa4ZwJrmNnvTdk9NQFhigd
 thntUfvH8+b/euLzYHfckVWa4XrABPL/iyDUu8wP7ax7/DHgFu2L6nKV5UgpqzH/nRg64CAFiT4
 i8zHa4pdxkvwOFwAdl1g4YJ5yJ/xCmdBZPQ7tgFxWsyjkLX1XUpd0RofvmhsQKtyUlekseNfp0O
 r6oHtfWJ2F7F3m5OVbg==
X-Google-Smtp-Source: AGHT+IHh5v3SlXYy0V66xIl/QG3cP2ldHzMzuvjaA7KRsXiyKq0roCykptmGR9fpUokxyab8aX7DZQ==
X-Received: by 2002:a17:90b:3851:b0:2fe:b8ba:62e1 with SMTP id
 98e67ed59e1d1-30a61a2bdf6mr9825698a91.28.1746439742183; 
 Mon, 05 May 2025 03:09:02 -0700 (PDT)
Received: from noble-leuven.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151ea18dsm50873555ad.92.2025.05.05.03.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 03:09:01 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com
Subject: [PATCH 1/1] tools: mkimage: validate image references in FIT
 configurations
Date: Mon,  5 May 2025 10:08:52 +0000
Message-ID: <20250505100852.9364-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 May 2025 14:37:53 +0200
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
 tools/fit_image.c | 48 +++++++++++++++++++++++++++++++++++++++++++++--
 tools/mkimage.c   |  7 ++++++-
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index caed8d5f901..02b9c9b5855 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -627,6 +627,7 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 	struct stat sbuf;
 	int ret;
 	int images;
+	int confs;
 	int node;
 
 	fd = mmap_fdt(params->cmdname, fname, 0, &old_fdt, &sbuf, false, false);
@@ -695,6 +696,49 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 		}
 	}
 
+	confs = fdt_path_offset(fdt, FIT_CONFS_PATH);
+
+	for (node = fdt_first_subnode(fdt, confs);
+	     node >= 0;
+	     node = fdt_next_subnode(fdt, node)) {
+		static const char * const props[] = { FIT_KERNEL_PROP,
+						      FIT_RAMDISK_PROP,
+						      FIT_FDT_PROP,
+						      FIT_LOADABLE_PROP };
+
+		for (int i = 0; i < ARRAY_SIZE(props); i++) {
+			const char *list;
+			int len = 0;
+			int offset = 0;
+
+			list = fdt_getprop(fdt, node, props[i], &len);
+			if (!list)
+				continue;
+
+			// Some properties (like loadables) are stringlists
+			while (offset < len) {
+				const char *img_name = list + offset;
+				char img_path[256];
+
+				offset += strlen(img_name) + 1;
+				snprintf(img_path, sizeof(img_path), "%s/%s", FIT_IMAGES_PATH,
+					 img_name);
+
+				int img = fdt_path_offset(fdt, img_path);
+
+				if (img < 0) {
+					const char *conf_name = fdt_get_name(fdt, node, NULL);
+
+					fprintf(stderr,
+						"Error: configuration '%s' references undefined image '%s'\n",
+						conf_name, img_name);
+					ret = FDT_ERR_NOTFOUND;
+					goto err_munmap;
+				}
+			}
+		}
+	}
+
 	munmap(old_fdt, sbuf.st_size);
 
 	/* Close the old fd so we can re-use it. */
@@ -750,7 +794,7 @@ static int fit_handle_file(struct image_tool_params *params)
 	char bakfile[MKIMAGE_MAX_TMPFILE_LEN + 4] = {0};
 	char cmd[MKIMAGE_MAX_DTC_CMDLINE_LEN];
 	size_t size_inc;
-	int ret;
+	int ret = EXIT_FAILURE;
 
 	/* Flattened Image Tree (FIT) format  handling */
 	debug ("FIT format handling\n");
@@ -854,7 +898,7 @@ static int fit_handle_file(struct image_tool_params *params)
 err_system:
 	unlink(tmpfile);
 	unlink(bakfile);
-	return -1;
+	return ret;
 }
 
 /**
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

