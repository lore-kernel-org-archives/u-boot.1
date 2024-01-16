Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5F4C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 17:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D25879C4;
	Tue, 16 Jan 2024 18:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PdwjMONM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A1A86F67; Tue, 16 Jan 2024 18:14:26 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 902F387A25
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 18:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-42989016014so58153881cf.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705425263; x=1706030063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5d+lQ+Kv8/PoZBoe1SuB5F2vpm8Gpf1JF4t/cIb9Yvo=;
 b=PdwjMONMcYRw4aVS+RWQS6dGsJCYYOwP0LPp7xuwkvbCu9Co6vfvtrZF2r7SXAZd9y
 NrtU6wGyZNDMDz84R9cvJMtPYCJBrlTMjox5i18izLzn/UjrxfPeZ4xfRZtByv+EmRYF
 WBf+fOndxpkJJGK3o2c6+/nRyusXGo1L7erI8D01Ha/DhnNP8cqWamFjrPsEjX87JG/C
 nK5XFnfe1Uob+AzyEDH/2SihpW/UUWJguPDRWTipSaBk1AYE8g8q49fidrZf+n/h3P+Z
 lszlHdGim9eRAyL/QffjofMl20AeRHoE9Y+EpDuzyV9JUIVs1i8c+aB6zIYspI50Bb0t
 3oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425263; x=1706030063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5d+lQ+Kv8/PoZBoe1SuB5F2vpm8Gpf1JF4t/cIb9Yvo=;
 b=NndiTzlhaPZaFlrC5Uh6Rw2N5pv8zFOTIPS95J4iUgxWeJUD+FARKmJkiNALlQVcf/
 Q6oCTjm17Mvd0UBX6j/6viikZArdjbhQ7pFMudXeOirNkkkGi2VvnthqYzd8gGzga+rd
 a3Hyo47eMqwvEfq5TrEGGqppJIfGUcsJGter4hTFLv/1Xubk3Qjy99I3F3ZAroDd9lPu
 EO5gC/uQKx1z5vEYdpvu5QUDiewFFf8H80PLtWxOdwWI78j94kO95etnyboS1YJr4uXE
 vLMR/Stv+Zcm2hCgiCGjIXMbhHOkw4WvZVw5x+WAzIL/XtDDnkS21i8MZxyA+sXf1X2O
 ESrA==
X-Gm-Message-State: AOJu0YyoXHFDsG+pVh6glO7x8TXmavO6NBwp4MmjewJD55Yp//hOcTKv
 NJVzS8gGFeQKnS6u4dCDhiI527yFoZPwUOKoSiHmSTu40Sg=
X-Google-Smtp-Source: AGHT+IF8uYkrgtTuOUsQR+J3A0197DWcqBBCQilTuAgAdVTjQVj+ITCT6piYrugB8C9f++s45QGHxg==
X-Received: by 2002:ac8:5dcc:0:b0:429:f102:5512 with SMTP id
 e12-20020ac85dcc000000b00429f1025512mr3459002qtx.58.1705425262950; 
 Tue, 16 Jan 2024 09:14:22 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 bp43-20020a05622a1bab00b00427e0e9c22dsm4988291qtb.54.2024.01.16.09.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 09:14:22 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Fabio Estevam <festevam@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <seanga2@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v6 3/7] bloblist: refactor of bloblist_reloc()
Date: Tue, 16 Jan 2024 09:13:48 -0800
Message-Id: <20240116171356.376801-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116171356.376801-1-raymond.mao@linaro.org>
References: <20240116171356.376801-1-raymond.mao@linaro.org>
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

