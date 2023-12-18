Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263FBC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0511875FE;
	Mon, 18 Dec 2023 19:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vWwqDbn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 362C687509; Mon, 18 Dec 2023 19:20:28 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E0F687613
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bb53e20a43so642571b6e.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923622; x=1703528422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0eh9xolvMbvTdmLa2Ngqnpmy4mlzhfcUYhl8pmdkAw=;
 b=vWwqDbn5s25IG1oPym4XSL8qNy/DelTsCNuJ631ocH3wT8jZ1ufVAbzjEJqsF7SNyJ
 iITy0naB4tVhCBzk2ujd7tbuJOGX9Nw5pLFHhjke5O8ETF3eU8ynu1me8Mod8eezvXuQ
 1haMtolIpQaqBsEjx1tWmMjNYpidsdkrDgejSIhVXiOPLDspcfD3SbLsynhX2tzMcK17
 xZXb7lnsWCsL56i2WBr1md1BJbnFZ/sjJHTZyzzv1P4TXvStL1QmzarNqIuD6Rkdgf+8
 4ADpjhaqEf4gqbZcFhBrS5vaKehuyz4Dbcuao//KYUGUGzHPwB1ieCCGDjgkgZN2E9Mp
 KNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923622; x=1703528422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0eh9xolvMbvTdmLa2Ngqnpmy4mlzhfcUYhl8pmdkAw=;
 b=TIpehF2UzmaLivFlxMcJf5xN1Y93tw0kfSoJgXeFR3L3/JPigaFpnquXGEtEBahG69
 ANXReHZbcPIS0uGgH7ptcGTSZySdKZUCh2yI+BMiD9/tBvQI0I6JO9ZcYY7zaTvUQFij
 nsjCvwOvUHJ8zrQCdLcI7+OkNYdUouGW4dEofGCkRJ7pMZadmfVNHGcAN3tPziTwjdH8
 azEADR2TMpjEKCmNxDN80qrBEdMv2qnG0rt5h++9eFhPDrSM2qauaWj1/3P0XW1o7t3/
 0Hj53vVOb1cTlJV7Tq2FyRv960/KSFZUXPxmPyBEgcWKCfQiunDCPpiqHm1LLj4nI4jZ
 GJXw==
X-Gm-Message-State: AOJu0YyqUIQbu6iwaCwbnZv5EC0GRbEXwDSliPzouTVIXzryyQhCKv06
 +rzZLf/L2iowuwST74VZzNq6LUTew9i+JPOSW8g=
X-Google-Smtp-Source: AGHT+IF/YxFQ2HW6hZl/oTXKtB//8ztkcxKqX63MG0Db4JjU6BOOLRj9W9VXj3yh+ow4SV49Bga60A==
X-Received: by 2002:a05:6808:148a:b0:3b9:ca51:5186 with SMTP id
 e10-20020a056808148a00b003b9ca515186mr19389980oiw.42.1702923622603; 
 Mon, 18 Dec 2023 10:20:22 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:20:22 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 11/14] bloblist: Adjust the bloblist header
Date: Mon, 18 Dec 2023 10:18:56 -0800
Message-Id: <20231218181901.337515-12-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218181901.337515-1-raymond.mao@linaro.org>
References: <20231218181901.337515-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

The v0.9 spec provides for a 24-byte header. Update
the implementation to match this.

This also adds an alignment field.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3
- Update the bloblist header to align to FW handoff spec up to commit 3592349.
- Update the related testcases.

 include/bloblist.h | 29 +++++++++++++++--------------
 test/bloblist.c    |  6 +++---
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/bloblist.h b/include/bloblist.h
index 7024d7bf9e..5dba630adb 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -166,32 +166,33 @@ enum bloblist_tag_t {
  * from the last.
  *
  * @magic: BLOBLIST_MAGIC
+ * @chksum: checksum for the entire bloblist allocated area. Since any of the
+ *	blobs can be altered after being created, this checksum is only valid
+ *	when the bloblist is finalized before jumping to the next stage of boot.
+ *	This is the value needed to make all checksummed bytes sum to 0
  * @version: BLOBLIST_VERSION
  * @hdr_size: Size of this header, normally sizeof(struct bloblist_hdr). The
  *	first bloblist_rec starts at this offset from the start of the header
- * @flags: Space for BLOBLISTF... flags (none yet)
- * @size: Total size of the bloblist (non-zero if valid) including this header.
- *	The bloblist extends for this many bytes from the start of this header.
- *	When adding new records, the bloblist can grow up to this size.
+ * @align_log2: Power of two of the maximum alignment required by this list
  * @alloced: Total size allocated so far for this bloblist. This starts out as
  *	sizeof(bloblist_hdr) since we need at least that much space to store a
  *	valid bloblist
+ * @size: Total size of the bloblist (non-zero if valid) including this header.
+ *	The bloblist extends for this many bytes from the start of this header.
+ *	When adding new records, the bloblist can grow up to this size.
+ * @flags: Space for BLOBLISTF... flags (none yet)
  * @spare: Spare space (for future use)
- * @chksum: checksum for the entire bloblist allocated area. Since any of the
- *	blobs can be altered after being created, this checksum is only valid
- *	when the bloblist is finalised before jumping to the next stage of boot.
- *	This is the value needed to make all checksummed bytes sum to 0
  */
 struct bloblist_hdr {
 	u32 magic;
-	u32 version;
-	u32 hdr_size;
-	u32 flags;
-
-	u32 size;
+	u8 chksum;
+	u8 version;
+	u8 hdr_size;
+	u8 align_log2;
 	u32 alloced;
+	u32 size;
+	u32 flags;
 	u32 spare;
-	u32 chksum;
 };
 
 /**
diff --git a/test/bloblist.c b/test/bloblist.c
index e6070041d3..a083259d0c 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -78,7 +78,7 @@ static int bloblist_test_init(struct unit_test_state *uts)
 	ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
 						     TEST_BLOBLIST_SIZE));
 
-	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0x10, 0));
+	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0xc, 0));
 	ut_asserteq(-EFAULT, bloblist_new(1, TEST_BLOBLIST_SIZE, 0));
 	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
 
@@ -272,8 +272,8 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	run_command("bloblist info", 0);
 	ut_assert_nextline("base:     %lx", (ulong)map_to_sysmem(hdr));
 	ut_assert_nextline("size:     400    1 KiB");
-	ut_assert_nextline("alloced:  58     88 Bytes");
-	ut_assert_nextline("free:     3a8    936 Bytes");
+	ut_assert_nextline("alloced:  50     80 Bytes");
+	ut_assert_nextline("free:     3b0    944 Bytes");
 	ut_assert_console_end();
 	ut_unsilence_console(uts);
 
-- 
2.25.1

