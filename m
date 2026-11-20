Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62462606A686
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tGBgM9dX;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pLz8K7n5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B560481676;
	Fri, 20 Nov 2026 21:50:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yGsyRgOqbuAN; Fri, 20 Nov 2026 21:50:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B098681763
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795211448;
	b=mtLlMPZzF0JqPHNxFG2d1IEFLVaAFKdCHEbBLYYpB9ckvoH2w+RhisbEUIzjPkFEQXct
	 q7x6ZPB4to5ZdbgBU8ZE2eXHjh5Sgfdha3Q5JYcgAV9avws8jvoXHIPdA8cCwV9kHPzWZ
	 6cPxoIYf5oPTZBBs/CmENCEnVhIdt+kw4Hp85eIMTh38H5XaLCgyO6yMAOY5OzEWgavmW
	 sGd+kVaPlR7nzCsn/Ba4I55Bs/lKRN+rfL5uPod403KgSp5+XpUTQrsxEZ3lQ6LYkacGK
	 Rswj7Ym3wHIFvRrIWGzZitnKJN0k5MGUrvOT/gAg3OWHGDulv/IOY6wohN+eMRXayHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795211448;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cnh4oKsg0iKQSxP9F1HlhZKs0RUiyJyWUOHilORgAN4=;
	b=svRm9M9YEU+suGgjCDzuPMyEge2DpxARBaaKN2yYcBpKlDdxvJZx/zFXOXQ7DQs+NpJZ
	 oTl52L7BSo2cuLat0a9QlyK6opE3AsVn0IACubmfMSqiGmhQpNHN9staN1F4UIuxcrJmi
	 ZOKf9Lx2+Xdox8YA2+SPsalU3i7uhfgbcchxXLb1J3bF0Z+KJ2avcnWHPXkRzTIBEDE0R
	 u9rgPChZcXKtuvcU1K6myJr5i1qLBqgddp8PZJKD1J1fTJ+Ast4lZQc8C6CtnMsodhDCm
	 QLQQqmdZStlBOPRDiHdqpDByMr7vijxpLJttVjsQrzAXZj99OpTj9ABIUWqgNSqiPJw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795211447;
	bh=cnh4oKsg0iKQSxP9F1HlhZKs0RUiyJyWUOHilORgAN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGBgM9dXP4fdnrggAHOLEqYViDV1KdBzKHigo6r2jW/C7wYTVeZ/aqjduD39GSFAh
	 d0wTSnlf0M/IFoTz91KHvV3mfPPvL4SqQ+3NmmXZ2H+N46d5fFXE+oHN7X7NvVn50p
	 +bNokj5EePgciWdD7ZU6ydw04UBg3VnJba2PqUhEgcQgSYRjOoUVbhX7RZgIdwpkh1
	 MGHbMQILyax8yppgi2winkVm/QqPheH8kU8maakwc53eqdP9S60fXxlCMykBeywqdz
	 pqZ1qaRgblnA5pACv1ORhm1B0T/TkcZN1wTHxIer7spQWhtVJeZqFJS4tCjIbhhoeS
	 OdORtKx1VxUJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B098681763;
	Fri, 20 Nov 2026 21:50:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65B28169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 636DA40D91
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7NSA9M6nF1Rj for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:50:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 53E8E40D6C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pLz8K7n5
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53E8E40D6C
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:43 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-717080a2d50so1277526eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795211443; x=1795816243;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cnh4oKsg0iKQSxP9F1HlhZKs0RUiyJyWUOHilORgAN4=;
 b=pLz8K7n5pouFd9LxvXSA+NDnbMNknk48JaxbROn3Kr8KsnufXH6RG9h+S0coX3TzUR
 OvaNz+4Y+0EUl/X5i/wEPJN2nJNMsTCSRw2eQZFclIBZjpQTLjDyu9kUwC1Abkw5vjTl
 C3YouKs8GMESkAvE+tRynbs/ZHs+FEb9KpLXr4yajjCxl4NvE1eYTssUv9Dxjp3IMody
 JWnGkoXcW1B2AB0RkLbd9VEn+E3SfHplIEHejkVvewsdFtIRh/p2F3EIeh+dg5Er9NFI
 naR4GQMrvGBGhmJETqdFVQ9sTLnIRZUrj75/y/7uLndwTHcMj0nGv38x/K65pOrIq2VU
 Jc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211443; x=1795816243;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cnh4oKsg0iKQSxP9F1HlhZKs0RUiyJyWUOHilORgAN4=;
 b=QA2sWIELmNUiFa6FkNT6BGZSn8ORTkvMLVKuSfk6GYYiS+mLvCMyXUpMYK/AJJumYU
 X9s9AigyOQ6NHL4x/HhzDd5nhEFC5qJhZxe7HJl8XlqPQBKlE2K6KZEs8NOccLZNtl9u
 RTxGB2hGkJrTLf+X8g0yojdldrSk99Jl6ta/GTrCV4XsLXuI90bbHc6wNK7YcDY1VTT0
 UPDWZV+7DzWM/b08+VNY4KYvH5CjWjaWlOpOBepz84tcQPE/57UWqhV8JfitJcVGJCvc
 aFg6aiIkmx9ROhOahTuXsmzWzrQboLtaiNhl8vlGCBS34q5QHwsqacw7SB+QT3bCiNH6
 OikQ==
