Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58D5E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C134586E6B;
	Tue, 26 Sep 2023 16:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J2icDMAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E04F86E10; Tue, 26 Sep 2023 16:15:59 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A3786E29
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79fbbb2bed0so126451839f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737751; x=1696342551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9CV6OH5fnzZVM+avtIBfP9gu32+Z/40yk4PX/g8IXc=;
 b=J2icDMASURFjkUfi1zPJYU+HUY6gHgBWlPId32RTplI00iLuK2Z2f+hVojLbNo8gow
 2AeKXri2D8Sfjwd9e32UQUFD2jrTxxsn9+/NY98QHMeIHLOExAfs3Ms+7lQ5L7o3o1Il
 KCqk0yr0eP+cu6IRFHoAS0/AqcD3jRKs5v2rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737751; x=1696342551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z9CV6OH5fnzZVM+avtIBfP9gu32+Z/40yk4PX/g8IXc=;
 b=qImoLUK0Ai27VOTx8EL4nxKzG1mRNxqaxyLym+xdgsrXz4WPp7cQH4+C+UsHhpVmzq
 RKR1vgFr9dspcx+55SkDvo3euV2MEwTpzsRy6/4NdgGx2IHX6RIef1CmNbT4Njxg12Gz
 /hhL31mYuoC62UgdhRJIwehHAHC0s2C8YECJSk35kF5EMwDAwV9mgq/khpKih6zKfmvn
 22A+xsvRN4pRDRJZPcGfPclYOLGa9g0wo9wPhcv+fNXi5RQEPv+1vKBiV/9FlLhFJjgc
 1DyP5prJZ65W0pkdy7eWiXRQOXYySqfeYlojwSvOfMKYKgtlC9M7PVmyCgH61ah/vJ1w
 pcaA==
X-Gm-Message-State: AOJu0YwyAKRoQc9aNR4fO8K85Pz3yWyJ+REb/4FLmum6k96ud8RDN2r9
 f3oYNOgIThIjYKmWWY1TZSpmxr5ozHj/UI8S+dk=
X-Google-Smtp-Source: AGHT+IEG5yis51Vo/uzZsnPLROKnUKIEgzl6FLeAZbCKAiveibggTlMhJg/UE7Rjf3j65Zv2a8LDHQ==
X-Received: by 2002:a05:6e02:1c07:b0:34f:20d9:74a9 with SMTP id
 l7-20020a056e021c0700b0034f20d974a9mr2911220ilh.11.1695737751186; 
 Tue, 26 Sep 2023 07:15:51 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v4 27/44] dm: core: Add a way to copy a node
Date: Tue, 26 Sep 2023 08:14:41 -0600
Message-ID: <20230926141514.2101787-28-sjg@chromium.org>
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

Add a function to copy a node to another place under a new name. This is
useful at least for testing, since copying a test node with existing
properties is easier than writing the code to generate it all afresh.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/ofnode.c | 20 ++++++++++++++
 include/dm/ofnode.h   | 15 +++++++++++
 test/dm/ofnode.c      | 63 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index d2bdb8b9af1c..403ee06ad94b 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1802,3 +1802,23 @@ int ofnode_copy_props(ofnode dst, ofnode src)
 
 	return 0;
 }
+
+int ofnode_copy_node(ofnode dst_parent, const char *name, ofnode src,
+		     ofnode *nodep)
+{
+	ofnode node;
+	int ret;
+
+	ret = ofnode_add_subnode(dst_parent, name, &node);
+	if (ret) {
+		if (ret == -EEXIST)
+			*nodep = node;
+		return log_msg_ret("add", ret);
+	}
+	ret = ofnode_copy_props(node, src);
+	if (ret)
+		return log_msg_ret("cpy", ret);
+	*nodep = node;
+
+	return 0;
+}
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 0b96ab34ede0..7eb04accd62c 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1620,4 +1620,19 @@ int ofnode_add_subnode(ofnode parent, const char *name, ofnode *nodep);
  */
 int ofnode_copy_props(ofnode dst, ofnode src);
 
+/**
+ * ofnode_copy_node() - Copy a node to another place
+ *
+ * If a node with this name already exists in dst_parent, this returns an
+ * .error
+ *
+ * @dst_parent: Parent of the newly copied node
+ * @name: Name to give the new node
+ * @src: Source node to copy
+ * @nodep: Returns the new node, or the existing node if there is one
+ * Return: 0 if OK, -EEXIST if dst_parent already has a node with this parent
+ */
+int ofnode_copy_node(ofnode dst_parent, const char *name, ofnode src,
+		     ofnode *nodep);
+
 #endif
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 594116e3c045..5459a9afbb99 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1362,3 +1362,66 @@ static int dm_test_oftree_new(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_oftree_new, UT_TESTF_SCAN_FDT);
+
+static int check_copy_node(struct unit_test_state *uts, ofnode dst, ofnode src,
+			   ofnode *nodep)
+{
+	u32 reg[2], val;
+	ofnode node;
+
+	ut_assertok(ofnode_copy_node(dst, "copy-test", src, &node));
+
+	ut_assertok(ofnode_read_u32(node, "ping-expect", &val));
+	ut_asserteq(3, val);
+
+	ut_asserteq_str("denx,u-boot-fdt-test",
+			ofnode_read_string(node, "compatible"));
+
+	/* check that a property with the same name is overwritten */
+	ut_assertok(ofnode_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg)));
+	ut_asserteq(3, reg[0]);
+	ut_asserteq(1, reg[1]);
+
+	/* reset the compatible so the live tree does not change */
+	ut_assertok(ofnode_write_string(node, "compatible", "nothing"));
+	*nodep = node;
+
+	return 0;
+}
+
+static int dm_test_ofnode_copy_node(struct unit_test_state *uts)
+{
+	ofnode src, dst, node, try;
+
+	/*
+	 * These nodes are chosen so that the src node is before the destination
+	 * node in the tree. This doesn't matter with livetree, but with
+	 * flattree any attempt to insert a property earlier in the tree will
+	 * mess up the offsets after it.
+	 */
+	src = ofnode_path("/b-test");
+	dst = ofnode_path("/some-bus");
+
+	ut_assertok(check_copy_node(uts, dst, src, &node));
+
+	/* check trying to copy over an existing node */
+	ut_asserteq(-EEXIST, ofnode_copy_node(dst, "copy-test", src, &try));
+	ut_asserteq(try.of_offset, node.of_offset);
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_copy_node, UT_TESTF_SCAN_FDT);
+
+/* test ofnode_copy_node() with the 'other' tree */
+static int dm_test_ofnode_copy_node_ot(struct unit_test_state *uts)
+{
+	oftree otree = get_other_oftree(uts);
+	ofnode src, dst, node;
+
+	src = ofnode_path("/b-test");
+	dst = oftree_path(otree, "/node/subnode2");
+	ut_assertok(check_copy_node(uts, dst, src, &node));
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_copy_node_ot, UT_TESTF_SCAN_FDT | UT_TESTF_OTHER_FDT);
-- 
2.42.0.515.g380fc7ccd1-goog

