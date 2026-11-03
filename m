Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4B6082BD0
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uDf4sH9z;
	dkim=pass (1024-bit key, unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=GxvzsB+J
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B1E6405CF;
	Tue,  3 Nov 2026 09:53:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eDOdc7Nbprh2; Tue,  3 Nov 2026 09:53:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86FBE40586
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793699624;
	b=aetPBvkTwSdnXSbW6dsI2Q0r55n49DxUY1u6HlRyAkCVu70a40keC2ytGoGjJ+5+q+4F
	 WzEry4ekZ1LVfoSJdIbp2sTKPEgoq+TOQae63kWxJpcpiUDyOVVBnT24BVsfFqQVihApZ
	 tGlFVtRyNHAWRBYxuT4MxMreCLtYoGqx7OrkfQj3vyTexLt+82cqKcwZfPjDHNIaSoHKo
	 A49xJ5BVExYexnjfRc4mzim27VY7gZrSdf9MW+8u2PSYx6eM9stEo1gLl7TFfk4Sb4XJ2
	 IdkDVvr8ixhVK8buZ4bB2H2IN2efEIDx+zzfsjigjhypj74PG/SCcnGcEIUt7MWhpEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793699624;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/3L9WCLGqKJ0H23/TnOe3us9MJTF3LiAZi8oFwqM9QM=;
	b=lMvHA35JKlX8rhfP/y1oLABMYGNr+ox5NpMfuj/+WFwmk6bv0C3lO2bhdGKlpgWtjKVp
	 /o94qnd5FQWXTVQcUA8atkq9hiTFVMXDO0jcZWi8WwiCi1iHKT5vdDsj+Ct2YxHdYG89P
	 1NWTGxAtxeOqwz5HTOpdKl3s70wMp4iqkeiU2BZCY39EWspBje2owj2CsJeRLVcAs6i8/
	 WQUEmCzbMN4lIL45bexv2REr6BDkZMX85ailq4rWst9xPJkyJivGzPivGEPUsj2rVT4KI
	 lzr8ic8UCAMQEFU/HENVtUvtHLlenw6e5JxhCyIqlAQowk0/FEYDwLSLfQPF1uVOGWA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793699624;
	bh=/3L9WCLGqKJ0H23/TnOe3us9MJTF3LiAZi8oFwqM9QM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDf4sH9zgpJ+ySW1ZDXydJ7S1CzdqZ/K4GfxwGnDKs/2kTJ8IX9G6+W1WlA7boiN+
	 eeg9delnp96JslcvwwR9r/XVu9yvk0oeiVzTRPXLgJLWa6/b+eSNANzaAUAmPLLJtG
	 +sWmFOgjRHqKpr/cTpydVxJrL/Ee7bAxtiSJzIt6ojiX1rKOMw2sxHwivAfuRvWH9c
	 3W5jMj+vrp9pH5BbfA6bO3cSFUd1yYfFX3KQJOW9+82+HSTFi3HDCnVUAT0MGclx7/
	 rkXvRAUdD/TnDSvk6C/oeu3isgYAzey8af0mlWa31Klelri9W8y33Tu6tpuczrpaI4
	 P+shFOe6KqmDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86FBE40586;
	Tue,  3 Nov 2026 09:53:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B162D356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA11960777
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qT4hAHF-QIw7 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:53:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B0AD60728
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699622;
 b=sxZIn/72XRjDgajWuEkHRBukaTtwadkDK2C84hYIFlifFlqDWZfXMMj9xtUapN2ie9yY
 2N0cgnrxaXaBYNqJsDaPadSeL7JB0WUVtvN4PqEFJcdOTiRRhI1mAqGvU4R0eIHSMpvkf
 PoVUuf9s0cFzBEPAW1QwAv3X3IHIl40y6Ux7sCKr4Jre3peiknnEcHQN9MmNZf9MEVMFR
 ZT6pl4PdjnigHUywhUNd6tN1cDE11UGbBEAw22NJ9nxNwmGtLVJQr4eFqPt/egJJdvwk1
 nbsSxdzobqImqIxsaT3BrMNPON4eBkvX4F2OlbXPqBj/Ui+bKSJ9ovAnf53Gm/l7zLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699622;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=/3L9WCLGqKJ0H23/TnOe3us9MJTF3LiAZi8oFwqM9QM=;
 b=YPASIiGDO4zGT/NqqQ0m5Bv8Hfbe+I8fB97ZxIARPaBjuEq3mfiXzhZu4wpLmJWBVCb9
 ZWPXDxzdqidIg2DNITFN0n/+3FStXgLcT6KcoYvMbxGWUCe3peR5rnfMUrXWaNqN7AESO
 vIvQg2BmIRH/wIUYiPJ2Nr7dXkAWlUWnqOUijtwvL6Da1AxGzIkrvsn+Sb7QHKTF0TVg+
 2LPuUAwhu+yxpjeJI5XItRdM6N/4MeNVLh03LU2LJ/VF5APntQlZwHH1jbeWZp+1LueiZ
 Ul/kgreOByyBmoqRixhmGJGdFM73+g4/0KuqXFCwU5MRPu+7CQHcoAwxdFMl6RZljeA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=maquefel.me;
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=GxvzsB+J; 
 arc=none smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c0e:500:1:45:d181:d103; helo=forward103a.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=GxvzsB+J
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B0AD60728
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:42 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-70
 (mail-nwsmtp-smtp-production-main-70.yp-c.yandex.net)
 by forward103a.mail.yandex.net (postfix) with ESMTPS id 75F038067C;
 Tue, 03 Nov 2026 12:53:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70 with ESMTPSA id
 OrH94I7pRiE0-3nR2kPtZ; Tue, 03 Nov 2026 12:53:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1793699614; bh=/3L9WCLGqKJ0H23/TnOe3us9MJTF3LiAZi8oFwqM9QM=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=GxvzsB+JvedqJJYkkW2TVBnKDqZ6/bKCA+AteipHTaiCqkXtQhFYqE0HjHChBvtbt
 YjFcZH/+JJbOOmoE6n70thYj2Z13GGn2oHckPUqKsgwbGdz7CCQRnRJw0hXADYGmmO
 zakg/mW6UO5cKtuVTT1bT7JVRdc7yr4IanPB6RVI=
Authentication-Results: mail-nwsmtp-smtp-production-main-70;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Tue, 03 Nov 2026 12:53:04 +0300
Subject: [PATCH v3 5/6] spl: fit: Record loadables to spl_image->fdt_addr
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-riscv-full-fit-support-v3-5-e1dcdc9638e5@maquefel.me>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
In-Reply-To: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793699606; l=4991;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=AKXsIYrGfqOPoeeslxdbPJfkiQxQ4ZksCRJ4nVdpbUI=;
 b=/1u7jxLMtFDOrihom3+ijIGjmD0Nf6+SqYfmV7l5NRI/P1JoYQpj0t5JKuGRSOGrPz8IB2n/W
 Lqs3Pr5XgbjBGCW8g11rM6bp8av/Wc8vUBICk+sa29haL7uwGi7hG1G
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Record loadables to FDT passed to next boot stage.

This is required for spl_invoke_opensbi(), for example, which requires
u-boot/kernel load or entry address to fill opensbi_info.next_addr
entry.

spl_load_simple_fit() does it, make spl_load_fit_image() also capable of
recording loadables into next stage.

One limitation remains: if the FIT image does not contain an FDT blob,
spl_load_fit_image() will not use gd->fdt_blob as a fallback,
unlike spl_load_simple_fit() which does.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 common/spl/spl_fit.c | 80 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 26c6cfad116..cc6fc066f40 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -601,6 +601,33 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 	return ret;
 }
 
