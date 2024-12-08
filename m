Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DC6E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 10:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F420E895B1;
	Sun,  8 Dec 2024 11:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HwoG7VvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D11389589; Sun,  8 Dec 2024 11:53:04 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77869895DD
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 11:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa63dbda904so423158266b.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 02:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733655176; x=1734259976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkmf/4JNVBoQ9BT6ifykdrJ3oCI8JLjeR4Q+X86P+r4=;
 b=HwoG7VvKYr2kzEjt7ea5glDqgmX/vAwjB2ZNXLE7J6t3ahEXi6yZ2RUsssywDXbuwB
 V6j9A9FaZVRmYiLHhCx8Lsj4tSr872f+b+Fuo6eYVEcMiJd8nFenwZDLKX6bQG9kDjCH
 Lsfr0n6kKiAz4jhPLq2GNgxMimOA23OsHU7+Nc+h/AWu50m8GWzhMNvNZDqLFJKfJkp9
 yKH0uI8kgVwMMwAqTDxcj5jD6fD07/RwtvnXYrjo2QZj4genHfVg4dc+ZIwVmXujNnQK
 V4LfsnWtywq8JzBS+rnllFBy8djB+yqjghqHIlSHGpFppPpSbhIa17gsmKFidBs7trfR
 VEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733655176; x=1734259976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkmf/4JNVBoQ9BT6ifykdrJ3oCI8JLjeR4Q+X86P+r4=;
 b=vdS3OoXf6IE7fl8cgPutpfOABbh6pvZG+k8rcZDUyAkC45RH/b/hs9PJZVL2yYrawu
 4H2eWDNol74IsqPbs1GNITux2t1ffxxgRr4Aa/sTYkA0fwLL3rHrzeMYQD6VFwiOy2hY
 SOR2lapvHkQ2nhYrNMVToPIHpszRPx8gcU/h18gqftNHZAmP3pAFkEAlccKrC95+52/Q
 Tj0Dkby87ylvfddYQdQJ8h6zfhEnxeM4zLchCNxwiVnUnJWrtCN3CmEoR6WzzOe/ud2A
 Ewf4cW1JTuUD+gvRLflIdJuuPYf+vvrY0saMSLCHNd7Wac1u6N25BhbYvrMoCD9VjSU9
 rPvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMavGZa4AtIVT5tVmkFW4eharptRsnX6TaaitpHn5EXlMxoRB1+LAO7OmVGnrEnIYejuehEHs=@lists.denx.de
X-Gm-Message-State: AOJu0YyiizIO0JdTEMh0RXbBwIsUI3mO785GwOw4foLWC0YVuh58TJKT
 wJN5JzXxa5tAV4krArtiBs2nsfvD/YILJUHVJkpkC06HQNyffUUnOFKx+CdpMkk=
X-Gm-Gg: ASbGncshwrQPWStK/iDWGWBz/dyhxwXZIVSPkvCSEltZnsKOWew1uGLtUj6825phSIn
 Zt+Q+8rklpVbkHd7i3AiEsMeY33RVryAYqRb1iXPvsS30BpUIbH2Y095zaiYBPoUxeE1zjPu9/X
 ffL7RZBkXmkSVgFGTYaiA7PMcN3tMx3yUAHJXveOmBaUSDrxTkT+J7jUWgipFw2EFwLlmS/v/7g
 ZCG6fd4lH99UsZmJzZ9E1b0UUUx/mEJRViOhmhAwtJRA0pLkp+NMLSs1kTNMhWFEhTyqtpglh5t
 Np/30bIppslJWivjvzvV0fAKXJU=
X-Google-Smtp-Source: AGHT+IFkfx4eWIJHOc7aB1fCIVM1V3kLsukRx1PuSwRwAm9vhKl5LEviiT7ndP1yL+XBaMlT3DJzLQ==
X-Received: by 2002:a17:906:9555:b0:aa6:423c:8514 with SMTP id
 a640c23a62f3a-aa6423c8842mr701631566b.40.1733655175946; 
 Sun, 08 Dec 2024 02:52:55 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e92fe3sm517768566b.51.2024.12.08.02.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 02:52:55 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Nam Cao <namcao@linutronix.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [RFC PATCH 5/7] lmb: Replace lmb_alloc_addr() with
 lmb_alloc_addr_flags()
Date: Sun,  8 Dec 2024 12:52:08 +0200
Message-ID: <20241208105223.2821049-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
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

lmb_alloc_addr() is just calling lmb_alloc_addr_flags() with LMB_NONE.
There's not much we gain from this abstraction, so let's remove the
former and make the code a bit easier to follow.

The code size increase is minimal - e.g for sandbox which includes all
of the LMB tests

add/remove: 0/1 grow/shrink: 5/0 up/down: 33/-4 (29)
Function                                     old     new   delta
test_alloc_addr                             2939    2963     +24
wget_handler                                1530    1533      +3
tftp_handler                                1190    1192      +2
do_spi_flash                                3150    3152      +2
_fs_read.lto_priv                            331     333      +2
lmb_alloc_addr                                 4       -      -4
Total: Before=2492734, After=2492763, chg +0.00%

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 fs/fs.c        |  2 +-
 include/lmb.h  |  3 +--
 lib/lmb.c      |  9 ---------
 test/lib/lmb.c | 28 +++++++++++++++-------------
 4 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 21a23efd932d..b7d422eaf0d1 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -554,7 +554,7 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 
 	lmb_dump_all();
 
