Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A16C0755A
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388CB877EA;
	Mon, 27 Nov 2023 20:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FwccDw1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6F81877EA; Mon, 27 Nov 2023 20:52:57 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330C7877F3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-67a3f1374bdso8805866d6.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114773; x=1701719573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WhV+VsO6GrOoUbkIrAgA9vE69hwX2zZ+GK9SYDX9kz0=;
 b=FwccDw1m99IKNMiUxOxhnkcGiSlAmDjRtG8cGePUKskkHnlmio4fLrnHktmnpK8viU
 cuti49Wzdt1nq8EKFkL9/glrAHGeJf01dfvRE1qjX0NaeI141BHMLxqe1phhV7kN6thQ
 7kvSTR09KzREBAJ5vjXMBdBrBY4oUvn0cjTApCS0L3gSidHnrhToQ/K66xf8uEkm2IdO
 GJScWBD1h/bIQiWG/MqQy3hA75Uj2MdVe5u0ViR17ydKSzPhbv5/UWbfMVihv+pC2PZo
 FIuKqjdaEpbiQ74BLFuDG+wQ7+xtdmQVg6HHNAuNIa/PErLrMCC7rTBjRUBursLOFjGA
 NZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114773; x=1701719573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WhV+VsO6GrOoUbkIrAgA9vE69hwX2zZ+GK9SYDX9kz0=;
 b=JDfsY1wGZEuYtMcn5ka52T/Aq2dO0/tLtpvfMnYTS+x4/h7KmgjvA3qmZ8i7Heg1SV
 ZS73V8FtEt+wtOdyXQLMR8Kvsb+5IvcAl8h46h2KYTXZZ19prio41UC+ddKuRjN+wmer
 T3M+YeI1Fw5sKQH1BiWjC6en2zYVPLDzZEpweIbc7ex25R6Pb1k4JTZ/yGYSWXvQQ7mj
 Kytj5YrdVLX6C4cRKKzcm3SiM9bIixaoTuaS3qCstQSfliXO8YPiucmhzmT8a02Z4LWZ
 bGq0xxatQ6PRGz6kk7FctpB9N8v0pnNdoeq0h5fkUXB5W7iV58+JNXRvmPNs4qdFRYnq
 pxCQ==
X-Gm-Message-State: AOJu0YxPT/pbrGZVHg6m5h1GofV4U4J5k8JGHX1mn6+yBSikNBnLuU77
 1BZkzFljgJJ4VV8UodGkUkVzY5uTe3ViINru8Uo=
X-Google-Smtp-Source: AGHT+IEQGMtUl9r/f/XiXEKfRkCJIEs0ZIciz1UQARgi+4DI83XC0mujnu0MN3Wozp4Pz+urdGdSXA==
X-Received: by 2002:ad4:4ba1:0:b0:67a:37b9:bb5b with SMTP id
 i1-20020ad44ba1000000b0067a37b9bb5bmr6807815qvw.38.1701114772835; 
 Mon, 27 Nov 2023 11:52:52 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:52:52 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 10/18] bloblist: Handle alignment with a void entry
Date: Mon, 27 Nov 2023 11:50:21 -0800
Message-Id: <20231127195029.90951-11-raymond.mao@linaro.org>
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

Rather than setting the alignment using the header size, add an entirely
new entry to cover the gap left by the alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 96e0a167c2..59a092d4cd 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -140,7 +140,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 {
 	struct bloblist_hdr *hdr = gd->bloblist;
 	struct bloblist_rec *rec;
-	int data_start, new_alloced;
+	int data_start, aligned_start, new_alloced;
 
 	if (!align_log2)
 		align_log2 = BLOBLIST_ALIGN_LOG2;
@@ -149,10 +149,25 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
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
@@ -162,7 +177,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 	rec = (void *)hdr + hdr->alloced;
 
 	rec->tag = tag;
-	rec->hdr_size = data_start - hdr->alloced;
+	rec->hdr_size = sizeof(struct bloblist_rec);
 	rec->size = size;
 
 	/* Zero the record data */
-- 
2.25.1

