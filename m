Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7485C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4105987A7F;
	Fri, 12 Jan 2024 22:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ve+hUe4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA31B87A22; Fri, 12 Jan 2024 22:34:20 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C262C879CE
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-783137d8049so612552585a.2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705095257; x=1705700057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5d+lQ+Kv8/PoZBoe1SuB5F2vpm8Gpf1JF4t/cIb9Yvo=;
 b=Ve+hUe4SGVnfZQpZttFcrgA39+UVdEwk3zouRHehC2/UvoT3rruves3ir42rI6r9NH
 PRN6Bn0bgSTqjafrJSWKLFzbV/csULqhmde9Zjx6ARkGYy7wMt/ZGguggE7kxQopQELA
 yiIHyYFRg/BSTRvIG84RaVuWXh2E7VMXtvRsUSBXiJgwe0WmcstyuJOmMR+MI6joyt6x
 ONtTjb/WblPyOVTIKk0rLORKQHE+yrQSKLPhm1EveBjLk1QHVUhuVs4uMx3En8JyKmD9
 OXu9B2efExl/aiW2uIPy8Ed1/Xo+wDeLBF97fhqYkb94s+4wTTn+KDrRLKcnuzuB6gOT
 W2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095257; x=1705700057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5d+lQ+Kv8/PoZBoe1SuB5F2vpm8Gpf1JF4t/cIb9Yvo=;
 b=sMsk2IL7uWTD8B4U/LsKuLk/WO7gRoUv86d6eBFGUul+hZ0TOOvVQIoWCz6eVULfnv
 1zdwURCfjS5wnAuCsKts2jbS+61yZtky/fgu5KbojcLHBb1UfdtHFpQpzWavBs/2qG4h
 iZ/KO0JDnO+CMKA2SZfaCQA2J6f8mwrUOuZFvOeJNIz9pfz+xSAPVne28uReFwTixqX9
 /ITaPn72AMZvCSc7HZFL8icS12yNNJIZctwOgZJxEigHWAV7qW9D73wopocVgCQ/1RQ6
 WkPZPsz3lgmyg2Klzrf0alwiMQ1uBhuMQWZgjqL3txUaJUc6LqT+ANI8Cgwb05quQ3k7
 L2eA==
X-Gm-Message-State: AOJu0YwQl3JMIgGOGzBtxcgkEI0zoXIQ7BcN3WnuapGwYbGq8TH841Uq
 InyEvLlya5wHkktIUCufAAaklxYgxnPX0d5NiFVycqVD4rk=
X-Google-Smtp-Source: AGHT+IF6YFMdUwpzoeZawfASCqWkNP1qyRBq4vxVqmta9rUNF4dtfrbsP4qE3BYAgQV+kyT+IX1FKg==
X-Received: by 2002:a05:620a:4d1:b0:783:3ed0:ffb5 with SMTP id
 17-20020a05620a04d100b007833ed0ffb5mr2300712qks.98.1705095257245; 
 Fri, 12 Jan 2024 13:34:17 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 wa12-20020a05620a4d0c00b0078321f3e7c7sm1325321qkn.114.2024.01.12.13.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:34:16 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 3/8] bloblist: refactor of bloblist_reloc()
Date: Fri, 12 Jan 2024 13:33:29 -0800
Message-Id: <20240112213337.185460-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112213337.185460-1-raymond.mao@linaro.org>
References: <20240112213337.185460-1-raymond.mao@linaro.org>
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

The current bloblist pointer and size can be retrieved from global
data, so we don't need to pass them from the function arguments.
This change also help to remove all external access of gd->bloblist
outside of bloblist module.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.
Changes in v3
- Check the space size before copying the bloblist.
- Add return code of bloblist_reloc().
Changes in v4
- return error code from bloblist_reloc().

 common/bloblist.c  | 10 ++++++++--
 common/board_f.c   |  9 +++------
 include/bloblist.h |  8 ++++----
 test/bloblist.c    |  6 ++----
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 26b0ba33b1..c2fd07575f 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -472,13 +472,19 @@ void bloblist_show_list(void)
 	}
 }
 
