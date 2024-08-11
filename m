Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7203C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A469888A55;
	Sun, 11 Aug 2024 16:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EODtTiOE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7353588A0D; Sun, 11 Aug 2024 16:52:43 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE40889CB
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39b3f65b387so14949195ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387960; x=1723992760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrSVzAkp7naUgUE3XYQzs/Z2IurA4XQDWXjDC7baz94=;
 b=EODtTiOEubxs7xUVt4ISgl0KZs4I9/SEPCiv0NnHOU4fiv6IcJ7MkUMkx2TYH2ot5i
 2RiXeaY8d6Xcw9Mwc32ZHmYbgaTg+y/qMyFa46YPxBMxsOUkSpulQCf90mg8jJvd4y73
 sZmmOheJhM5rAghyz1/qyGRvchKHe/+NzpDxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387960; x=1723992760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrSVzAkp7naUgUE3XYQzs/Z2IurA4XQDWXjDC7baz94=;
 b=DfHnnJE0+hlGIXc3PE9B7/n87Num9Hto4Y6eUpm9erHaTM32DtJkfOAhpvPFfhv849
 L4tKxCFOlstuLdEsina3KaXVk0WT+x4Ra99in3CuMVYOpizQVzGqPHm3o6qu2lZKIBLn
 kkUHrgetjAXjL8IALh2oPIRrcK4Dj0swnonNKu+MgzN0uGbphp/BL3oU/4srOBd4aRNi
 5Kg4ex5CCqgXyOLdy/nbPL0lZ5meUgobMSln1/qJ2HKPtB5djWAHnbIdYXqrID0PHemm
 qatjQBHyepGRww0moWNo4iKV1x/toKz+xvylXi3atJWgQ35yAHW1A6LEVs7bsjFWWnwt
 Oeag==
X-Gm-Message-State: AOJu0Yzcd6g+KciOsK1uQnHR3R0tqpTxXYcg2ZUkBCHGKq2nVzBbM6k+
 fGMdV5t1yidC2bFl2QPB++t9ErU52PT3DXthCIGWvRjNOMAHX6SxpyIkxBKtbRqZbhcZcPzPVl0
 =
X-Google-Smtp-Source: AGHT+IFYBuyrS+NbybUsop1G+WVy/+kWg/7QXCBXTecpWtXS+gKpvZ7EKMOnD+FIf36BRwYTQZROMA==
X-Received: by 2002:a05:6e02:1a65:b0:39a:ea6a:9a82 with SMTP id
 e9e14a558f8ab-39b7a41e62amr106532945ab.13.1723387960083; 
 Sun, 11 Aug 2024 07:52:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 11/40] test: mbr: Adjust test to use lower-case hex
Date: Sun, 11 Aug 2024 08:51:40 -0600
Message-Id: <20240811145209.4191404-12-sjg@chromium.org>
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

