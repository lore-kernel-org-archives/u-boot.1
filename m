Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4582C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 240CA8032B;
	Mon, 20 Jan 2025 22:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aPGYLY9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F69F80759; Mon, 20 Jan 2025 22:26:36 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCC6E80792
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844cd85f5ebso399824139f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408391; x=1738013191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7AlkYOTz5o8ot/ovTsVdQgTeGMcYULg4gWEH2zgpOs=;
 b=aPGYLY9pkssT41Q0EpeSXDUgfGgAzFQZQcaeiX4KQFPxpyFurCnjfn8t8xAxRi7oYE
 TQL17pwr7T6BO/qont4k5fB7JjHJeQLnn7TLiR9NfykXsg/Vp13z9pKw4a8V8GuQItqG
 MbuYk5Aak7Kl2RN4+6ng+atzQSh7C0EndDeMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408391; x=1738013191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7AlkYOTz5o8ot/ovTsVdQgTeGMcYULg4gWEH2zgpOs=;
 b=HtCz5UtZBHdeCPHe4TeJoVqfIeVgqJhT/0aK3F5+AH/cKL00imZhXrDHeafttcahma
 ubXmk3VIgxDdfZ6NLyqwWxk5/TcFU0a2Ba++YHa+foe+yQkMADVQPJvTx+gNsJF+BBDc
 eQjAmIBNg4NZYzZHKd9mmXCtoKr7fm/y64/MB5HCRjNKydTAK9GSJKUeal1stYQFN15n
 LuEC0i0vAjx1XSldKjI7ldNI0AhzZxj4QBgX++OCUCXPZxZmE3oYMI1K0WJNIEqbwZc5
 bSzIicT5ZTOVjhcuyMtnN8NDSI5LzIlYVdntCLSJKRs5+UbaMjryYA+PG+oP132fPGNE
 GwkA==
X-Gm-Message-State: AOJu0YyCLdJ6AX8m6ZVMR5NeCjNNGiLUurcx8T7Vle4V+QCcoGY6sRvo
 dF0cpOEQHGFQ2aH9yQcFjZw6BsQdrDnyxOnbF8agHwhRj9HJHFabyDQmMMi282PlsRsJQan+Fy4
 =
X-Gm-Gg: ASbGncsdeBF9d9gky/ftEDPjKNG+V5HRpgsVhotVxaZbx2Opy2H8EPwFujzy2iFOjD8
 iG7QchO1W75F1EdRzfd7jN9JE/HHoWLZCABQOotnfsEV+d3QPZlVgyxZx5vNggsYiPczC3U1vNC
 rs6D5HvfPC8rWnqwHGcgH1CiN44fXa5Ht++i6UTf7kZ4YFkZ+kEdOI5ySAtcanFCwfAIYqfn50A
 pEd9pKJAJSCY8HOCpuYY1Ze2CJlIoFZvSAQhpl/35wk8wpYBgwDDP7wDh8onAsUlXcmoGSfXzVn
 uFS1UJ3Z1zpPsjBSNatmjwyZX2xsx9w=
X-Google-Smtp-Source: AGHT+IHOcOCZxgzkgHi9a5DzLpMQswnF7YZLB6d9UluiC0MQx1RuXG5yMhVGjKoY3OYg4HL8j72/NQ==
X-Received: by 2002:a05:6602:1651:b0:83a:f447:f0b9 with SMTP id
 ca18e2360f4ac-851b64fa7eemr1575030839f.9.1737408391614; 
 Mon, 20 Jan 2025 13:26:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/44] test: Add functions to init and uninit the test state
Date: Mon, 20 Jan 2025 14:25:25 -0700
Message-ID: <20250120212613.516664-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

Move these operations into separate functions so that it is clearer what
is needed. These functions can also be called from somewhere other than
ut_run_list().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/test-main.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/test/test-main.c b/test/test-main.c
index cfb3504941d..871fc1f22b4 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -73,6 +73,19 @@ void ut_set_state(struct unit_test_state *uts)
 	cur_test_state = uts;
 }
 
+void ut_init_state(struct unit_test_state *uts)
+{
+	memset(uts, '\0', sizeof(*uts));
+}
+
+void ut_uninit_state(struct unit_test_state *uts)
+{
+	if (IS_ENABLED(CONFIG_SANDBOX)) {
+		os_free(uts->fdt_copy);
+		os_free(uts->other_fdt);
+	}
+}
+
 /**
  * dm_test_pre_run() - Get ready to run a driver model test
  *
@@ -664,10 +677,11 @@ int ut_run_list(const char *category, const char *prefix,
 		struct unit_test *tests, int count, const char *select_name,
 		int runs_per_test, bool force_run, const char *test_insert)
 {
-	struct unit_test_state uts = { .fail_count = 0 };
+	struct unit_test_state uts;
 	bool has_dm_tests = false;
 	int ret;
 
+	ut_init_state(&uts);
 	if (!CONFIG_IS_ENABLED(OF_PLATDATA) &&
 	    ut_list_has_dm_tests(tests, count, prefix, select_name)) {
 		has_dm_tests = true;
@@ -703,10 +717,6 @@ int ut_run_list(const char *category, const char *prefix,
 	/* Best efforts only...ignore errors */
 	if (has_dm_tests)
 		dm_test_restore(uts.of_root);
-	if (IS_ENABLED(CONFIG_SANDBOX)) {
-		os_free(uts.fdt_copy);
-		os_free(uts.other_fdt);
-	}
 
 	if (uts.skip_count)
 		printf("Skipped: %d, ", uts.skip_count);
@@ -714,6 +724,7 @@ int ut_run_list(const char *category, const char *prefix,
 		printf("Test '%s' not found\n", select_name);
 	else
 		printf("Failures: %d\n", uts.fail_count);
+	ut_uninit_state(&uts);
 
 	return ret;
 }
-- 
2.43.0

