Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF13CCE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BBA186C20;
	Tue, 19 Sep 2023 20:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mcvWqlqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E72386C13; Tue, 19 Sep 2023 20:09:45 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A36486BEA
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34fdd6d2dabso9719505ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146982; x=1695751782; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDFYjObn653xWhNnkKZSf08hlaR6kRRYpb5UOuOlbic=;
 b=mcvWqlqru9Ut3P+BMQlu7GdxKOU+dhwI8kzu6ZmtGUYk5vDFTItNimEHF+yvglrpUt
 eiR2syCsodg+roSs9yMuXovhqz1S+lB1E6RsmaAmzq0NWvKmm4mdmtlmSsy6zsQqDFh5
 OJDio70wlNNbqbMyUUAf2djLSkqpaM4QxI1K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146982; x=1695751782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDFYjObn653xWhNnkKZSf08hlaR6kRRYpb5UOuOlbic=;
 b=Ir0qsaIVB0KD/qa5VAIadEHTUBtLEm94XyGhO2rR2fBT/vNGuVjTV7G+/5t2ukpfy1
 E2k7iu5XiHin4rVL4hnQ/CH2JMMqhMbbw79d0T1g5+/d3owg1HRR6uwUMSix6fGOCRVa
 Kz4Fvh9TdAH5hwJvGgUveHEwqvLjaP41U3FRsNY4F1MYXbPcMr/rCuf0DYEIsEyMWbfL
 o4Q1+Wt1iz80ogw66aYreHVV2t4fuFf1MNmqQ+vf3trI01OMCxdfL6geNwiPh6gvB+Jx
 stYfsvaDhSvtW3s5g9dNh7fsO8nBWDBKqDBiZFSNvO0RhsZPj5TXJfN1R2l58WbyDttR
 ICwA==
X-Gm-Message-State: AOJu0YyH055K2oYjWEIYF6zQRPZUgAQw595SGli4oLe++i9mX5fFk9hB
 yvtlt15Pz1f5Ibv2y2Pnvlbg/q+ne4R8TjbtNcI=
X-Google-Smtp-Source: AGHT+IG9cOJwzV9OlShGssNNQSAjTKPtCNnd7G4x0/lmByAoEClJqQeDW1Lk0lgfz8574fxM1H5g0A==
X-Received: by 2002:a05:6e02:4c9:b0:348:cd6b:d593 with SMTP id
 f9-20020a056e0204c900b00348cd6bd593mr542652ils.27.1695146982053; 
 Tue, 19 Sep 2023 11:09:42 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 18/36] expo: Add better error reporting
Date: Tue, 19 Sep 2023 12:08:48 -0600
Message-ID: <20230919180918.2904313-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

When building an expo fails, show some information about which node
caused the problem. Use -ENOENT consistently when the ID is missing.
This makes it easier for the user to debug things.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/expo_build.c | 58 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/boot/expo_build.c b/boot/expo_build.c
index bb33cc2a33f..48ed31d5b32 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -23,10 +23,14 @@
  *	if there is nothing for this ID. Since ID 0 is never used, the first
  *	element of this array is always NULL
  * @str_count: Number of entries in @str_for_id
