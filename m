Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED50C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3AD287CCC;
	Sun, 17 Dec 2023 17:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j26DgaXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A46E87CB7; Sun, 17 Dec 2023 17:36:43 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35F5D87C8A
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 17:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7b783ee485eso125316139f.0
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 08:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702830999; x=1703435799; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VI8LxKa5FywCvLp9H2NwONCoDqzkU106xCV9zxtmNDo=;
 b=j26DgaXj6e/aH1MROnbFfGb04ENkxlffa207uPeOSJfzvQxxrEDuZaD1sDcHevr9f0
 upawX7ZH5qd1oa32jFGyE8O9ugl8r/5yUixfoYdThTWiRX1ylURS2/SN4x3l9fHpLePA
 NTf4Lqdp9EB0M825hO65zLR7/5fOHEyCWYs1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702830999; x=1703435799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VI8LxKa5FywCvLp9H2NwONCoDqzkU106xCV9zxtmNDo=;
 b=ppLSaQFSVtj8i6OJdRsconIcbiMVkvY3JOWhTjESV/yoAH0SWe+nSw3x4C2FKl7QJj
 FckuKMRg6FpQjFw+Vu7g69q7hh2baB5oAy6HuzCwbNOjKb54jkdpueWOUDtrkOerQbif
 n3nUKEON4wkPI548xa2bh/7ciJb+cpd6Hx+T71jg2F1hbRlqLZcSF4Alo8VRaZz38zwM
 eKVmEcMbwG9163FiqN1os0YlnT6NF1MO4N5RJEE4lNn+vVS7YISfyJ/f992gCacRz2fx
 AI32OhN7V3wgc9P4ELMa8VaV6JwxE31Q5WX+ehhK4RGggGUPqNRO1aWE2L8kKOBr+L3D
 77KA==
X-Gm-Message-State: AOJu0YwwrRg9ZTtimoPF/vNB4RptNb7wXeuLzd9r4o0wn7Olh+B+U6Oo
 xpE9bbx/tuJQTSLjTLGHIuAlRttVzhdFzABUEmVcdw==
X-Google-Smtp-Source: AGHT+IGfPdijUQXgaPjW/blf+qBweVPeK4F8p0O8X1e2+/sETQNDX0L+Cfn1mJcrzN/xs11ZQTFmxg==
X-Received: by 2002:a92:c566:0:b0:35f:88ce:814f with SMTP id
 b6-20020a92c566000000b0035f88ce814fmr4858795ilj.92.1702830999737; 
 Sun, 17 Dec 2023 08:36:39 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ei10-20020a05663829aa00b00466917fbfc4sm4925770jab.71.2023.12.17.08.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 08:36:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 07/10] fdtgrep: Move property checking into a function
Date: Sun, 17 Dec 2023 09:36:20 -0700
Message-ID: <20231217163627.2339802-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231217163627.2339802-1-sjg@chromium.org>
References: <20231217163627.2339802-1-sjg@chromium.org>
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

The h_include() function includes a piece which checks if a node
contains a property being searched for. Move this into its own
function to reduce the size of the h_include() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index b06a1a7a8384..ca639a2d9f4f 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -575,6 +575,40 @@ static int check_type_include(void *priv, int type, const char *data, int size)
 	return 0;
 }
 
+/**
+ * check_props() - Check if a node has properties that we want to include
+ *
+ * Calls check_type_include() for each property in the nodn, returning 1 if
+ * that function returns 1 for any of them
+ *
+ * @disp:	Display structure, holding info about our options
+ * @fdt:	Devicetree blob to check
+ * @node:	Node offset to check
+ * @inc:	Current value of the 'include' variable (see h_include())
+ * Return: 0 to exclude, 1 to include, -1 if no information is available
+ */
+static int check_props(struct display_info *disp, const void *fdt, int node,
+		       int inc)
+{
+	int offset;
+
+	for (offset = fdt_first_property_offset(fdt, node);
+	     offset > 0 && inc != 1;
+	     offset = fdt_next_property_offset(fdt, offset)) {
+		const struct fdt_property *prop;
+		const char *str;
+
+		prop = fdt_get_property_by_offset(fdt, offset, NULL);
+		if (!prop)
+			continue;
+		str = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+		inc = check_type_include(disp, FDT_NODE_HAS_PROP, str,
+					 strlen(str));
+	}
+
+	return inc;
+}
+
 /**
  * h_include() - Include handler function for fdt_first_region()
  *
@@ -617,19 +651,7 @@ static int h_include(void *priv, const void *fdt, int offset, int type,
 	    (disp->types_inc & FDT_NODE_HAS_PROP)) {
 		debug("   - checking node '%s'\n",
 		      fdt_get_name(fdt, offset, NULL));
-		for (offset = fdt_first_property_offset(fdt, offset);
-		     offset > 0 && inc != 1;
-		     offset = fdt_next_property_offset(fdt, offset)) {
-			const struct fdt_property *prop;
-			const char *str;
-
-			prop = fdt_get_property_by_offset(fdt, offset, NULL);
-			if (!prop)
-				continue;
-			str = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
-			inc = check_type_include(priv, FDT_NODE_HAS_PROP, str,
-						 strlen(str));
-		}
+		inc = check_props(disp, fdt, offset, inc);
 		if (inc == -1)
 			inc = 0;
 	}
-- 
2.43.0.472.g3155946c3a-goog

