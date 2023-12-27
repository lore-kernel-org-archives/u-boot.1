Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC646C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2BE2879CE;
	Wed, 27 Dec 2023 22:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FTA+Mlxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A344D878FF; Wed, 27 Dec 2023 22:08:12 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66A91879E8
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78117e97becso361613585a.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703711289; x=1704316089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsJN3Xq1sz1J8fWmEStFmoSnVOgNER7GlBiOGQifkfc=;
 b=FTA+MlxaSKciweeEyO+axtjaXKiIfzXyuRWuANvcS0DzWYtc0h+E6exDJDMijHpVtn
 uLh4fJD4Y1ajTrL37bs0kKntrCoEDP8k95sHqjU1EHU3I9rGdfcXtwepCHYgzUMxB+0U
 O7EKglJm4xo+2v2M7FL/MNtueuKPz62EidXOBu9oME9a4F8VgyiHdLekilliEIc0QH8q
 YfvI/Oe8RLx+XkgniSuP8e4WP9kzKRuPW5H9FTqhagUKn6Sr24vTzFQ8Wwgvn+mdZIFf
 17ATikwUikuh4XSu7oA/JsCJpnsPP6G9tcKsrNEouza4yMKHY68H27A1zb8oz6jNgYZP
 HA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703711289; x=1704316089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wsJN3Xq1sz1J8fWmEStFmoSnVOgNER7GlBiOGQifkfc=;
 b=sdA1+IqmsU/F5EU4DW/6YF2VrzA4qPQgASdljnoGveDiXcvqnF/3Uv7OxXd9w140Tw
 FkbMPvLsGMBjhodTUA/JIgxCLt+nLP+CXWwNTtyQdxetgYgjPVhGR6/L2jDCmQiEUTPU
 Hy9+35Rn3OZ+sjj7/160iH+BZatinPJY95L3qKq7cW61yqWyNReexgPnNyvxLChwgbgc
 UEcPzAB/5HBqdSnybwSZLMKDpR7xFLVo0IOVlm4k8J7POiOfcGYgvrzqJ8GQRUwuTIot
 3XoAILpRCFiUQhN0EBGcz5X52z995hND8qJ8OHRtG67jYSI+vbsUnhf4E6WZmnSeWlE0
 gvtA==
X-Gm-Message-State: AOJu0Yywm0oqUAYorEsu7Vb3nsmOV8pzsQum3VqNTaKTQcG0nTCumQas
 qqD+JDVotptTXOLZW3qB81En3gKUnVpmd4cZJLIvZBWYGKk=
X-Google-Smtp-Source: AGHT+IEVG6aE7Dzt+Vw8L0z1wM6FFAdAfiFbEReCt8QedV4Nu4YBkX/axYYCd+/nPkwPmwmA9Tm5RQ==
X-Received: by 2002:a05:620a:2843:b0:77e:fba3:757f with SMTP id
 h3-20020a05620a284300b0077efba3757fmr10866502qkp.119.1703711289084; 
 Wed, 27 Dec 2023 13:08:09 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b0078161897afcsm637107qkk.109.2023.12.27.13.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:08:08 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v4 07/12] bloblist: Checksum the entire bloblist
Date: Wed, 27 Dec 2023 13:07:05 -0800
Message-Id: <20231227210712.712937-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227210712.712937-1-raymond.mao@linaro.org>
References: <20231227210712.712937-1-raymond.mao@linaro.org>
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
---
Changes in v4
- Patch #7 and #8 from v3 are squashed into this patch.

 common/bloblist.c  | 13 ++++---------
 include/bloblist.h |  5 ++---
 test/bloblist.c    | 10 ++++++++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 88e2a0f5c0..705d9c6ae9 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <spl.h>
+#include <tables_csum.h>
 #include <asm/global_data.h>
 #include <u-boot/crc.h>
 
@@ -318,16 +319,10 @@ int bloblist_resize(uint tag, int new_size)
 
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
index 68f97395b7..d2dcad69a1 100644
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