+ * @err_node: Node being processed (for error reporting)
+ * @err_prop: Property being processed (for error reporting)
  */
 struct build_info {
 	const char **str_for_id;
 	int str_count;
+	ofnode err_node;
+	const char *err_prop;
 };
 
 /**
@@ -46,6 +50,7 @@ int add_txt_str(struct build_info *info, ofnode node, struct scene *scn,
 	uint str_id;
 	int ret;
 
+	info->err_prop = find_name;
 	text = ofnode_read_string(node, find_name);
 	if (!text) {
 		char name[40];
@@ -54,7 +59,7 @@ int add_txt_str(struct build_info *info, ofnode node, struct scene *scn,
 		snprintf(name, sizeof(name), "%s-id", find_name);
 		ret = ofnode_read_u32(node, name, &id);
 		if (ret)
-			return log_msg_ret("id", -EINVAL);
+			return log_msg_ret("id", -ENOENT);
 
 		if (id >= info->str_count)
 			return log_msg_ret("id", -E2BIG);
@@ -164,9 +169,10 @@ static int read_strings(struct build_info *info, ofnode root)
 		int ret;
 		u32 id;
 
+		info->err_node = node;
 		ret = ofnode_read_u32(node, "id", &id);
 		if (ret)
-			return log_msg_ret("id", -EINVAL);
+			return log_msg_ret("id", -ENOENT);
 		val = ofnode_read_string(node, "value");
 		if (!val)
 			return log_msg_ret("val", -EINVAL);
@@ -241,6 +247,8 @@ static int menu_build(struct build_info *info, ofnode node, struct scene *scn,
 		return log_msg_ret("tit", ret);
 	title_id = ret;
 	ret = scene_menu_set_title(scn, menu_id, title_id);
+	if (ret)
+		return log_msg_ret("set", ret);
 
 	item_ids = ofnode_read_prop(node, "item-id", &size);
 	if (!item_ids)
@@ -300,7 +308,7 @@ static int obj_build(struct build_info *info, ofnode node, struct scene *scn)
 	log_debug("- object %s\n", ofnode_get_name(node));
 	ret = ofnode_read_u32(node, "id", &id);
 	if (ret)
-		return log_msg_ret("id", -EINVAL);
+		return log_msg_ret("id", -ENOENT);
 
 	type = ofnode_read_string(node, "type");
 	if (!type)
@@ -308,8 +316,8 @@ static int obj_build(struct build_info *info, ofnode node, struct scene *scn)
 
 	if (!strcmp("menu", type))
 		ret = menu_build(info, node, scn, id, &obj);
-	 else
-		ret = -EINVAL;
+	else
+		ret = -EOPNOTSUPP;
 	if (ret)
 		return log_msg_ret("bld", ret);
 
@@ -341,11 +349,12 @@ static int scene_build(struct build_info *info, ofnode scn_node,
 	ofnode node;
 	int ret;
 
+	info->err_node = scn_node;
 	name = ofnode_get_name(scn_node);
 	log_debug("Building scene %s\n", name);
 	ret = ofnode_read_u32(scn_node, "id", &id);
 	if (ret)
-		return log_msg_ret("id", -EINVAL);
+		return log_msg_ret("id", -ENOENT);
 
 	ret = scene_new(exp, name, id, &scn);
 	if (ret < 0)
@@ -362,6 +371,7 @@ static int scene_build(struct build_info *info, ofnode scn_node,
 		return log_msg_ret("pr", ret);
 
 	ofnode_for_each_subnode(node, scn_node) {
+		info->err_node = node;
 		ret = obj_build(info, node, scn);
 		if (ret < 0)
 			return log_msg_ret("mit", ret);
@@ -370,20 +380,20 @@ static int scene_build(struct build_info *info, ofnode scn_node,
 	return 0;
 }
 
-int expo_build(ofnode root, struct expo **expp)
+int build_it(struct build_info *info, ofnode root, struct expo **expp)
 {
-	struct build_info info;
+	;
 	ofnode scenes, node;
 	struct expo *exp;
 	u32 dyn_start;
 	int ret;
 
-	memset(&info, '\0', sizeof(info));
-	ret = read_strings(&info, root);
+	ret = read_strings(info, root);
 	if (ret)
 		return log_msg_ret("str", ret);
 	if (_DEBUG)
-		list_strings(&info);
+		list_strings(info);
+	info->err_node = root;
 
 	ret = expo_new("name", NULL, &exp);
 	if (ret)
@@ -397,7 +407,7 @@ int expo_build(ofnode root, struct expo **expp)
 		return log_msg_ret("sno", -EINVAL);
 
 	ofnode_for_each_subnode(node, scenes) {
-		ret = scene_build(&info, node, exp);
+		ret = scene_build(info, node, exp);
 		if (ret < 0)
 			return log_msg_ret("scn", ret);
 	}
@@ -405,3 +415,27 @@ int expo_build(ofnode root, struct expo **expp)
 
 	return 0;
 }
+
+int expo_build(ofnode root, struct expo **expp)
+{
+	struct build_info info;
+	struct expo *exp;
+	int ret;
+
+	memset(&info, '\0', sizeof(info));
+	ret = build_it(&info, root, &exp);
+	if (ret) {
+		char buf[120];
+		int node_ret;
+
+		node_ret = ofnode_get_path(info.err_node, buf, sizeof(buf));
+		log_warning("Build failed at node %s, property %s\n",
+			    node_ret ? ofnode_get_name(info.err_node) : buf,
+			    info.err_prop);
+
+		return log_msg_ret("bui", ret);
+	}
+	*expp = exp;
+
+	return 0;
+}
-- 
2.42.0.459.ge4e396fd5e-goog

