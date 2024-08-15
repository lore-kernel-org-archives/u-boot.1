Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498A6C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A737188BC1;
	Thu, 15 Aug 2024 22:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Leb9j47r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB4988B67; Thu, 15 Aug 2024 22:26:00 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56AAD88B3C
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81f8f0198beso47315039f.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753551; x=1724358351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrSVzAkp7naUgUE3XYQzs/Z2IurA4XQDWXjDC7baz94=;
 b=Leb9j47rnme67GUyTesI/6NaFUcK6z7OoLNPaEhuP+ZoFCdGA9Mg+BO9LaLD8cvMSu
 NJ3/FDDvE0aVys23JbxB9sGPbk03tym4t//HjSpYE93uix1HouyoMR2zfh5XL07SrtST
 +LPZe42hJ7NHQezbU56ExK+lOcFiwuLir2fsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753551; x=1724358351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrSVzAkp7naUgUE3XYQzs/Z2IurA4XQDWXjDC7baz94=;
 b=iVIr61eUSR3X++3zd647Ap7CNUXIG/WjEy8zQl7jaS/bvXaPbOT9EnFkdWfOdTPlZI
 2quweTHM122/6zVvkqqUr8m0AlAj9NZYJiQjtEbpx80gJvEJrr+nmFfngjlbJrRsm6Qw
 qFok19cp+VZHL8rYW2gUqvhnC7rVLFGyVizaBZESY9thIRWIprE7rzJIhK7WIqmSB04I
 mffLrhN99TSObqwSd/CHB3OYbgkbnlwBYiAbGMFB7m0UVLPIcyq75qWef54UjYbc2VaM
 vtItp/m6hTvY3dbJZwkcx2QUwNR1BnFYkhBVLHiUxKmPHuKHEyghXGK3pMQvwfXsru+3
 fVNQ==
X-Gm-Message-State: AOJu0Yz9FesaBAVFziz5VOjNB8yx1kRVgjYAR1bwPmLIv0yacKGQpFgp
 ewD6XLlRwkkODqK+UqCPhA9mOxIRxwjellzz2fetwZtU9p6FqYJzQY8mzGx24bmwHEhpq/PzJ/N
 HWg==
X-Google-Smtp-Source: AGHT+IHbPCsD9fDHVMsJejXYCb3yqwaTuhAby1ICCeaFfuzCoVtotRQ28VsS3sKGaYUZecr0/VxApA==
X-Received: by 2002:a05:6e02:1fec:b0:39d:2124:d6d5 with SMTP id
 e9e14a558f8ab-39d26ceda1bmr9567335ab.10.1723753550924; 
 Thu, 15 Aug 2024 13:25:50 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 11/24] test: mbr: Adjust test to use lower-case hex
Date: Thu, 15 Aug 2024 14:25:22 -0600
Message-Id: <20240815202535.767869-12-sjg@chromium.org>
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

Switch to lower-case hex which is more commonly used in U-Boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/mbr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 235b363290e..4c884af10c7 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -50,7 +50,7 @@ static char * mbr_parts_tail = "'";
 000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 */
-static unsigned mbr_cmp_start = 0x1B8;
+static unsigned int mbr_cmp_start = 0x1b8;
 static unsigned mbr_cmp_size = 0x48;
 static unsigned char mbr_parts_ref_p1[] = {
                                                 0x78, 0x56, 0x34, 0x12, 0x00, 0x00, 0x80, 0x05,
@@ -257,7 +257,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	mbr_wa = map_to_sysmem(mbr_wbuf);
 	ebr_wa = map_to_sysmem(ebr_wbuf);
 	ra = map_to_sysmem(rbuf);
-	ebr_blk = (ulong)0xB00000 / 0x200;
+	ebr_blk = (ulong)0xb00000 / 0x200;
 
 	/* Make sure mmc6 exists */
 	ut_asserteq(6, blk_get_device_by_str("mmc", "6", &mmc_dev_desc));
@@ -268,7 +268,8 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Make sure mmc6 is 12+ MiB in size */
-	ut_assertok(run_commandf("mmc read 0x%lx 0x%lx 1", ra, (ulong)0xBFFE00 / 0x200));
+	ut_assertok(run_commandf("mmc read 0x%lx 0x%lx 1", ra,
+				 (ulong)0xbffe00 / 0x200));
 
 	/* Test one MBR partition */
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
-- 
2.34.1

