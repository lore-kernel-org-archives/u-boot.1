Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54978CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 08:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF28E848C6;
	Tue,  2 Jun 2026 10:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="SL0QhO3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E889848A1; Tue,  2 Jun 2026 09:42:21 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E36684884
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 09:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lorenz@sigma-star.at
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490b2b037d2so1678655e9.3
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1780386138; x=1780990938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mi2jhIAVNJJf3dzLFAjCOtfwlKVP8a/akkMTMTNzfKk=;
 b=SL0QhO3IkrTFcBi6xLZvPmScDltQ7zFOwtmm0vxkMa03Im5u/e3Jd/N0L+Uf+1p/FD
 lzUm+AxZmrDMnbOzmvRADf7PZoQoc5gCDxkTUZE11seaXmrxBPE3lGMqtkkMWvlAq71f
 aUU3QsSDzr0KH8YnnIPmjbmV6bbShR3HZrkLSsLtH1lbO70ZSlvcCk7ryNXJuzsnTDGn
 lwcO6MISoC4IKcmMJeZgheC2TH3bVS7q6gRAFMkoGS5RMMUPNjp3b0t45FLgBG6ol51B
 dsXH6KgLRcAPLAx1mUCVtCxJZX3Aaq3ar91ZLo0bUW7qPz4hh2XH2IY9RP8wbaIip8PQ
 qZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780386138; x=1780990938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mi2jhIAVNJJf3dzLFAjCOtfwlKVP8a/akkMTMTNzfKk=;
 b=HkSPiXRqkXBI0uAr8T5FzOuAPMBtEdZNY7GNMLV9h+e71OwRNMvGVNOPWIs6QKE4uZ
 HzgIwinpNV1DXGaUIDx3HuI808yilFWIAdTMFnf9o7XdKr6dI1WveEihFDWgfjeTjaFQ
 LviRrtSv15kRaaSQPp56HfDNJ/UVTLOXDJ1PuJB6aq1Ag5ydNspk6/s+vdl0mdKBNbQc
 Bwv6QbYk/fphtzwAIfnE88JeTpNQkGeZpNaWXzzI/JT3mAN/gSIPf9CBiTYAHEPj6tsz
 Xaqfj7mVWdmc9rOOhDezIMSZV7z6b9Cv6dXBlCn/MDOsdOUsjjQu+hSN9KXD/t6Lbvso
 8/3A==
X-Gm-Message-State: AOJu0YyNBaBhQtVoKCg2hk+XvB1fNW7D3YfaqqDeBESijV97Y4/z5NXm
 BP9in0iDx+3HPAcnvKeFKJqVvVI1+/56jn0Ktk/Lq2ZklMMlI4W6o6mhGMEeOzTRMDQLwTwX3jf
 OEVNLy0BXdw==
X-Gm-Gg: Acq92OEDiSgOymGazHNmYWVc6K0yaeZALW2vOQBHGxBvf/eVnLilYWjgKMKBZlAQ63l
 zQaEAh+4mWSDgTwF9miE7+0J+e3PVl5UNSFEo1JUP/lv9UJcfa79Hq/jrevE7Ff+NMrz/Hml4NW
 M8/pAAXeLgLCzKAOkFLeiobTbeVpecv0x8gxDtyHc6nHZ3lqA+KTnSIrne3UWugY7joxRr2xh0F
 XWhii20ErO1tLpv/oModE6fczi+n/B6PTHWDdls1izT+dOmuFgXlp7jhSNwoCcdgiJDIt2Mzvcg
 msspBq6+Hh3+F4VpN8T1H4SMOBy0rmHp4sE6uoLVgIMf1YsHqCr+My1ZQhGTnJMke7275Cqs1Ql
 AQYJ07/75ClBZvzcsZGvrhWmlA/c+7WfHKucXGaAVRUn8O0VCp4nfqClFoehieRNl409tn80f9/
 RLH9QlrnZlb0mGyvM/10xEstbz/ZumnixL2VAWeAroARgSMA==
X-Received: by 2002:a05:600d:844a:10b0:48a:557e:6b4f with SMTP id
 5b1f17b1804b1-490a293afe2mr193788065e9.23.1780386138472; 
 Tue, 02 Jun 2026 00:42:18 -0700 (PDT)
