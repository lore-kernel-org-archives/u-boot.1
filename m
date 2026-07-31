Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A7DC55165
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 00:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6526D6073E;
	Fri, 31 Jul 2026 00:15:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uyrYKoCRMQxk; Fri, 31 Jul 2026 00:15:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6880960678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785456953;
	bh=iJcmyt7f0kUvttUqpwM64fIUPK9TJ9MEthcZoGG6qjQ=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wt0CasOk43GJE12JIq3XAaHF9hxbWIljt/ZnunGEdmXUZOFz0HOrlXQR7i/5/oyRU
	 bdpoRwgfJNgJrh9c/iTeQCtSbFaCzKCeyF3L6YzlOXlXcbFxY7ehFop7/p2o8eoufc
	 lieq4eyT0HdLy/JLFueTOBvumw6RLaF/eZJ9MrHFaE9MtPA+17lFKzVwEMLAmkJTRU
	 dZALe3J4iu+xQGJK8DbSL4tGIBs1qvnUUGoJu9bmbC9VGHSwBBTmNzidSUpUQMyMUt
	 2SlrDOjN/3M8dNJgTOMRZ/wG+/+iBv54aeHM4DOJRcKuWDeFEaBvztUzd9f2n5Ig3L
	 LCypnHGIgh55g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6880960678;
	Fri, 31 Jul 2026 00:15:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 009A527C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E69FF60674
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ctgKNoClC2FQ for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 00:14:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0666D60648
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0666D60648
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0666D60648
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:56 +0000 (UTC)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7C92A3FBFB
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:54 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-848544a8496so485750b3a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456893; x=1786061693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iJcmyt7f0kUvttUqpwM64fIUPK9TJ9MEthcZoGG6qjQ=;
 b=o0rGo2zWstdNOtv9x+SjQykIW1JmmAzvc/X6U0kaaP36lu6oQEj0J//c5e79w8gN2G
 /uChueLlft2UFfmbg29DjXby4MRILkjjHzNvQrS4c626aLCHv2xYaXeMYe8JJjTmWV0N
 Bq3I27hD31QBbc7qYoXggGN0dT/5QFNuhiqYdT/MDujBvc0QGVRq17i9g/HzKnyOnhhp
 549PXgjipRwvOqpyRtN67uC6K5sIH2tHgl4Rv2aJfjJVE2wCLJ73wTiadQ+EI/vqN0aI
 +bQqNsX/dftrY5jYnGkjGkZ1YE1BJr/IzUWRLQ3N6jIfyFXKw2fJfoBEpk5nw5sm9/3K
 bE1A==
X-Gm-Message-State: AOJu0YyxHOHUIXsALQAntWMEoHILIDfkCkN9EiNEhKphyoxAwAyoqcUY
 DBLaX5e0Nyp0hDQz2BpPWgmVmPKSG5lwvJmkUxghpGf6t5ITjc8OAeVfJlmrVERTovYg1QZlLdp
 /cEdODXDk2CLln+YAHoXKRIpSs/WVp0qCq7myc7wxUD9m2oUx4sGaxwVNTTu3F18Hj5rK6cIXwu
 6qbXMta/aUQ4n2ZQBIFSEsEyg=
X-Gm-Gg: AR+sD129BfbCFzPOCpkDDXElbcMwr/VzvpxMWF6u8KQXqo5Rt17AbSxBoJ1pjrjyDfi
 xrkT+KMPOrMUsY9KXTsfQLzzjDghiKTYfIxi9PgCUu68h4YSH/NF7yJlNuUzmX482MAKe6ki3yn
 qyYayMc//Vf82K5/lpQZi3EeIIHo00HUj7yxloitCBwCWRbwXWUWVGmmg9HT41INul8mdWyhX8l
 jWCNnrLFzGpJpcYTjALd7ByfhD5N3IDL15axT3bXr3jwL6zT0X6PC9nXOCKLcOuL7MHMqlMClka
 DCMFnZBFrUWaHqcWV/cgrpep629zQBJLOEjyGAV47jDwMLjN8nMaMBwi79v9pgSMWr07YZjYWKd
 YqXdEttQG983La5hCKA6/3QFpnqD2+qC4L+sfim5T0kSX5U7SWG0u50UOVADH4QL82rTOug==
