Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F32C61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 06:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56EF240755;
	Wed,  2 Sep 2026 06:31:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_SCftIry7Z8; Wed,  2 Sep 2026 06:31:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788330683;
	bh=qA34UgbRhf96XQgQdQWezN2QKyeyCWDv2JyAbHqoGrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T8LMdDMQiDNrj91yc0jRuQfc/EktZKhHIctBtQreJ4WUHy9BCcE5ztmP21b3lqjTX
	 TtJUH3pPdeHAWDRlkIJPioo3sKsy0Awjodr8f6Wwc3N4BzX1zQm3tEqy1Cb/lgq0Gt
	 vsi46/saT8WVlWb6iJIAU2j6M2qcITHEg/5kLv2u15/cfk5PBV4Qgb3Ufeuj4+JYL8
	 BVhpFjOm16SjUUC1S9JDm2m4gml7GQwsaUo34bajj2I4NmH0/dx21GNbDj/ZBTqJem
	 l0nwj9qus4fukljwLFwP7PVO+/ZZhtswbM2LHQi0be64TCaHyuPS6pQ4OMkM672Iri
	 ndW2JmiLqITqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A881F4077C;
	Wed,  2 Sep 2026 06:31:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B6D5E2FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C9A04077C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XtFtO9OkkqR for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 06:31:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.85;
 helo=forward102a.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=OgNHwewL
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net
 [178.154.239.85])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7758740755
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:18 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c17:2010:0:640:2180:0])
 by forward102a.mail.yandex.net (postfix) with ESMTPS id 526C1C0058;
 Wed, 02 Sep 2026 09:31:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id 9VdE69DeMiE0-5a47BnhM; 
 Wed, 02 Sep 2026 09:31:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788330675; bh=qA34UgbRhf96XQgQdQWezN2QKyeyCWDv2JyAbHqoGrI=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=OgNHwewLPSacsRLMeUJs+VOuYtq3MOAHdstYIyr5gyHtq4su0LYDppSmvY4gaupRX
 4veIOyKjmD50cHjnwYHRz7ZNzX40YMkyOGa3SB7jjiRgq1V/OUQ70aj4lIIYK2xjKv
 6gBJe79sFlu+6Z9di8fB741Twl8aR52Do9lKL3bg=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Wed, 02 Sep 2026 09:31:15 +0300
Subject: [PATCH v2 5/6] spl: fit: Record loadables to spl_image->fdt_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-riscv-full-fit-support-v2-5-493e904a129e@maquefel.me>
References: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
In-Reply-To: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788330671; l=4388;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=WMugL8t0yAdEbcw6y6Poa2TD6mxxBdV+Gm5Ciux8W0c=;
 b=jgx78uMeZWacBAQ01+UVCIut+sXN3Cx8a3dFcr2ivDSZ2AnsSpfmycaYG3CTgDleYc2wDBwLs
 pkkhChmmFEtCcPX6YXmmA9U7/vwdn/ArhKHlQ6qvNRw810u0AGNporD
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
 common/spl/spl_fit.c | 62 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 4d4a96d1c4c..a0aa91f0725 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -550,6 +550,17 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 	return ret;
 }
 
+static int fit_record_loadable(const void *fit, int node, int idx, const char *name,
+			       ulong load_addr, ulong size, ulong entry_point,
+			       void *fdt_blob)
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
@@ -563,13 +574,9 @@ static int spl_fit_record_loadable(const struct spl_fit_info *ctx, int index,
 
 	node = spl_fit_get_image_node(ctx, "loadables", index);
 
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
@@ -991,7 +998,7 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	const char *uname;
 	ulong fw_data = 0, dt_data = 0, img_data = 0;
 	ulong fw_len = 0, dt_len = 0, img_len = 0;
-	int idx, conf_noffset;
+	int idx, conf_noffset, noffset;
 	int ret;
 
 	images.verify = CONFIG_IS_ENABLED(FIT_SIGNATURE);
@@ -1040,6 +1047,13 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 		}
 	}
 
+	/* Try to make space, so we can inject details on the loadable */
+	if (spl_image->fdt_addr) {
+		ret = fdt_shrink_to_minimum(spl_image->fdt_addr, 8192);
+		if (ret < 0)
+			log_debug("Failed to prepare FDT for loadables: %d\n", ret);
+	}
+
 	conf_noffset = fit_conf_get_node((const void *)header,
 					 fit_uname_config);
 	if (conf_noffset < 0)
@@ -1048,17 +1062,33 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
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
+			fit_image_get_entry((const void *)header, noffset, &entry_addr);
+			log_debug("record_loadable: %s entry addr: 0x%lx\n",
+				  uname, entry_addr);
+
+			ret = fit_record_loadable((const void *)header, noffset,
+						  idx, uname, img_data, img_len,
+						  entry_addr, spl_image->fdt_addr);
+			if (ret < 0)
+				log_debug("record_loadable: couldn't "
+					  "record loadable: %s\n", uname);
+		}
 	}
 	spl_image->flags |= SPL_FIT_FOUND;
 

-- 
2.54.0

