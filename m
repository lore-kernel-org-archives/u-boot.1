Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3468CD493F
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78FA186DD0;
	Thu, 21 Sep 2023 03:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XIxN2EUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D2AE8615A; Thu, 21 Sep 2023 03:58:20 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB1886DC5
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79d1a920137so21130939f.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261483; x=1695866283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wiIQumkNRlBGBUdyAGPbqossPGIbD1h3WY2NSnQeOQ=;
 b=XIxN2EUDfCsVaelBhC1mi/RgWbnVkO3okr9bZa75/8ES1cr02mnX92r2kOeV8Kbl8x
 cMFwSB6P9Ml+8rppjxiPpTwr1/YMgM2IN8DWdJ7yfHOMW70XAvTVnfcx9FEI53M5/em1
 iZ+oJPZzitMUY1s7R8TXoeDyCqXm1sfo52SO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261483; x=1695866283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wiIQumkNRlBGBUdyAGPbqossPGIbD1h3WY2NSnQeOQ=;
 b=uQBZfIDyi3TCOsGNe8X8ziZhVdW5c2pbftC7+b9gDl3tgOo/EthdjwZtdLyqkyZLRI
 FH9FULnmWtFkqy7Jc7GGBBoYkxpD1AGf7LlZ8bnxTGb7YrXzFYzH02INJYTtmO93cLnx
 cFKSFbeYK5FWgOSHF+arGLoFr0x0fy22QrN25sRAiL6W6MBpGErDRCUaPHVnFVyDWM5l
 FouPo13aAldTC3AA4KfJl2ckYiH5d1w2GZvJPpT9qD8voZV0ir3J6I7tJYdCrcH81bFW
 ksjKKhjaDjzbZr+gL+ZvAQOBjrZLKj0MZAcZp5D6uqf/xNmwM8mKWSixbFSoOqicYrb5
 Mpjw==
X-Gm-Message-State: AOJu0Yx6u61nZTMSpCU/e55FVoayoitCZKB32NX27AtfNKVQSY88adTe
 t0yZc6c2ybCpvfKEk4tzimGlvLIfp4DK9DKtMNA=
X-Google-Smtp-Source: AGHT+IGbbFFQeXQku5cXUasdZyVaBfJ+vAOKZci/HwksxjuhgJBFgaJjcZGjqMYcqITX2s0MsesO0A==
X-Received: by 2002:a5d:9384:0:b0:791:1739:d525 with SMTP id
 c4-20020a5d9384000000b007911739d525mr3966464iol.20.1695261483185; 
 Wed, 20 Sep 2023 18:58:03 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 19/32] dm: core: Add a way to copy a node
Date: Wed, 20 Sep 2023 19:57:08 -0600
Message-ID: <20230921015730.1511373-20-sjg@chromium.org>
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
index 7100fc630352..ba8385af7b46 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1743,3 +1743,23 @@ int ofnode_copy_props(ofnode dst, ofnode src)
 
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
index fa6a83188995..80708a3644c4 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1567,4 +1567,19 @@ int ofnode_add_subnode(ofnode parent, const char *name, ofnode *nodep);
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
index 63b651df84eb..fe7916c27222 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1343,3 +1343,66 @@ static int dm_test_oftree_new(struct unit_test_state *uts)
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