-	if (lmb_alloc_addr(addr, read_len) == addr)
+	if (lmb_alloc_addr_flags(addr, read_len, LMB_NONE) == addr)
 		return 0;
 
 	log_err("** Reading file would overwrite reserved memory **\n");
diff --git a/include/lmb.h b/include/lmb.h
index 54af5b0e4b44..4e8e4f23e279 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -94,7 +94,6 @@ long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
 		       enum lmb_flags flags);
 phys_addr_t lmb_alloc(phys_size_t size, ulong align);
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr);
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
 
 phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
@@ -152,7 +151,7 @@ void lmb_pop(struct lmb *store);
 
 static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
 {
-	return lmb_alloc_addr(addr, len) == addr ? 0 : -1;
+	return lmb_alloc_addr_flags(addr, len, LMB_NONE) == addr ? 0 : -1;
 }
 
 /**
diff --git a/lib/lmb.c b/lib/lmb.c
index 56e005308dde..6dbdd81bd7d8 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -815,15 +815,6 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 	return 0;
 }
 
-/*
- * Try to allocate a specific address range: must be in defined memory but not
- * reserved
- */
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
-{
-	return _lmb_alloc_addr(base, size, LMB_NONE);
-}
-
 /**
  * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
  * @base: Base Address requested
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 0f7052224c10..49857cb3fd4b 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -560,22 +560,24 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 
 	/* allocate blocks */
-	a = lmb_alloc_addr(ram, alloc_addr_a - ram);
+	a = lmb_alloc_addr_flags(ram, alloc_addr_a - ram, LMB_NONE);
 	ut_asserteq(a, ram);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, ram, 0x8010000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
-	b = lmb_alloc_addr(alloc_addr_a + 0x10000,
-			   alloc_addr_b - alloc_addr_a - 0x10000);
+	b = lmb_alloc_addr_flags(alloc_addr_a + 0x10000,
+				 alloc_addr_b - alloc_addr_a - 0x10000,
+				 LMB_NONE);
 	ut_asserteq(b, alloc_addr_a + 0x10000);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x10010000,
 		   alloc_addr_c, 0x10000, 0, 0);
-	c = lmb_alloc_addr(alloc_addr_b + 0x10000,
-			   alloc_addr_c - alloc_addr_b - 0x10000);
+	c = lmb_alloc_addr_flags(alloc_addr_b + 0x10000,
+				 alloc_addr_c - alloc_addr_b - 0x10000,
+				 LMB_NONE);
 	ut_asserteq(c, alloc_addr_b + 0x10000);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
-	d = lmb_alloc_addr(alloc_addr_c + 0x10000,
-			   ram_end - alloc_addr_c - 0x10000);
+	d = lmb_alloc_addr_flags(alloc_addr_c + 0x10000,
+				 ram_end - alloc_addr_c - 0x10000, LMB_NONE);
 	ut_asserteq(d, alloc_addr_c + 0x10000);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, ram_size,
 		   0, 0, 0, 0);
@@ -591,7 +593,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 
 	/* allocate at 3 points in free range */
 
-	d = lmb_alloc_addr(ram_end - 4, 4);
+	d = lmb_alloc_addr_flags(ram_end - 4, 4, LMB_NONE);
 	ut_asserteq(d, ram_end - 4);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
@@ -600,7 +602,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
-	d = lmb_alloc_addr(ram_end - 128, 4);
+	d = lmb_alloc_addr_flags(ram_end - 128, 4, LMB_NONE);
 	ut_asserteq(d, ram_end - 128);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
@@ -609,7 +611,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
-	d = lmb_alloc_addr(alloc_addr_c + 0x10000, 4);
+	d = lmb_alloc_addr_flags(alloc_addr_c + 0x10000, 4, LMB_NONE);
 	ut_asserteq(d, alloc_addr_c + 0x10000);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010004,
 		   0, 0, 0, 0);
@@ -624,18 +626,18 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram + 0x8000000,
 		   0x10010000, 0, 0, 0, 0);
 
-	d = lmb_alloc_addr(ram, 4);
+	d = lmb_alloc_addr_flags(ram, 4, LMB_NONE);
 	ut_asserteq(d, ram);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, d, 4,
 		   ram + 0x8000000, 0x10010000, 0, 0);
 
 	/* check that allocating outside memory fails */
 	if (ram_end != 0) {
-		ret = lmb_alloc_addr(ram_end, 1);
+		ret = lmb_alloc_addr_flags(ram_end, 1, LMB_NONE);
 		ut_asserteq(ret, 0);
 	}
 	if (ram != 0) {
-		ret = lmb_alloc_addr(ram - 1, 1);
+		ret = lmb_alloc_addr_flags(ram - 1, 1, LMB_NONE);
 		ut_asserteq(ret, 0);
 	}
 
-- 
2.45.2

