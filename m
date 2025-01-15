Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7341EC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEDB080BA6;
	Wed, 15 Jan 2025 14:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HQhmkHgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D2818096D; Wed, 15 Jan 2025 14:32:32 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BA080BAE
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844e9b8b0b9so503333539f.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947948; x=1737552748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kb3SmMeGudbe6J0+HK207lt+tXzHLp0Pk58c6msJ9oU=;
 b=HQhmkHgT5jTj4+c6X5AEHORUhiqNMpwQhl8fHxrSpsaFaDGbphPo32+bF8bIqzLqNH
 NdHnChwcqZZHdinsYFHSGyCsf55CY4v2iTxwISCXdATmFxixFGco3jjWRWeJcBTK2Y48
 ZaAFBHL+2FYQE/jS4dcapcnUazSdmnhBFmHao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947948; x=1737552748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kb3SmMeGudbe6J0+HK207lt+tXzHLp0Pk58c6msJ9oU=;
 b=DsDBHFRdgKs+HA1Ih2X4L/HlmVsTKcPmWAP4w/GPrmDCV/3A6vsSQM8NgYljY9raf+
 d1t5wBZ2/gbZx7pUrLXmmyWO2sna0IvZPIsg89Q0gCnVPNRtisiNcGqyt4xDfuv8RQDZ
 9768OYrRUZJp+V3milKNFE+0ALEK0PjD3hbXhT04LcXgmdPxfeZ7DseJ5feleOQILJy1
 LmEqHXTahrL5yK+HRDrnF1XPnU/iwt4ivFDkE/yWqGuAgmW3oyBvoEjKH3uuHrrTPddF
 3DIYjU+xoQGXB32Y9/ANLOiM8hf8MVxn/CGdHFR5ZhiZUHjHL1+qbxjp4+6Z6zJcWjmU
 MQig==
X-Gm-Message-State: AOJu0Yyz9RSHs+U/WDjr2ahrL60Lvwz8gs8Xc4SCtqcg20YBw7d1Vqje
 v9f/DMkH0WIwqlbB1ACnCRnjR1GD2mrrjTbsN5je42FolMzd0WyY8E/eFcepC0PxW8x/zGVd+BA
 =
X-Gm-Gg: ASbGncvNl1MjtGIjjaV+RG5PA03PttGhrJjuU1MUNne2QTp3NbGy58I8Bi6ePk0eymV
 /3wr+bBMnslpqWlyESH5I4YV9uLCJse3cwHb7u2RGxMMwSsYHT111PZmwPv5g/13O3kzUCOlRJI
 WVAJ1/pd9hGWZlbN8By+900b66EPTTFovqu0wjAoco6Yer90bEKgkhgdvkK2agND+0GHV/CpMru
 k/3STRYR2oTjC5Mwp2Cah9ieK7weoNcAfonOI0PGtQJF6vnEdcezX2bS2wW/luJk5h77H1NEwLh
 zYxY5Uags9sBIS6jbw==
X-Google-Smtp-Source: AGHT+IGe7C0sWR2pEJf6qXPinHTFbaH6yxhI/NQRyIfsmB6ZehYm445hqmLohmp1SeUTD6LpG0r00w==
X-Received: by 2002:a05:6602:4c06:b0:841:950b:386d with SMTP id
 ca18e2360f4ac-84ce0036c1cmr3048051439f.3.1736947948007; 
 Wed, 15 Jan 2025 05:32:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 40/43] test: Record and show the totals for all test runs
Date: Wed, 15 Jan 2025 06:31:10 -0700
Message-Id: <20250115133114.590375-41-sjg@chromium.org>
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

With 'ut all' multiple test suites are run. Add a way to collect totals
and show them at the end.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/test.h | 3 +++
 test/cmd_ut.c       | 2 ++
 test/test-main.c    | 9 +++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/test/test.h b/include/test/test.h
index f7087ab4eea..58023f6eafb 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -27,6 +27,7 @@ struct ut_stats {
  * struct unit_test_state - Entire state of test system
  *
  * @cur: Statistics for the current run
+ * @run_count: Number of times ut_run_list() has been called
  * @start: Store the starting mallinfo when doing leak test
  * @of_live: true to use livetree if available, false to use flattree
  * @of_root: Record of the livetree root node (used for setting up tests)
@@ -48,6 +49,8 @@ struct ut_stats {
  */
 struct unit_test_state {
 	struct ut_stats cur;
+	struct ut_stats total;
+	int run_count;
 	struct mallinfo start;
 	struct device_node *of_root;
 	bool of_live;
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index f315c442abf..f33918ddd00 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -206,6 +206,8 @@ static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 				any_fail = retval;
 		}
 	}
+	if (uts->run_count > 1)
+		ut_report(&uts->total, "Total tests");
 
 	return any_fail;
 }
diff --git a/test/test-main.c b/test/test-main.c
index a0a3f6086ef..6010c24207c 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -690,6 +690,8 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 	bool has_dm_tests = false;
 	int ret;
 
+	memset(&uts->cur, '\0', sizeof(struct ut_stats));
+
 	if (!CONFIG_IS_ENABLED(OF_PLATDATA) &&
 	    ut_list_has_dm_tests(tests, count, prefix, select_name)) {
 		has_dm_tests = true;
@@ -727,8 +729,11 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 		dm_test_restore(uts->of_root);
 
 	ut_report(&uts->cur, "Tests");
-	if (ret == -ENOENT)
-		printf("Test '%s' not found\n", select_name);
+
+	uts->total.skip_count += uts->cur.skip_count;
+	uts->total.fail_count += uts->cur.fail_count;
+	uts->total.test_count += uts->cur.test_count;
+	uts->run_count++;
 
 	return ret;
 }
-- 
2.34.1

