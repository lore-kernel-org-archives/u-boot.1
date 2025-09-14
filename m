Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EEECAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1CB8341C;
	Sun, 14 Sep 2025 15:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DkkviX3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA0C82A9E; Sun, 14 Sep 2025 13:01:23 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 777A580B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 13:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30cce872d9cso2671005fac.1
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757847680; x=1758452480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuPQBTcT8ew2tsKsUdO9LyG5obsQipFUJsGS6d5PXPo=;
 b=DkkviX3z2SC2suJQ0Ek/qo4jB7LUTzEim/I/dc0dsgM+zy6hjkmHfqkYtgS/5TiA2i
 3Kk6/eR9/rklWwyh7d9G/EnmB7TcE0DIE91FQmpFjh4rF6H0IDeZkFuBu0R6xroG+kGM
 ayfKDyO7xNXK72SLYeb0hp8TvmAtRZaO1M1JTThZSfciU7nsBbIhbmOYa/wzW8nhELjv
 sgUWtN0hd4u0vXTVJ+BbEiFvAFPT7pRJIcr7RxzOwCWAmV6NSX3AD7YJRZ1eyNiloDax
 2IYHUfAjQfhtdo5HQnc3ErciJlT2T4WUmtpKPWBTuv/DmScqSajbN9d4nAOISTg7urB4
 jh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757847680; x=1758452480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuPQBTcT8ew2tsKsUdO9LyG5obsQipFUJsGS6d5PXPo=;
 b=QKKz+avhKSksoytFYxb/vB4rn6F3eTcMewKVn06+nrBFqyaZaUgYS8xUmbZ0a/Tur5
 +wjpVcto9IVoqwEfRyS0PaEb+MFCFwftpW8tVhA9yt499etjZ/CG8f1VPUSAQLqx7CTb
 auWCHcGdlrejoAf/MOG37NarjHeqfRYldX8xoBM82wAkHk1qFSydQr2b95fOQIdNJlpZ
 zhU8twJJFJLM98Sta5rNpNG4dFANhD48dstVnn4lAesFRoFiLZZ5P5IbEauGOIrbNjlm
 n0qmdL4U+cJv81DNCep7V/ydfMjmid56OF93JrFv8ltLyp/JeY0yj2oUoE5EMe6azBQz
 FWTQ==
X-Gm-Message-State: AOJu0YxjK/XgVpoKlrdORmpbUMMYc+wCDxJKrNWp5w+94Vh6ySk0TXxJ
 +vTNyRcGAyRy/GJzV5NGCuw4i7dC6Ui7DsBCBoW2C5v2ECFxtDeJug5AyyzIjZwa
X-Gm-Gg: ASbGnctDRRqi+goDDfr2OhW7y36PaV8U93gMXMbg1XOdeO6MN8msGj2+i8Dzb1rn7TQ
 mKjoyq5Dfdij5t1r91Ga+/AOEkzdcGc8U9q7PMCnINb2RNZKWWSJMPhV6jqDzou5M0ChIKnVAkR
 2kC9Jg7HgysrYejCYsGoYotrMlqrnDhCkRUf8GlNkRyN40AoP14YI9RgsIbd03cIjBKL+XPA5aA
 XCZVKBECnoC6Ut21AjvV0IonRmOWsqgHNtp8ODsjKrZ1uQGxvekGY5QQHzx/cS1UK+W7Ob9vhJt
 KupkkeAmerUM3IJbqm7AGelXgzJGHWwz/R7RqZx+tTBX3LDaXhZsGEI7IvQq6havrw2eQiEl9wn
 uEckWpq0B5x2gSOkg+rku+y+1QG8s/wYOUpaf7lrctJ7DRnvbtC1KwaBjxhh47FPDRg8xmK0=
X-Google-Smtp-Source: AGHT+IHL5088JZIpXjQCdnaBXXrHsIZ87rwJ29mmn3lJqA3Ae13Bk+y7eznbpzdrk8xMThu8gc5LeA==
X-Received: by 2002:a05:6870:9109:b0:315:887d:b9c9 with SMTP id
 586e51a60fabf-32e579fa781mr4581924fac.36.1757847679995; 
 Sun, 14 Sep 2025 04:01:19 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d32d56557sm2612720fac.1.2025.09.14.04.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 04:01:19 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 quentin.schulz@cherry.de, alice.guo@nxp.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 5/7] tools: mkimage: detect overlapping load regions in FIT
 configurations
Date: Sun, 14 Sep 2025 10:59:30 +0000
Message-ID: <20250914110021.4103-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914110021.4103-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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

