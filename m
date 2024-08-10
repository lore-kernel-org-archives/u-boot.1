Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189B3C3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D4C88965;
	Sat, 10 Aug 2024 22:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FRO8fElk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D30F18891A; Sat, 10 Aug 2024 22:52:38 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222A3888FD
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81f9339e534so110154839f.3
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323149; x=1723927949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVpu9AYlCINxT67XJikpDcbvBM5OPwYDYQEkH6G214Y=;
 b=FRO8fElk+SZB27rHExug9zANBDSzB3ukYwi5NIh3lnP+dr2u3PDefJ2i3AewRhGMsj
 +/bgXSyrA2Wr2b2UoWqGmRK09gpn3TlCNUmh+J94Qwy4OSSH5qw+0hgIuX+vV6coV5dV
 6nytOcvWT13121KAw0Er27Rm8fJ7UrNibvpew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323149; x=1723927949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SVpu9AYlCINxT67XJikpDcbvBM5OPwYDYQEkH6G214Y=;
 b=mWm6la+l7hCHzRN9GN4wDNVu+mG49zWWpspSkgCC8VNpmttL5/Cde54MbLUKVYfp1K
 WQnne/fyTz7yhuDdQyK2kz5O1jN74V613t+aYCVv1mVTfWxIBNhSawMgeE3jWliNSyrP
 sUvRVQweoQpTwnZpUrmz2k25V6j4a9zY1U6JhFy3Z86xtQky/5gICTopVtLEM/BKCOez
 SNMKwt6YheAPlf3eyAbAKKXyj3lAL7sDyrbTfDUJj4Wi7JLuia/OGc664ZcZBmnecVQv
 Guu+zTaKhv/8Wxs1s5GhTPVDOhE8fCZeDDtO3TuVIetnv+98RvZcfoA3Cyp1ctlDtjWo
 /CFw==
X-Gm-Message-State: AOJu0Yx0AO95RAapkTPqxuhnvNTnd/10QM4yH8eRnqY2QKGACnTnwpPS
 4JwGf5ueMY4nYjys0bYku4x19U8woiAbxYcpkigIvUs0qDqWfzQ9mm7Nm4R23xLTr6k3YdjVEqY
 =
X-Google-Smtp-Source: AGHT+IEuEIVAlCmUKuoPj085197P8IUtOI8ZH7MJjgYkIapEN3J//B0eMMlV/BIWfsnhrHfpK0XKIQ==
X-Received: by 2002:a05:6602:1541:b0:81f:a288:efa7 with SMTP id
 ca18e2360f4ac-8225eedfb24mr680303639f.15.1723323148768; 
 Sat, 10 Aug 2024 13:52:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 09/21] test: Update NAND test to avoid extra macros
Date: Sat, 10 Aug 2024 14:51:53 -0600
Message-Id: <20240810205205.3403177-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

Use a single test function with a for() loop instead of using macros to
create multiple test functions. Add a message so it is clear what piece
the test is up to, if it fails.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/dm/nand.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/test/dm/nand.c b/test/dm/nand.c
index 397cc88567c..2d9866030f2 100644
--- a/test/dm/nand.c
+++ b/test/dm/nand.c
@@ -12,7 +12,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 
-static int dm_test_nand(struct unit_test_state *uts, int dev, bool end)
+static int run_test_nand(struct unit_test_state *uts, int dev, bool end)
 {
 	nand_erase_options_t opts = { };
 	struct mtd_info *mtd;
@@ -25,6 +25,8 @@ static int dm_test_nand(struct unit_test_state *uts, int dev, bool end)
 	loff_t off = 0;
 	mtd_oob_ops_t ops = { };
 
+	printf("running: dev %d end %d\n", dev, end);
+
 	/* Seed RNG for bit errors */
 	srand((off >> 32) ^ off ^ ~dev);
 
@@ -88,17 +90,15 @@ static int dm_test_nand(struct unit_test_state *uts, int dev, bool end)
 	return 0;
 }
 
-#define DM_NAND_TEST(dev) \
-static int dm_test_nand##dev##_start(struct unit_test_state *uts) \
-{ \
-	return dm_test_nand(uts, dev, false); \
-} \
-DM_TEST(dm_test_nand##dev##_start, UTF_SCAN_FDT); \
-static int dm_test_nand##dev##_end(struct unit_test_state *uts) \
-{ \
-	return dm_test_nand(uts, dev, true); \
-} \
-DM_TEST(dm_test_nand##dev##_end, UTF_SCAN_FDT)
-
-DM_NAND_TEST(0);
-DM_NAND_TEST(1);
+static int dm_test_nand(struct unit_test_state *uts)
+{
+	int devnum;
+
+	for (devnum = 0; devnum < 2; devnum++) {
+		ut_assertok(run_test_nand(uts, devnum, false));
+		ut_assertok(run_test_nand(uts, devnum, true));
+	}
+
+	return 0;
+}
+DM_TEST(dm_test_nand, UTF_SCAN_FDT);
-- 
2.34.1

