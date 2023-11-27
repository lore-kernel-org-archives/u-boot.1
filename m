Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E288C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348F7877E1;
	Mon, 27 Nov 2023 20:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tgh+as/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD29E877E1; Mon, 27 Nov 2023 20:52:47 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA27B877B6
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-67a22fb8ee0so11131936d6.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114764; x=1701719564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2d7pJR8VAQN9Qx38OKvCQTYILl6xwZxy1E+hB1FCbA=;
 b=Tgh+as/ddx6JlOJtdoLAzNGfXrZz8vGd5hcMctPPRkKDvkcOPPJWKEKbV+gch98PUB
 yGWnUSIiHCGZ/rRRSgJwOmRjbP9AYJsD41Us3NS+TCXHZML2qrpWcsYdXuEWEQPkRPq9
 nnvBlIQSTx3DDleSCD9LXyiI7Emb9nibaaog2fBesTiPwZaXe17Nn32qRlPsZJXJkCGz
 f4eAJYIHA9UfS+HqM/kqcd3cEqszb6s9tMlzEBzyXmKIsElp9AuI9SRgzjfLMhyEzwQT
 ZJHPZ9XismI61JHbZidj1UIdsrenR+ZpAQxn/f9nYtc1pFYGrM7OmVdyrZ2M8I/hykOb
 3WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114764; x=1701719564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2d7pJR8VAQN9Qx38OKvCQTYILl6xwZxy1E+hB1FCbA=;
 b=L/60UeHEaKJ/w4eca4QiSxoPf4UaSwh0M+ZiW+cXMAQaXVLtmAd+u/tv6rl4Tm/VfO
 diy51oKVUKyMXSpKBYfcuhl5jqxGGAQU/bD9kbLUhUeaa+7AeGfVFeMQNno+8BlWBHzq
 wYRo8/543CfEikedfHA2PSMcu3FbfMipOAuQM4mAf4qAuIo0pPXkaDaIbRzwNb1l/WWk
 ZeaeGZA5/hZWZC91uYRGveFO48rnJQJGAlpr0q4/0MNdqTPAVpJUUIsnpl0HHYUGpWop
 akB3NJ0CZgQ4mF7f5wx/UkagDcTsOkCuUbSyf44f9gmED9L/TweTa/XHsirIzI6W3iXt
 9Q/Q==
X-Gm-Message-State: AOJu0Ywr/LQYA/AAMSXHb/CGcD4ffRoLF1lQ88EEhXEdjnSXGgb8iDKU
 hzNEfknlL8NsyZEakUuH2n/dWYNt/Qm9pG58eH01fA==
X-Google-Smtp-Source: AGHT+IE+j/qTPMS3RKeGAAz6BlY4n3lI3YiyqGsuibudguLbBlPLG62t9dhTNseacPLtovsALQEHyw==
X-Received: by 2002:a05:6214:5484:b0:67a:1e8d:6f8a with SMTP id
 lg4-20020a056214548400b0067a1e8d6f8amr9965446qvb.0.1701114764353; 
 Mon, 27 Nov 2023 11:52:44 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:52:43 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 08/18] bloblist: Change the checksum algorithm
Date: Mon, 27 Nov 2023 11:50:19 -0800
Message-Id: <20231127195029.90951-9-raymond.mao@linaro.org>
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

Use a sinple 8-bit checksum for bloblist, as specified by the spec
version 0.9

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c  | 14 ++++++++------
 include/bloblist.h |  5 ++---
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 691f86f600..70ec0c13e6 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <spl.h>
+#include <tables_csum.h>
 #include <asm/global_data.h>
 #include <u-boot/crc.h>
 
@@ -317,14 +318,15 @@ int bloblist_resize(uint tag, int new_size)
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
index d46bf060d7..ab7a7fc299 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -170,11 +170,10 @@ enum bloblist_tag_t {
  * @alloced: Total size allocated so far for this bloblist. This starts out as
  *	sizeof(bloblist_hdr) since we need at least that much space to store a
  *	valid bloblist
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

