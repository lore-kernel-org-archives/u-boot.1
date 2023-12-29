Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFCDC47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC9887B8A;
	Fri, 29 Dec 2023 18:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WPV3r7h5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3403687B7D; Fri, 29 Dec 2023 18:43:33 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A3787B84
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7815aad83acso197463985a.0
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871809; x=1704476609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIqlDhDdbzb4305GuwMLNJroe+35MugWs73z4f0LRyg=;
 b=WPV3r7h53n2TVaCNxyDbKDpMnWd2jlk3zKlCYWJRzXtwzSHDFH3LVEin2f1b2zswJU
 TfjVDyhl/ZAdAleEcmQb/NI7CI1CB+MGPcPlY0hnW6sIAOShLnXRQzXqWgMAVD+3ZehT
 wLzASFSerfiPUNi+k+hWMHCnxVaDk8vjfbOyRUZW7DyZPsw7vCOZRtE5YFtxSg8vaX9D
 iwYk7pmwnGS98METbkBiYyEPkgP1ZQpVUWSv5Qv7w+sgbiSPOuaWVZBt7c579yIdJ9TX
 2rtlnPf/IZuwI/7uE7B17PXQmgj7CeqsZzeESyXq+QD2rUhsSWQudM/cS8ZaAz5e7ZB6
 poMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871809; x=1704476609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KIqlDhDdbzb4305GuwMLNJroe+35MugWs73z4f0LRyg=;
 b=q9bkA7HSOIpEO1jhkxj3yA85GGZnMReq0hgi1gu2aH6xTBq69yyX4fXenGdXMQpPRY
 D29ejPPZyZTKuHldWKQdwl2hrNhEiYtTgn955r3nowMeuDzjvPqLxDSXBBm3YD6rDzy1
 IQC5KHg4Qnx0Ot0xmq79rUZNs0IZ5ewBWOyiWzcgJv3PV2FepsmTsFMORCQN5Sk442ih
 ThOb2gQTNHB5e2MtvotUXtDz8lZb8j6fXWIRpa20/J3tulFSaAB5Va4uJSc6mnbgHqh4
 RD9TV4MH9NXjKRM/pjpH6hbV/+is2JiPXBXnEnZcKbkkae+RFawlWVHEXQwEWpsBi0NE
 y1jw==
X-Gm-Message-State: AOJu0YwN23ZMwZWnKA31LrdIZrn6wbZMQ+xm2SXvLIMIc3UK7HwhGzYC
 BsjiT8LOoJr6+0Y0ot1tzYtjfpTDUUvF6Msb9kmpxmNd6Eg=
X-Google-Smtp-Source: AGHT+IGOgejwNax3frFEYAzVcsiQ0oKEYKs640sEaSosRx1Cibpq1e2TUIYn2u/Btpkddx2kAYIdmQ==
X-Received: by 2002:ae9:e64b:0:b0:781:750b:1449 with SMTP id
 x11-20020ae9e64b000000b00781750b1449mr3397762qkl.73.1703871809351; 
 Fri, 29 Dec 2023 09:43:29 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:28 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 06/11] bloblist: Checksum the entire bloblist
Date: Fri, 29 Dec 2023 09:42:38 -0800
Message-Id: <20231229174244.892818-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229174244.892818-1-raymond.mao@linaro.org>
References: <20231229174244.892818-1-raymond.mao@linaro.org>
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

Use a sinple 8-bit checksum for bloblist, as specified by the spec
version 0.9.
Spec v0.9 specifies that the entire bloblist area is checksummed,
including unused portions. Update the code to follow this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v4
- Patch #7 and #8 from v3 are squashed into this patch.

 common/bloblist.c  | 13 ++++---------
 include/bloblist.h |  5 ++---
 test/bloblist.c    | 10 ++++++++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 168993e0a7..5b88c6c6a8 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <spl.h>
+#include <tables_csum.h>
 #include <asm/global_data.h>
 #include <u-boot/crc.h>
 
@@ -319,16 +320,10 @@ int bloblist_resize(uint tag, int new_size)
 
 static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
 {
-	struct bloblist_rec *rec;
-	u32 chksum;
+	u8 chksum;
 
-	chksum = crc32(0, (unsigned char *)hdr,
-		       offsetof(struct bloblist_hdr, chksum));
-	foreach_rec(rec, hdr) {
-		chksum = crc32(chksum, (void *)rec, rec_hdr_size(rec));
-		chksum = crc32(chksum, (void *)rec + rec_hdr_size(rec),
-			       rec->size);
-	}
+	chksum = table_compute_checksum(hdr, hdr->alloced);
+	chksum += hdr->chksum;
 
 	return chksum;
 }
diff --git a/include/bloblist.h b/include/bloblist.h
index 7eff709ec8..255ac8d554 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -174,11 +174,10 @@ enum bloblist_tag_t {
  *	sizeof(bloblist_hdr) since we need at least that much space to store a
  *	valid bloblist
  * @spare: Spare space (for future use)
- * @chksum: CRC32 for the entire bloblist allocated area. Since any of the
+ * @chksum: checksum for the entire bloblist allocated area. Since any of the
  *	blobs can be altered after being created, this checksum is only valid
  *	when the bloblist is finalised before jumping to the next stage of boot.
- *	Note that chksum is last to make it easier to exclude it from the
- *	checksum calculation.
+ *	This is the value needed to make all checksummed bytes sum to 0
  */
 struct bloblist_hdr {
 	u32 magic;
diff --git a/test/bloblist.c b/test/bloblist.c
index 8b435e27ca..49ac4b92ae 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -237,12 +237,18 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	*data2 -= 1;
 
 	/*
-	 * Changing data outside the range of valid data should not affect
-	 * the checksum.
+	 * Changing data outside the range of valid data should affect the
+	 * checksum.
 	 */
 	ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	data[TEST_SIZE]++;
+	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	data[TEST_SIZE]--;
+	ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
+
 	data2[TEST_SIZE2]++;
+	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	data[TEST_SIZE]--;
 	ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 
 	return 0;
-- 
2.25.1

