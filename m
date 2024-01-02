Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A14C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 22:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09EA087955;
	Tue,  2 Jan 2024 23:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AQUk6XEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E409A8794F; Tue,  2 Jan 2024 23:13:16 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6B728756F
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 23:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5e7409797a1so83222597b3.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 14:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704233593; x=1704838393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GU8LkBhSue5G42jSI2uFhEPmyOBDFLPpcfO0o2sEe8=;
 b=AQUk6XEz/4wrAmS92Vi8wE8JHueMWXhK9i8r8SmPLHMsjuDeS1cNYqDMU9X5LZZoER
 4tYaff53AiKF1hZ+5/aGc2UnlC+l/rUNb8PolYM2K2CJNFU4QhhS0Va16ci2dp27aMb1
 hVYgVbGcWMGgkuXQJZm87CC16KPomsRV+pQIUC+UZiGagVyn1Hy3TsXsx/JIH0t9VLLq
 r83L6odPFMnj0jBWcqPuGxZQf0ELTKy3/hZNawxiQtNbr+fgArupy0JtNfuv9Y0IUeLb
 KHFJDpP5/XMA+DzRBsauRCBMxAXQR/2x22vveimmZxiG7TF5jQHAENzo6arlHX5Pjiyx
 edBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704233593; x=1704838393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GU8LkBhSue5G42jSI2uFhEPmyOBDFLPpcfO0o2sEe8=;
 b=HomL2NnOIVvDDe/lnp83UwzeoULQoykN6HPM+h5ZMzlpgh9RxbKKCU6pL6mbLRyS+W
 da4xulhNbO4+l6eiCEcH+s2KxemaBt1bOYk3Svk/qSRoKWWzIlWB3Vww5eIbG1L3TXTe
 j9k9LXvfFoU2ROuZIN9xedMFNxLH2JWykq/saADhScaVvVfVfIHdIDYzGBbK2LOaRMFO
 T3fKON+BY0e+F2CA1QqUHwkzn9D5gKKZZQeU5GKsHlMlXcjBtHTSYOs8zT1trl5oyACU
 7OWwOL67zcpdmLiI8DJwCIGnYkA94+4nSE+nIYwS6qAi9duetQux3X6B0CsvPh70g3lD
 d0pw==
X-Gm-Message-State: AOJu0YxXvCXHp7Gmv/4JbFAmNc6xj6KbWUlQNcLm0TJ0IdF5OkHHDW2s
 WQlHLqswzEjNd/DBR0Spf6jaZgCHWfjWZ8zG9TibTRjHJZk=
X-Google-Smtp-Source: AGHT+IEY5GhrE2qhwK2kcvlYrmX9IdUf6ZvK2/cjLvIW8wAq5tdhT9l7ogHTNizmu8EpWyvLlJ1CGw==
X-Received: by 2002:a0d:e28b:0:b0:5e6:ee0e:ba04 with SMTP id
 l133-20020a0de28b000000b005e6ee0eba04mr10069531ywe.21.1704233593136; 
 Tue, 02 Jan 2024 14:13:13 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 mg14-20020a056214560e00b0067f70cc986asm10431487qvb.92.2024.01.02.14.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 14:13:12 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 3/9] bloblist: refactor of bloblist_reloc()
Date: Tue,  2 Jan 2024 14:12:28 -0800
Message-Id: <20240102221237.1007090-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102221237.1007090-1-raymond.mao@linaro.org>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
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
index 4039eb3a03..4e76975627 100644
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
index 1906847c15..81f1dfa027 100644
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