X-Gm-Message-State: APuU4Z8H5uk+ZgwKkcESPaAs/c7x3X91ld38bbI/f104C/WC4etq5v+B
 0/9AulFQct8JQ/YFqfTG0wypWZ9P0+eVVk6JEakxykQsx0/sukHZd9MHZLllX17YIhM=
X-Gm-Gg: AYBFou0gGc75/eziBAEfzLm7q/mJnRmV0KH4m/MT0tEM0KLDxSr57lWtrCS/l9mgCzl
 ezZPm8tDXO/TCh0xJQflvLuJ0LdPS3OptdLKpUurs6eggS7kbaEp+4bNr4m5x3eP1ec795Zf6CQ
 ZAfaA8GvUJwAnGcd2ztAn9daH9+3DXE8DKY+zx8x/PqMfvGvRVxUvPAHsR0JFMJvKqQC3WeKWo2
 NTGaGBUt/eaed0joRiFZAchAKmQ9p854BRvIJDkVNp3Xxzvm9FGw0GTm9nMuZP2xRu7owoYqa2T
 izQW+5+401AHdA1mHY56eYraLZcbksoeaIQMO4+jJBub942y1+4DjK3WFY8f6Zc/puKClUIPwYm
 Cep0OiecyoHwxES+5ft2Ptj6LtBll6kqVq9lx8HXfk4YlQJQ7vuhdUMmK1HXWF54P2aV3/HYLuE
 Dz5qTlVxJqoJXd/7JE/itK64c1g/Ei+BHNEm2EBiRyConMv7geyJSyHPdhK+dpF/W05Ua3ERofo
 hVzzdkQGS3a5WrtcFZoLY65L1mxMcPsqzNSuFhODm+/Wq9Evlab3ZHSMGckWBvBpKrg9CH0ztzU
 ic+ZbR80l6EZ8YQtRQBsrL2qLsbE76J0
X-Received: by 2002:a05:6820:16a5:b0:6e0:8fc2:84b2 with SMTP id
 006d021491bc7-71b3944027amr3396118eaf.20.1795211442726; 
 Fri, 20 Nov 2026 13:50:42 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bd044fc4besm2846726fac.7.2026.11.20.13.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:50:41 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 15:49:28 -0600
Subject: [PATCH v2 1/8] tools: mtk_image: add UFS support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-720-spl-ufs-v2-1-3ef93cb27dcc@baylibre.com>
References: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
In-Reply-To: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7533; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=KIsq74tI81rhPfi/SglIVhlpfY4qACE7zVKqSTXQvZQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMB0+WXiwe7rXlUA73HtPBBkrguxc6kwn4Ial
 aEhjrgCAsiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDAdBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AXsMH/0RsMbCUmORCpvIb0X8X3l25v4fBvd7rUdFuhBU
 zq6ij9LYzjxC1espE+ae2aYapSaeHLVhNAKborJYH5PbFwLe4eQB84RKJ8NWB53x0T2s88JXMPt
 Lr7/KcIjAG5G2z3odKxE6bM7e3OumlGqY+P2phLtwKrVaeBmHnkra0R1YLU0YA67Boz//JM03t2
 Vr5TiOerq2Ebvnag4b+2EMKBwaNUVpuHpXkxGyrynD+Q1yk+cPxmYwtePY8eMjFyRnAYGl6DlE5
 Ra3mFJgq6gh2RjJyXQcXaMnHjz4ejq9wQx19wDor2OVUwl4U79Pm+EkwHSxSbD9GSrZ6Q/VrW+P
 Atzg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fabien Parent <fparent@baylibre.com>

Add support for generating images that can boot on UFS storage for
MediaTek SoCs.

The UFS device header is 4 KiB instead of 1.5 KiB, and the size field
of its generic boot header covers the whole device header.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
[dlechner: rebase, fix header size check when verifying, document the
 ufs media type, fold UFS into the generic header helpers]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/README.mediatek |  1 +
 tools/mtk_image.c   | 60 +++++++++++++++++++++++++++++++++++------------------
 tools/mtk_image.h   | 20 ++++++++++++++++--
 3 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/doc/README.mediatek b/doc/README.mediatek
