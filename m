Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C23C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A82583102;
	Wed, 30 Jul 2025 07:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lUSsLm26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A32382BCD; Tue, 29 Jul 2025 14:51:25 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D68A82063
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 14:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ae0c571f137so1064389666b.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 05:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753793482; x=1754398282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNPWf8Y72JtoZNHbv5tpCX+KqsCA0SAdN9TvsL/Tv7k=;
 b=lUSsLm26POTJKgy0kq6V3Hz/AUbynS8zqA7CTlNG8keXBwrwijoK4XXiA74u/Xgyhd
 Bn1T+ey4Jkm1gTljgKMMm5QYJMSqjvJyUZaH417F1jOFzhn+v7DFrg/JESErdaLBNUFU
 xJDrVEPuWuTe3kq0CwXWRJBeBXR8Dz4nIYpY4Uc2fxuz+JzKOCcrbZ6KjNtD1NSCCZOJ
 CeVaoQgHVLXIVvS5uA/tP2P01DPA14b8TahZOZG19yZx4rrGCvBWoSxo+yEopF2P24ho
 aYJGd6R9pWLemxXdis1aB2zneaKNY01Nem7QRWD98GY1VU/I9STSx5ebsoEbMicOWm3h
 KaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753793482; x=1754398282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNPWf8Y72JtoZNHbv5tpCX+KqsCA0SAdN9TvsL/Tv7k=;
 b=PyfcSKvlWaBbamrEpvwBJBLDv3+AWy+R/3BvJig8S7DFfSBGIkLcFwDezDidSKQmPt
 rR4mCAIcQxDjWSBKRdB8aWHMePC8jOZUj996wLmMWy5yN5Uv3pcY4ZFCjIYpsCxRZQSu
 N7WI4k2dlENm39LBdvic2zQwULA6BhH1BTyws/c/gqOirV1vSq+u3fdm/CvnQA1gPRLp
 qk8DXedMB0HA+Em98wXz/o14XRTG9VgTrpjF8pCvaWMGRqUkIEXTnSw1LsLVTyMVzNea
 391HDAQUxkMKoN2VMRCaqSZsACBT/WFwo8ZH59JNbiekq5Itiuh6poIvgzna5J4/LeN1
 RzBw==
X-Gm-Message-State: AOJu0YwAgZUTqN/MV21YKx5DcRtNZ0EKJ+0A9X1s+/Ou1NLYcxy8TABk
 pfUZT3tvfFCitZBDgS9F/8w+9PwUGfLEYgwJc6ZWugFGS/qOQyYgJ+CGA+HOIdt0
X-Gm-Gg: ASbGncvEZ1k77MgSl2M+JN3H2AelZXb8sw6H7XknTf/tEj4Hv4HsIgB84qctav6S/+S
 xlwZL4BeeeoC/7yOJ9uD/xt4Bimjp2sSmwKcJLhJCbddFqvjPBSfmzPczbTW6yoSuOXbnwtNNsd
 nihWKUiTpTC3aBfIvPFN9rfXlabnlQUWvcTiuxj+ThI6aCpOelnlB2/fMz5UeRoSzGoAjrq3KDu
 Qkqr3wkM9D3nyUc+QzMxdt1UqxSd8YP7EyAuBz4unDz19vNHQvIw4+EfPicxH7ZudazrwpM7Rxx
 Xo2wG9C4JLyhIADCO78r0JosFVE8T2CxZGx/idofWqJW0pWyk/6S5FQZIDQOdU4cwVuEnM7wWhp
 eUUgOeWy3tmKiMvQCHymn3w52FthE2v2Sy1sDf1mGBOwCd6trvjxneq3jNBNfOgiuYnzW06g=
X-Google-Smtp-Source: AGHT+IF09g8cu5vnYd+Cd/d7PwYxQssqFZlUcDu+uoBvymdxTg3DZH4pOCzU+t7nlELzi0MO/epHwA==
X-Received: by 2002:a17:907:6e8f:b0:af2:91c7:f2f8 with SMTP id
 a640c23a62f3a-af619c0df38mr1615603166b.50.1753793482164; 
 Tue, 29 Jul 2025 05:51:22 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635acc99esm572223366b.115.2025.07.29.05.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 05:51:21 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 4/5] tools: mkimage: detect overlapping load regions in FIT
 configurations
Date: Tue, 29 Jul 2025 12:48:55 +0000
Message-ID: <20250729125022.4220-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729125022.4220-1-aristo.chen@canonical.com>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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
 tools/fit_image.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/mkimage.c   |  3 +-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 331be5ae71d..d0061adf051 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -22,6 +22,22 @@
 #include <version.h>
 #include <u-boot/crc.h>
 
+#define MAX_IMAGES_PER_CONFIG 16
+
+struct fit_region {
+	ulong load;
+	ulong size;
+	const char *name;
+};
+
+static int regions_overlap(struct fit_region *a, struct fit_region *b)
+{
+	ulong a_end = a->load + a->size;
+	ulong b_end = b->load + b->size;
+
+	return !(a_end <= b->load || b_end <= a->load);
+}
+
 static struct legacy_img_hdr header;
 
 static int fit_estimate_hash_sig_size(struct image_tool_params *params, const char *fname)
@@ -775,6 +791,8 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 	}
 
 	fdt_for_each_subnode(node, fdt, confs) {
+		struct fit_region regions[MAX_IMAGES_PER_CONFIG];
+		int img_count = 0;
 		const char *conf_name = fdt_get_name(fdt, node, NULL);
 
 		for (int i = 0; i < ARRAY_SIZE(props); i++) {
@@ -798,6 +816,66 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
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
+				if (!img_data || img_size == 0)
+					continue;
+
+				// Check if we've already added this image to avoid duplicates
+				bool already_added = false;
+
+				for (int k = 0; k < img_count; k++) {
+					if (strcmp(regions[k].name, img_name) == 0) {
+						already_added = true;
+						break;
+					}
+				}
+				if (already_added)
+					continue;
+
+				if (img_count >= MAX_IMAGES_PER_CONFIG) {
+					fprintf(stderr, "Too many images in config %s\n",
+						fdt_get_name(fdt, node, NULL));
+					break;
+				}
+
+				regions[img_count].load = img_load;
+				regions[img_count].size = img_size;
+				regions[img_count].name = img_name;
+				img_count++;
+			}
+		}
+
+		// Check for overlap within this config only
+		for (int i = 0; i < img_count; i++) {
+			for (int j = i + 1; j < img_count; j++) {
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
+					goto err_munmap;
+				}
 			}
 		}
 	}
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

