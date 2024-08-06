Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBB7C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95EE88ABF;
	Tue,  6 Aug 2024 14:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fi2uG5Ol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF4A88A55; Tue,  6 Aug 2024 14:59:45 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 120F788A5E
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39834949f27so2382205ab.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949176; x=1723553976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSZzhVNkWmxXYXniIKSPq/0ms8CGEbp8bOFdbuo61Sc=;
 b=Fi2uG5Olfuj0mcF7RnhNOfhF2hXd2BmDlUIzHpuG3wK0nDXGGVTNPjwqxYLWVq9YZK
 McbAFJNhiVtv8884lO3MldvTQloSw734GKlrnKx2w384+fY2s3OItiFpj4Sf1dCptxRf
 tJBP/O1CBHHTuZY1Vh2/tevuwWnbBt1FfIDTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949176; x=1723553976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSZzhVNkWmxXYXniIKSPq/0ms8CGEbp8bOFdbuo61Sc=;
 b=h6cKTD/xNHMZxcMB3mnRPierkVgM3eddFJKnuDMubBuH3pisWlOyDoGTiHeN1mRq8S
 qddxHnoVwiVFRqLgGB6MC1CzfLjGTeaTU0exf+LXouQwRYXOYS7RajG0AYaL6WXfHmfD
 JAMRAGTcF6i0C97yHlJmSa9tYDN7RT7pS1TyH9zPfKxKv/Mn2MQtIgZgIyH9h+VGCjLs
 DWRvVM7L4NSMKbBRkyzwjvNu8BGUTP5f+E9SVUad+oqynhubujMwkJPanwWsVjchiBzO
 wIAC7NsXHo4o34ShtJY1/qVU4o2tE6ZwFe0Nof5d8XztEe8A8PvQ5HTNuvT6Sc47pDFg
 H0Ig==
X-Gm-Message-State: AOJu0Yz7KQqQ9DVAgKsKEBfd+KGdkb6ZcL3AKCm+Ooj6Pfq1I7SoXVpZ
 y4PiPZlsXQJtMYx/FL1AmNYz8Zsb6O3IBoPqzrLVNYVOSA6btyhmZHqV3WH/sw4U/+pXHtTOjGY
 =
X-Google-Smtp-Source: AGHT+IG/WuY4majoFNsYc5O8Gnyp3dg83GsLMmPyBGZvxi6VeBg3bvIwgUAyj3bno1a09n8B1Ol98g==
X-Received: by 2002:a05:6e02:1a86:b0:397:e0ef:dc8c with SMTP id
 e9e14a558f8ab-39b1fc1e9a2mr211510805ab.19.1722949176104; 
 Tue, 06 Aug 2024 05:59:36 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 20/39] cmd: Fix memory-mapping in cmp command
Date: Tue,  6 Aug 2024 06:58:31 -0600
Message-Id: <20240806125850.2316956-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

