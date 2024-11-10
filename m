Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBADD10C0C
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 11:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB5AA8912B;
	Sun, 10 Nov 2024 12:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cYV0eGcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D02789124; Sun, 10 Nov 2024 12:51:37 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58DB890BC
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 12:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so29691745e9.0
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 03:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731239495; x=1731844295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0gLwx2sIOhKB4xzx5TISFKWF0q3NnvkTmK8wiWVP/OM=;
 b=cYV0eGcUqGXEE9jBuI84D49cFG1Aep3TcH/SZ//UX6LLu7+hb/Lh9N63sqxl8UiDUE
 i7U2cxc7+HJLekgETnsZlUJe7j69c+BZ6U/nLWk9wrDLos3PJoyc8/e1WedUYY1EiDUf
 lNXrD/oV3FGOFxZCVack/bJ8RnFti7H2nASNV8JmGpDLoPlKvJJlPfwcazx3a9uiyI3U
 KsobiCYnugoHBvgJPzgKWTkHeTvBlLGlDVbCfSRCeNxnznCaZp0nn8Mtc1/7/jfpzyF+
 ycvne6JlaYLg1J1BwwT0PGxxqnPVp6hjyjh/ezyR0+ptt3Db9FW85rcrKTWgcsnABkmZ
 Idtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731239495; x=1731844295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gLwx2sIOhKB4xzx5TISFKWF0q3NnvkTmK8wiWVP/OM=;
 b=g/2OpE8C2+aTW/PGFBEjP3y1g7QStlss+mC/FAFVFimoaNAsWsWS51Re1/951TTXd0
 gCE4excSkruNB7nGK3W8k4KbyILnJk4A54NqiddFNT9cjgBM5TTYnFLlYSLWdRq6WHAZ
 0y3NF+fIZKaxHciPp6agqTz/HPgeaphJ5xfy2FOoA/TML0eVBtYUve5K8hHQVFKC++cd
 w+oIfahUT0cGwf9zUfB5INiyJZnSAr5//SKtRbizK70UKt6/RdWMdkTEDq56dasw6cqt
 jZM8WXy/U2zTqdVV2MVMFmdfRDSem/eRk6LA510qu1J95Rtm7oZAYJOD/vqH0XIpAdbP
 z1vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1+Kzta3RNkcUAvmNcrvFkPeu4+zkaRDwq0IrS30syjLlZkMuslijGq1ZtgRSbmI4zWCMXYcA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1EMr/2bI1JoPNuq86KmHJngorquDeJZp3WbLBj2h13OVPWxcf
 hWOiG2crKIIMTehReoUiErV6B2xdy9TIr3itKt0Nk1SdKB5usgNy
X-Google-Smtp-Source: AGHT+IEP7Jv3Sp8X3wgm1vSgYCnlcn88CDt+OBhGfaHYhyHaQFlkPTppbw2uwMcRhoKOPOJaZPjTgQ==
X-Received: by 2002:a05:600c:4f04:b0:431:5194:1687 with SMTP id
 5b1f17b1804b1-432b7509722mr79301295e9.18.1731239495056; 
 Sun, 10 Nov 2024 03:51:35 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm181423745e9.8.2024.11.10.03.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 03:51:34 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v2 5/8] dm: core: implement phandle ofnode_options helper
Date: Sun, 10 Nov 2024 12:50:24 +0100
Message-ID: <20241110115054.2555-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110115054.2555-1-ansuelsmth@gmail.com>
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
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

Implement ofnode_options phandle helper to get an ofnode from a phandle
option in /options/u-boot.

This helper can be useful since new DT yaml usually require to link a
phandle of a node instead of referencing it by name or other indirect
way.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/core/ofnode.c | 15 +++++++++++++++
 include/dm/ofnode.h   | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index dc6ac069311..c8161827d1c 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1871,6 +1871,21 @@ const char *ofnode_options_read_str(const char *prop_name)
 	return ofnode_read_string(uboot, prop_name);
 }
 
+int ofnode_options_get_by_phandle(const char *prop_name, ofnode *nodep)
+{
+	ofnode uboot;
+
+	uboot = ofnode_path("/options/u-boot");
+	if (!ofnode_valid(uboot))
+		return -EINVAL;
+
+	*nodep = ofnode_parse_phandle(uboot, prop_name, 0);
+	if (!ofnode_valid(*nodep))
+		return -EINVAL;
+
+	return 0;
+}
+
 int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
 {
 	int ret;
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index eea6b13217c..890f0e6cf40 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1720,6 +1720,21 @@ int ofnode_options_read_int(const char *prop_name, int default_val);
  */
 const char *ofnode_options_read_str(const char *prop_name);
 
+/**
+ * ofnode_options_get_by_phandle() - Get a ofnode from phandle from the U-Boot options
+ *
+ * This reads a property from the /options/u-boot/ node of the devicetree.
+ *
+ * This only works with the control FDT.
+ *
+ * See dtschema/schemas/options/u-boot.yaml in dt-schema project for bindings
+ *
+ * @prop_name: property name to look up
+ * @nodep: pointer to ofnode where node is stored
+ * Return: 0, if found, or negative error if not
+ */
+int ofnode_options_get_by_phandle(const char *prop_name, ofnode *nodep);
+
 /**
  * ofnode_read_bootscript_address() - Read bootscr-address or bootscr-ram-offset
  *
-- 
2.45.2