-void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
+int bloblist_reloc(void *to, uint to_size)
 {
 	struct bloblist_hdr *hdr;
 
-	memcpy(to, from, from_size);
+	if (to_size < gd->bloblist->total_size)
+		return -ENOSPC;
+
+	memcpy(to, gd->bloblist, gd->bloblist->total_size);
 	hdr = to;
 	hdr->total_size = to_size;
+	gd->bloblist = to;
+
+	return 0;
 }
 
 int bloblist_init(void)
diff --git a/common/board_f.c b/common/board_f.c
index d4d7d01f8f..f4145a2698 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -676,13 +676,10 @@ static int reloc_bloblist(void)
 		return 0;
 	}
 	if (gd->new_bloblist) {
-		int size = CONFIG_BLOBLIST_SIZE;
-
 		debug("Copying bloblist from %p to %p, size %x\n",
-		      gd->bloblist, gd->new_bloblist, size);
-		bloblist_reloc(gd->new_bloblist, CONFIG_BLOBLIST_SIZE_RELOC,
-			       gd->bloblist, size);
-		gd->bloblist = gd->new_bloblist;
+		      gd->bloblist, gd->new_bloblist, gd->bloblist->total_size);
+		return bloblist_reloc(gd->new_bloblist,
+				      CONFIG_BLOBLIST_SIZE_RELOC);
 	}
 #endif
 
diff --git a/include/bloblist.h b/include/bloblist.h
index cc78259e5a..0ae079d62a 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -426,11 +426,11 @@ const char *bloblist_tag_name(enum bloblist_tag_t tag);
  * bloblist_reloc() - Relocate the bloblist and optionally resize it
  *
  * @to: Pointer to new bloblist location (must not overlap old location)
- * @to_size: New size for bloblist (must be larger than from_size)
- * @from: Pointer to bloblist to relocate
- * @from_size: Size of bloblist to relocate
+ * @to_size: New size for bloblist
+ * Return: 0 if OK, -ENOSPC if the new size is small than the bloblist total
+ *	   size.
  */
-void bloblist_reloc(void *to, uint to_size, void *from, uint from_size);
+int bloblist_reloc(void *to, uint to_size);
 
 /**
  * bloblist_init() - Init the bloblist system with a single bloblist
diff --git a/test/bloblist.c b/test/bloblist.c
index 7dab9addf8..1c60bbac36 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -376,13 +376,12 @@ static int bloblist_test_reloc(struct unit_test_state *uts)
 {
 	const uint large_size = TEST_BLOBLIST_SIZE;
 	const uint small_size = 0x20;
-	void *old_ptr, *new_ptr;
+	void *new_ptr;
 	void *blob1, *blob2;
 	ulong new_addr;
 	ulong new_size;
 
 	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
-	old_ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
 
 	/* Add one blob and then one that won't fit */
 	blob1 = bloblist_add(TEST_TAG, small_size, 0);
@@ -394,8 +393,7 @@ static int bloblist_test_reloc(struct unit_test_state *uts)
 	new_addr = TEST_ADDR + TEST_BLOBLIST_SIZE;
 	new_size = TEST_BLOBLIST_SIZE + 0x100;
 	new_ptr = map_sysmem(new_addr, TEST_BLOBLIST_SIZE);
-	bloblist_reloc(new_ptr, new_size, old_ptr, TEST_BLOBLIST_SIZE);
-	gd->bloblist = new_ptr;
+	ut_assertok(bloblist_reloc(new_ptr, new_size));
 
 	/* Check the old blob is there and that we can now add the bigger one */
 	ut_assertnonnull(bloblist_find(TEST_TAG, small_size));
-- 
2.25.1