X-Received: by 2002:a05:6a00:4fc8:b0:845:d274:c024 with SMTP id
 d2e1a72fcca58-84ebc415edemr3907254b3a.61.1785456892938; 
 Thu, 30 Jul 2026 17:14:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fc8:b0:845:d274:c024 with SMTP id
 d2e1a72fcca58-84ebc415edemr3907237b3a.61.1785456892513; 
 Thu, 30 Jul 2026 17:14:52 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea02f8461sm3695718b3a.28.2026.07.30.17.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:14:52 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org,
 nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, e@freeshell.de,
 jonas@kwiboo.se, Aristo Chen <aristo.chen@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v4 5/7] tools: mkimage: detect overlapping load regions in FIT
 configurations
Date: Fri, 31 Jul 2026 00:13:39 +0000
Message-ID: <20260731001347.35624-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731001347.35624-1-aristo.chen@canonical.com>
References: <20260731001347.35624-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 00:15:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785456894;
 bh=iJcmyt7f0kUvttUqpwM64fIUPK9TJ9MEthcZoGG6qjQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=hyrsvQ3xOLKVRrxhdQudL5y2V8ydzqFil2RzKFq+w5w9rsz/7KsrRpa3ORgqgsiKq
 jnr4rxCjjVCHXexWnrE97Z8PoIY+ygemgBQbAtUSmq/+lD1kD8Y8XphrI9maPZRv3n
 UUB4FH1tDRwbR/1e9y9ExKE3SV4sTzLIdXAyKrheINeCremQ56dRITSUDIBeUwIbeF
 B0h2pWlkMpRyooC1zB3FSnnbUN95TF+z0dtTVDRg1fo0B9YmGEHO2k9eQkIVKpwRC4
 QBAFATTU9RWV3hTIO8TM1HIR+sB3u+rk0NTyAuZf54IY3QgNk3K62IYlMwmXWRle7p
 vQGkEAm+0EfhfABjq/nK5qNm8yoM9W01rrkE/z6Q7TUKEGqvJFNxnOm6NO6IRkPFYs
 X1jrNhje8fWI8QvrFRAMOwgpK5P2fBPCOIvcBqJZUxgDmMKMKUhQaigDcJGWprU2C3
 vDpopdUWSxwdpbLKA0XQC+AM3Sgmjs03B195BHdM7eVbZ606YgiJiPUbnekmJunU9B
 xJvdjFSrPLwhesOrSrq6Aaro8GXLESRZ3MtBmy0/X5a25Z+zP4d5NsEMHQWvOurMh1
 fpo/dJhH6DiZDROtvsyCVii/dNhe+PBbD/vT1o64QEOQWffur+v7suBLpyMI3PZshN
 JXrWhhGHiY483ma7fPMXYEec=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=hyrsvQ3x
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a validation step to mkimage that checks, for every configuration
of a FIT image, whether the images referenced by that configuration
declare overlapping load regions. Images that are loaded together must
not share memory, and such conflicts currently go unnoticed until the
resulting image corrupts memory at runtime.

The check is strictly per configuration. Images that share a load
address while being referenced by different configurations are not
reported, because only one configuration is selected at boot. This
matches the layout used by the TI K3 tispl images since commit
c85bf61b14f9 ("arm: k3: select tifsstub via board_fit_config_name_match"),
where the mutually exclusive tifsstub variants moved into per security
state configurations precisely so that static tooling can reason about
each configuration on its own.

Images without a load address or without data are skipped, since
nothing is copied anywhere for them. Compared to the previously
reverted version of this check, the missing load address case no
longer prints a warning, as FDT images routinely have no load address
and the warning only added noise to every build. An image referenced
through several properties of the same configuration, for example
listed in both firmware and loadables, is only counted once.

When an overlap is found mkimage prints the configuration name
together with both image names and their regions, then fails with
FDT_ERR_BADSTRUCTURE. Teach main() to exit cleanly for that value the
same way it already does for FDT_ERR_NOTFOUND, since the error
message has already been printed.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 tools/fit_image.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/mkimage.c   |  3 +-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 7e59bc43b77..f0fe68894d6 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -24,6 +24,18 @@
 
 static struct legacy_img_hdr header;
 
