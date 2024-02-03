Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A08C4828D
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 16:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA9C879E0;
	Sat,  3 Feb 2024 17:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RCUVKcSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFAC58767C; Sat,  3 Feb 2024 17:37:51 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE3E879F4
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 17:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-602d222c078so29298507b3.0
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 08:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706978267; x=1707583067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yY7eUTFBfE3aq4E2vaxNcJ0VTstSRaqivooRe2O8RVs=;
 b=RCUVKcSfpjR+s0z+N6qxxuM8PETsY9OqMoo8jWy0ISanbzxPr/Cl1eGkGLTnh0LAqn
 t+JY/wZXBWpziUINk7LvrxzwNNsiwgFixyu9tJQuEhz4+ggaDSFKZWSlM6r7VKwtv1jg
 hclfSJ8Ap/YjDgmRpNAgw0Qel9MILsdlPb4CmkCLlrbHl7KLC8Ov3+x3QMtUEd11m0+8
 SNFJ8yUsTxQKGuDXNULTjKuN5m5TPqFc+uCpntO2F0ka923BwgNylXS/zvH7JVy0PGBA
 QnURYaZFqzIm+7ulFuy8v0bwk8Lc31K1jZP3xM4rs+0BnFAl0iWfS3qqRr5BIvuDN34C
 5iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706978267; x=1707583067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yY7eUTFBfE3aq4E2vaxNcJ0VTstSRaqivooRe2O8RVs=;
 b=vHH4FIm49FUoJrzYjHBWQPz+/xPy2hxoDC+c5meITSj2yxIQy55owUJwxuksCj0tt7
 +jt5GbbQuE/6hn6a0HWWvk847cdQJSQT5jyPFkydxYdivFO0LZXrYfh7C7uKPT2nwt6N
 qu5hdVEZUXMF1KAJHdH/or85wYhNMY0BFbmBnAn76y4lTbbEN2rdzF1+twr4h+M6qqyB
 I7HMDH+V0+Xea9TKFSh377X1uCS+hDlcDZ93ai8I2WoXlrfc0fXGL6motP2l+/dUTSID
 7kPtMMaOZMuBJ4GoWoLaAdDwV5918rxtxNoTk426U8MFTL7DdKEMDy5dpKcyvIJpVCYf
 mJgg==
X-Gm-Message-State: AOJu0YzdsCUu3lkajYHI0SqolaLn4CMELNbfLRD39E1Z6bvQ4PpKU1ld
 fBSg6GUy0ku6EEy3unzlhfMBQFYW9TqdaxATc/cwS9+CAV+G5GwVsuqX6M9MwELqRM8AShVSI7G
 w
X-Google-Smtp-Source: AGHT+IGdMD0cuJmxBDfFXAy1bg1Nzb3XeY7jBgpVusaJ1CycPZC0hKkWhrBlIIEy1Cv8bkRKwSWg+Q==
X-Received: by 2002:a0d:cc43:0:b0:603:d3f1:1c2b with SMTP id
 o64-20020a0dcc43000000b00603d3f11c2bmr5165363ywd.24.1706978267721; 
 Sat, 03 Feb 2024 08:37:47 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXcpARMHD6PtNRcaTL93lTYM4XtfgqAfS7FgDrKoK7qovyPdVayWBcooZdYbt9ZQvE0R4xycXCyfJBzC05Zm+3YjO9Ckg3hNn87GloDwIBz8aUulCFQxHSKR6DXmSTt/Hd3SsWt9GEZym9WQQ4SiMcLDOwUa1CiP4T2DaxeCjpX29m4lZ91xBTG8QX4elo5XJl0GduvVYyIQrJGszMtzT0iCxaC45nLkhF1TFCKre+lKIUYdQqm2zdVQsktbIiXVkrCNQTu5AAiQSmps5RuUzthV0YAj/H31LJXXmBX2eWnpfdtl+kcwhyb0mWP0ur5oSq8G1fwfA29m192wVp0jKKM8zovnvjkKcye2htYqzYlV5HHFkayDvbtr8ywTxRYXDHIFONrJx8+V9Ai8rnnfxZnSUA=
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 oj16-20020a056214441000b006869d54c818sm1909086qvb.109.2024.02.03.08.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 08:37:47 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 3/8] bloblist: refactor of bloblist_reloc()
Date: Sat,  3 Feb 2024 08:36:22 -0800
Message-Id: <20240203163631.177508-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240203163631.177508-1-raymond.mao@linaro.org>
References: <20240203163631.177508-1-raymond.mao@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

