Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253DCC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ABDE8753C;
	Mon, 18 Dec 2023 19:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cSsgR9JC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 329568752B; Mon, 18 Dec 2023 19:20:13 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FCF48753C
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-42594f0ca09so22547301cf.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923609; x=1703528409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcGiS27HGHxffo+0P3QXhe9RPcCqwVdnMMivCHX/FoA=;
 b=cSsgR9JCFqPJ5iJk+nLgfIEnmkBOsKQf9ofKxlCkbqlOpHc5AbcKWwXQ+eQv/okzu3
 igA/FzGNuHjCMRO8hGhvSuC101uyr39pa9WtRpx4pEQ0AYLF7Tk6a/TxORmE1aUeTc1q
 6rnggqAlC0cfvg7EZjcDS+E6L8Q8TEEYRs+USQNy1GZhpiUajKk4pjPDOCyUvrC8jyvY
 IFfaojXxpMFpGG31Ct/GgvH0E5o31r/rPqp/5g5C9e1+DMzNc5GmPS3qvCdxiOxiakKz
 3zHq/d8qj0u+J0T84usHR4MdiwYIGnX7snjVk7XD1BoVopNxkcnhM+Su137NHYJ6iYYW
 riWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923609; x=1703528409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcGiS27HGHxffo+0P3QXhe9RPcCqwVdnMMivCHX/FoA=;
 b=OMGHXU8mCOFPfzmJgMh1ogq+G+JS4irVY5nvv1XZS921yDfVUTWmWcsLHc8ZLPtR8i
 bfAVFPotkMPvhOjYgCbyzSZpgl4zpwJmCe1OspKIPxCCQDETAW7P3BlD4zDoOmjAQSqN
 TV4mhAbpYzrcQ0UH1z40JsTOPqCtatWxJdTTB6EECsR7ASOt+VfXrwBGMaoTPwTopJ1X
 wTogaQm6xEh35tYq5YqaG/vVF5s3TusszpAUdELUaTeB9zrnaIIoLvlamJX7y6CgdYPO
 54z8jMdQwBtbi5qJhWDsAWLABYaqv9IuSaXQKLSMKQTLE/2d9GJIql/glyKhY1H2oo36
 DBww==
X-Gm-Message-State: AOJu0Yw60riE2+9zK8RfuxtM/Jc50x2arSzk1ZGpRrbLVKSF2RFhINB9
 2tTc4j46NIHZPBnfP118ipmwFqsAEciYG1KKBEk=
X-Google-Smtp-Source: AGHT+IGYOzRXJnixcmsx1Q+EMkDKxvpp3/xz30mEZQ7EQB3Du6gaQ7Eh8lAoaNsCDtRahL1nbdt89A==
X-Received: by 2002:a0c:ff46:0:b0:67e:f411:2254 with SMTP id
 y6-20020a0cff46000000b0067ef4112254mr7730209qvt.6.1702923609641; 
 Mon, 18 Dec 2023 10:20:09 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:20:09 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 08/14] bloblist: Checksum the entire bloblist
Date: Mon, 18 Dec 2023 10:18:53 -0800
Message-Id: <20231218181901.337515-9-raymond.mao@linaro.org>
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

Spec v0.9 specifies that the entire bloblist area is checksummed,
including unused portions. Update the code to follow this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c |  9 +--------
 test/bloblist.c   | 10 ++++++++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 32692d8319..705d9c6ae9 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -319,17 +319,10 @@ int bloblist_resize(uint tag, int new_size)
 
 static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
 {
-	struct bloblist_rec *rec;
 	u8 chksum;
 
-	chksum = table_compute_checksum(hdr, hdr->hdr_size);
+	chksum = table_compute_checksum(hdr, hdr->alloced);
 	chksum += hdr->chksum;
-	foreach_rec(rec, hdr) {
-		chksum -= table_compute_checksum((void *)rec,
-						 rec_hdr_size(rec));
-		chksum -= table_compute_checksum((void *)rec +
-						 rec_hdr_size(rec), rec->size);
-	}
 
 	return chksum;
 }
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

