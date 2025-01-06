Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC64E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E14C5805D5;
	Mon,  6 Jan 2025 15:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c8j5wm4P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 599998070D; Mon,  6 Jan 2025 15:34:13 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD9080740
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a9caa3726fso52105625ab.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174048; x=1736778848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKrXk8va8izy/AWuxP8tBXUydDbrCCRsIlckTvRKHPY=;
 b=c8j5wm4Pk+xLso5ygzcri3vWbL67dlP/v5wVivx3LzL8x6rR+7l76DWw16qLy3iPHr
 uF+2fZbxOia3Vp43aJTRfiyqU5kvFlJQ/IAQuIqP9UzluUlYs/5nM6qqNyR6z0AibXNM
 SezW5swvVyAFOL1HHz5QNrfEJ6mae2rNCfARY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174048; x=1736778848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKrXk8va8izy/AWuxP8tBXUydDbrCCRsIlckTvRKHPY=;
 b=hcSqC9a1OGENqrn50W5lK/ThsXrmZ7ld+ss0CJE31iy4ACiXyDS17Sdc3XmuO4S13f
 jzAdCinVMixOFpbfOUEtGpex1yRGuv1+27UeuzxEJq9Z5VMyolxpSolp1cA87xXt6HIU
 gOF1JXFxoSMyabOeIB/p2MMLk3AMB1tv2vUcV9gcoR2+Wg902lULCTqdQZUy8Zzt9Ua4
 FscMrtM7uPDQE7ujvsQizcKmQ+oBSE44qx/4oRINtOl4mx9Cm2z40KBzg7Wy+QzSdZ+B
 nBYN0l3IJVRlEBOXjZkQTnw3vMhD5oEwoMj2icBj/pOotxY7DcuyLaps/RkLSIghkYVO
 ORZw==
X-Gm-Message-State: AOJu0YwNDOJKXdY2fBDV3OD46E0tVDD6FPyCw8FVVbY4SeuPqKHXHl/C
 Nl2W3Xh7E6flCrRXfRgwB1ZYcHgKO4DzAr41nXTTT1Hk683Z93vsC+annm9MmhTaKHmAvSoXchM
 =
X-Gm-Gg: ASbGncv/LR19j3ACXPsaSkNRinxFEIvbbcxE5EDwe+xXz7OJzj5ZHIR9U2p97q3JQuq
 7I05sRo1NsiVMMBRXcukL1Pu8muPZgaN9K4woVsFfFm6zCUTZIEQ8UDafadGEeHV5qjCnX84CY1
 sJ5NVWDlFfYdfZiZlCIZKG6rqwml+VdD2H4QOwLRveazuWelBj1KHhqz19WrKncwQ4+iHLMz8DU
 y6L3QHAOxJQ5L2ADrinBGosPeUPMVbm7J0HzEvk6HDnwBYllAizx6Zpp88R5DC/PXMfNzeAg+nc
 fQtOx1KRcNqVUdZuDw==
X-Google-Smtp-Source: AGHT+IGLcvTJcDwum97eFCYxl9VtaWqJix53PAx+wEe4EKisTwciJ2CweWLaF70rNc7JS65gL5WBAw==
X-Received: by 2002:a05:6e02:16c5:b0:3a7:e1c3:11f5 with SMTP id
 e9e14a558f8ab-3c2ff00f349mr497193695ab.6.1736174048581; 
 Mon, 06 Jan 2025 06:34:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:34:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 32/33] dm: core: Provide ofnode_name_eq_unit() to accept a
 unit address
Date: Mon,  6 Jan 2025 07:32:28 -0700
Message-Id: <20250106143229.3023771-33-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

When a unit-address is provided, use it to match against the node
name.

Since this increases code size, put it into a separate function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split this into its own function

 drivers/core/ofnode.c | 23 +++++++++++++++++++++++
 include/dm/ofnode.h   | 14 ++++++++++++++
 test/dm/core.c        | 18 ++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 5b8be218d3b..529bc132f7d 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -309,6 +309,29 @@ bool ofnode_name_eq(ofnode node, const char *name)
 	return (strlen(name) == len) && !strncmp(node_name, name, len);
 }
 
+bool ofnode_name_eq_unit(ofnode node, const char *name)
+{
+	const char *node_name, *p;
+	int len;
+
+	assert(ofnode_valid(node));
+
+	node_name = ofnode_get_name(node);
+
+	/* check the whole name */
+	if (!strcmp(node_name, name))
+		return true;
+
+	/* if @name has no unit address, try the node name without it */
+	len = strlen(name);
+	p = strchr(node_name, '@');
+	if (p && !strchr(name, '@') && len == p - node_name &&
+	    !strncmp(node_name, name, len))
+		return true;
+
+	return false;
+}
+
 int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
 {
 	const u8 *cell;
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 6d6a6fef8ef..3bb7d3e05e1 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -394,6 +394,20 @@ void oftree_dispose(oftree tree);
  */
 bool ofnode_name_eq(ofnode node, const char *name);
 
+/**
+ * ofnode_name_eq_unit() - Check a node name ignoring its unit address
+ *
+ * This is separate from ofnode_name_eq() to avoid code-size increase for
+ * boards which don't need this function
+ *
+ * @node:	valid node to compared, which may have a unit address
+ * @name:	name to compare with the node name. If this contains a unit
+ *		address, it is matched, otherwise the unit address is ignored
+ *		when searching for matches
+ * Return: true if matches, false if it doesn't match
+ */
+bool ofnode_name_eq_unit(ofnode node, const char *name);
+
 /**
  * ofnode_read_u8() - Read a 8-bit integer from a property
  *
diff --git a/test/dm/core.c b/test/dm/core.c
index d40916ef588..959b834576f 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -192,6 +192,24 @@ static int dm_test_compare_node_name(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_compare_node_name, UTF_SCAN_PDATA);
 
+/* compare node names ignoring the unit address */
+static int dm_test_compare_node_name_unit(struct unit_test_state *uts)
+{
+	ofnode node;
+
+	node = ofnode_path("/mmio-bus@0");
+	ut_assert(ofnode_valid(node));
+	ut_assert(ofnode_name_eq_unit(node, "mmio-bus"));
+
+	ut_assert(ofnode_name_eq_unit(node, "mmio-bus@0"));
+	ut_assert(!ofnode_name_eq_unit(node, "mmio-bus@1"));
+	ut_assert(!ofnode_name_eq_unit(node, "mmio-bu"));
+	ut_assert(!ofnode_name_eq_unit(node, "mmio-buss@0"));
+
+	return 0;
+}
+DM_TEST(dm_test_compare_node_name_unit, UTF_SCAN_PDATA);
+
 /* Test that binding with uclass plat setting occurs correctly */
 static int dm_test_autobind_uclass_pdata_valid(struct unit_test_state *uts)
 {
-- 
2.34.1

