Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA67C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 14:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18941877C8;
	Thu, 11 Jan 2024 15:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bKlmVlha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D69F87885; Thu, 11 Jan 2024 15:39:44 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0E458765B
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 15:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e5f615a32so6616945e9.1
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 06:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983981; x=1705588781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzTzR5VNiT0R5wEPYpe09GvA11cdNr11PvYP0OyMppI=;
 b=bKlmVlhaG/RTMuRbxSY/Gmu41zYMmVadbtXTrRWDh137EAp5ZgoVPGiCdCYYCmChOC
 FpWspjBOnFIxUD3Fp5K3DVcWtZitY3ZSfZB3wg5o3LraFKc1TUUokuUy7r6bOGs2mGjs
 74Cogu07g5YcuBy9SIfvqRqP6ZbOQ96LAc395NwzSqIzmjOcyZ8QaWYfoFEK2PGr/vK+
 taPs+6Ixai2IaRc1YsEvE6aF83X/TxFSwHhGJT/YM3r8gbyBY5eEvlrd+ulBvIRrZfCQ
 XjRfr7cE6itAvckibl+S6mePh/BxlbmrioxYcYkS30ATCD+J5tnUzrEqeSm31AJJp7+S
 h9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983981; x=1705588781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzTzR5VNiT0R5wEPYpe09GvA11cdNr11PvYP0OyMppI=;
 b=cwjGi3yTYfAEmn5bg/6v8YEPM35S1s5bjINNCRHFV16sctlsxBRdDnqw4tybg93kx0
 j6FE+QE73sFaDYo/TzGBO0tmWUayV1oCFcFsN2cd/ZAZPbR/oqRXeNhu8aAUt2l9cgwN
 mgmpPFD17ZLLOZVCXx4N0O8IZrwn/irAlAFdu+DJvPtjOF7NpP1ZVTrYQm4SH7hwy2G4
 l2Ecq3z4tQ5sfmiW6gOiu4yL7QIigQMl0c3sWUheMJAeWoEy58cYxh4ajGAdIUiS4PnA
 wrx1zmL65JZ0fObYh9jbJRHaH50TuP1jlem4jrVd9ykwNbZzOqqfjyqK34owxTGmGq9L
 bT2g==
X-Gm-Message-State: AOJu0Yx3UK2bIlPxJMyCXjuqpLSGej0x2nWRtG2xbg+2BzVTu4mU/go/
 oNGimLrUOOlvMAlN1vs1NKzGJIfh+XwW0LOCL8y4ttUa/Pg=
X-Google-Smtp-Source: AGHT+IGuCuFcB7KcOX9OMPaY4mBVTVw6fLKfCna/g99fhTl2dERRNSVR5pc9wB40va6aZu75sHV2iw==
X-Received: by 2002:a05:600c:4e14:b0:40e:567f:38d7 with SMTP id
 b20-20020a05600c4e1400b0040e567f38d7mr265434wmq.225.1704983981314; 
 Thu, 11 Jan 2024 06:39:41 -0800 (PST)
Received: from hades.. (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 j25-20020a1709066dd900b00a26af4d96c6sm655062ejt.4.2024.01.11.06.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:39:41 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 2/2] smbios: fix matching issues for table types
Date: Thu, 11 Jan 2024 16:39:36 +0200
Message-Id: <20240111143936.983448-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240111143936.983448-1-ilias.apalodimas@linaro.org>
References: <20240111143936.983448-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

commit 738b34668f28 ("smbios: Fallback to the default DT if sysinfo nodes are missing")
allowed the code to fallback and fill in SMBIOS tables with properties
from the compatible and product nodes of the DT, in case the
'smbios,sysinfo' node is missing.
That works fine for Type1/2 tables, but for other types we need to
match the smbios,sysinfo subnode name as well. So add it to the
smbios_ctx and check it during the sysinfo <-> DT mathcing

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
We still lack selftests for smbios code.
Heinrich started an effort here [0]. I'll update that once his series gets merged

