Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FC4E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8AA980107;
	Thu,  9 Jan 2025 16:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M8P37syr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A134F80601; Thu,  9 Jan 2025 16:09:39 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5525B8005B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-467a37a2a53so10240041cf.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736435376; x=1737040176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jh3E7vzoxDYdkl3v4fYsLXr2VlBMnc6oyBKvL9uteaA=;
 b=M8P37syrbo4sWQ73Fwhs/NcuQeGjZcNkBMSC126sQn5N/FVVHCKr1zuCKqpZgx2Cp0
 PuzynCzWcU0FGjB++UlyAu1+HQ+h2v6wdrkuXbx6nQRgPz5BUOivb4Rg67SlSsPwWq+g
 H60G35d9OgxUWytEhORBOdFOlKKBYAKdr7WJa4SMsGNzy8JFvHpfHreH58wNkaRAb2PA
 Z/9tvt4mRK6uYgpr8e/LZxdDrnvuNbRvw5F19vWfGM23GHMUnPLrWUdtiPIfKyPd99tP
 bx0foq7ccQwRjoiGr7JbzHUcM/yYiD4mayft8QJr4ESrBv2+MdJlF/rpHDOfSvNhkZDm
 Bq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736435376; x=1737040176;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jh3E7vzoxDYdkl3v4fYsLXr2VlBMnc6oyBKvL9uteaA=;
 b=fb2KpC0ppHqk2GZWZ6+Y+HPkH0Rh4E96zeSqudvDxFoe48A9/U0OFYkF6tmtEntrGM
 DIf7EbeRKu91KGUIFBmnnW3mMoki1F6w1rlXRIBO1I63bIEhpa3TJ4VN3JeLVDVl4V4G
 WqiBV1l2reYw3/bwotnFRAUVPHsX2mKnn8KieLt4G9qRONiJiVWElSbD2w7RjK0iPSBs
 F3p6+di0aIvZ626nxh68NnZBiwUUsaqOZUwpT3N2pTonQSrJCROfUY+vFtCeH54G7PWf
 YdR2ACVIC+wy/H/3kUlxVNMz+NN1xKd/iqucSpsBNB5OPdKrXUEYIUnGx13OF8HnhbT0
 MmXA==
X-Gm-Message-State: AOJu0YxTBniwg1KOmRoxCR53I5v8PewRZkRJnZYUoivhbfKzhiK+Zsw7
 znzz6MlZZWcpPDZhmv+jY3tY73CmEE3nmn5uq24BjpYhNZYRgJBnowrQ4SescQxSxHcFMRgxQkk
 iwss=
X-Gm-Gg: ASbGncuxjjcHc6BCWfkCmqlLPVvU/V1yg/IP+ecdNqTo3qL1DNEKYQxR7+mlGa+abuf
 LzVHHJUOcV2/Snue1YwFMumPCBOUMs4E9uyjfhE3qu77FBeKL2BaZ1B0kKoSbjAwm1YSqjBIraW
 N34FQ6xrV57hiJRmzqHNjPfmg7FZZa2ntJP/u8j2vYoN3XvonYkPUY0dTpEf2Y7UFzwZI/J/yBd
 Nr1Xnt+RDyWe9ZtAly6mZsw3M3G2+48NsrqCDyhBnz8az1sLpgB7fCoJUwXa6eDIxn8PCKpANel
 7kFuCj1tC100EJlQW1GqWXz7ck6c/ThgqlLYbEbE5g3Q8wp5dL91FS0=
X-Google-Smtp-Source: AGHT+IEdVauyB2Yedo28iPpnstysKEN6t3wrhPXdMU3iMrCzBag2500RSiusSdNJDgbT93VFWIy1pQ==
X-Received: by 2002:ac8:57c9:0:b0:467:73f3:887d with SMTP id
 d75a77b69052e-46c710467c9mr98324361cf.33.1736435375939; 
 Thu, 09 Jan 2025 07:09:35 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e4fdf93sm206396451cf.0.2025.01.09.07.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:09:35 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH v3 1/2] bloblist: add api to get blob with size
Date: Thu,  9 Jan 2025 07:09:22 -0800
Message-Id: <20250109150928.878849-1-raymond.mao@linaro.org>
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

Add a few ut test cases for the new api.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Rename function argument.
- Add ut tests.
Changes in v3
- None.

 common/bloblist.c      | 17 +++++++++++++++--
 include/bloblist.h     | 18 ++++++++++++++++++
 test/common/bloblist.c |  4 ++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 110bb9dc44..ab48a3cdb9 100644
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
+void *bloblist_get_blob(uint tag, int *sizep)
 {
 	struct bloblist_rec *rec;
 
 	rec = bloblist_findrec(tag);
 	if (!rec)
 		return NULL;
-	if (size && size != rec->size)
-		return NULL;
+
+	*sizep = rec->size;
 
 	return (void *)rec + rec_hdr_size(rec);
 }
diff --git a/include/bloblist.h b/include/bloblist.h
index f999391f74..52ba0ddcf8 100644
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
+ * @sizep:	Size of the blob found
+ * Return: pointer to bloblist if found, or NULL if not found
+ */
+void *bloblist_get_blob(uint tag, int *sizep);
+#else
+static inline void *bloblist_get_blob(uint tag, int *sizep)
+{
+	return NULL;
+}
+#endif
+
 /**
  * bloblist_find() - Find a blob
  *
diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index 4bca62110a..324127596f 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -98,10 +98,12 @@ static int bloblist_test_blob(struct unit_test_state *uts)
 	struct bloblist_hdr *hdr;
 	struct bloblist_rec *rec, *rec2;
 	char *data;
+	int size = 0;
 
 	/* At the start there should be no records */
 	hdr = clear_bloblist();
 	ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
+	ut_assertnull(bloblist_get_blob(TEST_TAG, &size));
 	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
 	ut_asserteq(sizeof(struct bloblist_hdr), bloblist_get_size());
 	ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_total_size());
@@ -114,6 +116,8 @@ static int bloblist_test_blob(struct unit_test_state *uts)
 	ut_asserteq_addr(rec + 1, data);
 	data = bloblist_find(TEST_TAG, TEST_SIZE);
 	ut_asserteq_addr(rec + 1, data);
+	ut_asserteq_addr(bloblist_get_blob(TEST_TAG, &size), data);
+	ut_asserteq(size, TEST_SIZE);
 
 	/* Check the data is zeroed */
 	ut_assertok(check_zero(data, TEST_SIZE));
-- 
2.25.1

