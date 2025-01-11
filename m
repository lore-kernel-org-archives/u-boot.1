Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA2FE7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678AD80797;
	Sat, 11 Jan 2025 01:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y+tQ37tK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 692F0806B7; Sat, 11 Jan 2025 01:02:01 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A052800D0
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a8160382d4so6922685ab.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553717; x=1737158517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PzNvg8Mj2yNnCqJSH8SSPEZ/lELoyx2JStmTgWmyeA=;
 b=Y+tQ37tKwUKKj5OVcA3Thg7W6WyCcY2P3yw+skihZNJ7+1B18kVye+4z9vG9Un2iiU
 w2+WhppR8meIQXQJv3klhfsw1Nzynqvknubc9Kqj0Npo8UpgyPgQ+zv5/HfRmV74Ub8a
 8yFJcNWySo3L5hShASQngJ5VywhqI7f/Wmfzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553717; x=1737158517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PzNvg8Mj2yNnCqJSH8SSPEZ/lELoyx2JStmTgWmyeA=;
 b=bPIjG9Jc0XvPInA/GMjCoiFT89ik2VYnoFluLNczgbcT2uo4gd2yf/g5y9AOQzOFw4
 wOy6fajBCppROYVVIs4Y3SD0hEhpuFrvHRnZPMon7pg+6SjRb9AM9WacJ0MOk3G+Lo3/
 iRie/H/Xoez0smLmy4QLDutzBypKgCOGbhnYFr7mIVNYVsbGD3qJ0seMn2DuP5T1HIPq
 z0nUx28fcYGIqdHHWljLs2VzntSEYspLwhf5Z9PZMxlneq33ajGpl0N9f1aXn5O2bSus
 o//4stSStrT3NfSGxZZ0pS/Da9t1UpuVNnecV8xTdce5p3tkOGGaagRcsxgojJ6OxDAL
 9/tA==
X-Gm-Message-State: AOJu0YxZ78RMVaCkEaru8dDPbLcJuccMfuGvwxwW3bW+Ye1PLzwDPLaZ
 /tEnBg/Ptb7+2fdNLHIi5Plxe5lKYuovhM45l+0jpvGqg1b81uKkfPSAf5MuWbRBrRkdK+w0d9M
 =
X-Gm-Gg: ASbGncvFDKD/AOSp1CzPNUJ5IUd8Ud+Uhg8eifc26xnAjtS0qtMDONFmolMnFldtJ9l
 NX9pnsmMs2cuCNetxW/bAX8CVY5Ju5lqRVcjYTMShg7gN/a9vqEtOhMD29u/YQn61Bu+hr1QHeb
 IjTCWxOKrvslPVvla/+RVEujcCNP11nvqR5rY+rz06zJ9olfKGIZvAV5eNcVwa2TD9BCbZ12TVF
 yAjzZ7ikJOlOupaRmUAIUxD96gbIW/3PUbBWyoFzbs16GFsoGWFzVn/rOEBQ7qHfCudngRl7mYy
 Szv9ImvuD0mL8zRORA==
X-Google-Smtp-Source: AGHT+IFzU+8WNRVZSLhOSPkMugfq85pIXLL4lH3UR9BC17xQz8U7TJM99u6GJ0SdTZzU3hF0mxSKcw==
X-Received: by 2002:a05:6e02:160e:b0:3a7:c5b1:a55f with SMTP id
 e9e14a558f8ab-3ce3a893945mr96862565ab.0.1736553717023; 
 Fri, 10 Jan 2025 16:01:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 29/30] dm: core: Provide ofnode_name_eq_unit() to accept a
 unit address
Date: Fri, 10 Jan 2025 17:00:28 -0700
Message-Id: <20250111000029.245022-30-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

(no changes since v2)

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

