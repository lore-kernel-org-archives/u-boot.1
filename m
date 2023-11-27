Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10120C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BFB4877F7;
	Mon, 27 Nov 2023 20:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L5TaEZUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14293877F5; Mon, 27 Nov 2023 20:53:09 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E445D877F7
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b8412723c4so3079855b6e.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114785; x=1701719585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6uj3Pe8u6pkzEru6ufenu8J4ehDCjVe7nQFpEbfPv74=;
 b=L5TaEZUOkdDIDl95Db2RlLprsOzB4gINq72ljvnISx+Jo13MCZsHgXXTD6qJsGhhVi
 3s+m6eiZ4aKgJIlTt91g0LJmWPndVuoGKvi735ocb/QKT1eHMJaMhepAwCwXJND92LAK
 9TrYlJQABQ2RMoyPzKYB/iXoxuoeRAn/Dqmh0zFziFmEUcpcwq1tWqWZzqJLsy8gdy/i
 ueoVslpVdqWGe4RXV4PVB1p/qOgCyqGaU/PKriGMZNBrsAF8H07kCrHXFQ2K0F4MJ17i
 hkOIooe4DUir4CZ42Buh/Ln04yGGte/hp+hvq76y0winMhvUbhQeiU8lccxJjgEj0jQb
 H5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114785; x=1701719585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6uj3Pe8u6pkzEru6ufenu8J4ehDCjVe7nQFpEbfPv74=;
 b=rXKrODgNcfF+KKzoSIcS8pf4YeqMZGV01/LAaamXyrtyxCnMzB33jxdYdB2L0WMeYS
 snnXKZzEprZ2OI3Uu0Q4qFpB2Y5/xzJb/AhOCZAHbJkYL4cGoWlrCL0Udv9sZ8OZ0NoR
 avTFwKhh7aO/LnYEcpG0iFY2LZkMgVk0vdmLaxHj10uMPyb1CQlLe4nA21VWdLQwCSPg
 w+QINMLjgoL5v7X5fVfS9lMmG5nBVpTVmxDQolHyhaEChw1Urc3k/lLsyJRYzjrls+50
 0rMjQgQPXGYN6y4pBdOovc6DcoNVUoULGGjvn1GmCa5U/OzsvDgyl+HvPy4W5aEnOLZ5
 8GSQ==
X-Gm-Message-State: AOJu0YwNK+L2/xcmg/7l1LodEscZvfIOLKd1Xxd2WsBRVYTmh6S0qXwo
 1UlCRUVsJOHAv3kFSrK6gBHKteXZO+QXgymMRtugcw==
X-Google-Smtp-Source: AGHT+IFat2uP3y6Q5qkn+iTZDHoSll9k+zn3Q5bua3S308Fc+pK2pFRZO5DcsNcj2Kx7hlF6kj+z8Q==
X-Received: by 2002:a05:6808:4196:b0:3b8:4ced:40c with SMTP id
 dj22-20020a056808419600b003b84ced040cmr13558665oib.59.1701114785215; 
 Mon, 27 Nov 2023 11:53:05 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:53:04 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 12/18] bloblist: Reduce bloblist header size
Date: Mon, 27 Nov 2023 11:50:23 -0800
Message-Id: <20231127195029.90951-13-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127195029.90951-1-raymond.mao@linaro.org>
References: <20231127195029.90951-1-raymond.mao@linaro.org>
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

The v0.9 spec provides for a 16-byte header with fewer fields. Update
the implementation to match this.

This also adds an alignment field.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/bloblist.h | 26 +++++++++++++-------------
 test/bloblist.c    |  6 +++---
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/bloblist.h b/include/bloblist.h
index 745bcdd227..57625ea004 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -164,30 +164,30 @@ enum bloblist_tag_t {
  * from the last.
  *
  * @magic: BLOBLIST_MAGIC
+ * @chksum: checksum for the entire bloblist allocated area. Since any of the
+ *	blobs can be altered after being created, this checksum is only valid
+ *	when the bloblist is finalised before jumping to the next stage of boot.
+ *	This is the value needed to make all chechksummed bytes sum to 0
  * @version: BLOBLIST_VERSION
  * @hdr_size: Size of this header, normally sizeof(struct bloblist_hdr). The
  *	first bloblist_rec starts at this offset from the start of the header
- * @size: Total size of the bloblist (non-zero if valid) including this header.
- *	The bloblist extends for this many bytes from the start of this header.
- *	When adding new records, the bloblist can grow up to this size.
+ * @align_log2: Power of two of the maximum alignment required by this list
  * @alloced: Total size allocated so far for this bloblist. This starts out as
  *	sizeof(bloblist_hdr) since we need at least that much space to store a
  *	valid bloblist
- * @chksum: checksum for the entire bloblist allocated area. Since any of the
- *	blobs can be altered after being created, this checksum is only valid
- *	when the bloblist is finalised before jumping to the next stage of boot.
- *	This is the value needed to make all checksummed bytes sum to 0
+ * @size: Total size of the bloblist (non-zero if valid) including this header.
+ *	The bloblist extends for this many bytes from the start of this header.
+ *	When adding new records, the bloblist can grow up to this size.
  */
 struct bloblist_hdr {
 	u32 magic;
-	u32 version;
-	u32 hdr_size;
-	u32 _flags;
+	u8 chksum;
+	u8 version;
+	u8 hdr_size;
+	u8 align_log2;
 
-	u32 size;
 	u32 alloced;
-	u32 _spare;
-	u32 chksum;
+	u32 size;
 };
 
 /**
diff --git a/test/bloblist.c b/test/bloblist.c
index 7e65f30518..be237c6155 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -78,7 +78,7 @@ static int bloblist_test_init(struct unit_test_state *uts)
 	ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
 						     TEST_BLOBLIST_SIZE));
 
-	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0x10));
+	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0xc));
 	ut_asserteq(-EFAULT, bloblist_new(1, TEST_BLOBLIST_SIZE));
 	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
 
@@ -261,8 +261,8 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	run_command("bloblist info", 0);
 	ut_assert_nextline("base:     %lx", (ulong)map_to_sysmem(hdr));
 	ut_assert_nextline("size:     400    1 KiB");
-	ut_assert_nextline("alloced:  58     88 Bytes");
-	ut_assert_nextline("free:     3a8    936 Bytes");
+	ut_assert_nextline("alloced:  48     72 Bytes");
+	ut_assert_nextline("free:     3b8    952 Bytes");
 	ut_assert_console_end();
 	ut_unsilence_console(uts);
 
-- 
2.25.1

