Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27799C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3DCC877DF;
	Mon, 27 Nov 2023 20:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MmapYZtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17AF877CE; Mon, 27 Nov 2023 20:52:44 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B6A3877E2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-58d1b767b2bso2367192eaf.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114759; x=1701719559; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqVWDxdp9O+Bq5cfpqovn2rXbFlSPuJ0dSyGcxN4mKs=;
 b=MmapYZtFiSLtaIBCTwOUeYnRGMoFAmBHUEJelYNMF6jfKehMY3A8wAwh8y0BMMiHWB
 ZiUj8lvAHGdeYhQncwKEkIbX56VPAUVUMkLxpd5gSMt+ntUMeQ2wipI8py5xrzOKumON
 06oII73sEa3W8wB8FuDisI+RZPZbDePvVWxE5gDAqAQMe9u2mn7LBvHkYxnngnoPhG6R
 uDhHoVw+pBQjpQRVl8MHhtBE/mWOE1ZuNzFNcAQpe6O7d5i/b3VrHxAjmAjrGxaweC4j
 Ahnn73VDbRjq4dGssvPgY9/PNgFQBDstXHYndj89wMvxsr5AYWMQxVOT79H9DN2IDIB7
 2Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114759; x=1701719559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqVWDxdp9O+Bq5cfpqovn2rXbFlSPuJ0dSyGcxN4mKs=;
 b=wRvkito1q75uowMNJeeEu0V9NTEDmCW0MzW5bkuw8v1k5tDfIqNPhoV7B41ciiLXJZ
 lMkWVYrqSq/geuqSpZ47B4n/ZKBswaFmu+We9E49kC8ERuYWUR+tl7fnc0ETRykN5x8e
 XYLtkJSfmoTeoJlsTQKlPF+/YR+XTEkm8STr2+MfzDmqCKYnVK8vEUHZPGqvJqFHi5Pi
 wmOxBWm7FgRXtIDcuWzYWjWWVFR7M+ji0G+EBGIq5AECtMyNt8fNUUoluVU6Y52FMkD0
 rwOeS5iAFy9eRolkgsYV7cFVFsnEeJdhxbh1bf5Cbu7k4LVuodaNF6hlvh0ewMsj5CpX
 Bcxw==
X-Gm-Message-State: AOJu0YxroUesZY5AssY7GcRPs0nVmZSMLdUhykUl0AB/Odvm4m1vYl/6
 ZMXjYCSVolhnOu4On3s7MXPtXhB7Hp2Urtkjq0vapg==
X-Google-Smtp-Source: AGHT+IEPs0lSplG/MjuQbdHeRWBtVqFBRgtiLrPgbJsOi9Y8BPyCjdJjqoUMmCQ/7NluJU4CO1zYvw==
X-Received: by 2002:a05:6820:514:b0:58d:9d79:abc with SMTP id
 m20-20020a056820051400b0058d9d790abcmr2978675ooj.1.1701114759522; 
 Mon, 27 Nov 2023 11:52:39 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:52:39 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 07/18] bloblist: Drop the spare values
Date: Mon, 27 Nov 2023 11:50:18 -0800
Message-Id: <20231127195029.90951-8-raymond.mao@linaro.org>
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

There are no spare values in spec v0.9 so drop them.

For now they are still present in the headers, with an underscore, so that
tests continue to pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c  | 1 -
 include/bloblist.h | 6 ++----
 test/bloblist.c    | 4 ----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 4d01772c3b..691f86f600 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -163,7 +163,6 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	rec->tag = tag;
 	rec->hdr_size = data_start - hdr->alloced;
 	rec->size = size;
-	rec->spare = 0;
 
 	/* Zero the record data */
 	memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
diff --git a/include/bloblist.h b/include/bloblist.h
index 2b898d0c55..d46bf060d7 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -170,7 +170,6 @@ enum bloblist_tag_t {
  * @alloced: Total size allocated so far for this bloblist. This starts out as
  *	sizeof(bloblist_hdr) since we need at least that much space to store a
  *	valid bloblist
- * @spare: Spare space (for future use)
  * @chksum: CRC32 for the entire bloblist allocated area. Since any of the
  *	blobs can be altered after being created, this checksum is only valid
  *	when the bloblist is finalised before jumping to the next stage of boot.
@@ -185,7 +184,7 @@ struct bloblist_hdr {
 
 	u32 size;
 	u32 alloced;
-	u32 spare;
+	u32 _spare;
 	u32 chksum;
 };
 
@@ -202,13 +201,12 @@ struct bloblist_hdr {
  *	record's data starts at this offset from the start of the record
  * @size: Size of record in bytes, excluding the header size. This does not
  *	need to be aligned (e.g. 3 is OK).
- * @spare: Spare space for other things
  */
 struct bloblist_rec {
 	u32 tag;
 	u32 hdr_size;
 	u32 size;
-	u32 spare;
+	u32 _spare;
 };
 
 /**
diff --git a/test/bloblist.c b/test/bloblist.c
index 36994c3dd4..9e51735d83 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -202,10 +202,6 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	ut_asserteq(-EFBIG, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	hdr->size++;
 
-	hdr->spare++;
-	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
-	hdr->spare--;
-
 	hdr->chksum++;
 	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	hdr->chksum--;
-- 
2.25.1

