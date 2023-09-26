Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFB6E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07CA186DED;
	Tue, 26 Sep 2023 16:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fZhxBZcY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C9186DD1; Tue, 26 Sep 2023 16:16:01 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970E086D90
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79f915e5b47so301816339f.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737754; x=1696342554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTQbObLAeuMKlEGeIDcOsdTDhSE14NmYpbFFWbbMwss=;
 b=fZhxBZcYtci1IWi5JQU/oP/1clayPcj0e/Pr75+216T5MBuYmN3S/ctmn4nS1DwX/F
 ZyOzXs24RQ9B3FCE4DbHf4wjS2GyIqTwC4Lab9qD+BhKGeo1jwHK/GTBB1alV1v2mnCl
 yTaMAGa+p7Fb3BNpFGryFgU9/+/RQd+u5q0lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737754; x=1696342554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTQbObLAeuMKlEGeIDcOsdTDhSE14NmYpbFFWbbMwss=;
 b=OwSloyMMWN7s0jx6MgAOe4HbYOHgObCinys8K46s81B8M6HxEo9DMAEydWNN13Uug6
 uDaZzbgUhbSwZueDOewBNlLOGMxVsri7Wjag/8qu3VJ2US/U2OA+7aOfWa1fpQsLs4BT
 Y6zEf1u9A+eR+sA/jxYi2gPayrLiFR4JSQlTcATPlXN9jJZwqyD9uAyw03YuwNPIUkuv
 io183B5vEB/m5m+1dJmIStAw7URjpW0pcs3Xwf7gyRIzbjr/2qZkNUl3qCxtVQ85Ttem
 dVuCGjCfIrqQu9o+PsETJ/JAUqs6ECI0WDFnVBgbI3x/iScmU53YmBkPsCSaaZHL6thp
 kmCA==
X-Gm-Message-State: AOJu0YyxnJFGXXa0NVh2vb8hwLor8fXQQv95RsxV1bHkkxE2t3+QAjuc
 idCSZOevxl2n0fEYuRnzoZzVP48JMjOVuaG2h7w=
X-Google-Smtp-Source: AGHT+IHXFCSPoB0qF2LDKm8Bkg4IM7phTkQUL/UdkkvjMMcAjmdt4zxSc87bes/s/io3WRQNg1vBLw==
X-Received: by 2002:a6b:ec07:0:b0:798:312a:5403 with SMTP id
 c7-20020a6bec07000000b00798312a5403mr10290678ioh.19.1695737754241; 
 Tue, 26 Sep 2023 07:15:54 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v4 30/44] dm: core: Support writing a boolean
Date: Tue, 26 Sep 2023 08:14:44 -0600
Message-ID: <20230926141514.2101787-31-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

Add functions to write a boolean property. This involves deleting it if
the value is false.

Add a new ofnode_has_property() as well. Add a comment about the behaviour
of of_read_property() when the property value is empty.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/ofnode.c | 36 ++++++++++++++++++++++++++++++++++--
 include/dm/ofnode.h   | 32 +++++++++++++++++++++++++++++++-
 test/dm/ofnode.c      | 25 +++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 39ba480c8f88..4dcb3dd1c037 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -491,12 +491,12 @@ u64 ofnode_read_u64_default(ofnode node, const char *propname, u64 def)
 
 bool ofnode_read_bool(ofnode node, const char *propname)
 {
-	const void *prop;
+	bool prop;
 
 	assert(ofnode_valid(node));
 	debug("%s: %s: ", __func__, propname);
 
-	prop = ofnode_get_property(node, propname, NULL);
+	prop = ofnode_has_property(node, propname);
 
 	debug("%s\n", prop ? "true" : "false");
 
@@ -1168,6 +1168,14 @@ const void *ofnode_get_property(ofnode node, const char *propname, int *lenp)
 				   propname, lenp);
 }
 
+bool ofnode_has_property(ofnode node, const char *propname)
+{
+	if (ofnode_is_np(node))
+		return of_find_property(ofnode_to_np(node), propname, NULL);
+	else
+		return ofnode_get_property(node, propname, NULL);
+}
+
 int ofnode_first_property(ofnode node, struct ofprop *prop)
 {
 	prop->node = node;
@@ -1616,6 +1624,30 @@ int ofnode_write_u32(ofnode node, const char *propname, u32 value)
 	return ofnode_write_prop(node, propname, val, sizeof(value), false);
 }
 
