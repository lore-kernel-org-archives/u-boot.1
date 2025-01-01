Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217FAE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5720D80391;
	Wed,  1 Jan 2025 23:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BfElO4tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 290B080391; Wed,  1 Jan 2025 23:10:51 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8FF7800D7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so154403685ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769447; x=1736374247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTFdoZvcDSHD+yjr4PqsrUnRpy0P6R7kZm+hwq8hJNs=;
 b=BfElO4tkwLAD/Vxu9OFxs6ohbAE4PgTmGp5DlT1+YXu9mp2b9grir5TuCQY6NvZp/g
 oNb+ChZfKR0zp0bqvx8UBMJ5ieQ2n9eRzYhK5OTnWShsTfBKLH2B2q8dOlbBMnZfm9Jt
 v8dp5tSWW2WTQCQXeveIax/iroA4lrcfyIxzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769447; x=1736374247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mTFdoZvcDSHD+yjr4PqsrUnRpy0P6R7kZm+hwq8hJNs=;
 b=sUINTsyBhFSHOPCUz2s+74PB3KztvV/WjPkMe5DgOHaIm5qBJ7ehYL/vow4jCbs3ny
 iEsRy1TQsOWy8e4Kp1PpadrHqhsl/11VNEZApIMFiLBLbDNIlRWJCAR3WnU6uyyBp61d
 ACJl0ZjITYOhLMiWoZMh29ffsQ1xT+NE5P3l5TkDJ8sAuResNFYo5IGwfzKoVhrzLt7L
 yvi1D77XWRPkHkahlvgrKXHekbPDJ2Iml+KaKK8dmkltg9rtf94fYkRjxnFtAMEKKG90
 S7c2AzyS2e7UDgwl756xLZxu6VUF70r69IXirmx6JjdUxvIcrRkffe3Ff61zCQjVeDId
 qqjA==
X-Gm-Message-State: AOJu0YxBzXwlLoliU3CRDhnHoDZ4LI8CY5Y3/c8Zh4GFIWllBDc6Fg2c
 NIWbc9dG0c7CnkZtSEBzNzWBrIU3q6r6R2Qak0+AgKKA+46gCMYkRtLXhEIrPyE61pLop0a/+Yw
 =
X-Gm-Gg: ASbGnctbD2G3egs162VJSfYhIG9Lc7QbnCY4h3ducQwU5VP4TKFptAg/j6eRunW47+E
 UjfUoKRVyFyXq5IoC4xi2QqeGypc9M9AnmJoqUqvyY1yf4jYADl+5AfcRyBVgluZr7u4g+1+xAO
 +v1Yl8Rk+rRh4qH4+h6rsn0C6gKhQw0ac1/+Tpv4vLImIvQbZcfXL1sJKlYzNPOH+DRQCKA4VWJ
 JmvCp8Vl1V31mCkiep9AvB1U3VgtywfXg75ER5RnQAThgRVN2lxbWY=
X-Google-Smtp-Source: AGHT+IH00XCfVFm85JondnGOPDZV27X4pK3XQsl9wsOEonc5JXgdtyfA/ciho2fDTe7aeYoAqNZebQ==
X-Received: by 2002:a05:6a00:10d0:b0:725:d64c:f122 with SMTP id
 d2e1a72fcca58-72aa9a1041amr84303973b3a.2.1735769446803; 
 Wed, 01 Jan 2025 14:10:46 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:10:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/67] abuf: Provide a way to get the buffer address
Date: Thu,  2 Jan 2025 11:08:48 +1300
Message-ID: <20250101221003.1944600-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

In many cases it is useful to get the address of a buffer, e.g. when
booting from it. Add a function to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/abuf.h  | 8 ++++++++
 lib/abuf.c      | 6 ++++++
 test/lib/abuf.c | 4 +++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/abuf.h b/include/abuf.h
index be98ec78c86..76e314b9a47 100644
--- a/include/abuf.h
+++ b/include/abuf.h
@@ -42,6 +42,14 @@ static inline size_t abuf_size(const struct abuf *abuf)
 	return abuf->size;
 }
 
+/**
+ * abuf_addr() - Get the address of a buffer's data
+ *
+ * @abuf: Buffer to check
+ * Return: address of buffer
+ */
+ulong abuf_addr(const struct abuf *abuf);
+
 /**
  * abuf_set() - set the (unallocated) data in a buffer
  *
diff --git a/lib/abuf.c b/lib/abuf.c
index 937c3df351e..8156177c773 100644
--- a/lib/abuf.c
+++ b/lib/abuf.c
@@ -26,6 +26,12 @@ void abuf_map_sysmem(struct abuf *abuf, ulong addr, size_t size)
 {
 	abuf_set(abuf, map_sysmem(addr, size), size);
 }
+
+ulong abuf_addr(const struct abuf *abuf)
+{
+	return map_to_sysmem(abuf->data);
+}
+
 #else
 /* copied from lib/string.c for convenience */
 static char *memdup(const void *src, size_t len)
diff --git a/test/lib/abuf.c b/test/lib/abuf.c
index 7c0481ab610..5d61f9261c6 100644
--- a/test/lib/abuf.c
+++ b/test/lib/abuf.c
@@ -46,7 +46,7 @@ static int lib_test_abuf_set(struct unit_test_state *uts)
 }
 LIB_TEST(lib_test_abuf_set, 0);
 
-/* Test abuf_map_sysmem() */
+/* Test abuf_map_sysmem() and abuf_addr() */
 static int lib_test_abuf_map_sysmem(struct unit_test_state *uts)
 {
 	struct abuf buf;
@@ -60,6 +60,8 @@ static int lib_test_abuf_map_sysmem(struct unit_test_state *uts)
 	ut_asserteq(TEST_DATA_LEN, buf.size);
 	ut_asserteq(false, buf.alloced);
 
+	ut_asserteq(addr, abuf_addr(&buf));
+
 	return 0;
 }
 LIB_TEST(lib_test_abuf_map_sysmem, 0);
-- 
2.43.0