+/**
+ * fit_record_loadable() - Record a loaded FIT image in the next-stage FDT
+ *
+ * Adds a /fit-images/<name> node to @fdt_blob describing the image, taking
+ * the type, OS and architecture from the image node in the FIT.
+ *
+ * @fit:	Pointer to the FIT
+ * @node:	Offset of the image node within @fit
+ * @idx:	Index of the loadable
+ * @name:	Name of the image
+ * @load_addr:	Address the image was loaded to
+ * @size:	Size of the image
+ * @entry_point: Entry address of the image, or FDT_ERROR if none
+ * @fdt_blob:	FDT to update
+ * Return: 0 on success, -ve on error
+ */
+static int fit_record_loadable(const void *fit, int node, int idx,
+			       const char *name, ulong load_addr, ulong size,
+			       ulong entry_point, void *fdt_blob)
+{
+	return fdt_record_loadable(fdt_blob, idx, name, load_addr, size,
+				   entry_point,
+				   fdt_getprop(fit, node, FIT_TYPE_PROP, NULL),
+				   fdt_getprop(fit, node, FIT_OS_PROP, NULL),
+				   fdt_getprop(fit, node, FIT_ARCH_PROP, NULL));
+}
+
 static int spl_fit_record_loadable(const struct spl_fit_info *ctx, int index,
 				   void *blob, struct spl_image_info *image)
 {
@@ -614,13 +641,9 @@ static int spl_fit_record_loadable(const struct spl_fit_info *ctx, int index,
 
 	node = spl_fit_get_image_node(ctx, FIT_LOADABLE_PROP, index);
 
-	ret = fdt_record_loadable(blob, index, name, image->load_addr,
-			image->size, image->entry_point,
-			fdt_getprop(ctx->fit, node, FIT_TYPE_PROP, NULL),
-			fdt_getprop(ctx->fit, node, FIT_OS_PROP, NULL),
-			fdt_getprop(ctx->fit, node, FIT_ARCH_PROP, NULL));
-
-	return ret;
+	return fit_record_loadable(ctx->fit, node, index, name,
+				   image->load_addr, image->size,
+				   image->entry_point, blob);
 }
 
 static int spl_fit_image_is_fpga(const void *fit, int node)
@@ -1047,7 +1070,7 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	const char *uname;
 	ulong fw_data = 0, dt_data = 0, img_data = 0;
 	ulong fw_len = 0, dt_len = 0, img_len = 0;
-	int idx, conf_noffset;
+	int idx, conf_noffset, noffset;
 	int ret;
 
 	images.verify = CONFIG_IS_ENABLED(FIT_SIGNATURE);
@@ -1096,6 +1119,14 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 		}
 	}
 
