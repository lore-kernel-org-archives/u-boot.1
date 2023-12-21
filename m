Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CF9C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 00:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D75E68785E;
	Thu, 21 Dec 2023 01:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aPFMv/pT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B6D6876C8; Thu, 21 Dec 2023 01:41:10 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A5887854
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4279a1b2a00so486311cf.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703119264; x=1703724064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvowlHLU+Zrjn94Hu2B+DvUI702tdev+Y9S+HKdwHaA=;
 b=aPFMv/pT9vY6KEau0NBYAxWSTRulromaL6xBIgrvKIkY/W82U3mzm7L5zh83zQR0lF
 95OzQkopf6iAr+wMWKA/ymKYtuAIQd4Swy9GepIt3Ig5bxhKCeDzkCX/Z0edQ5Dc/bp5
 510CmR/nnRdg0WUe2a8n2ft09zRYH5bqfZfeQXqjIIzDz5Lf/hN6mIGbd72n+zSE8PHb
 XhPUl9B0sSjLPG97XYjRgvfMf5S9ZxySaH2TCnsAp2NDdTRcMWXnfaaxRcATYNSElGUy
 c3hG3hvH77FuVFK8tLcMEuCNf9C+QeJAhrZijY7OJ8thVeSDWu7dfXoSb4VAF4SQ1AhQ
 mUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703119264; x=1703724064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvowlHLU+Zrjn94Hu2B+DvUI702tdev+Y9S+HKdwHaA=;
 b=e48omtUAPIfU9w9raeF3sxa61FZJm5DL8ig2ogu6oBYjQA2aZ+U5ftjaqBIIxZGGtx
 9dIyBWkgNSHI+VxJ60g/EJl+xYyTx+y+0jCMLjq7Ts2mAGMPQE46LKqVoBArNDgPqm0R
 U9OP4JLJWOO/54YKB74CqX3KkwGB0PgKGDuqpC0HVlql/0RXFmJhZeElfKi1eLtCNU9p
 dL9jJKWxaoGt771wo862WoxaXl/FyK6YIH7MjN680WhM3tZxAse8VIsH2JcXpI0F6vIZ
 cJ+dhD1tedx1hUjiYpQuvK9xvOF841Ck5zLM5tCJRQ2MCWfMeDH6TaZA11fWIr4/Hhto
 VHUw==
X-Gm-Message-State: AOJu0Yw1+ZIpkgKx5BgykE+8CcUXUzCmQaoLgfe/Qfquw5zCE8X5tUMt
 yjB+uLHH30Ls4tWexZ90MJVa8UAiWA6hk1CrWOU=
X-Google-Smtp-Source: AGHT+IHgLcKsqgF7/F9bi3o8fioiARpeYYeJu07llqCfURSZS9ie/bTH6MFoGlMvjJc7ov7keZJ0+w==
X-Received: by 2002:ac8:7c4b:0:b0:427:93cd:95cc with SMTP id
 o11-20020ac87c4b000000b0042793cd95ccmr1051104qtv.105.1703119263859; 
 Wed, 20 Dec 2023 16:41:03 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 fv9-20020a05622a4a0900b00419801b1094sm354184qtb.13.2023.12.20.16.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 16:41:03 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <sean.anderson@seco.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 3/9] bloblist: refactor of bloblist_reloc()
Date: Wed, 20 Dec 2023 16:40:22 -0800
Message-Id: <20231221004030.581388-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221004030.581388-1-raymond.mao@linaro.org>
References: <20231221004030.581388-1-raymond.mao@linaro.org>
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

 common/bloblist.c  | 10 +++++++---
 common/board_f.c   |  8 ++------
 include/bloblist.h |  6 ++----
 test/bloblist.c    |  6 ++----
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index be2050611a..fcfd62a618 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -472,13 +472,17 @@ void bloblist_show_list(void)
 	}
 }
 
-void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
+void bloblist_reloc(void *to, uint to_size)
 {
 	struct bloblist_hdr *hdr;
 
-	memcpy(to, from, from_size);
+	memcpy(to, gd->bloblist, gd->bloblist->total_size);
 	hdr = to;
-	hdr->total_size = to_size;
+	if (to_size < gd->bloblist->total_size)
+		hdr->total_size = gd->bloblist->total_size;
+	else
+		hdr->total_size = to_size;
+	gd->bloblist = to;
 }
 
 int bloblist_init(void)
diff --git a/common/board_f.c b/common/board_f.c
index d4d7d01f8f..00b0430889 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -676,13 +676,9 @@ static int reloc_bloblist(void)
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
+		bloblist_reloc(gd->new_bloblist, CONFIG_BLOBLIST_SIZE_RELOC);
 	}
 #endif
 
diff --git a/include/bloblist.h b/include/bloblist.h
index b5d0f147f6..c8f61c45de 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -418,11 +418,9 @@ const char *bloblist_tag_name(enum bloblist_tag_t tag);
  * bloblist_reloc() - Relocate the bloblist and optionally resize it
  *
  * @to: Pointer to new bloblist location (must not overlap old location)
- * @to_size: New size for bloblist (must be larger than from_size)
- * @from: Pointer to bloblist to relocate
- * @from_size: Size of bloblist to relocate
+ * @to_size: New size for bloblist
  */
-void bloblist_reloc(void *to, uint to_size, void *from, uint from_size);
+void bloblist_reloc(void *to, uint to_size);
 
 /**
  * bloblist_init() - Init the bloblist system with a single bloblist
diff --git a/test/bloblist.c b/test/bloblist.c
index 7dab9addf8..3b6f0cd42e 100644
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
+	bloblist_reloc(new_ptr, new_size);
 
 	/* Check the old blob is there and that we can now add the bigger one */
 	ut_assertnonnull(bloblist_find(TEST_TAG, small_size));
-- 
2.25.1

