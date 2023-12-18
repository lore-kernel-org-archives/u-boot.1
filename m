Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C23BC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6462387575;
	Mon, 18 Dec 2023 19:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eOH9ZyWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 721EE8755D; Mon, 18 Dec 2023 19:20:09 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E0F870D5
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-77fbc9020deso245261685a.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923606; x=1703528406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsOOx1WArnF4SRibehvqwTRxmHtCiqNXEjhUB3FZAJk=;
 b=eOH9ZyWwBebQ7JsvddTD/Bt4zfdcSjb6ffutBFIlZdxXOfvrE/M39mapByBbwLRBZP
 HECCsDRyqieE0k57NDpcnxx+/8hfYW43pukDAf2WkBlTe7OyiZEtE3u7gdDSg+JO6F+B
 yBUgNroes6M6GN6arlfmifUA2jgjmuvWPdK2MYKyYgWS2Uu6oWXyPaTg08F45Cag9aQk
 dmDCikYiH4GoTw+SGPSxGBuJO+s4J9+aCLnxlFutqoH0Ru1Jig5Doh/AB/YvyJktgzwB
 nd6gYNO7zWg+/HHLrGD6pJf8rTFCkU2etNgEXQqqREDxSZtAwjwa/U63w4Y593EkJMQu
 G4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923606; x=1703528406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dsOOx1WArnF4SRibehvqwTRxmHtCiqNXEjhUB3FZAJk=;
 b=knFZLE3ROp4R6Xdy2/HqbqXgRD/lJqSxrjp3cPUx5weTonxuG7eqGwm55ODeVYv8QM
 +u2NANEzuXAGXnNPFzqloJnOIZ0BJA4MV9jCWjVbrEQdDwNA232+K7dUI3guVlQq7zOj
 EqbD/BMa4bLs/Exe/yJ3AZTB/g11bn1E3VIo1WpZ/Iu79wYTsIFN5PU0FTj/FDxf/pqG
 aftghP/edcPB6Y/PiTe0qOQpUykOvvjQ2f4mIdPD+/ywst3c58y23KgPCTQ59j9Bowiu
 Mhk3KxuGOz5Gc6aNrN8er3PiQQM2YYWwmBCTWoTouFJx68CbAOznHp1Qp8psk2JEdE1y
 vswQ==
X-Gm-Message-State: AOJu0YwxXuvwqH9R8/QFsMTM8XZooJVkd9dFFiWknkWDFdKF3pxWSB3A
 ZX4n5O8dpA1TzSfB61Ije2+5G/NTPJFCNtB0+Nk=
X-Google-Smtp-Source: AGHT+IHfSvQ60uYcbPkR7pDYQGNh6FKtjDuBQdZyBuRGm8JnoYJBHjRJmnnehSPh4W1T5APQD6fRtw==
X-Received: by 2002:ad4:4708:0:b0:67a:ba4c:6f69 with SMTP id
 qb8-20020ad44708000000b0067aba4c6f69mr18556892qvb.22.1702923605758; 
 Mon, 18 Dec 2023 10:20:05 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:20:05 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 07/14] bloblist: Change the checksum algorithm
Date: Mon, 18 Dec 2023 10:18:52 -0800
Message-Id: <20231218181901.337515-8-raymond.mao@linaro.org>
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

Use a sinple 8-bit checksum for bloblist, as specified by the spec
version 0.9

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c  | 14 ++++++++------
 include/bloblist.h |  5 ++---
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 88e2a0f5c0..32692d8319 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <spl.h>
+#include <tables_csum.h>
 #include <asm/global_data.h>
 #include <u-boot/crc.h>
 
@@ -319,14 +320,15 @@ int bloblist_resize(uint tag, int new_size)
 static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
 {
 	struct bloblist_rec *rec;
-	u32 chksum;
+	u8 chksum;
 
-	chksum = crc32(0, (unsigned char *)hdr,
-		       offsetof(struct bloblist_hdr, chksum));
+	chksum = table_compute_checksum(hdr, hdr->hdr_size);
+	chksum += hdr->chksum;
 	foreach_rec(rec, hdr) {
-		chksum = crc32(chksum, (void *)rec, rec_hdr_size(rec));
-		chksum = crc32(chksum, (void *)rec + rec_hdr_size(rec),
-			       rec->size);
+		chksum -= table_compute_checksum((void *)rec,
+						 rec_hdr_size(rec));
+		chksum -= table_compute_checksum((void *)rec +
+						 rec_hdr_size(rec), rec->size);
 	}
 
 	return chksum;
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
-- 
2.25.1