index 246579d4be2..d38709408b7 100644
--- a/doc/README.mediatek
+++ b/doc/README.mediatek
@@ -107,6 +107,7 @@ To generate these two headers with mkimage:
 		nor  : Serial NOR
 		emmc : eMMC
 		sdmmc: SD
+		ufs  : UFS
 
 	   nandinfo: Desired NAND device type, a combination of page size, oob size and
 		     optional device capacity. Valid types are:
diff --git a/tools/mtk_image.c b/tools/mtk_image.c
index 1b1aed59924..91a715a4b57 100644
--- a/tools/mtk_image.c
+++ b/tools/mtk_image.c
@@ -36,6 +36,9 @@ static const struct brom_img_type {
 	}, {
 		.name = "spim-nand",
 		.type = BRLYT_TYPE_SNAND
+	}, {
+		.name = "ufs",
+		.type = BRLYT_TYPE_UFS
 	}
 };
 
@@ -262,6 +265,8 @@ static int mtk_image_vrec_header(struct image_tool_params *params,
 
 	if (hdr_media == BRLYT_TYPE_NAND || hdr_media == BRLYT_TYPE_SNAND)
 		tparams->header_size = hdr_nand_size;
+	else if (hdr_media == BRLYT_TYPE_UFS)
+		tparams->header_size = sizeof(struct ufs_device_header);
 	else
 		tparams->header_size = sizeof(struct gen_device_header);
 
@@ -295,28 +300,37 @@ static int mtk_image_verify_gfh(struct gfh_header *gfh, uint32_t type, int print
 static int mtk_image_verify_gen_header(const uint8_t *ptr, int print)
 {
 	union gen_boot_header *gbh = (union gen_boot_header *)ptr;
-	uint32_t gfh_offset, total_size, devh_size;
+	uint32_t gfh_offset, total_size, devh_size, gbh_size;
 	struct brom_layout_header *bh;
 	struct gfh_header *gfh;
 	const char *bootmedia;
 
-	if (!strcmp(gbh->name, SF_BOOT_NAME))
+	devh_size = sizeof(struct gen_device_header);
+	gbh_size = sizeof(union gen_boot_header);
+
+	if (!strcmp(gbh->name, SF_BOOT_NAME)) {
 		bootmedia = "Serial NOR";
-	else if (!strcmp(gbh->name, EMMC_BOOT_NAME))
+	} else if (!strcmp(gbh->name, EMMC_BOOT_NAME)) {
 		bootmedia = "eMMC";
-	else if (!strcmp(gbh->name, SDMMC_BOOT_NAME))
+	} else if (!strcmp(gbh->name, SDMMC_BOOT_NAME)) {
 		bootmedia = "SD/MMC";
-	else
+	} else if (!strcmp(gbh->name, UFS_BOOT_NAME)) {
+		bootmedia = "UFS";
+		devh_size = sizeof(struct ufs_device_header);
+		/* For UFS, the size covers the whole device header */
+		gbh_size = devh_size;
+	} else {
 		return -1;
+	}
 
 	if (print)
 		printf("Boot Media:   %s\n", bootmedia);
 
 	if (le32_to_cpu(gbh->version) != 1 ||
-	    le32_to_cpu(gbh->size) != sizeof(union gen_boot_header))
+	    le32_to_cpu(gbh->size) != gbh_size)
 		return -1;
 
-	bh = (struct brom_layout_header *)(ptr + le32_to_cpu(gbh->size));
+	bh = (struct brom_layout_header *)(ptr + sizeof(union gen_boot_header));
 
 	if (strcmp(bh->name, BRLYT_NAME))
 		return -1;
@@ -324,11 +338,10 @@ static int mtk_image_verify_gen_header(const uint8_t *ptr, int print)
 	if (le32_to_cpu(bh->magic) != BRLYT_MAGIC ||
 	    (le32_to_cpu(bh->type) != BRLYT_TYPE_NOR &&
 	    le32_to_cpu(bh->type) != BRLYT_TYPE_EMMC &&
-	    le32_to_cpu(bh->type) != BRLYT_TYPE_SDMMC))
+	    le32_to_cpu(bh->type) != BRLYT_TYPE_SDMMC &&
+	    le32_to_cpu(bh->type) != BRLYT_TYPE_UFS))
 		return -1;
 
