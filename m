Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07E2C44532
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AFF780EC3;
	Tue, 21 Jul 2026 15:55:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8BbOrQw5DFrV; Tue, 21 Jul 2026 15:55:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86DFD80EF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784649347;
	bh=nxmjHbTGa2HfxRacoOTtsAKv4rcpNIroEYgmzskEpxo=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DUaPE2yPakv/t5WxH2Z/o3OVw1UjENPnmfWgPPHGgi5Gc0bJeGDfL7Pwq/v9XXV8y
	 04jC7AlKOPo8A+AFBXrINYTZV+272IT/Sp1TdkOwx0S9fr/J5GGC6984QdggRph66T
	 9n9vcex//Y6bJkMQmletlZDPpysNDVuRFCwKmrS5M7D3wMLOLdZh4gtd0kBBvim+Tr
	 j0tHNfVXRrMhwEtw2MUpQKfWp5eCScF39S8I5vf2xaPN3gmh7BaOtuuzRcRmC2ffsl
	 GtUf4AAufnrqshxpkQpH5Ns4OmFendRtO7lH/Ial+HKwufi94eIkioM7qiheaonRjc
	 2tTv92rFQheSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86DFD80EF1;
	Tue, 21 Jul 2026 15:55:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7F26109F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADC0840877
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h0gILzmLdu6l for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:28:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C629840875
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C629840875
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C629840875
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:28:43 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F2E383FC03
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:38 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc86a9ef97so246572835ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647297; x=1785252097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nxmjHbTGa2HfxRacoOTtsAKv4rcpNIroEYgmzskEpxo=;
 b=ZSu7LZj01epy7Hl+1zlPqsNJLz08QoYRavqj+uuIUVX31haQe2JkeT21HBoLJnfHSM
 9iJg3iyguO0XkW9wB0i3ZGwQBanV3/Nise9ht0wadpgqsZ82XDDovWvGRakS+G2a/qZ6
 6NJtCUvDePI4/jK+CjOnwHClKgXbtEY8UNi6eMvvSU22Ko60i9E644yWeJJGMCzY+Ugp
 bHyfbUawFAtK93QLGCeqdM3KSQiYORPo1WAeRPcyvwvQE9EN69kThe5s4DEJhrqQ/BRF
 xk4842FEwzT/BPxfIBeXtMpKkVTFQpWcQ5yQbIJk/vl0CU98SFB1vQVsiTOXvOQJufWX
 u5kw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqwdy/nuTKmEuTdO07aVjLcK562jUE63ilAlqrnSTNntJZU6ZP9CwYGCUJzCxzAKXiIrByCBbI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzvpUfwLxlLe1BNuzIJx2ERAGL7q3GpgfK7X/7dgk8OP5dmP+s1
 WwZken7kML+Gc0zcxbzKRO/t7hjx3tx/OSsHwLBQumLTQoSkN5QGRt1rxqCJmtjuPMCnLzdayYX
 y8ahYPETc4+/T2XVtscDXHl62+q7QBrDD/uRggEGDXvM90FGR4ZD3tGy/FcUhljTE51B28m0AjI
 LSNYTOjTjXZQEr8j9nD/5O
X-Gm-Gg: AR+sD12qN80mPB79p5icNlDD+LKUDg+pIZtrVxJnQ461NybPDMJ3ga27M6ZWZrmLxjJ
 Sh/VeQjawHc1WG83hineRyJaFG2WVrWMvpH2MwE9x5q3WJzIfGhBYSDkhOu298Zkz5YV/1ss0fZ
 eAwbCDh1BWa9Lffd1PyegNtjjPqXp3H77vBo/gv8kT2/v3shctAHbaOcEm7YWDF/ORsJlU2VgQJ
 2NM3uBe6NVNTX/AzvDGy/pj6wz77RTwjEkMQ8PeJi1bLzFeDIYzHrpZL3nMJS5Vtf6r27PodKk2
 MJFrMjWfBUBzj9c7iBGDi4GzLPINaP6tXCxnk55eqNFaU0sj7xpacjs6hGLpvHtZKxqUMcUmYfA
 IjXs63w38+FAKwVefS0sj+6S058HTH7V3Iofq/tLSTmPwrW63p+ev1Zvz/8CdyEdXr1E=
X-Received: by 2002:a17:903:360c:b0:2ce:b096:e50b with SMTP id
 d9443c01a7336-2cf349fe60dmr189682415ad.47.1784647297212; 
 Tue, 21 Jul 2026 08:21:37 -0700 (PDT)
X-Received: by 2002:a17:903:360c:b0:2ce:b096:e50b with SMTP id
 d9443c01a7336-2cf349fe60dmr189681815ad.47.1784647296568; 
 Tue, 21 Jul 2026 08:21:36 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf347119dfsm77733775ad.56.2026.07.21.08.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:21:36 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 5/7] tools: mkimage: detect overlapping load regions in FIT
 configurations
Date: Tue, 21 Jul 2026 15:21:04 +0000
Message-ID: <20260721152110.283998-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721152110.283998-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 15:55:37 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784647299;
 bh=nxmjHbTGa2HfxRacoOTtsAKv4rcpNIroEYgmzskEpxo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ZlHwgFNdMnGBlFu6D+TDrz5SyzYI4YcV8kxBNUTkUXJu+w0N4nLEuv1W37kgQmQ3L
 rSA3W7rODDUwrgqMKO9yVBkeFAV4bC6SIWlXpUAgfw1/3HrHGhj4tPheQ4VGaAGlZj
 uhPM31su7ULMHQq3pRk9DPaeo80PQfkAXucpVwbzweLEYJjaGWnKnfAJ9YYkLZyojM
 8TPJyPr+HnH/bc+nY/r25wupvyCm5xeYmZsdNqBYxaRKu7+Yym0TljuOwKztpbBNla
 H4BbLRldEHUyr9WU/8+/JWLuxv7ZfjJcSmLN21y/PpMoVWNTAhiyWvCZplh0PYTApm
 fB7em5YN3mgKSPDS6ppfUQskX5SZfQzUAjaLK6dssymOwPIOmDXmifepg5NGVnl/8I
 n6wdRYj4Y2NInCqV7EUx9jZybfxqGCr2s7+ciDYTiflrBWVOf6ds8nEtoWJgemOfoH
 HRxUB1Gcoy3N/xsfsSOBUDE9NrxdZ7yEjtAcDKPLTBlH3oWejZuqMP4bayTW9F34ke
 MFuwYd8r3Irk0QB9fypTai5QZOifZVQfRb0lPVcm7hNEsVcItYgOoXfXQ+8LefDhcb
 cdtMoSHukKNm7SBBy4xjvGPz1BO1Zl9ivPel60NF9kmbaEQHC1J+HXaTMTfVrbptnF
 uCwDLYTRqHidRdOyMecezZqE=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=ZlHwgFNd
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
---
 tools/fit_image.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/mkimage.c   |  3 +-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 5831b07c090..74c9e65f6c6 100644
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
@@ -907,6 +919,8 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
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

