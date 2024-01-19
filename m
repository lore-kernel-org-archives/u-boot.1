Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8ACC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B49EC87CE1;
	Fri, 19 Jan 2024 16:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cip+v2+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9743987CDE; Fri, 19 Jan 2024 16:12:22 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C07187CE3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-783310bd2d3so60596385a.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705677139; x=1706281939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yY7eUTFBfE3aq4E2vaxNcJ0VTstSRaqivooRe2O8RVs=;
 b=Cip+v2+eouuCp8Q5T2D3QkwuDVysKjEdC2XH3PlQW96//JpqB0eHqLl5FvKvOvt+Dm
 8Wm5YMItaENSWdKJgJx2FwF/1sAmXVwPyTgIVRYBR4eyYXzTjWwmpc4OlRbBG3NiK5e3
 NNQ9qJwJDi7OkjPBBqeyA2mAsANplw4tJbcwZPDu+tYzqebpMfd5jFQS7BYcH5JehddJ
 pagH95m7FfZOiEzESpE4PB6TDi7eIJcOgfKSdeAK2RL6iNET1j9sj24NLDtUaxeZ6Dwb
 5dA1yzv2rVaoocoV2ftIN3bwkQ7WX59amse/x0iwmDpyz+7WL002bFxadFldGqI/J6bq
 yddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705677139; x=1706281939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yY7eUTFBfE3aq4E2vaxNcJ0VTstSRaqivooRe2O8RVs=;
 b=gGSQerU8qG1i3LwmKGSbuRYQ0ZlssHEk8726Vi5bWORsgYzhkzTQI7svAoPPL1HqmR
 pssoNnncQqad2lZ4fxaj58xLtCJdXzHVFiUvKYIE2bKLJB1pQMbJmZ+2gn4h5b75poNg
 cLarMEjITcloJFReIBZcptRtEfK9c732R4Cj2VZc1L1BF9Gyel4mfdkYmj0tEymKHK6o
 Z1qPf/bnhuopKHbCwvSk0YalZOFh7GwDhCA/vBLi2eNNMYI2CMEAmnLhvliDShuT3QKn
 7R+ZPlXe7jT1NCQppKbFGxk9l15zYtdGiMWntLwCoUYSHmXWePqGYSqCQ10l6lMirBBt
 5JMQ==
X-Gm-Message-State: AOJu0YwLJhFb5klfLMzV2v+cYj19H9Inxf99O3q+ubmQMjfTQK+Eg/DZ
 qH2lHgLYszrVWnZ1hWi7Z4lw/JeYjnOLn1KGNitFcyycQc612xLA01oSbD0iVAZuIEj1k2OvRa2
 d
X-Google-Smtp-Source: AGHT+IEUcfwp8vPCByx99b4wkfdxEEDIIJM2tc43eYZAiC6nkJD1Mp6Ll/MxhmZdkfnRv5fIggdylw==
X-Received: by 2002:a05:620a:66c:b0:783:8ba0:9265 with SMTP id
 a12-20020a05620a066c00b007838ba09265mr19101qkh.77.1705677138850; 
 Fri, 19 Jan 2024 07:12:18 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a37c208000000b0078322dc4f97sm6142113qkm.26.2024.01.19.07.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:12:18 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v7 3/8] bloblist: refactor of bloblist_reloc()
Date: Fri, 19 Jan 2024 07:09:59 -0800
Message-Id: <20240119151007.715348-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119151007.715348-1-raymond.mao@linaro.org>
References: <20240119151007.715348-1-raymond.mao@linaro.org>
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

