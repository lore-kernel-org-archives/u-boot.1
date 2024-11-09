Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBB3D5E37A
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 18:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC49E89274;
	Sat,  9 Nov 2024 19:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NNPwdDVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646C389048; Sat,  9 Nov 2024 19:01:17 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE4B89145
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 19:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso18522105e9.1
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 10:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731175273; x=1731780073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SZ+ot6RXhVf2YFVz3WJwnDv+QHsTg1lURx7UI1iVHl8=;
 b=NNPwdDVrh34y9V1H1wt5yr9ifB1eRLupuvxxRS1LOXaNS9gkWpNlXZWv4Nsbo15Fgm
 rfzc/d5QTOf7fv6Wp73owWmNXj3FfQEyyCetk5XBtX6EVfDTRdIKCkhMfSepp/f00/0I
 22YneZm1VZxI4hla0rvZurXLksaujPigY+Dq2RvEUxeQFx68TjqsG8ZCiyxOZXgI3iF+
 l0L9Q4onKEVizr4Q3dxOcWisAzHhjYNn6glxuvjVAFGUD7NZLtC/D9G618/oQoi4FNMb
 O3dYRF5UQ89d/TC0n/+rvo2abw/NhptRzYnOmIiW1v0TqA9u9CW//ToZwMoeZXOtNPdD
 dpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731175273; x=1731780073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZ+ot6RXhVf2YFVz3WJwnDv+QHsTg1lURx7UI1iVHl8=;
 b=k4sqj+d2YmXf4Z29SZwJJh3YAX1+OmSgPUaExMOgE2YlKVShCt9jMMtdoW6jMRx/Fz
 kr2A3Hp40DABJDqMRSPvDNjRLK3ESYWfu11Xi4orrAV3G5ASV4v/pEWO+pju5DBwXCbA
 MJvZ7YloOu0GOmB/ZHpivC2FUzVE6OKXJ0gF7t4BTwI0kKlV73uN+JaZvh8+Cp4IL99S
 Q19D31JisrXX8gO0iLnQsurHtjw30dT3tgOfVKX5j/ce69sulodrUABjFJoRYdtGXznE
 PoKNDo1xllzxKc3UU1+DMY+cXf10gyS3X7aTKAeTXI5gszKCL+ORfW+bnF9DdCxhYikY
 iBPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjXxIH/9UqgZTFluPH8qH9/eW29Ne3R52bkE7Alkb/UKdk/lbg61fDFlMGWJ62FtEfDMGlR7Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyI/GlYggQaPoWwYRA1A3ckofv+Dc5SptcVY5rr4XAOzR2+YXbT
 +opXtkfkYnYmH5aXX+x35eGYJaBVUZF7SXz5xWk4FDEnF8SfmpuN
X-Google-Smtp-Source: AGHT+IFLQ1jvsIn8BkcEVUlwqPsnqEAv/e/OpWiAM1k5lDPp7CEWWX/sqtH2CIKizq2xzjhb2N7drQ==
X-Received: by 2002:a05:600c:3b11:b0:431:416e:2603 with SMTP id
 5b1f17b1804b1-432b684f334mr70101675e9.3.1731175273125; 
 Sat, 09 Nov 2024 10:01:13 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa73a2d8sm146095025e9.41.2024.11.09.10.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 10:01:12 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH 3/8] dm: core: implement ofnode/tree_parse_phandle() helper
Date: Sat,  9 Nov 2024 19:00:28 +0100
Message-ID: <20241109180038.10344-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241109180038.10344-1-ansuelsmth@gmail.com>
References: <20241109180038.10344-1-ansuelsmth@gmail.com>
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

Implement ofnode/tree_parse_phandle() helper as an equivalent of
of_parse_phandle to handle simple single value phandle.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/core/ofnode.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 include/dm/ofnode.h   | 26 +++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index a2136f61b7d..774b428c43f 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -879,6 +879,64 @@ int ofnode_read_string_list(ofnode node, const char *property,
 	return count;
 }
 
+ofnode ofnode_parse_phandle(ofnode node, const char *phandle_name,
+			    int index)
+{
+	ofnode phandle;
+
+	if (ofnode_is_np(node)) {
+		struct device_node *np;
+
+		np = of_parse_phandle(ofnode_to_np(node), phandle_name,
+				      index);
+		if (!np)
+			return ofnode_null();
+
+		phandle = np_to_ofnode(np);
+	} else {
+		struct fdtdec_phandle_args args;
+
+		if (fdtdec_parse_phandle_with_args(ofnode_to_fdt(node),
+						   ofnode_to_offset(node),
+						   phandle_name, NULL,
+						   0, index, &args))
+			return ofnode_null();
+
+		phandle = offset_to_ofnode(args.node);
+	}
+
+	return phandle;
+}
+
+ofnode oftree_parse_phandle(oftree tree, ofnode node, const char *phandle_name,
+			    int index)
+{
+	ofnode phandle;
+
+	if (ofnode_is_np(node)) {
+		struct device_node *np;
+
+		np = of_root_parse_phandle(tree.np, ofnode_to_np(node),
+					   phandle_name, index);
+		if (!np)
+			return ofnode_null();
+
+		phandle = np_to_ofnode(np);
+	} else {
+		struct fdtdec_phandle_args args;
+
+		if (fdtdec_parse_phandle_with_args(tree.fdt,
+						   ofnode_to_offset(node),
+						   phandle_name, NULL,
+						   0, index, &args))
+			return ofnode_null();
+
+		phandle = offset_to_ofnode(args.node);
+	}
+
+	return phandle;
+}
+
 static void ofnode_from_fdtdec_phandle_args(struct fdtdec_phandle_args *in,
 					    struct ofnode_phandle_args *out)
 {
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 7ece68874ae..eea6b13217c 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -847,6 +847,18 @@ int ofnode_read_string_count(ofnode node, const char *property);
 int ofnode_read_string_list(ofnode node, const char *property,
 			    const char ***listp);
 
+/**
+ * ofnode_parse_phandle() - Resolve a phandle property to an ofnode
+ *
+ * @node: node to check
+ * @phandle_name: Name of property holding a phandle value
+ * @index: For properties holding a table of phandles, this is the index into
+ *         the table
+ * Return: ofnode that the phandle points to or ofnode_null() on error.
+ */
+ofnode ofnode_parse_phandle(ofnode node, const char *phandle_name,
+			    int index);
+
 /**
  * ofnode_parse_phandle_with_args() - Find a node pointed by phandle in a list
  *
@@ -909,6 +921,20 @@ int ofnode_parse_phandle_with_args(ofnode node, const char *list_name,
 int ofnode_count_phandle_with_args(ofnode node, const char *list_name,
 				   const char *cells_name, int cell_count);
 
+/**
+ * oftree_parse_phandle() - Resolve a phandle property to an ofnode
+ *			    from a root node
+ *
+ * @tree: device tree to use
+ * @node: node to check
+ * @phandle_name: Name of property holding a phandle value
+ * @index: For properties holding a table of phandles, this is the index into
+ *         the table
+ * Return: ofnode that the phandle points to or ofnode_null() on error.
+ */
+ofnode oftree_parse_phandle(oftree tree, ofnode node, const char *phandle_name,
+			    int index);
+
 /**
  * oftree_parse_phandle_with_args() - Find a node pointed by phandle in a list
  *				      from a root node
-- 
2.45.2