+struct fit_region {
+	ulong load;
+	ulong size;
+	const char *name;
+};
+
+static bool fit_regions_overlap(const struct fit_region *a,
+				const struct fit_region *b)
+{
+	return a->load < b->load + b->size && b->load < a->load + a->size;
+}
+
 static int fit_estimate_hash_sig_size(struct image_tool_params *params, const char *fname)
 {
 	bool signing = IMAGE_ENABLE_SIGN &&
@@ -905,6 +917,8 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 	int images;
 	int confs;
 	int node;
+	struct fit_region *regions = NULL;
+	unsigned int regions_alloc = 0;
 
 	fd = mmap_fdt(params->cmdname, fname, 0, &old_fdt, &sbuf, false, false);
 	if (fd < 0)
@@ -1009,6 +1023,7 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 
 	fdt_for_each_subnode(node, fdt, confs) {
 		const char *conf_name = fdt_get_name(fdt, node, NULL);
+		unsigned int reg_count = 0;
 
 		for (int i = 0; i < ARRAY_SIZE(props); i++) {
 			int count = fdt_stringlist_count(fdt, node, props[i]);
@@ -1017,6 +1032,11 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 				continue;
 
 			for (int j = 0; j < count; j++) {
+				const char *img_data;
+				ulong img_load;
+				int img_size;
+				unsigned int k;
+
 				const char *img_name =
 					fdt_stringlist_get(fdt, node, props[i], j, NULL);
 				if (!img_name || !*img_name)
@@ -1031,10 +1051,88 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 					ret = FDT_ERR_NOTFOUND;
 					goto err_munmap;
 				}
+
+				/*
+				 * Collect the memory region the image is
+				 * loaded to. Images without a load address or
+				 * without data are never copied anywhere, so
+				 * they cannot conflict.
+				 */
+				if (fit_image_get_load(fdt, img, &img_load))
+					continue;
+				img_data = fdt_getprop(fdt, img, FIT_DATA_PROP,
+						       &img_size);
+				if (!img_data || img_size <= 0)
+					continue;
+
+				/*
+				 * A configuration may reference one image
+				 * through several properties, for example
+				 * both "firmware" and "loadables". Count
+				 * each image only once.
+				 */
+				for (k = 0; k < reg_count; k++) {
+					if (!strcmp(regions[k].name, img_name))
+						break;
+				}
+				if (k < reg_count)
+					continue;
+
+				if (reg_count == regions_alloc) {
+					struct fit_region *tmp;
+
+					regions_alloc = regions_alloc ?
+						regions_alloc * 2 : 8;
+					tmp = realloc(regions, regions_alloc *
+						      sizeof(*regions));
+					if (!tmp) {
+						fprintf(stderr,
+							"%s: Out of memory for %u load regions\n",
+							params->cmdname,
+							regions_alloc);
+						ret = -ENOMEM;
+						goto err_munmap;
+					}
+					regions = tmp;
+				}
+
+				regions[reg_count].load = img_load;
+				regions[reg_count].size = img_size;
+				regions[reg_count].name = img_name;
+				reg_count++;
+			}
+		}
+
+		/*
+		 * All images referenced by one configuration are loaded
+		 * together, so no two of them may claim overlapping memory
+		 * regions. Images sharing a load address across different
+		 * configurations are fine, since only one configuration is
+		 * selected at runtime.
+		 */
+		for (unsigned int i = 0; i < reg_count; i++) {
+			for (unsigned int j = i + 1; j < reg_count; j++) {
+				if (!fit_regions_overlap(&regions[i],
+							 &regions[j]))
+					continue;
+				fprintf(stderr,
+					"Error: configuration '%s' has overlapping load regions:\n"
+					"  - %s: [0x%lx - 0x%lx]\n"
+					"  - %s: [0x%lx - 0x%lx]\n",
+					conf_name,
+					regions[i].name, regions[i].load,
+					regions[i].load + regions[i].size,
+					regions[j].name, regions[j].load,
+					regions[j].load + regions[j].size);
+				ret = FDT_ERR_BADSTRUCTURE;
+				goto err_munmap;
 			}
 		}
 	}
 
+	free(regions);
+	regions = NULL;
+
 	munmap(old_fdt, sbuf.st_size);
 
 	/* Close the old fd so we can re-use it. */
@@ -1067,6 +1165,7 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 err_munmap:
 	munmap(old_fdt, sbuf.st_size);
 err:
+	free(regions);
 	free(fdt);
 	close(fd);
 	return ret;
diff --git a/tools/mkimage.c b/tools/mkimage.c
index 3c43962807d..6b3fd60adbf 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -550,7 +550,8 @@ int main(int argc, char **argv)
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

