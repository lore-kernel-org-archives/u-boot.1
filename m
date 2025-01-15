Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9371C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC78780934;
	Wed, 15 Jan 2025 14:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FrJDYraC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18FC680B9F; Wed, 15 Jan 2025 14:32:12 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03F380040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844e39439abso216195939f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947928; x=1737552728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBiYzOfRYjnaeHSmo5qICglB8sx/BDGP4lFWPrF5Gsk=;
 b=FrJDYraCsqGPtM1W0keyYuIb3VjVkJ/3w5N3ejgBBpK0w+1IoO8cCjh6crMXJW5zI7
 c98Y6LoxeTWAP8BLhoDLeg8y53dxsMuuP1hoc0wXXmrhLPjQpbcUQp3wh37rGNPFxRGV
 YpY5TmjOK+mn9zF0HI2plaDGwF0LCkVxCNdOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947928; x=1737552728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBiYzOfRYjnaeHSmo5qICglB8sx/BDGP4lFWPrF5Gsk=;
 b=Crz1QRn64+NOkCj9AUula9eWz80n0JtkRoC4Abe13oQdVgGx8S+i+XRB7SKJn0fR7D
 UGz7EkpiUlu/Q+Qwjg2KVamVNYqelnkB0HIoE2HcaUB5EHObgadjHGkmUc5X8YIg9VAr
 OtDTSOKSI0LL9J0xS+fPcxlNhddDXB/1pRj+rLKz0TkgwW39bsadCFH1EPVGR/tXJ0ch
 WnS0CKaHmRFeCZE8WAy8hsPGZJycKoAU7lqWuJ9I3ddns1hbm8In6yCnEnXwspij9nrs
 4EbE0d4e7RIR5a+BYuyzFBqsJ0j+LIedkMqFFcRKmyz/PbdeNfKMcsjtGJTgKCskaJGU
 VQWA==
X-Gm-Message-State: AOJu0Yz1le6qL+AdPjf+DwcyhnX/y9/wielB8zXkZOo1j0jS6XNKcyAV
 dmIn9akLEZF/Su3peOzKtN+xnktfTSzsi9yoOGw+Tf35p0XF79RVwpcRfuB81Z7dOLUjk4pFRO0
 =
X-Gm-Gg: ASbGncsWnodq3bPDPG6h9omqV6HC9GN3lVHP1drypx5zU4A4tmUa1KjXCDTonjxVyPk
 kB+eprLeJNxQ7LgC2+uYqLR4DLMJNY8kanFncnT1LRupgPyC2wWuw7kpY1glzhqi4A7YuYXjyLN
 HysAolikrRGM1MHynsHrh9xqj3FcJovQATdRxhHkHH4I5qUZ8mUi62YdVkfqdAzmlTJBHD7/qWn
 fyCxK073LBvY325ewN6QIjeZXusiYL+d9zwqQir0MKus1reFpP6UNNE5VZItIfbdFgRgiwFdDV8
 V9Qe0HhTV8w4PcDOAA==
X-Google-Smtp-Source: AGHT+IGy3dueJlLPpacDhJhoDlFBXqZdtvRPV/TN9BK8NRNqQyg1vBFXSTxetxZElOK0uRGi15qvkw==
X-Received: by 2002:a05:6602:6c06:b0:84f:5637:8dff with SMTP id
 ca18e2360f4ac-84f56378eacmr888310139f.4.1736947928125; 
 Wed, 15 Jan 2025 05:32:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 28/43] test: Drop the function for running addrmap tests
Date: Wed, 15 Jan 2025 06:30:58 -0700
Message-Id: <20250115133114.590375-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h | 2 --
 test/cmd/addrmap.c    | 9 ---------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 77af692be3c..54fddaa6bac 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -30,8 +30,6 @@ int cmd_ut_category(const char *name, const char *prefix,
 		    struct unit_test *tests, int n_ents,
 		    int argc, char *const argv[]);
 
-int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char *const argv[]);
 int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd/addrmap.c b/test/cmd/addrmap.c
index fd0117102e2..1f2deb15052 100644
--- a/test/cmd/addrmap.c
+++ b/test/cmd/addrmap.c
@@ -24,12 +24,3 @@ static int addrmap_test_basic(struct unit_test_state *uts)
 	return 0;
 }
 ADDRMAP_TEST(addrmap_test_basic, UTF_CONSOLE);
-
-int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(addrmap);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(addrmap);
-
-	return cmd_ut_category("addrmap", "cmd_addrmap_", tests, n_ents,
-			       argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index eb5ef099cb8..f68da4dcf76 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -173,7 +173,7 @@ static struct suite suites[] = {
 	SUITE(bootm),
 #endif
 #ifdef CONFIG_CMD_ADDRMAP
-	SUITE_CMD(addrmap, do_ut_addrmap),
+	SUITE(addrmap),
 #endif
 #if CONFIG_IS_ENABLED(HUSH_PARSER)
 	SUITE_CMD(hush, do_ut_hush),
-- 
2.34.1

