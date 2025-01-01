Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDB9E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB25803C6;
	Wed,  1 Jan 2025 23:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mfcKpdzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D7D5804BA; Wed,  1 Jan 2025 23:22:50 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D2B8069C
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216281bc30fso169516165ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770165; x=1736374965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Je+d50iUEWQHhzSx3PeOE65SrtUq849Hv9Qz0GZ9bzc=;
 b=mfcKpdzMoDz5B4rKURBKoXJW2WZxfNDtKiUERFTEh8R65/nQPdWyPOI2iuxrg7Po70
 oNfjwUVqeVTFof2voZ3n+H2EQj+lKulzr4tqeouziHkU3/cPss7bg1ORCX0wHDOpvMy/
 l9FMwb5Tf8VdINZgOAZjtMcG80wBT9fBX+qVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770165; x=1736374965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Je+d50iUEWQHhzSx3PeOE65SrtUq849Hv9Qz0GZ9bzc=;
 b=SPHYJjDDaqDX88k26PB+ZpOXFAV9UNjglS3gBcR5StHTtduRXWGBIh7WICfn5yhTDI
 eWOj8xGu7bwuYckTy1yZMuK06ib5p+L55TMXgS5ZTD0pQ9iA0OaPnUClO7AavlmvMuAx
 X4SkGhsD9VdGruRWqlZ0MJRy4cmkMheOX6pdcuVk1rUtBiv8FonFTiZrlP7uAUVDkbIm
 4hf49UsEc23nnS3fIkC+Fj1F/BpLiGOb4OK24+RBRqfczizKe5MbjlLBBO/ih0giGqwW
 T2Fw6EDy4OyNfWdjCEQZ4Ek2iWVd39pf+o/Ap5d4NySKFQ/sukDKN76KU/9w69Pe535S
 2P8g==
X-Gm-Message-State: AOJu0YyPLmvdW6PWcgWoJbRTY1NgR3vsi3l404+TtC2DPfTqRXY4+UWR
 pVdmdAfWJ9K9HqErUr2EOg4/BcyacSWv2yiw9j/alQ+pnJ0a/MSBHsoNfKphjiV90OBKlPOwKMI
 =
X-Gm-Gg: ASbGncs5U+dP/7NKsPkIDr5/x7jN/wcIVEPTULLsh00Xg5zLUOVOeDSZ1dsiXANs0yT
 i6ZfK0KBhHH5w0DEsL04UldAWSp+6APtt8D9h+6q7NsCaC2DC6h64ZQYLvMoqAVEY77Ndy6LRLa
 GlVwVv+Dt13cNm5XAkF4QzltdYawpKubp5uu1RuiQjvYP6nKPOzsRLpLvhKQ0iFJWmfxSpqswwN
 gA0BaAC3+nMRrG3Lk4/yUOfWwIlLFaNHxr/AVioXCyDQmTnwLrr2Os=
X-Google-Smtp-Source: AGHT+IH7OvP38DW35tNhlFeA7VssaaHhWAp4Fe66HCUNRvZYdrX29ysnxuM2CxinMSMXefZin/uSlA==
X-Received: by 2002:a05:6a21:7896:b0:1e0:cf39:846a with SMTP id
 adf61e73a8af0-1e5e07e79aamr69220250637.29.1735770164740; 
 Wed, 01 Jan 2025 14:22:44 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 52/67] dm: core: Rewrite ofnode_find_subnode() to use ofnode
 API
Date: Thu,  2 Jan 2025 11:09:38 +1300
Message-ID: <20250101221003.1944600-53-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

This function currently processes things two different ways, so the
treatment of unit addresses differs depending on whether OF_LIVE is
enabled or not.

Rewrite it to use the ofnode API and add a test to check that unit
addresses can be matched correctly.

Unfortunately this increases code size by about 104 bytes on Thumb2,
mostly due to the extra logic in ofnode_name_eq(). We could fix that
by having two separate ofnode_name_eq() functions, only one of which
allows an @ sign in its parameter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/ofnode.c | 24 +++++++++---------------
 include/dm/ofnode.h   |  4 +++-
 test/dm/ofnode.c      | 19 +++++++++++++++++++
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index e6f390c710b..62e7a041fdf 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -580,28 +580,22 @@ int ofnode_read_size(ofnode node, const char *propname)
 
 ofnode ofnode_find_subnode(ofnode node, const char *subnode_name)
 {
-	ofnode subnode;
+	ofnode subnode, found = ofnode_null();
 
 	assert(ofnode_valid(node));
 	log_debug("%s: %s: ", __func__, subnode_name);
 
-	if (ofnode_is_np(node)) {
-		struct device_node *np = ofnode_to_np(node);
-
-		for (np = np->child; np; np = np->sibling) {
-			if (!strcmp(subnode_name, np->name))
-				break;
+	ofnode_for_each_subnode(subnode, node) {
+		if (ofnode_name_eq(subnode, subnode_name)) {
+			found = subnode;
+			break;
 		}
-		subnode = np_to_ofnode(np);
-	} else {
-		int ooffset = fdt_subnode_offset(ofnode_to_fdt(node),
-				ofnode_to_offset(node), subnode_name);
-		subnode = noffset_to_ofnode(node, ooffset);
 	}
-	log_debug("%s\n", ofnode_valid(subnode) ?
-		  ofnode_get_name(subnode) : "<none>");
 
-	return subnode;
+	log_debug("%s\n", ofnode_valid(found) ?
+		  ofnode_get_name(found) : "<none>");
+
+	return found;
 }
 
 int ofnode_read_u32_array(ofnode node, const char *propname,
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 9d73a321cbc..5e043616803 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -589,7 +589,9 @@ bool ofnode_read_bool(ofnode node, const char *propname);
  * ofnode_find_subnode() - find a named subnode of a parent node
  *
  * @node:	valid reference to parent node
- * @subnode_name: name of subnode to find
+ * @subnode_name: name of subnode to find, including any unit address. If the
+ *	unit address is omitted, any subnode which matches the name (excluding
+ *	any unit address) is returned
  * Return: reference to subnode (which can be invalid if there is no such
  * subnode)
  */
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index ce996567c3c..47c890e0f92 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -1201,6 +1201,25 @@ static int dm_test_ofnode_find_subnode(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_find_subnode, UTF_SCAN_FDT);
 
+/* check ofnode_find_subnode() with unit addresses */
+static int dm_test_ofnode_find_subnode_unit(struct unit_test_state *uts)
+{
+	ofnode node, subnode;
+
+	node = ofnode_path("/some-bus");
+	ut_assert(ofnode_valid(node));
+	subnode = ofnode_find_subnode(node, "c-test@5");
+	ut_assert(ofnode_valid(subnode));
+	ut_asserteq_str("c-test@5", ofnode_get_name(subnode));
+
+	subnode = ofnode_find_subnode(node, "c-test");
+	ut_assert(ofnode_valid(subnode));
+	ut_asserteq_str("c-test@5", ofnode_get_name(subnode));
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_find_subnode_unit, UTF_SCAN_FDT);
+
 /* test ofnode_find_subnode() on the 'other' tree */
 static int dm_test_ofnode_find_subnode_ot(struct unit_test_state *uts)
 {
-- 
2.43.0

