Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744F4CD493D
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7952E86DB4;
	Thu, 21 Sep 2023 03:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EYIc4SzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E34486DC0; Thu, 21 Sep 2023 03:58:18 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 527AD86DB4
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34f68fe0944so1403445ab.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261487; x=1695866287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJihqRLOBraXZo/E18mDqk9JBWS47/7TWW2MjTPTClc=;
 b=EYIc4SzI4JHCv3s0f9vxlp4wo/t/5MgVApffN3Mm+tLBFeQ+VyneWbIQmPdzEWUZ7W
 dDARO469ZR3nrWobNH3UAAWabrbfT2Fb1qt+X0sashQyttNctd8digE9YpmiLcrZi06F
 wqI8yfPWgxZwIpdJ86v3ZFg+7gpkAfflXgeaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261487; x=1695866287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJihqRLOBraXZo/E18mDqk9JBWS47/7TWW2MjTPTClc=;
 b=KE3yQ0M3CDuRDUhzFPkr/jgEriVRkQ4i8HMgV2d58TnWPtkWNZRvoYK/TIBL7Hds00
 lnccEDhhB75+2jlmgEBcv+HEFBiUCoOBt94lWrQQvB7Fy7IGLelsa/3o0qBz21ou+yYV
 RTkWkN1Dz8pY4enScgEHLFBjbHKh7/eKXvYBJV+HF48KHyPnJ14ffVyi3/ObY+qxH7we
 PVVk4yXrxJenC776dQcybW8mY/0ciJa+ogeNIpfOorMGeyDz4SZEcw6+Yfsp34oKO0WO
 mzBdz6teUkevuDcIUKtZcyYuVlLdWL1IzyBFGaxyCNqWCYSH1KgtnuQ2p0kazyjfIC25
 jWnQ==
X-Gm-Message-State: AOJu0Yzv0kuj4sb14HaPg+BdH7hqppyViWLoEwQSWRW7sAT/+dWW+4NT
 hGYjzw07fnn1tVToOR2duByqHE/s+JBGVUfq+gU=
X-Google-Smtp-Source: AGHT+IET0h2I77iEtVLat0uoCWJkfkLs2zCeqWeezE2FzPF+woukdjVdT8En1m0XbQkXsrnwqXpMsw==
X-Received: by 2002:a05:6e02:d52:b0:34f:d822:baab with SMTP id
 h18-20020a056e020d5200b0034fd822baabmr4198912ilj.12.1695261486873; 
 Wed, 20 Sep 2023 18:58:06 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 22/32] dm: core: Support writing a boolean
Date: Wed, 20 Sep 2023 19:57:11 -0600
Message-ID: <20230921015730.1511373-23-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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
index 4dc7589c1d23..0229695dba1f 100644
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
index f3ef1bff6db6..58c6849534ea 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1036,10 +1036,19 @@ int ofnode_decode_panel_timing(ofnode node,
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
@@ -1451,6 +1460,27 @@ int ofnode_write_string(ofnode node, const char *propname, const char *value);
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
index d2b393750ffc..af844a50308e 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1461,3 +1461,28 @@ static int dm_test_oftree_to_fdt(struct unit_test_state *uts)
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