+	/* Try to make space, so we can inject details on the loadable */
+	if (spl_image->fdt_addr) {
+		ret = fdt_shrink_to_minimum(spl_image->fdt_addr, 8192);
+		if (ret < 0)
+			log_debug("Failed to prepare FDT for loadables: %d\n",
+				  ret);
+	}
+
 	conf_noffset = fit_conf_get_node((const void *)header,
 					 fit_uname_config);
 	if (conf_noffset < 0)
@@ -1104,17 +1135,34 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	for (idx = 0;
 	     uname = fdt_stringlist_get((const void *)header, conf_noffset,
 					FIT_LOADABLE_PROP, idx,
-				NULL), uname;
+					NULL), uname;
 	     idx++) {
 		images.verify = CONFIG_IS_ENABLED(FIT_SIGNATURE);
 
-		ret = fit_image_load(&images, virt_to_phys((void *)header),
-				     &uname, &fit_uname_config,
-				     IH_ARCH_DEFAULT, IH_TYPE_LOADABLE, -1,
-				     FIT_LOAD_OPTIONAL_NON_ZERO,
-				     &img_data, &img_len);
-		if (ret < 0)
-			return ret;
+		noffset = fit_image_load(&images, virt_to_phys((void *)header),
+					 &uname, &fit_uname_config,
+					 IH_ARCH_DEFAULT, IH_TYPE_LOADABLE, -1,
+					 FIT_LOAD_OPTIONAL_NON_ZERO,
+					 &img_data, &img_len);
+		if (noffset < 0)
+			return noffset;
+
+		/* Record our loadables into the FDT */
+		if (spl_image->fdt_addr) {
+			ulong entry_addr = FDT_ERROR;
+
+			fit_image_get_entry((const void *)header, noffset,
+					    &entry_addr);
+			log_debug("%s entry addr: 0x%lx\n", uname, entry_addr);
+
+			ret = fit_record_loadable((const void *)header, noffset,
+						  idx, uname, img_data, img_len,
+						  entry_addr,
+						  spl_image->fdt_addr);
+			if (ret < 0)
+				log_debug("Couldn't record loadable %s: %d\n",
+					  uname, ret);
+		}
 	}
 	spl_image->flags |= SPL_FIT_FOUND;
 

-- 
2.55.0

