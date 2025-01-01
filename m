Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B38DE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F86380511;
	Wed,  1 Jan 2025 23:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jE7dbUXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94CC68050A; Wed,  1 Jan 2025 23:22:45 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84A5B80379
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21636268e43so57274045ad.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770160; x=1736374960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBffKZt6HLVlP7o9fEL9sOQ7xL8n9X0aLhjVln4TVbk=;
 b=jE7dbUXF7d0QzOD3kwy/ayouM2KGshhCi8Ksu8dOw/lCus3tJJEB/2Anhgt0CkyvCT
 FItLEP1nmd96a9NFkALG9I2RB/Ie1NBFnP0z9gzlhe3DIWtGLatkcXoMbDJvjqsk3CG1
 HYv78WsLHKpSXXT4uocbAfocvLOB5fiYdsHeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770160; x=1736374960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBffKZt6HLVlP7o9fEL9sOQ7xL8n9X0aLhjVln4TVbk=;
 b=jQ+CZUUoqiNCHs0vbzgVItA3K+x5CHEnHr2F5m4fxWbeNSnX8iq6LZCOSd+dx5Db+X
 mPh6F5BoHBFMdFTpDFYcpE2eW+itdRpmsauJmKjrBf8QGtQIUXN1xxxk4QFC6qgWMp0z
 zhcNUQVXL/M8CqCDG9QmrKZc/i/m9znsfpCbIB2qkm03IoFn64sNlJu3QEf3HZH3AGE7
 sRcSPMVKkqW1bBJE1/PWp6wuop/seKUDgS8uJj3OPGv2GpJU3BfRAeeZdWMzgXJWN958
 ud2Mrj+qBAwz+K/aBmwaz8dXb2c5eOq0SJFCgF047lce/tvMjeKxsfGcwMJyd2+H4esw
 Rcwg==
X-Gm-Message-State: AOJu0Ywja6S2ev8VpGKTlvJt2ygxoHbV5SVi2RuaU3HpJ3zdlWA2doQH
 llMOnvqm11SwrFXGBySXQIrmLpICq0wOfg8XwfSAZA2a9eLCwsAvkUJy6ZSp+YrtRkJ/oOBwaLE
 =
X-Gm-Gg: ASbGncuPxvO+SZek7PsEC3dp/gGWHMLXjG1ZBYTlLOPPs65Nz7QdlqaRFQhGAuhN4ZL
 gNHjne8ELAYiaUB6i2CsM+9kxmEz7DOLdbgd0p0hubIrc4YmUkMr0JB3YZqKVwpBXvmoXn5x2Yk
 SzvNFqyUM+X+lT691GCvrcbonjNrVcoFBf60+g9OE0WJZ3sOXie3mC8GtjAgMoiTutGRloWvx4x
 dTi4bZfe3VZ3WQHHAhHMyqmrsNInGOUPXmkp6ldXvRpnaYfkR/T2+E=
X-Google-Smtp-Source: AGHT+IHUGczKYgzzYpCkTVExwb36ZBVaONkHG95GqC2Phoq0XsR/yCZIjFCcZfZcvlGkhqQR1zgmGA==
X-Received: by 2002:a05:6a21:164e:b0:1e1:bdae:e054 with SMTP id
 adf61e73a8af0-1e5e079985emr72520099637.25.1735770160115; 
 Wed, 01 Jan 2025 14:22:40 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:39 -0800 (PST)
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
Subject: [PATCH 51/67] dm: core: Allow ofnode_name_eq() to accept a unit
 address
Date: Thu,  2 Jan 2025 11:09:37 +1300
Message-ID: <20250101221003.1944600-52-sjg@chromium.org>
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

When a unit-address is provided, use it to match against the node
name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/ofnode.c | 18 ++++++++++++++----
 include/dm/ofnode.h   |  4 +++-
 test/dm/core.c        |  5 ++++-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 5b8be218d3b..e6f390c710b 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -298,15 +298,25 @@ static ofnode ofnode_from_tree_offset(oftree tree, int offset)
 
 bool ofnode_name_eq(ofnode node, const char *name)
 {
-	const char *node_name;
-	size_t len;
+	const char *node_name, *p;
+	int len;
 
 	assert(ofnode_valid(node));
 
 	node_name = ofnode_get_name(node);
-	len = strchrnul(node_name, '@') - node_name;
 
-	return (strlen(name) == len) && !strncmp(node_name, name, len);
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
 }
 
 int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 6d6a6fef8ef..9d73a321cbc 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -389,7 +389,9 @@ void oftree_dispose(oftree tree);
  * ofnode_name_eq() - Check a node name ignoring its unit address
  *
  * @node:	valid node to compared, which may have a unit address
- * @name:	name (without unit address) to compare with the node name
+ * @name:	name to compare with the node name. If this contains a unit
+ *		address, it is matched, otherwise the unit address is ignored
+ *		when searching for matches
  * Return: true if matches, false if it doesn't match
  */
 bool ofnode_name_eq(ofnode node, const char *name);
diff --git a/test/dm/core.c b/test/dm/core.c
index d40916ef588..ba78ac8ba6a 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -186,7 +186,10 @@ static int dm_test_compare_node_name(struct unit_test_state *uts)
 	ut_assert(ofnode_valid(node));
 	ut_assert(ofnode_name_eq(node, "mmio-bus"));
 
-	ut_assert(!ofnode_name_eq(node, "mmio-bus@0"));
+	ut_assert(ofnode_name_eq(node, "mmio-bus@0"));
+	ut_assert(!ofnode_name_eq(node, "mmio-bus@1"));
+	ut_assert(!ofnode_name_eq(node, "mmio-bu"));
+	ut_assert(!ofnode_name_eq(node, "mmio-buss@0"));
 
 	return 0;
 }
-- 
2.43.0

