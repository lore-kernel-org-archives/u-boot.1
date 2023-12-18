Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBD6C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F8A875B9;
	Mon, 18 Dec 2023 19:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sLbTroEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5318B87578; Mon, 18 Dec 2023 19:20:18 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F34A87561
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 19:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-590711b416fso2344380eaf.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702923614; x=1703528414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xgb2cKdn7cOAUVgfIbnLpCQYwhDWdtB6PDT7Tm5ir7U=;
 b=sLbTroEK+IOI94e/B0z6SopuGXboySe8CqIEh4zAyqZyi1wnMjDS8UCo1bcpPjvwgz
 HmT9goOUtpzROTQWe0I0c+F5EKvJgocWxiSSZDU5gKgHKYbKjnT0azCeiwFwQtBeeaVv
 5DIiIYStUM4nGpikscABeIvL0OIiqhGvKZ4MGFV2IlxePm9lMOXUd0AUUgtEGrbe0eg6
 5EJWnjEaO81jo03Fnci5MyWrDYAvd7l5q97VHpdLEDwtFhHarTg4hrVInITX+IctiByU
 4EYSkLypY7g/+AI9Fhvv3ucLGkNZCGZSLPuEBOtaiR0LygOfbU7GUQK+KQj9Ch5lzEQS
 Vgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923614; x=1703528414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xgb2cKdn7cOAUVgfIbnLpCQYwhDWdtB6PDT7Tm5ir7U=;
 b=aH1JcS/QlbeGJvpR6j0/5g2KWI69J211eK/KCp/1C+hoZrS6H/t01pShpKFWTcHDbu
 9ONHnYpBAhac6MZY1RARMRwxfM1MQrXMMimvDPlHNLnreY2GdBzC1zk95gMl9F1Rue4t
 5FRQVspAYKZS+yvBWZ/fQZG9twTtVY9B4Qd/U4GZvGcl8IF+10jZGNG0vkPIrn9zIvzA
 dMmcyirMup96xUKIU/z58HpkfayTYkzImDa/zw26uNlZaZ8ANZCe8C2huTbHUcqZmCXh
 /p2HPKckQtUgU581aKVI6LBIIfT3IG8kgOWNSpT76+YtBrgmk7JMViSkX5c/hsRo0VUo
 UwjQ==
X-Gm-Message-State: AOJu0YxVqHm73O04b+1Kwm7oOdMYBJBFl/F06EBCCH8l+zizr33lLeKW
 CAIhUL9OADSY5G7Piyrm3DggC1yoCji1EHVQMpQ=
X-Google-Smtp-Source: AGHT+IGu88zN64Rtk5DtWvQ7O3xwujxsNLOrfNWRcI+NYt/Vc9YcI0Rj39OWyZvm02YraQhXZ1TTqQ==
X-Received: by 2002:a05:6358:52c6:b0:172:8976:49be with SMTP id
 z6-20020a05635852c600b00172897649bemr13482141rwz.34.1702923614597; 
 Mon, 18 Dec 2023 10:20:14 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dy7-20020ad44e87000000b0067f213933bdsm3046136qvb.2.2023.12.18.10.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:20:14 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 09/14] bloblist: Handle alignment with a void entry
Date: Mon, 18 Dec 2023 10:18:54 -0800
Message-Id: <20231218181901.337515-10-raymond.mao@linaro.org>
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

Rather than setting the alignment using the header size, add an entirely
new entry to cover the gap left by the alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 705d9c6ae9..73dbbc01c0 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -142,7 +142,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 {
 	struct bloblist_hdr *hdr = gd->bloblist;
 	struct bloblist_rec *rec;
-	int data_start, new_alloced;
+	int data_start, aligned_start, new_alloced;
 
 	if (!align_log2)
 		align_log2 = BLOBLIST_ALIGN_LOG2;
@@ -151,10 +151,25 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec);
 
 	/* Align the address and then calculate the offset from ->alloced */
-	data_start = ALIGN(data_start, 1U << align_log2) - map_to_sysmem(hdr);
+	aligned_start = ALIGN(data_start, 1U << align_log2) - data_start;
+
+	/* If we need to create a dummy record, create it */
+	if (aligned_start) {
+		int void_size = aligned_start - sizeof(*rec);
+		struct bloblist_rec *vrec;
+		int ret;
+
+		ret = bloblist_addrec(BLOBLISTT_VOID, void_size, 0, &vrec);
+		if (ret)
+			return log_msg_ret("void", ret);
+
+		/* start the record after that */
+		data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*vrec);
+	}
 
 	/* Calculate the new allocated total */
-	new_alloced = data_start + ALIGN(size, 1U << align_log2);
+	new_alloced = data_start - map_to_sysmem(hdr) +
+		ALIGN(size, 1U << align_log2);
 
 	if (new_alloced > hdr->size) {
 		log_err("Failed to allocate %x bytes size=%x, need size=%x\n",
@@ -164,7 +179,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	rec = (void *)hdr + hdr->alloced;
 
 	rec->tag = tag;
-	rec->hdr_size = data_start - hdr->alloced;
+	rec->hdr_size = sizeof(struct bloblist_rec);
 	rec->size = size;
 
 	/* Zero the record data */
-- 
2.25.1

