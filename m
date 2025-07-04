Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E20C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D8638206E;
	Fri,  4 Jul 2025 23:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O2STFMN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFF3B83015; Fri,  4 Jul 2025 23:46:17 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5A2283010
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-735a6d7c5b1so891378a34.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751665574; x=1752270374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=p6cSRNSCoHtszFPZpQXNpXSLzLloBsF6CgwHbPpmSg0=;
 b=O2STFMN2mQPT8RBCVu9yEd4o5l8ankSrgTFuntpOMXHAebLoyOv+oYYia/nheE18T2
 T2WVOMIEG2rotEGvJ/2Y8GIPDx6wOYOlT3WhQpUPHhVB5dFYuabN0vHtdA2yC/5vzYsv
 F7qXnsTp5FwUlQvrdlGlznRLLzavYcoB/WB4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751665574; x=1752270374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p6cSRNSCoHtszFPZpQXNpXSLzLloBsF6CgwHbPpmSg0=;
 b=Es7h7Fwwn6oMl5CVCh3VDdHrKvYpzMEKwuny8qqb9A93ckkHaXa2N240uH6j/3EYvq
 UWBPoLKxQrM7u2dg8D/BbUBVyeRRjJb8CAe9K3tJMojtv/wlD29CzU0EK2lu7h3obuTJ
 92UtjMW28wUzZVrxFmUb74grN3n04QTjj34SCQdOUcvR8Rv9X7PBj+WGbXuo4OhY+D2N
 j9/5Ms9wTQnpJX4iRJrz2lS9lFOmdX5uKwWk8Bp6FosDzcWUfeRXxCJ0z+uC4qk/3kWR
 K1E2ZkEv6vCXDyr+v2EFPtWFY0/98V/sIDnQ0zFlGVs8xu/CoYd99aTZipS4hFgccG3P
 RFTQ==
X-Gm-Message-State: AOJu0YxwoofGvEWO7/sK/A0TTwU0ZSNF6034lvjKBH0mRBn9YbtQJSEe
 lMvCVsqvv8Vfv/1epnZr1F57hqZj9vX41hx4b4g91aYv/nZiJB0652N7CZwzyyjle7Rtu2UTnaD
 F0xxyFzU=
X-Gm-Gg: ASbGncvdF68XaN8KvYYWppv7J7ghHL/UN7Skyprf2gLWgTblVA5ygjLVarr3w5Jl8Rl
 OROpukycEzqUMxpaudhTXQnvva7Up/MQsUEbA2+wbkm7MeCa/yC6BoUsr0EfcIPiH6AOEXXF2ZD
 q08+6DsJs0xaItJTz3nie61U+YGP7pUATm/mJHdOXdjAyQctRqYCddI1pj+hxwoU1WzB5QTIy8z
 zftpfd5PkmPsUOhbUuys4r3owmi1nFiMFzL/OqQEiTnpXWBRk/HZE3rBU2zcPwHf3SsQv/qVqBi
 6/5s36bAOrDv+R0iLyv55+xE9nn83s6cKF1jpsf6MAKiy81slk4b4jwU6e/lgJiZmRzmVIOuLmo
 wvVWPpsztEWJLGoaut2WsFYU=
X-Google-Smtp-Source: AGHT+IGKKSUY847xyeJJPf4g1KRtwNZs5cj2Q/pTzNSLbSo4tMXyrnx3j0On/0NbFd7ouBYZ6HfDNw==
X-Received: by 2002:a05:6830:2c03:b0:73a:96e5:19b9 with SMTP id
 46e09a7af769-73cb44e1f14mr168819a34.2.1751665574452; 
 Fri, 04 Jul 2025 14:46:14 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f9801dfsm525290a34.66.2025.07.04.14.46.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 14:46:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] block: sandbox: Add support for SYS_64BIT_LBA
Date: Fri,  4 Jul 2025 15:46:12 -0600
Message-ID: <20250704214612.3418920-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In order to use SYS_64BIT_LBA with this driver we need for "start" to
also be of type lbaint_t and to then use the correct printf format
characters.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/block/sandbox.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/sandbox.c b/drivers/block/sandbox.c
index 6c74d66037e7..9cb27561a97f 100644
--- a/drivers/block/sandbox.c
+++ b/drivers/block/sandbox.c
@@ -18,7 +18,7 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 static unsigned long host_block_read(struct udevice *dev,
-				     unsigned long start, lbaint_t blkcnt,
+				     lbaint_t start, lbaint_t blkcnt,
 				     void *buffer)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(dev);
@@ -26,7 +26,7 @@ static unsigned long host_block_read(struct udevice *dev,
 	struct host_sb_plat *plat = dev_get_plat(host_dev);
 
 	if (os_lseek(plat->fd, start * desc->blksz, OS_SEEK_SET) < 0) {
-		printf("ERROR: Invalid block %lx\n", start);
+		printf("ERROR: Invalid block " LBAF "\n", start);
 		return -1;
 	}
 	ssize_t len = os_read(plat->fd, buffer, blkcnt * desc->blksz);
@@ -37,7 +37,7 @@ static unsigned long host_block_read(struct udevice *dev,
 }
 
 static unsigned long host_block_write(struct udevice *dev,
-				      unsigned long start, lbaint_t blkcnt,
+				      lbaint_t start, lbaint_t blkcnt,
 				      const void *buffer)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(dev);
@@ -45,7 +45,7 @@ static unsigned long host_block_write(struct udevice *dev,
 	struct host_sb_plat *plat = dev_get_plat(host_dev);
 
 	if (os_lseek(plat->fd, start * desc->blksz, OS_SEEK_SET) < 0) {
-		printf("ERROR: Invalid block %lx\n", start);
+		printf("ERROR: Invalid block " LBAF "\n", start);
 		return -1;
 	}
 	ssize_t len = os_write(plat->fd, buffer, blkcnt * desc->blksz);
-- 
2.43.0

