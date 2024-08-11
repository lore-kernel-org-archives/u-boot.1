Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267C7C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC4B988AD2;
	Sun, 11 Aug 2024 16:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cOMaHoDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713EB88A5D; Sun, 11 Aug 2024 16:52:50 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9E588A37
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39b3754468eso12825445ab.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387967; x=1723992767; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSZzhVNkWmxXYXniIKSPq/0ms8CGEbp8bOFdbuo61Sc=;
 b=cOMaHoDJ6tHTF5ZxENZ19qK373SfyDmRnNjhI4wwh/0cq8sDTYwXOyxAQ4k8GHd8Dd
 hNLPEQ6npbwgLRaTc92dB+OnzC+ZVwgv/DHauh06wI50URSSy6BNaPnCOucb4qvQIoA2
 UZi2Lz68AwLKSopWfRF1a1slXC/WBl/znbJ7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387967; x=1723992767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSZzhVNkWmxXYXniIKSPq/0ms8CGEbp8bOFdbuo61Sc=;
 b=Z6fnOQFQzvL68WhLyR/3rqhREQwfrwZjZAc0A+buBRvpQkWh20i9pHyBhfdcBsbG0y
 xQUOBl3y8w2aGkbX5jmizyTg5Sin8zmxGL1DiLjkFaY2oVflzhzTeNJ02M2GSc9hmbLd
 PKkb5bE9IvYIdhWBT/jczTTmKcvunz3IRB8wLxzXI8ARikcD0yeP8s3vSk4PQFXqsvMF
 bV74UBZRBfGrQxFpqR4bSDEgyQEGrrZzBBzhpEl652F7xZPiZmn8P1/cDQSq3erXO4Z0
 4A4ohOqsJjYzehX7BEe8KsKrMBMnIdd63d7tJSKBSHIEMhi4eJWzw6WoZ/6dz4rm+Skh
 pdVg==
X-Gm-Message-State: AOJu0YycS7siv+mXxS2AqHHFc8Ldd2/4pmnGdI+aW50qGwxcl4qhOaPa
 QOU5KNOVKHhPuyovD6+J+PiXhX+qC+ETjIARN6vNhgQo4Ut1v9zAsm1SyDRkoFJAQNwUiBLiJJE
 =
X-Google-Smtp-Source: AGHT+IEuEtZFEJwffOjq+/bkRCisIylmyYvVxLKmWBTEymReof2f5204g8G/l7e6gyZ8cpo7bTqVxg==
X-Received: by 2002:a05:6e02:1fc5:b0:397:6dfc:993a with SMTP id
 e9e14a558f8ab-39b7a449735mr81229375ab.21.1723387966993; 
 Sun, 11 Aug 2024 07:52:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 20/40] cmd: Fix memory-mapping in cmp command
Date: Sun, 11 Aug 2024 08:51:49 -0600
Message-Id: <20240811145209.4191404-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

