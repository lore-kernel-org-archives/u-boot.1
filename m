Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD38C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5067988BD2;
	Thu, 15 Aug 2024 22:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VjOUxcdn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172D388B88; Thu, 15 Aug 2024 22:26:05 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3918E88BAC
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81f86fd9305so72114839f.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753558; x=1724358358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSZzhVNkWmxXYXniIKSPq/0ms8CGEbp8bOFdbuo61Sc=;
 b=VjOUxcdnY/aTwOqb5mUsT4wEOUc/iqLToTNe81i+HxDIkuFVC/wStwGM45KKqMoe+b
 YQ4mpc/DOi+aXbFbndMeMhN+m+Zd7eV12OTT612xaBGXwJ4YDtbn/fqrXG4DKllppp5D
 1WXa70nUITCsKjzYq8ia3bTqwiiV7GLyB4DPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753558; x=1724358358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSZzhVNkWmxXYXniIKSPq/0ms8CGEbp8bOFdbuo61Sc=;
 b=h0bfNQu8Lad1IDYynXXvMiuYT5gbWRF9Yc/oL9ysMOsb1qZRydES0IKBb9mJBHO1lB
 BGvEOLntY9nHCBmyvPXfhHYPkA8HOv3MP34762hAhKbJEUz+ut/QM4VscGhpA3FHrmn6
 ho+0kSzfLxb4uvxy+ED5WWrN3cZAIe6dg9yrGpzQOiMTz5d94QV6qrSCPXK5/6MaSNJ8
 2x92nzDMIZMfL7dmWVlCCraeqMXNncI0dOuntt3qlNMoum6/+7Feh2do34ur5wJ7GeZ1
 vjlAN3wFy24IMzB0xwvqv9ByxJuGpwzMRDjNp/qCCh2D6PFthh1rXbOqMCkT1Tm5D6kK
 JH5Q==
X-Gm-Message-State: AOJu0YxZ4SGCOqhK76Ool0COKf2v52u/hndSEfhelkb2BKKJz1BbSicY
 IC9zjdpVTb/Dj6tZzrzUpWx/wdhyquo8iFfLiLOXSUu2VefPv/1ZGhPuh6fNV6C8PRLBLlJIF9z
 PNg==
X-Google-Smtp-Source: AGHT+IFWA79VMsX0NqweZTF9KBqax3P1eJEg+Noh8cEj7jjju2Uq4LtzXK6JfSKi/el08G3QcC+9Mg==
X-Received: by 2002:a92:c56c:0:b0:39d:1694:d261 with SMTP id
 e9e14a558f8ab-39d26cee5afmr11135785ab.12.1723753557918; 
 Thu, 15 Aug 2024 13:25:57 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 20/24] cmd: Fix memory-mapping in cmp command
Date: Thu, 15 Aug 2024 14:25:31 -0600
Message-Id: <20240815202535.767869-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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

This unmaps a different address from what was mapped. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/mem.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/cmd/mem.c b/cmd/mem.c
index 274348068c2..4d6fde28531 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -245,7 +245,7 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
 	int	size;
 	int     rcode = 0;
 	const char *type;
-	const void *buf1, *buf2, *base;
+	const void *buf1, *buf2, *base, *ptr1, *ptr2;
 	ulong word1, word2;  /* 64-bit if MEM_SUPPORT_64BIT_DATA */
 
 	if (argc != 4)
@@ -270,22 +270,22 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
 	bytes = size * count;
 	base = buf1 = map_sysmem(addr1, bytes);
 	buf2 = map_sysmem(addr2, bytes);
-	for (ngood = 0; ngood < count; ++ngood) {
+	for (ngood = 0, ptr1 = buf1, ptr2 = buf2; ngood < count; ++ngood) {
 		if (size == 4) {
-			word1 = *(u32 *)buf1;
-			word2 = *(u32 *)buf2;
+			word1 = *(u32 *)ptr1;
+			word2 = *(u32 *)ptr2;
 		} else if (MEM_SUPPORT_64BIT_DATA && size == 8) {
-			word1 = *(ulong *)buf1;
-			word2 = *(ulong *)buf2;
+			word1 = *(ulong *)ptr1;
+			word2 = *(ulong *)ptr2;
 		} else if (size == 2) {
-			word1 = *(u16 *)buf1;
-			word2 = *(u16 *)buf2;
+			word1 = *(u16 *)ptr1;
+			word2 = *(u16 *)ptr2;
 		} else {
-			word1 = *(u8 *)buf1;
-			word2 = *(u8 *)buf2;
+			word1 = *(u8 *)ptr1;
+			word2 = *(u8 *)ptr2;
 		}
 		if (word1 != word2) {
-			ulong offset = buf1 - base;
+			ulong offset = ptr1 - base;
 			printf("%s at 0x%08lx (%#0*lx) != %s at 0x%08lx (%#0*lx)\n",
 				type, (ulong)(addr1 + offset), size, word1,
 				type, (ulong)(addr2 + offset), size, word2);
@@ -293,8 +293,8 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
 			break;
 		}
 
-		buf1 += size;
-		buf2 += size;
+		ptr1 += size;
+		ptr2 += size;
 
 		/* reset watchdog from time to time */
 		if ((ngood % (64 << 10)) == 0)
-- 
2.34.1

