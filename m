Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E13D3C931
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 11:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C888890C6;
	Sun, 10 Nov 2024 12:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YQO3ivkU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D7C8911A; Sun, 10 Nov 2024 12:51:33 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C058908A
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 12:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-431688d5127so28046855e9.0
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 03:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731239491; x=1731844291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sNqtkOshP4DGaFGAoBHz+sxnWFsqVVeDprbQTP8aqp4=;
 b=YQO3ivkUcq3uWUt6Dv55Qtdq+t3wLnX3dCDF0oOA/D18S0zd5rikXoebKelw3GiBRG
 JL5FHN2avDr1HwDC2AujJI2JJkXqYL5lixqfpyqXfs1Hs3qUtXVkdsOwYwSSlxbQ1VNh
 EaN3Qx5h6Ktzne4BpFfvm9WuVW0QlLu3Mt1Kg6vaDuj10JMQr3sUpJTDwBFtmRXGBIW5
 6bUakzTjh+5V61RhzdjP3bWcUw/Nm6dOLTKbr+8ml/OfLRjJUXXJJujgAaXOMncIIzGB
 1CNtGweQ29tcdOyH0uvOLl/wX5wTzxo8SQ8rOXJ5UEhmaaZGLPznjWhPRSWAG+n3bcr8
 H5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731239491; x=1731844291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNqtkOshP4DGaFGAoBHz+sxnWFsqVVeDprbQTP8aqp4=;
 b=ez6K8tdQCYRG1F4iYXZq9cCe5mwDpy7Gtw91pEnk70jOpmyX8slJCLGkbIF7CZBQwh
 mHAUtzxm6rIZLYk0qjz0hVmhi+XpuFMw9UZ176M0YQLLHCqmq+Q/SuIixp+e8/hUw10g
 4eRJnDNoE+cSbJvaLsxlktj17kTMSZn+JmIpYYw0VuzhC9pss73MUQkKWDUkgrgg2Xld
 oFVRfv58Ode7tgjZ9EHcJMpypNfuXCc0LoaWzG3eAJjNQrL4FdAh2m8nFL8fsx7k74nR
 JOm/6oJ3Xh+t3MYBqPPR7Kz4ouOrqpDq8a5h2L7lGoft5iHIti4w3ZQj8GeH6nLM1J7V
 kwgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuGYNwMMk/cGjWKY0DL8TFPzmiuvGMFyZ6QuDczFGVHwLJY+1hLaLMVScXw5Ch2bqkVfin8KA=@lists.denx.de
X-Gm-Message-State: AOJu0YzO8ugJcrpG7F8XQ03PN9yaRF4C1F8YOwSoxFUXsv03+yiDOz41
 TW12WOCSXgA2OB5LOG6x496XKhKRyttOjvwrJi2apqeSC4ohTcSz
X-Google-Smtp-Source: AGHT+IGbMuLC6pYz/2EYUs6GgGLaqGFVcek1pCj8L+jKSo5LYGpuNr4KmFEXHwn37XAQQ8XjVGdQsw==
X-Received: by 2002:a05:600c:8608:b0:431:4c14:abf4 with SMTP id
 5b1f17b1804b1-432b7887154mr75786495e9.14.1731239490931; 
 Sun, 10 Nov 2024 03:51:30 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm181423745e9.8.2024.11.10.03.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 03:51:30 -0800 (PST)
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
Subject: [PATCH v2 3/8] dm: core: implement ofnode/tree_parse_phandle() helper
Date: Sun, 10 Nov 2024 12:50:22 +0100
Message-ID: <20241110115054.2555-4-ansuelsmth@gmail.com>
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

Implement ofnode/tree_parse_phandle() helper as an equivalent of
of_parse_phandle to handle simple single value phandle.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/core/ofnode.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 include/dm/ofnode.h   | 26 +++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index b9cc9419407..dc6ac069311 100644
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
+		phandle = noffset_to_ofnode(node, args.node);
+	}
+
+	return phandle;
+}
+
 static void ofnode_from_fdtdec_phandle_args(ofnode node, struct fdtdec_phandle_args *in,
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

