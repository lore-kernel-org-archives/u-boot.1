Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CABBC04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76EF9869BC;
	Tue, 15 Aug 2023 00:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GsrPPMHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9682E869B5; Tue, 15 Aug 2023 00:41:22 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DB2E869A0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3490cce32c4so23761915ab.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052879; x=1692657679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmU31G9cNhnJjdgNocL/C0Pa6BrlxrfQoQ6K+gfT3gA=;
 b=GsrPPMHLDjOnUagvY16dN2MnDySkbgat/nXZ2ZtL+uCi6zPG9oKEzY3BiDIHNgALvi
 OtPUkwKmO3qG8UY+nPQ9x/LtAJLtnVZ+WiP2/FtYvH2Q/Mha4uZ4gvfyG3fZjJXN2IpH
 0BYR9N4SXCBGXcxWCK1/Il7FHMQDNKQtgDzSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052879; x=1692657679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmU31G9cNhnJjdgNocL/C0Pa6BrlxrfQoQ6K+gfT3gA=;
 b=Ol74YRlGTCMvnBJYV1jj7QsmRX1BGp9jwzMlvIKdS8cvrHvwPv/BfUuNny+84oTTBX
 rf5+5+c4p/I0Dq2IgFSDt5EmOVhbjfcQmk9FnmhJfZkk8wecjHqCx3o9hegriVgHfLCk
 JJRP94iME3oZOhjrwcoDTtY3xfbCTVq6miXszs4S5dfsvCzqIIWvtW5K/BFzCxx4xTCn
 vbOr0cxUuz8vWIHk4vh86l99qRDZfeQIG3E2mMKIUk9VVySLhi04KNgYFqAYqhys2pyb
 ycbonoyI3bAIaSlXkvMERgr2/jXOYICrHCfQBxiKp8DnDhCuIrWjuuynacElDgXaJ73R
 3wWA==
X-Gm-Message-State: AOJu0Yw8XIUZPRY5Q0746tzo6q0e+j2HRwZ8UooBK9l2Y3JB+pGicbKG
 oS0LH3TSVvMevGftbLJm7oj9c6RYR5vCg907lQM=
X-Google-Smtp-Source: AGHT+IHYF4vCmYP7ugTzttGbWShJL2w/KNBUy9YYsNzgKMWRaoyLphGOQ8nkg6VLsJ3Zt1Or2nQPpA==
X-Received: by 2002:a05:6e02:1d16:b0:348:f0a2:84e9 with SMTP id
 i22-20020a056e021d1600b00348f0a284e9mr17973820ila.15.1692052879138; 
 Mon, 14 Aug 2023 15:41:19 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 04/19] expo: Refactor menu_build() to return the object created
Date: Mon, 14 Aug 2023 16:40:24 -0600
Message-ID: <20230814224047.535491-5-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

The caller reads the ID but menu_build() does this again. Add the ID as
a parameter to avoid this. Return the object created so that the caller
can adjust it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/expo_build.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/boot/expo_build.c b/boot/expo_build.c
index 22f62eb54bc5..e8c4a40d3f09 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -214,22 +214,21 @@ static void list_strings(struct build_info *info)
  * @info: Build information
  * @node: Node containing the menu description
  * @scn: Scene to add the menu to
+ * @id: ID for the menu
+ * @objp: Returns the object pointer
  * Returns: 0 if OK, -ENOMEM if out of memory, -EINVAL if there is a format
  * error, -ENOENT if there is a references to a non-existent string
  */
-static int menu_build(struct build_info *info, ofnode node, struct scene *scn)
+static int menu_build(struct build_info *info, ofnode node, struct scene *scn,
+		      uint id, struct scene_obj **objp)
 {
 	struct scene_obj_menu *menu;
 	uint title_id, menu_id;
 	const u32 *item_ids;
 	int ret, size, i;
 	const char *name;
-	u32 id;
 
 	name = ofnode_get_name(node);
-	ret = ofnode_read_u32(node, "id", &id);
-	if (ret)
-		return log_msg_ret("id", -EINVAL);
 
 	ret = scene_menu(scn, name, id, &menu);
 	if (ret < 0)
@@ -275,12 +274,13 @@ static int menu_build(struct build_info *info, ofnode node, struct scene *scn)
 		if (ret < 0)
 			return log_msg_ret("mi", ret);
 	}
+	*objp = &menu->obj;
 
 	return 0;
 }
 
 /**
- * menu_build() - Build an expo object and add it to a scene
+ * obj_build() - Build an expo object and add it to a scene
  *
  * See doc/developer/expo.rst for a description of the format
  *
@@ -292,6 +292,7 @@ static int menu_build(struct build_info *info, ofnode node, struct scene *scn)
  */
 static int obj_build(struct build_info *info, ofnode node, struct scene *scn)
 {
+	struct scene_obj *obj;
 	const char *type;
 	u32 id;
 	int ret;
@@ -306,7 +307,7 @@ static int obj_build(struct build_info *info, ofnode node, struct scene *scn)
 		return log_msg_ret("typ", -EINVAL);
 
 	if (!strcmp("menu", type))
-		ret = menu_build(info, node, scn);
+		ret = menu_build(info, node, scn, id, &obj);
 	 else
 		ret = -EINVAL;
 	if (ret)
-- 
2.41.0.694.ge786442a9b-goog

