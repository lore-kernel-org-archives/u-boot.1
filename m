Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3942C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 12:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B8182F4D;
	Wed, 21 May 2025 14:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C+6kt2on";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDDAC82D33; Wed, 21 May 2025 08:28:46 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9504882BD6
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 08:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso6051508b3a.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747808923; x=1748413723; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6dxhKAmGIeE0lS+/61VMNrPTJkQvaeMR2CtTw3YPtQ=;
 b=C+6kt2onHNWpl3JrNx2hZVjzRB9h1WEpkrP1CW/5tmoN8ZmZBGAlQ83JC1Nc478tQu
 ytSoTeDxmQ9LUyypNSRNhTWmArCiaxk9MsJ2VzbKtdygsIWu3ygtL/2fRbhaxsBfpfii
 wK/7prCwyUooRfZFwnYDYIbaBMP9x9/LVNH4LYVnObEErJmi+x+Vj22gNqHgmrpgej0L
 WqoPPuSyaL7qzEx08TjPnd1fhCSOrjvQjq0ZitVxNlGSmusqh9MeoNls+DjoLPp/ywxO
 bRaS5pliMqsWV/bAeIaQFAnDoGhQRbB6j30cVQh37P9qWn5lrjSQ7Tw89eiJW0U/wkow
 bVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747808923; x=1748413723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6dxhKAmGIeE0lS+/61VMNrPTJkQvaeMR2CtTw3YPtQ=;
 b=kWTbGc59N27+p574KC3UbaPhnbITkfnU38ivSwc8rDbSI0Su4ReDLYklCLrrS5tyrB
 85QYQa4/OWB+AvQ3l9DmLaPiWM/fNSfuc0xH0HvQghvsUfcEUcgczmdwyt2w6P5XXPjD
 ZncI6jgI7Sp9JrTDByoDtCGw6qAix0u3R/W2OzsztdxBaB5rczd2vmiYN2xmWnWtrX3O
 KiASgkGbl5Lhcp9cfriNbG0h9BPgKvc6AuUpxh9Wnp2ImoxIcaleX8RHlFrzVty7+bVu
 VU254TQdGDGskZlRcIlLMVPZlTm0EP9mpgvOlWcrPxyJ2x5vlmPaaDUfQVbtIeWDqsSK
 PNlA==
X-Gm-Message-State: AOJu0Yxhi0AET+ajnnoef3uA9Bq6VV1+hYQW/htBuCkjB1HRN3CLnqO9
 SAHLo2uiS8SK6A9xckR7TjL+dvsaAbl2ElvERFUKvpi8nVhUztwaoYBf8WeNlZXW
X-Gm-Gg: ASbGncsWm+1VAmmh6IO2nRwWVVICoNz1ClYQsuCBL/R6iNuQ4XQ7mhHcfIlSNr2utVq
 pyTOHHNmruiOpUwrNKJ0g2/aFb9YRM0XMj7/IAScxkrRZkzWKXvvzfcgAuqX/yt+jSn4qn2oju5
 TIhCvxrXzEozfOl9UmCasj5rRKVjjZf2OZC9SdOwZOGBxaCZKlZWu+mVdfyBLHtnA5s2PQgVXpS
 b4SUXpIDh1At0SBBrJRR9pbLF3m9Lu/4AHqAZV/oK73OZgo7cKg7Po9N55zCKvmeSxP9hm/A9hO
 fbG6f0PUjlfKc2WuRsHLjhZkgLaSppHTV2WpaLyZ9uIWc1gd2mBmhyEHrqKzFUPpcT071G2sNxL
 5CAfLhUixGJ0ZhPSpZcIzVb00sPCF
X-Google-Smtp-Source: AGHT+IE/a+69cGYHze8eRLj8DSJ8eQ4YVrarQ0hjcytGU3ssw6/2dTC2W7gEpB9sMblegatJjzE60Q==
X-Received: by 2002:a05:6a20:9c9b:b0:215:e44c:831f with SMTP id
 adf61e73a8af0-2165f5e3ec6mr31602067637.4.1747808922806; 
 Tue, 20 May 2025 23:28:42 -0700 (PDT)
Received: from noble-leuven.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a982b884sm9277911b3a.95.2025.05.20.23.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 23:28:42 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com
Subject: [PATCH v3 2/4] tools: mkimage: validate image references in FIT
 configurations
Date: Wed, 21 May 2025 06:27:43 +0000
Message-ID: <20250521062745.3458-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521062745.3458-1-aristo.chen@canonical.com>
References: <20250521062745.3458-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 May 2025 14:36:46 +0200
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

