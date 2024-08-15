Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FB7C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4433988B6D;
	Thu, 15 Aug 2024 22:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lQzM65+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE91C88BD6; Thu, 15 Aug 2024 22:26:07 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66BFA88BB6
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81f83b14d65so63247339f.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753557; x=1724358357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gF4L4/LqhTmHLXLs6sfz2g4aPV4zfNGACs/y8Y8HoFs=;
 b=lQzM65+zmwOGb2OUknh4upI+zYFWzhlDdSKnyg2re4QERdHtTveSKUZJ/Sb4JxvjAG
 pzr96tj0gNtiZUnynIULoIHN2tYt1N1nLKow/yIpmmUkiAReZTP9mMqvS23Gn+RLK0l8
 hW8pySa36etRo+hidMIi12GAxIhiYjjrccXqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753557; x=1724358357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gF4L4/LqhTmHLXLs6sfz2g4aPV4zfNGACs/y8Y8HoFs=;
 b=QpvbTflkLQo+nF4YvWgk+E3BGRMZc7J8IGcKHmrYz48JaXeYgBpSZJ1IkOhQ9jiVcc
 1xn5JddHpDdO/PRmy2oCGmpwPrJg8c+qQsaTkiRVMys7qKg//ofi2U9uVprKVoq7DMRr
 h+cugoaqs5NHEyf9cAmiKCjqj9mGwsC8rT6YaIFITKWhqSoBCOr9Y9gSmOh0WYIVHxn+
 Qs92cJzUgziyDLqjOfentnnNVU/SkdiNVs2oRW/8XmyN5RXN8oWYRdlOzeoM4ZFgmpm7
 0v1dMSJS2q51ud65zwcIO7iYzrc2wYbnIMi06GO3W0kSNhS9N/pNEqIl2HK0KTOYmduN
 dbjQ==
X-Gm-Message-State: AOJu0YzcFVJW301Tk3/ZPFi49L6dvqt7QcuDiiESXy0Hrui2T/fXzF1i
 0vhqQl/ADLN2IllbDHJTKaUAF8Qgfh0n7788Llrzd7exZzm2BSkAjQkuYPit9XJj+BIgYCXRwM/
 5Dw==
X-Google-Smtp-Source: AGHT+IG8Lq8AyugIHtO1GVLB7R4VOaCUjk48wJzTe6WC7mXQMsKm3H0nDRzBY9XnIL+62cwjcto/Uw==
X-Received: by 2002:a05:6e02:15c8:b0:376:4049:69e5 with SMTP id
 e9e14a558f8ab-39d26d733f9mr13421015ab.23.1723753557177; 
 Thu, 15 Aug 2024 13:25:57 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 19/24] read: Tidy up use of map_sysmem() in the read command
Date: Thu, 15 Aug 2024 14:25:30 -0600
Message-Id: <20240815202535.767869-20-sjg@chromium.org>
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

Rename the variable to 'ptr' since it is a pointer, not an address. Make
sure to unmap the pointer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Correct the commit subject and message

 cmd/read.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cmd/read.c b/cmd/read.c
index af54bd17654..8e21f004423 100644
--- a/cmd/read.c
+++ b/cmd/read.c
@@ -20,7 +20,7 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct disk_partition part_info;
 	ulong offset, limit;
 	uint blk, cnt, res;
-	void *addr;
+	void *ptr;
 	int part;
 
 	if (argc != 6) {
@@ -33,7 +33,7 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (part < 0)
 		return 1;
 
-	addr = map_sysmem(hextoul(argv[3], NULL), 0);
+	ptr = map_sysmem(hextoul(argv[3], NULL), 0);
 	blk = hextoul(argv[4], NULL);
 	cnt = hextoul(argv[5], NULL);
 
@@ -48,13 +48,15 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	if (cnt + blk > limit) {
 		printf("%s out of range\n", cmdtp->name);
+		unmap_sysmem(ptr);
 		return 1;
 	}
 
 	if (IS_ENABLED(CONFIG_CMD_WRITE) && !strcmp(cmdtp->name, "write"))
-		res = blk_dwrite(dev_desc, offset + blk, cnt, addr);
+		res = blk_dwrite(dev_desc, offset + blk, cnt, ptr);
 	else
-		res = blk_dread(dev_desc, offset + blk, cnt, addr);
+		res = blk_dread(dev_desc, offset + blk, cnt, ptr);
+	unmap_sysmem(ptr);
 
 	if (res != cnt) {
 		printf("%s error\n", cmdtp->name);
-- 
2.34.1