+int ofnode_write_bool(ofnode node, const char *propname, bool value)
+{
+	if (value)
+		return ofnode_write_prop(node, propname, NULL, 0, false);
+	else
+		return ofnode_delete_prop(node, propname);
+}
+
+int ofnode_delete_prop(ofnode node, const char *propname)
+{
+	if (ofnode_is_np(node)) {
+		struct property *prop;
+		int len;
+
+		prop = of_find_property(ofnode_to_np(node), propname, &len);
+		if (prop)
+			return of_remove_property(ofnode_to_np(node), prop);
+		return 0;
+	} else {
+		return fdt_delprop(ofnode_to_fdt(node), ofnode_to_offset(node),
+				   propname);
+	}
+}
+
 int ofnode_set_enabled(ofnode node, bool value)
 {
 	assert(ofnode_valid(node));
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index a8605fb718b2..ebea29d32afc 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1037,10 +1037,19 @@ int ofnode_decode_panel_timing(ofnode node,
  * @node: node to read
  * @propname: property to read
  * @lenp: place to put length on success
- * Return: pointer to property, or NULL if not found
+ * Return: pointer to property value, or NULL if not found or empty
  */
 const void *ofnode_get_property(ofnode node, const char *propname, int *lenp);
 
+/**
+ * ofnode_has_property() - check if a node has a named property
+ *
+ * @node: node to read
+ * @propname: property to read
+ * Return: true if the property exists in the node, false if not
+ */
+bool ofnode_has_property(ofnode node, const char *propname);
+
 /**
  * ofnode_first_property()- get the reference of the first property
  *
@@ -1452,6 +1461,27 @@ int ofnode_write_string(ofnode node, const char *propname, const char *value);
  */
 int ofnode_write_u32(ofnode node, const char *propname, u32 value);
 
+/**
+ * ofnode_write_bool() - Set a boolean property of an ofnode
+ *
+ * This either adds or deleted a property with a zero-length value
+ *
+ * @node:	The node for whose string property should be set
+ * @propname:	The name of the string property to set
+ * @value:	The new value of the boolean property
+ * Return: 0 if successful, -ve on error
+ */
+int ofnode_write_bool(ofnode node, const char *propname, bool value);
+
+/**
+ * ofnode_delete_prop() - Delete a property
+ *
+ * @node:	Node containing the property to delete
+ * @propname:	Name of property to delete
+ * Return: 0 if successful, -ve on error
+ */
+int ofnode_delete_prop(ofnode node, const char *propname);
+
 /**
  * ofnode_set_enabled() - Enable or disable a device tree node given by its
  *			  ofnode
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index ceeb8e57791e..9477f791d649 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1480,3 +1480,28 @@ static int dm_test_oftree_to_fdt(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_oftree_to_fdt, UT_TESTF_SCAN_FDT);
+
+/* test ofnode_read_bool() and ofnode_write_bool() */
+static int dm_test_bool(struct unit_test_state *uts)
+{
+	const char *propname = "missing-bool-value";
+	ofnode node;
+
+	node = ofnode_path("/a-test");
+	ut_assert(ofnode_read_bool(node, "bool-value"));
+	ut_assert(!ofnode_read_bool(node, propname));
+	ut_assert(!ofnode_has_property(node, propname));
+
+	ut_assertok(ofnode_write_bool(node, propname, true));
+	ut_assert(ofnode_read_bool(node, propname));
+	ut_assert(ofnode_has_property(node, propname));
+	ut_assert(ofnode_read_bool(node, "bool-value"));
+
+	ut_assertok(ofnode_write_bool(node, propname, false));
+	ut_assert(!ofnode_read_bool(node, propname));
+	ut_assert(!ofnode_has_property(node, propname));
+	ut_assert(ofnode_read_bool(node, "bool-value"));
+
+	return 0;
+}
+DM_TEST(dm_test_bool, UT_TESTF_SCAN_FDT);
-- 
2.42.0.515.g380fc7ccd1-goog

