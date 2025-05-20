Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AA2C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 12:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D2482C7F;
	Tue, 20 May 2025 14:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hy8KvQjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C8A782AB9; Tue, 20 May 2025 09:58:30 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4165B82A4B
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 09:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af51596da56so3902755a12.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747727906; x=1748332706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6dxhKAmGIeE0lS+/61VMNrPTJkQvaeMR2CtTw3YPtQ=;
 b=hy8KvQjF82ZUVSN9ZncEqLfqYLs26lGOXpOqk6A47VxPxQCANeRMfpQZqbAbPhHt32
 MOmOQ4Z0x/alYbkp3l2wKQddOIwM8TV6eflKfyatA+0z/nvnx60IlyGejW5nV+WmJg8N
 6xPqmC0d8mIL8JvDmNYXwF2bD+OkywBJvpCHKvU8gPopjrlpp40QH+DZWc3M7wVV7tx+
 wEY7Etzg3XhWCmsbQqp4Gl8V9NgmFhR8+FqYRtJuJ5SFkiv9kDFtoab4HoKn3qy9HXBX
 P4Bw1TvLYEc1D39T2FzUXfbDWaNB9KCF/GId9Poj0EP0ohja8XsqZ8UMX8LwwYZSBRI7
 VTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747727906; x=1748332706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6dxhKAmGIeE0lS+/61VMNrPTJkQvaeMR2CtTw3YPtQ=;
 b=eYsppMglUu6X0hF/fa7h3lB0IxKScMbOCryBLow7IJ/OKAvzZU74d6Gowmtg5DTy9L
 CISJtV6rlrJPFSfZG5Gxh6G8lQTuYs9wzO1cqzyyVBduvR613VvHorrVViJEkPylS/gm
 lLIqI+WOCGFmGGhDUmmLvxQHgvyeFLXon66LLE3JzYe1Cy8gZkQTdUkaf8Qebzmvv8Wo
 99wa23CpHrVFUUZ22w2OB4bBOFMqA9zi5RAcet4ZS9IM43RECrPcXhBZrr52bDX7Fc9s
 NHzRNvTTW2rJKDmfCd6nk0KyBgCgkHwkUcc24RF7OEmsD4KJcIa2q7pSHThfFyx9V7Gl
 VKPA==
X-Gm-Message-State: AOJu0Yz9Kcq90pcNGSAHyyFySjknpZ+AcBhDWTo2ZPAgH29aGL6m/Hl+
 fy01ufGGg4gK3cQBWxxr5OHrZyYPPhwJTaqPIOhGB0wMK0TPvh3ZQf8Yz+Pgd8+2
X-Gm-Gg: ASbGncvEohS0l/ggfnDbB9nEImdAT9Zx4yWUBQ/QjIoAGTwH7hzZi+HNZT08GRy6SSp
 QQtyNCDpSFeYLmt1MvPBsIlWbRGdt5ZDgM1Z1G3OQkzdQvLlyZQynqcs1UyCPTDqwUgjSIzRw4l
 UVDma/ml1a/eKKUAOdsA54emK9aekoHUyHzLhtNfQsc3Fuf/MmTgONAHOdaNi7eSFcHrdcgTaO4
 PUWJWYYtgETFEYBNCW2iiqsfNw6MIYFtJ/RZeAy+gK/onVQMrVSNLcVUsB5wjF4mAjsKDZTZ69B
 i4ebDt1jVT7kvGo9R0O5N949/SxaK6Xf9pLYd7X19fZwA8nMEVSVGgdMuG17jn7BEMWKXJs+/GX
 4FglLdFd1Yl5Yh1q172y24tc8QVq0V69fU8CSv9o2744WBqc=
X-Google-Smtp-Source: AGHT+IH++l9IZerhX1lpAyppUp4HJI8qX+hy+xZeX2pWCI7Avv5OIIXyWW30Um4XppQ7yIX/qot5SA==
X-Received: by 2002:a17:903:25c7:b0:231:e331:b7ca with SMTP id
 d9443c01a7336-231e331bc48mr127477895ad.3.1747727906468; 
 Tue, 20 May 2025 00:58:26 -0700 (PDT)
Received: from noble-leuven.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4eba49esm71544795ad.163.2025.05.20.00.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 00:58:26 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com
Subject: [PATCH v2 2/4] tools: mkimage: validate image references in FIT
 configurations
Date: Tue, 20 May 2025 07:50:04 +0000
Message-ID: <20250520075735.132308-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505100852.9364-1-aristo.chen@canonical.com>
References: <20250505100852.9364-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 May 2025 14:28:13 +0200
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
index 3d2fbad3853..bf9a6fc369a 100644
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
+				if (!img_name)
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

