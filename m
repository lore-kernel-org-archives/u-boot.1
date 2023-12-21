Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F90BC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 00:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABA68785D;
	Thu, 21 Dec 2023 01:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jvKFUZxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCC387854; Thu, 21 Dec 2023 01:41:05 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54AD68786A
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78101108e3fso12672585a.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703119258; x=1703724058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqok8Q6IuXM/RkkIsQTcJNdnN87YjGjKxPQ0drZ36+0=;
 b=jvKFUZxW8kUzKTU6TJtEvFPYKFwe1PJfp1BtninmG+yJnwv/yMKPd3aJyrHLK+it2A
 9rzqMWuOLd03iYca0db5pKZY3R0T7oawuvtuTGWBP+7CLXh5i1aZWFP5a8tK95DKVItJ
 +JSskml4EP/vXHKBagZngnBO5a/ocHt8z+blOTLbBJA5kpwxqf1nCThrZDegWxgaA/Fp
 q3j5g0irtmlXiMgjEXjhQqE0qEwZmXmQddul3jKmh9RAjEuscUyFalzUnWRtozrZpiQL
 l6WhIFTJxS7c3J/QD6Z/qu6iBhHZghGoNeQ0o6Ga1rVn1UHdEgzp5Ao/UYaZzrThhUnz
 0jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703119258; x=1703724058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqok8Q6IuXM/RkkIsQTcJNdnN87YjGjKxPQ0drZ36+0=;
 b=kYwh+RYPx0qZGqmsbgnwRebe7J5/rLFTPxuniDLVVGVoZgfYHfSMs4lQgaVIaFpCE5
 hWBPwqTqqgIQ22UqZSxOTZb8pKE1UHus2/4avlcJsKrvLOwR5tiV/k8eTP48wQnHj9Jt
 ELo9VbsFydtIFG2/2bZLsqFksRS+DH1UgwOZY+kaDngY6bQDdwAbG1QaidVyQR6bEtlU
 zefWJdYQI9I/+xFIB86DOPyAh4vTf3nYjO0C7IYIPXqQteWc0iWHnDX0g20UV6BctjS9
 3C7H/uxbdPKF92HVmIjHyXGMiwcAXRra6VraPK4LZGOuDjODkLR075L269ejtMHkoU6s
 /1xA==
X-Gm-Message-State: AOJu0Yzj0jRuS+2kJ8HEAE4hPKwH4KpEOTfQy02+nZU0us21t/X87nJR
 Q3TmpxjIXTNf3p8PvujS7tl9XB3pUq47u2rdPwk=
X-Google-Smtp-Source: AGHT+IGd/G6H0ipP2xR0ArWaKQUXxa3E6Xda7xjIq8kyw+9djtQ39rDXHtYVO+pg10aa/jPnorU55A==
X-Received: by 2002:a05:622a:1308:b0:423:d652:6afb with SMTP id
 v8-20020a05622a130800b00423d6526afbmr30262652qtk.33.1703119258307; 
 Wed, 20 Dec 2023 16:40:58 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 fv9-20020a05622a4a0900b00419801b1094sm354184qtb.13.2023.12.20.16.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 16:40:57 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 2/9] bloblist: check bloblist with specified buffer size
Date: Wed, 20 Dec 2023 16:40:21 -0800
Message-Id: <20231221004030.581388-3-raymond.mao@linaro.org>
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

Instead of expecting the bloblist total size to be the same as the
pre-allocated buffer size, practically we are more interested in
whether the pre-allocated buffer size is bigger than the bloblist
total size.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.

 common/bloblist.c | 2 +-
 test/bloblist.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 193122a8af..be2050611a 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -384,7 +384,7 @@ int bloblist_check(ulong addr, uint size)
 		return log_msg_ret("Bad magic", -ENOENT);
 	if (hdr->version != BLOBLIST_VERSION)
 		return log_msg_ret("Bad version", -EPROTONOSUPPORT);
-	if (!hdr->total_size || (size && hdr->total_size != size))
+	if (!hdr->total_size || (size && hdr->total_size > size))
 		return log_msg_ret("Bad total size", -EFBIG);
 	if (hdr->used_size > hdr->total_size)
 		return log_msg_ret("Bad used size", -ENOENT);
diff --git a/test/bloblist.c b/test/bloblist.c
index 17d9dd03d0..7dab9addf8 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -207,7 +207,7 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
 	hdr->flags++;
 
 	hdr->total_size--;
-	ut_asserteq(-EFBIG, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
+	ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
 	hdr->total_size++;
 
 	hdr->spare++;
-- 
2.25.1

