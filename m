Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A51C46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF4487863;
	Fri, 22 Dec 2023 22:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NBWbJ0gK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 979B186FB5; Fri, 22 Dec 2023 22:32:15 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D65CD8785E
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-67f95d69115so6457926d6.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703280730; x=1703885530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCG/DVe01GyydbeQCZ1PAmA6FhcgYMKWy7veFsR5W0w=;
 b=NBWbJ0gKtlhnMpgq8J7w+3T7yHbM/C73gyry/usedW6X9vRPzy1wep/N7t5ZVBOeHS
 Z9Nks8L9wLlfVlrqVOSgJRT+I2oba/WI0Z++qDC1led17IwBUdB/6K/BwiF7buXZtMpO
 loWei2trUPLYxSrbLa6DwqF1easLLE3uYlRq8Gmsuma9a57LzR/vQANqDdSmZzJWY/98
 fDvqTt44dPKb5vQvcVupcBwcX7zpooC340Ek1+fYvVgFpJ5tOgA6la3YMXmegKHncvuO
 kfgnH5tLNEK5oyU6A7dlUO5o+QEbp8YDUm6x98RAzJDkz8+6AtXpQOBiZ/5gaAAuM2QN
 svNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703280730; x=1703885530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bCG/DVe01GyydbeQCZ1PAmA6FhcgYMKWy7veFsR5W0w=;
 b=Q8CXi222y5s702PXsK7vpICZIINqF1QuoAgbdotaG0hASL6O2Em0SGvWTtiVKBtPhb
 /ksDcZLTpZl315bsYdpFMyMzo8IwNAOhF6YOLnc8usQbMm7eqtiPYNkMlV5s6iPb1/td
 gF/UysBK5Kwl1lqdhgvv0EMy1LrMXIYMecSs5n9XrJj94+CWYRILxmkfy34E7iRdYOPi
 EQTDSPGosAoqwdAhJjEdDy8DRxpjmVT2sSbCl3ctyFF3Rads7dcrDTZ5FGkJmOuNzeha
 jYNFA8wWP9cdPxLxceMad44EEx8cALNcIPy2xL7PsEymN4jPTyisnvaGV0YqgdKtgchz
 el/g==
X-Gm-Message-State: AOJu0Yz/ZZCfrPnXpNKvNzjQx/Z5m98fgkJ73foMLhj5uIM5i0jP8Y5m
 yZkFw/SQmLZMv1pQGYvXcg6BuDjA2UxPWuxy4a9bp+E2vh8=
X-Google-Smtp-Source: AGHT+IH4UFWoEy+QMvcDop1h7Z5dHr1sVFo4d/dgLc+JneRnUxmn4G+VtXKWEttTR3FGqQbEUk0bnA==
X-Received: by 2002:a05:6214:2308:b0:67f:4926:60cd with SMTP id
 gc8-20020a056214230800b0067f492660cdmr2453641qvb.83.1703280730549; 
 Fri, 22 Dec 2023 13:32:10 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dm6-20020ad44e26000000b0067f6ec98ae9sm1623096qvb.32.2023.12.22.13.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:32:10 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v3 7/9] bloblist: Load the bloblist from the previous loader
Date: Fri, 22 Dec 2023 13:31:07 -0800
Message-Id: <20231222213110.660402-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231222213110.660402-1-raymond.mao@linaro.org>
References: <20231222213110.660402-1-raymond.mao@linaro.org>
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
index 5ad1db137a..e66afcde64 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -492,31 +492,38 @@ int bloblist_init(void)
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
@@ -525,7 +532,8 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("!fixed", ret);
+			return log_msg_ret("BLOBLIST_FIXED is not enabled",
+					   ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
@@ -538,6 +546,9 @@ int bloblist_init(void)
 		return log_msg_ret("ini", ret);
 	gd->flags |= GD_FLG_BLOBLIST_READY;
 
+	bloblist_show_stats();
+	bloblist_show_list();
+
 	return 0;
 }
 
diff --git a/include/bloblist.h b/include/bloblist.h
index c1dab11f78..2f4246576e 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -445,6 +445,22 @@ int bloblist_reloc(void *to, uint to_size);
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

