Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A5FC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 21:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7122D87669;
	Tue, 19 Dec 2023 22:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GqsXPIRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0C687695; Tue, 19 Dec 2023 22:11:54 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35CED876B2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 22:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6d9f7af8918so4223315a34.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703020309; x=1703625109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlS90m7fGL6laU5WUSGISHfARyN4tBz8sEo0IoSllYM=;
 b=GqsXPIRRBd/zQG5FZO6DHUhILkmGxLY4mubNCBCaKLD8r5Hr1Zi7hHCFVSKE4ZvIDv
 flW+JdvDisItFWk6bh8ZVmv8PnoZKCFugWxmhaFvSVDvVxEJi/XBmr53IGbszO2SVHh3
 mp52PRbtomexoizllqbGG+B+fWHE+c7DugidE/SEinTInS67Lg72zE3nvuJAPB/c3B/0
 qkeXhI3Auxspb087wlimoLQRqd+pAHtRliPAtNJDWni6QO5PPdSMYi7cUMi3APlOAuR4
 eKA8h51GHgXXM36WL2XWLfMTP2vlymVf3v2Mvr+49PikIbAHZLmwMqKgKJCqpXRW6q/m
 AM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703020309; x=1703625109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlS90m7fGL6laU5WUSGISHfARyN4tBz8sEo0IoSllYM=;
 b=uTPctTEa4Sieqzr4XS1Z4KLsST78E6ysRLQTYDjtMe2oaVJx0lAkfPSFHDMbmO4LJ1
 ogxMqF9s56OG0ZxDj/P1rZhY7Zma+qHxDsT5XAkMtH/f6Rd0UwZgrWQYGZVpxXVUyvTk
 AgbObBXg5jRdSjRoBIwubWHh6nCdDIdjnNJ/m/xXUWMA5wYC5vqxao4R1LkTZimz8quL
 hMxPhszQYLUaYgOikYk5p3gxEQfoOfZ/7CzXQN6iO/OS4ZH5NpOagNbKFC8YNfwkS7IJ
 /VizUewvecv7uVcBog6r4hAO745+Ya5udGFW3Uho0YVy8AHc8mucuOiJniaayVieUlVz
 Ry0A==
X-Gm-Message-State: AOJu0YxK6L4J5l4ru6Q1fUczzGmrjZ2CcxioxyraXzVU4T1Hjbn709b9
 C/880sH3P6sEFDZst1ASt5PyisTI0lCLEvAUK18=
X-Google-Smtp-Source: AGHT+IGB9n66qRSFaKpYVQK+SVQC7JBvOTGw8dVAbxHMJWSHGc4aqYb1DBP0nXthkuDqf6//9pX9kA==
X-Received: by 2002:a05:6808:1526:b0:3b9:ef59:42f8 with SMTP id
 u38-20020a056808152600b003b9ef5942f8mr22935171oiw.21.1703020309472; 
 Tue, 19 Dec 2023 13:11:49 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a0cf38e000000b0067a33133420sm10709493qvk.110.2023.12.19.13.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 13:11:49 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 3/5] bloblist: Load the bloblist from the previous loader
Date: Tue, 19 Dec 2023 13:11:10 -0800
Message-Id: <20231219211114.393193-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219211114.393193-1-raymond.mao@linaro.org>
References: <20231219211114.393193-1-raymond.mao@linaro.org>
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

During bloblist initialization, when CONFIG_OF_BOARD is defined,
invoke the platform custom function to load the bloblist via boot
arguments from the previous loader.
If the bloblist exists, copy it into the fixed bloblist memory region.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c  | 47 ++++++++++++++++++++++++++++------------------
 include/bloblist.h | 16 ++++++++++++++++
 2 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 232ca4c6ce..c89f7a1554 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -486,31 +486,38 @@ int bloblist_init(void)
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
 	ulong addr, size;
-	bool expected;
-
-	/**
-	 * We don't expect to find an existing bloblist in the first phase of
-	 * U-Boot that runs. Also we have no way to receive the address of an
-	 * allocated bloblist from a previous stage, so it must be at a fixed
+	/*
+	 * If U-Boot is not in the first phase, an existing bloblist must be
+	 * at a fixed address.
+	 */
+	bool from_addr = fixed && !u_boot_first_phase();
+	/*
+	 * If U-Boot is in the first phase that a board specific routine should
+	 * install the bloblist passed from previous loader to this fixed
 	 * address.
 	 */
-	expected = fixed && !u_boot_first_phase();
+	bool from_board = fixed && IS_ENABLED(CONFIG_OF_BOARD) &&
+			  u_boot_first_phase();
+
 	if (spl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
-		expected = false;
+		from_addr = false;
 	if (fixed)
 		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
 				      CONFIG_BLOBLIST_ADDR);
 	size = CONFIG_BLOBLIST_SIZE;
-	if (expected) {
+
+	if (from_board)
+		ret = board_bloblist_from_boot_arg(addr, size);
+	else if (from_addr)
 		ret = bloblist_check(addr, size);
-		if (ret) {
-			log_warning("Expected bloblist at %lx not found (err=%d)\n",
-				    addr, ret);
-		} else {
-			/* Get the real size, if it is not what we expected */
-			size = gd->bloblist->total_size;
-		}
-	}
+
+	if (ret)
+		log_warning("Bloblist at %lx not found (err=%d)\n",
+			    addr, ret);
+	else
+		/* Get the real size */
+		size = gd->bloblist->total_size;
+
 	if (ret) {
 		if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
 			void *ptr = memalign(BLOBLIST_ALIGN, size);
@@ -519,7 +526,8 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("!fixed", ret);
+			return log_msg_ret("BLOBLIST_FIXED is not enabled",
+					   ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
@@ -532,6 +540,9 @@ int bloblist_init(void)
 		return log_msg_ret("ini", ret);
 	gd->flags |= GD_FLG_BLOBLIST_READY;
 
+	bloblist_show_stats();
+	bloblist_show_list();
+
 	return 0;
 }
 
diff --git a/include/bloblist.h b/include/bloblist.h
index b5d0f147f6..f5c623133d 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -445,6 +445,22 @@ void bloblist_reloc(void *to, uint to_size, void *from, uint from_size);
  */
 int bloblist_init(void);
 
+#if (IS_ENABLED(CONFIG_ARCH_QEMU) && IS_ENABLED(CONFIG_ARM))
+/* Board custom function for qemu-arm */
+int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size);
+#else
+/*
+ * A board need to implement this custom function if it needs to retrieve
+ * bloblist from a previous loader
+ */
+static inline
+int board_bloblist_from_boot_arg(unsigned long __always_unused addr,
+				 unsigned long __always_unused size)
+{
+	return -1;
+}
+#endif
+
 #if CONFIG_IS_ENABLED(BLOBLIST)
 /**
  * bloblist_maybe_init() - Init the bloblist system if not already done
-- 
2.25.1