[0]
https://lore.kernel.org/u-boot/20231223004429.247301-4-xypron.glpk@gmx.de/#t

 lib/smbios.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 47db410a2141..64e65bfd6f93 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -54,32 +54,38 @@ DECLARE_GLOBAL_DATA_PTR;
  *
  */
 struct map_sysinfo {
+	const char *si_node;
 	const char *si_str;
 	const char *dt_str;
 	int max;
 };

 static const struct map_sysinfo sysinfo_to_dt[] = {
-	{ .si_str = "product", .dt_str = "model", 2 },
-	{ .si_str = "manufacturer", .dt_str = "compatible", 1 },
+	{ .si_node = "system", .si_str = "product", .dt_str = "model", 2 },
+	{ .si_node = "system", .si_str = "manufacturer", .dt_str = "compatible", 1 },
+	{ .si_node = "baseboard", .si_str = "product", .dt_str = "model", 2 },
+	{ .si_node = "baseboard", .si_str = "manufacturer", .dt_str = "compatible", 1 },
 };

 /**
  * struct smbios_ctx - context for writing SMBIOS tables
  *
- * @node:	node containing the information to write (ofnode_null() if none)
- * @dev:	sysinfo device to use (NULL if none)
- * @eos:	end-of-string pointer for the table being processed. This is set
- *		up when we start processing a table
- * @next_ptr:	pointer to the start of the next string to be added. When the
- *		table is nopt empty, this points to the byte after the \0 of the
- *		previous string.
- * @last_str:	points to the last string that was written to the table, or NULL
- *		if none
+ * @node:		node containing the information to write (ofnode_null()
+ *			if none)
+ * @dev:		sysinfo device to use (NULL if none)
+ * @subnode_name:	sysinfo subnode_name. Used for DT fallback
+ * @eos:		end-of-string pointer for the table being processed.
+ *			This is set up when we start processing a table
+ * @next_ptr:		pointer to the start of the next string to be added.
+ *			When the table is not empty, this points to the byte
+ *			after the \0 of the previous string.
+ * @last_str:		points to the last string that was written to the table,
+ *			or NULL if none
  */
 struct smbios_ctx {
 	ofnode node;
 	struct udevice *dev;
+	const char *subnode_name;
 	char *eos;
 	char *next_ptr;
 	char *last_str;
@@ -108,12 +114,13 @@ struct smbios_write_method {
 	const char *subnode_name;
 };

-static const struct map_sysinfo *convert_sysinfo_to_dt(const char *si)
+static const struct map_sysinfo *convert_sysinfo_to_dt(const char *node, const char *si)
 {
 	int i;

 	for (i = 0; i < ARRAY_SIZE(sysinfo_to_dt); i++) {
-		if (!strcmp(si, sysinfo_to_dt[i].si_str))
+		if (node && !strcmp(node, sysinfo_to_dt[i].si_node) &&
+		    !strcmp(si, sysinfo_to_dt[i].si_str))
 			return &sysinfo_to_dt[i];
 	}

@@ -233,7 +240,7 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
 		} else {
 			const struct map_sysinfo *nprop;

-			nprop = convert_sysinfo_to_dt(prop);
+			nprop = convert_sysinfo_to_dt(ctx->subnode_name, prop);
 			get_str_from_dt(nprop, str_dt, sizeof(str_dt));
 			str = (const char *)str_dt;
 		}
@@ -574,9 +581,13 @@ ulong write_smbios_table(ulong addr)
 		int tmp;

 		method = &smbios_write_funcs[i];
-		if (IS_ENABLED(CONFIG_OF_CONTROL) && method->subnode_name)
-			ctx.node = ofnode_find_subnode(parent_node,
-						       method->subnode_name);
+		ctx.subnode_name = NULL;
+		if (method->subnode_name) {
+			ctx.subnode_name = method->subnode_name;
+			if (IS_ENABLED(CONFIG_OF_CONTROL))
+				ctx.node = ofnode_find_subnode(parent_node,
+							       method->subnode_name);
+		}
 		tmp = method->write((ulong *)&addr, handle++, &ctx);

 		max_struct_size = max(max_struct_size, tmp);
--
2.37.2

