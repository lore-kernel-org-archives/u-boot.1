Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D969E77180
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 22:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 849D7800D2;
	Fri, 13 Dec 2024 23:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FWL226Bx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5DD2800D6; Fri, 13 Dec 2024 23:55:58 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62926800C2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 23:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d92cd1e811so31931586d6.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 14:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734130555; x=1734735355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sXEUyw5iudYsqNCtwuS3EWdMb81+3c+KKbtrVT0v+Ik=;
 b=FWL226BxHfmbL/Kny2I7QPGYvCkNuN5gUNPE3a463aTGilL4S+gdNOVq9QRf9YdkyO
 +ospLFnzMO9HuproH9xIxaG0T3+X3gAv5KfgXx9O9zVfZkwBtp22oY6kY2kezDwj6fsC
 Qgw5Vkjpz7iDs7HrjkTN1es7DY+tiSsqK1+S30HAeYdF6PwrlRsJXyC/IsS6acz2Nl0b
 dp5cAFfscTy3kU6pPmdOj7BWzAr49C6OwQ1+Q0FSMFxAxBy8zzXZilRrbFJdsVDkBeY1
 4596U7xaYYz4ig3+FplODLwfXxkAFfGwgiGLq/PBBY7/PI66fyhH2C3AR5tj0P0TIZyp
 ODzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734130555; x=1734735355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sXEUyw5iudYsqNCtwuS3EWdMb81+3c+KKbtrVT0v+Ik=;
 b=Za0nJi4UC/tFGnTcfHEnQNWVs6Izy/P0XGyTQ3bhBmlNJwZR1XYk6Z52QGgN8x6VzF
 j206LzpscbOhWjXunmnvJFwob5KZIN/DmgSAH2SXQXpIP6MZU3rAQdNHEiAdlivUC8tH
 j5LL+KbkS1eWmmG+mpQI2E26NQAevJyASrrLLcVfAa3faLBZdJM604D2ypOjg/IrwW3X
 1qIAEmI9yEJ1V0xvbpGzVBDsltWraQyW15XXnroN8xJRTuZrBFq4O1jlrmctGoYsXOHS
 WecnRcMHNjQKcd7/a6RD7WvbsEfIChq1gBd+rtYUVvxwF2R6Zw74JPPElazvMb5y/TKh
 OPfw==
X-Gm-Message-State: AOJu0Yz4uGAlyhpAw2i/MPgPuMzKI9NcGx6gSqcpUH9XDFoSfqt40I4E
 yo+A12yv0nG0V+4vEN4DD30bjgSIKmr4jvYSf0SgBIO9C+wnZXbaAYo3hWPfTBDTYdbe6ejDznm
 8
X-Gm-Gg: ASbGncvke9V+zaTZ7TF5dmClvXIa+ilMBwkfFwavmx0acErKhWVu1RIEDGRhqQFGyzt
 lLkTzVQgrLNB7PC/j+CXcy7yO7u5/8pv+7Ng7/qrvNNKVBjqP/chUjBtxJsLrE/AO94le+9sQDw
 GLcoZaOF8CXS8NxX60MRifFhP0lYwuXTh2BnXLDjNfVWcQK7Dc8LXC0GzACl508u5IAbLHvdG60
 X3jj14c6FPgktyi20mMbF+e78BBDiJ8PkVGSat4vSvchbPvtEXj5N6KTsdP5WCgT4G0tjicUeof
 OwRsd/TSjMN0VO2UFvdyjcxmkQvUSHMoASkaWNNWzscIFWxCjSTC5DY=
X-Google-Smtp-Source: AGHT+IGuElUaxYS1NuhIzQ/g4IKxhM4UWBYyKQiQL0B1ucY+uzj5e3BLLS2me/D0EsZC76x2sZnZwA==
X-Received: by 2002:a05:6214:3002:b0:6d9:429:ab4b with SMTP id
 6a1803df08f44-6db0f241e68mr111855916d6.0.1734130554773; 
 Fri, 13 Dec 2024 14:55:54 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd366196sm2084106d6.80.2024.12.13.14.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 14:55:54 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH 1/2] bloblist: add api to get blob with size
Date: Fri, 13 Dec 2024 14:55:39 -0800
Message-Id: <20241213225543.392282-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

bloblist_find function only returns the pointer of blob data,
which is fine for those self-describing data like FDT.
But as a common scenario, an interface is needed to retrieve both
the pointer and the size of the blob data.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c  | 17 +++++++++++++++--
 include/bloblist.h | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index ec6ff7a5a9..efc1905da3 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -222,14 +222,27 @@ static int bloblist_ensurerec(uint tag, struct bloblist_rec **recp, int size,
 }
 
 void *bloblist_find(uint tag, int size)
+{
+	void *blob = NULL;
+	int blob_size;
+
+	blob = bloblist_get_blob(tag, &blob_size);
+
+	if (size && size != blob_size)
+		return NULL;
+
+	return blob;
+}
+
+void *bloblist_get_blob(uint tag, int *size)
 {
 	struct bloblist_rec *rec;
 
 	rec = bloblist_findrec(tag);
 	if (!rec)
 		return NULL;
-	if (size && size != rec->size)
-		return NULL;
+
+	*size = rec->size;
 
 	return (void *)rec + rec_hdr_size(rec);
 }
diff --git a/include/bloblist.h b/include/bloblist.h
index ff32d3fecf..a04c7c80be 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -250,6 +250,24 @@ static inline void *bloblist_check_magic(ulong addr)
 	return ptr;
 }
 
+#if CONFIG_IS_ENABLED(BLOBLIST)
+/**
+ * bloblist_get_blob() - Find a blob and get the size of it
+ *
+ * Searches the bloblist and returns the blob with the matching tag
+ *
+ * @tag:	Tag to search for (enum bloblist_tag_t)
+ * @size:	Size of the blob found
+ * Return: pointer to bloblist if found, or NULL if not found
+ */
+void *bloblist_get_blob(uint tag, int *size);
+#else
+static inline void *bloblist_get_blob(uint tag, int *size)
+{
+	return NULL;
+}
+#endif
+
 /**
  * bloblist_find() - Find a blob
  *
-- 
2.25.1