-	devh_size = sizeof(struct gen_device_header);
-
 	if (img_gen) {
 		gfh_offset = devh_size;
 	} else {
@@ -625,37 +638,44 @@ static void put_hash(uint8_t *buff, int size)
 static void mtk_image_set_gen_header(void *ptr, off_t filesize,
 				     uint32_t loadaddr)
 {
+	/* The UFS device header only has a bigger BRLYT area */
 	struct gen_device_header *hdr = (struct gen_device_header *)ptr;
+	uint32_t devh_size = sizeof(struct gen_device_header);
+	uint32_t gbh_size = sizeof(hdr->boot);
 	struct gfh_header *gfh;
 	const char *bootname = NULL;
 
-	if (hdr_media == BRLYT_TYPE_NOR)
+	if (hdr_media == BRLYT_TYPE_NOR) {
 		bootname = SF_BOOT_NAME;
-	else if (hdr_media == BRLYT_TYPE_EMMC)
+	} else if (hdr_media == BRLYT_TYPE_EMMC) {
 		bootname = EMMC_BOOT_NAME;
-	else if (hdr_media == BRLYT_TYPE_SDMMC)
+	} else if (hdr_media == BRLYT_TYPE_SDMMC) {
 		bootname = SDMMC_BOOT_NAME;
+	} else if (hdr_media == BRLYT_TYPE_UFS) {
+		bootname = UFS_BOOT_NAME;
+		devh_size = sizeof(struct ufs_device_header);
+		/* For UFS, the size covers the whole device header */
+		gbh_size = devh_size;
+	}
 
 	/* Generic device header */
 	snprintf(hdr->boot.name, sizeof(hdr->boot.name), "%s", bootname);
 	hdr->boot.version = cpu_to_le32(1);
-	hdr->boot.size = cpu_to_le32(sizeof(hdr->boot));
+	hdr->boot.size = cpu_to_le32(gbh_size);
 
 	/* BRLYT header */
 	put_brom_layout_header(&hdr->brlyt, hdr_media);
-	hdr->brlyt.header_size = cpu_to_le32(hdr_offset + sizeof(*hdr));
+	hdr->brlyt.header_size = cpu_to_le32(hdr_offset + devh_size);
 	hdr->brlyt.total_size = cpu_to_le32(hdr_offset + filesize);
 	hdr->brlyt.header_size_2 = hdr->brlyt.header_size;
 	hdr->brlyt.total_size_2 = hdr->brlyt.total_size;
 
 	/* GFH header */
-	gfh = (struct gfh_header *)(ptr + sizeof(struct gen_device_header));
-	put_ghf_header(gfh, filesize, sizeof(struct gen_device_header),
-		       loadaddr, GFH_FLASH_TYPE_GEN);
+	gfh = (struct gfh_header *)(ptr + devh_size);
+	put_ghf_header(gfh, filesize, devh_size, loadaddr, GFH_FLASH_TYPE_GEN);
 
 	/* Generate SHA256 hash */
-	put_hash((uint8_t *)gfh,
-		 filesize - sizeof(struct gen_device_header) - SHA256_SUM_LEN);
+	put_hash((uint8_t *)gfh, filesize - devh_size - SHA256_SUM_LEN);
 }
 
 static void mtk_image_set_nand_header(void *ptr, off_t filesize,
diff --git a/tools/mtk_image.h b/tools/mtk_image.h
index 54a838de863..01037e99e32 100644
--- a/tools/mtk_image.h
+++ b/tools/mtk_image.h
@@ -11,7 +11,7 @@
 
 /* Device header definitions, all fields are little-endian */
 
-/* Header for NOR/SD/eMMC */
+/* Header for NOR/SD/eMMC/UFS */
 union gen_boot_header {
 	struct {
 		char name[12];
@@ -25,6 +25,7 @@ union gen_boot_header {
 #define EMMC_BOOT_NAME		"EMMC_BOOT"
 #define SF_BOOT_NAME		"SF_BOOT"
 #define SDMMC_BOOT_NAME		"SDMMC_BOOT"
+#define UFS_BOOT_NAME		"UFS_BOOT"
 
 /* BootROM layout header */
 struct brom_layout_header {
@@ -48,7 +49,8 @@ enum brlyt_img_type {
 	BRLYT_TYPE_EMMC = 0x10005,
 	BRLYT_TYPE_NOR = 0x10007,
 	BRLYT_TYPE_SDMMC = 0x10008,
-	BRLYT_TYPE_SNAND = 0x10009
+	BRLYT_TYPE_SNAND = 0x10009,
+	BRLYT_TYPE_UFS = 0x1000c
 };
 
 /* Combined device header for NOR/SD/eMMC */
@@ -61,6 +63,20 @@ struct gen_device_header {
 	};
 };
 
+/*
+ * Device header for UFS: the same as for NOR/SD/eMMC, but 4 KiB in total, one
+ * UFS logical block, so the BRLYT header has 0xE00 bytes after the 0x200 of
+ * the generic boot header.
+ */
+struct ufs_device_header {
+	union gen_boot_header boot;
+
+	union {
+		struct brom_layout_header brlyt;
+		uint8_t brlyt_pad[0xE00];
+	};
+};
+
 /* BootROM header definitions */
 struct gfh_common_header {
 	uint32_t magic_version;

-- 
2.53.0

