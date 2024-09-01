Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62697C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA2E88CD5;
	Mon,  2 Sep 2024 00:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eTs7uVks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8298888C9F; Mon,  2 Sep 2024 00:27:13 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7319787CF8
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-82a29c11e1cso96772939f.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229630; x=1725834430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSZzhVNkWmxXYXniIKSPq/0ms8CGEbp8bOFdbuo61Sc=;
 b=eTs7uVksTS44OqadS196thhIdm9jPDtGVe614jmsRVA4DjZ7L2ayxMi/6hZGAapW0g
 MOVGyjRYzAO9hm41OFJBs1cc8Cs0vFPm/ne4iDbnX1TQKLgzf5cIrxCb8dffNmoYsJ3y
 0U1ApoCgIyVWe2izjVi9XflBwAyFjzi1y5nQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229630; x=1725834430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSZzhVNkWmxXYXniIKSPq/0ms8CGEbp8bOFdbuo61Sc=;
 b=DWeKITbvD+m8MetmaRDB/HHKLkFwFI8k9ccizG4wWWf7rq4TsMAsydhMH+4bU7fqLr
 5OxTeyG9+bTir8tjvadT5xYWJufxQUQx8sIqJmVyVTkJLSqlnAzM11So8WFNRGKBAm4s
 +22h1qD1bqUn4j0009Y5+w8BVVuWmwm2YhN5gVJM6CBef2+NT/WCso0a3CZL620c5b+8
 +jY4YnRW/Q3kF56Kebrqs+KmFbIRv7e4cmA0kpU3rvCs8k1ugrPkd2x66PBxfSlbOIp6
 QZOYjvSkLavdA/mk03b82YOqj/J8POmqj2czvBDRrtG7bhyn/kIVqjtyMhEdio0F4CwD
 uVqw==
X-Gm-Message-State: AOJu0YwcSDweEQGyIdsw2YHU7LH4wYLajpNfZpxnZ3YcA8dy/F8aejyU
 K0mZuY9M2uTCuNfeZFFj2pQltxsPE3VHNNBRlPTMw+F+m8v29ohQ7PQ/RBkuDyTmXT3+2es4o1s
 =
X-Google-Smtp-Source: AGHT+IF2MIhm5lN61moQh3qLwD1e9BDKIBgN2y6cKkP8dViDN7/Bp3lwnm8kW4G4l/s+koJ4LjGriA==
X-Received: by 2002:a05:6602:3fc3:b0:81f:9328:9631 with SMTP id
 ca18e2360f4ac-82a3418c1dfmr709004639f.2.1725229629882; 
 Sun, 01 Sep 2024 15:27:09 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 19/23] cmd: Fix memory-mapping in cmp command
Date: Sun,  1 Sep 2024 16:26:30 -0600
Message-Id: <20240901222634.460873-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