Received: from mimir.fritz.box ([2a04:9546:1c18:5b01:cab3:2478:20a6:2fb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354b5bdsm30239748f8f.21.2026.06.02.00.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:42:18 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 upstream+uboot@sigma-star.at, Bruce Monroe <bruce.monroe@intel.com>,
 Arie Haenel <arie.haenel@intel.com>,
 Julien Lenoir <julien.lenoir@intel.com>,
 Lorenz Kofler <lorenz@sigma-star.at>
Subject: [RFC PATCH 1/3] boot/fit: require exact subnode matches for FIT
 references
Date: Tue,  2 Jun 2026 09:43:33 +0200
Message-ID: <20260602074335.3965312-2-lorenz@sigma-star.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602074335.3965312-1-lorenz@sigma-star.at>
References: <20260602074335.3965312-1-lorenz@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Jun 2026 10:00:24 +0200
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

Libfdt lookup semantics can match a node by its base name even when the
actual node name includes a unit address. As a result, a request for
"kernel" can resolve to a node named "kernel@1".

This aliasing was the basis of CVE-2021-27138, which was fixed by two
commits:

  commit 3f04db891a35 ("image: Check for unit addresses in FITs")
  commit 79af75f7776f ("fit: Don't allow verification of images with @
  nodes")

Both address it by rejecting any FIT node whose name contains '@'. That is
overly broad: it also breaks FIT images that legitimately use unit
addresses in their node names.

Harden the lookup itself instead. Add a fit_subnode_offset_exact() helper
that wraps fdt_subnode_offset(), reads the resolved node name back with
fdt_get_name() and rejects the match unless it is identical to the
requested string, so a config referencing "kernel" no longer resolves to
"kernel@1".

Use it in place of fdt_subnode_offset() at the FIT reference lookups in
fit_image_get_node(), fit_conf_get_node() and fit_conf_find_compat(), and
at the matching image lookups in the SPL FIT loader.

Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 boot/image-fit.c     |  7 +++----
 common/spl/spl_fit.c |  4 ++--
 include/image.h      | 28 ++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..a6504cd8041 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -678,7 +678,7 @@ int fit_image_get_node(const void *fit, const char *image_uname)
 		return images_noffset;
 	}
 
-	noffset = fdt_subnode_offset(fit, images_noffset, image_uname);
+	noffset = fit_subnode_offset_exact(fit, images_noffset, image_uname);
 	if (noffset < 0) {
 		debug("Can't get node offset for image unit name: '%s' (%s)\n",
 		      image_uname, fdt_strerror(noffset));
@@ -1781,8 +1781,7 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 				debug("No fdt property found.\n");
 				continue;
 			}
-			kfdt_noffset = fdt_subnode_offset(fit, images_noffset,
-							  kfdt_name);
+			kfdt_noffset = fit_subnode_offset_exact(fit, images_noffset, kfdt_name);
 			if (kfdt_noffset < 0) {
 				debug("No image node named \"%s\" found.\n",
 				      kfdt_name);
@@ -1881,7 +1880,7 @@ int fit_conf_get_node(const void *fit, const char *conf_uname)
 		conf_uname = conf_uname_copy;
 	}
 
-	noffset = fdt_subnode_offset(fit, confs_noffset, conf_uname);
+	noffset = fit_subnode_offset_exact(fit, confs_noffset, conf_uname);
 	if (noffset < 0) {
 		debug("Can't get node offset for configuration unit name: '%s' (%s)\n",
 		      conf_uname, fdt_strerror(noffset));
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 46ebcabe56a..baa0214fa46 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -166,7 +166,7 @@ static int spl_fit_get_image_node(const struct spl_fit_info *ctx,
 
 	debug("%s: '%s'\n", type, str);
 
-	node = fdt_subnode_offset(ctx->fit, ctx->images_node, str);
+	node = fit_subnode_offset_exact(ctx->fit, ctx->images_node, str);
 	if (node < 0) {
 		pr_err("cannot find image node '%s': %d\n", str, node);
 		return -EINVAL;
@@ -456,7 +456,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 			if (ret)
 				continue;
 
-			node = fdt_subnode_offset(ctx->fit, ctx->images_node, str);
+			node = fit_subnode_offset_exact(ctx->fit, ctx->images_node, str);
 			if (node < 0) {
 				debug("%s: unable to find FDT node %d\n",
 				      __func__, index);
diff --git a/include/image.h b/include/image.h
index 34efac6056d..b3ddc9202a5 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1156,6 +1156,34 @@ static inline const char *fit_get_name(const void *fit_hdr,
 	return fdt_get_name(fit_hdr, noffset, len);
 }
 
+/**
+ * fit_subnode_offset_exact() - Find a subnode by exact node name
+ * @fit: FIT image
+ * @parent: Parent node offset
+ * @name: Exact child node name to look up
+ *
+ * fdt_subnode_offset() may ignore the unit-address suffix, so a request for
+ * "kernel" may resolve to a node named "kernel@1". Verify that the returned
+ * node name exactly matches the requested name.
+ *
+ * Return: node offset on success, negative libfdt error value otherwise
+ */
+static inline int fit_subnode_offset_exact(const void *fit, int parent, const char *name)
+{
+	const char *actual;
+	int noffset;
+
+	noffset = fdt_subnode_offset(fit, parent, name);
+	if (noffset < 0)
+		return noffset;
+
+	actual = fdt_get_name(fit, noffset, NULL);
+	if (!actual || strcmp(actual, name))
+		return -FDT_ERR_NOTFOUND;
+
+	return noffset;
+}
+
 int fit_get_desc(const void *fit, int noffset, char **desc);
 int fit_get_timestamp(const void *fit, int noffset, time_t *timestamp);
 
-- 
2.54.0