This patch adds a validation step in mkimage to detect memory region
overlaps between images specified in the same configuration of a
FIT image. If any overlaps are found, the tool prints an error and
aborts the build.

This helps prevent runtime memory corruption caused by conflicting
load addresses between images.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/fit_image.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++-
 tools/mkimage.c   |  3 +-
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 331be5ae71d..bd849110646 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -22,6 +22,20 @@
 #include <version.h>
 #include <u-boot/crc.h>
 
+struct fit_region {
+	ulong load;
+	ulong size;
+	const char *name;
+};
+
+static int regions_overlap(const struct fit_region *a, const struct fit_region *b)
+{
+	ulong a_end = a->load + a->size;
+	ulong b_end = b->load + b->size;
+
+	return !(a_end <= b->load || b_end <= a->load);
+}
+
 static struct legacy_img_hdr header;
 
 static int fit_estimate_hash_sig_size(struct image_tool_params *params, const char *fname)
@@ -775,9 +789,12 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 	}
 
 	fdt_for_each_subnode(node, fdt, confs) {
+		struct fit_region *regions = NULL;
+		unsigned int img_count = 0;
+		unsigned int regions_allocated = 0;
 		const char *conf_name = fdt_get_name(fdt, node, NULL);
 
-		for (int i = 0; i < ARRAY_SIZE(props); i++) {
+		for (unsigned int i = 0; i < ARRAY_SIZE(props); i++) {
 			int count = fdt_stringlist_count(fdt, node, props[i]);
 
 			if (count < 0)
@@ -798,8 +815,79 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 					ret = FDT_ERR_NOTFOUND;
 					goto err_munmap;
 				}
+
+				ulong img_load = 0;
+				int img_size = 0;
+
+				if (fit_image_get_load(fdt, img, &img_load)) {
+					fprintf(stderr,
+						"Warning: not able to get `load` of node '%s'\n",
+						img_name);
+					// Skip checking the components that do not have a
+					// definition for `load`
+					continue;
+				}
+				const char *img_data = fdt_getprop(fdt, img,
+								   FIT_DATA_PROP,
+								   &img_size);
+
+				if (!img_data || !img_size)
+					continue;
+
+				// Check if we've already added this image to avoid duplicates
+				for (unsigned int k = 0; k < img_count; k++) {
+					if (!strcmp(regions[k].name, img_name))
+						goto next_node;
+				}
+
+				// Expand regions array if needed
+				if (img_count >= regions_allocated) {
+					unsigned int new_size = regions_allocated ?
+								regions_allocated * 2 : 8;
+					struct fit_region *new_regions = realloc(regions,
+							new_size * sizeof(struct fit_region));
+					if (!new_regions) {
+						fprintf(stderr,
+							"Failed to allocate memory for regions in config %s\n",
+							fdt_get_name(fdt, node, NULL));
+						free(regions);
+						ret = -ENOMEM;
+						goto err_munmap;
+					}
+					regions = new_regions;
+					regions_allocated = new_size;
+				}
+
+				regions[img_count].load = img_load;
+				regions[img_count].size = img_size;
+				regions[img_count].name = img_name;
+				img_count++;
+next_node:;
+			}
+		}
+
+		// Check for overlap within this config only
+		for (unsigned int i = 0; i < img_count; i++) {
+			for (unsigned int j = i + 1; j < img_count; j++) {
+				if (regions_overlap(&regions[i], &regions[j])) {
+					fprintf(stderr,
+						"[Config: %s] Error: Overlap detected:\n"
+						"  - %s: [0x%lx - 0x%lx]\n"
+						"  - %s: [0x%lx - 0x%lx]\n",
+						fdt_get_name(fdt, node, NULL),
+						regions[i].name, regions[i].load,
+						regions[i].load + regions[i].size,
+						regions[j].name, regions[j].load,
+						regions[j].load + regions[j].size);
+					ret = FDT_ERR_BADSTRUCTURE;
+					free(regions);
+					goto err_munmap;
+				}
 			}
 		}
+
+		// Clean up allocated memory for this configuration
+		free(regions);
 	}
 
 	munmap(old_fdt, sbuf.st_size);
diff --git a/tools/mkimage.c b/tools/mkimage.c
index 361711c53b2..3f28918f5cf 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -520,7 +520,8 @@ int main(int argc, char **argv)
 			retval = tparams->fflag_handle(&params);
 
 		if (retval != EXIT_SUCCESS) {
-			if (retval == FDT_ERR_NOTFOUND) {
+			if (retval == FDT_ERR_NOTFOUND ||
+			    retval == FDT_ERR_BADSTRUCTURE) {
 				// Already printed error, exit cleanly
 				exit(EXIT_FAILURE);
 			}
-- 
2.43.0

