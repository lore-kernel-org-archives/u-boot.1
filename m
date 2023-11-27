Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF8FC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A67DF877E7;
	Mon, 27 Nov 2023 20:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KulfFiJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E19C1877CE; Mon, 27 Nov 2023 20:52:51 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74E3877E9
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6d7e6df999fso2942614a34.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114768; x=1701719568; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cR38NYaQI7+G05R5vss0lLqgOF/bfkrev+5uneFitP0=;
 b=KulfFiJZ2MDThD/zmuYikg4s2DYa2mu+gb3xQZApx6xO6ppTcUXG/akA0XmeRxR5g/
 bK4gfVP9VDddbyLL2Wox0ecIJp6j6Hf6Pb6SCtcSE0aeBofS2lx21S7WdsoTcRh9xC0E
 WLy9Yf5Xg6E7G5NbA2f9M5HIvhr+c9nA+0zd494Kcai+VFwPfAN5Qsv333p6cOjSHTXc
 SetAoDx+zd6tDAuVhYfN5VQRALcBrbvc4r+lYspHaqr/pdHqkj3TX+D1tPcC65Am3qHi
 VHaxig4KwdBhgJgRVmP5vCtJMTnw0YRI/nDTFDPsiryRaFKZ0MhRAv+8bDifnI4Si6gn
 dHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114768; x=1701719568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cR38NYaQI7+G05R5vss0lLqgOF/bfkrev+5uneFitP0=;
 b=KSYP/hns/F2CtA0Uz8LP6FLyECdGkvgqD61kNrrNfB+tLdfdW3VhNxEABpJl/2Byrw
 /OBn4SOygYpyHv+9dpisZaM2VIytj2mI8nn/ptk1KoKVmgw7wXXhCnWW8xxzVyqs4mFd
 5ebujtfB6/S1IYW3jq2tD324LjTHO6v9AAqcfHDw8oUmpI7lAq66xdQezvPNb9g3d2Zz
 CD6VteOE7cNv74ZsfBQnIGRrLX8KT4KA/JsX5gl8ryjVzFjMA0vGbs3a5L6z95BubJbx
 mvCp9fKa81LukWi2Tsu8w0/33MKYQL76Kk2sm6hE8rxUnuCwGcLmXNo5WjQtzDENGrSY
 dySw==
X-Gm-Message-State: AOJu0Yxh7YWMKXIY8OlYXlxzWtG3elewvbvpQQcnIszebOVUV3UFv007
 Cbzos0sYt9XUyAQ5pOYaHGkzl1gZk2Mc/2tOF9jmFg==
X-Google-Smtp-Source: AGHT+IGPOZ0xixn9Ve56x3CLWRnN4xEtx3aoPmoqwBIxRtqEtTbF8AIMw7TRiHEp6H1YRLSZ2KjreA==
X-Received: by 2002:a05:6830:3151:b0:6d8:16ab:2b10 with SMTP id
 c17-20020a056830315100b006d816ab2b10mr9596113ots.10.1701114768316; 
 Mon, 27 Nov 2023 11:52:48 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:52:48 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 09/18] bloblist: Checksum the entire bloblist
Date: Mon, 27 Nov 2023 11:50:20 -0800
Message-Id: <20231127195029.90951-10-raymond.mao@linaro.org>
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

Spec v0.9 specifies that the entire bloblist area is checksummed,
including unused portions. Update the code to follow this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c |  9 +--------
 test/bloblist.c   | 10 ++++++++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 70ec0c13e6..96e0a167c2 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -317,17 +317,10 @@ int bloblist_resize(uint tag, int new_size)
 
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
index 9e51735d83..32256be772 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -226,12 +226,18 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
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

