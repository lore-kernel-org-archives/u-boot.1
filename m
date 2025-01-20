Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE4CC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDA9E8082D;
	Mon, 20 Jan 2025 22:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MhQaQeOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD0D80836; Mon, 20 Jan 2025 22:54:27 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7193680758
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844e10ef3cfso386332439f.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410063; x=1738014863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQhOOS7i0zK0o6eWM84QnPlSqPo4MwD1OFbM1vgIWhQ=;
 b=MhQaQeOhCuJSaH5CwalOoA8zRxuaaPT9rkkgrd6DZE0o4T3Q06P1o5J3mqqEYdC5CR
 XuM/OU3qN1056pzLJ6DpVuqaYo90tUoy+iRGw4aQwlWXZ45RSAS8ZqSMxDULg+LJtQCr
 kc0my21XYhNzoMnUFqxmtMZ/uh6O2H2IB/Uxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410063; x=1738014863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQhOOS7i0zK0o6eWM84QnPlSqPo4MwD1OFbM1vgIWhQ=;
 b=lWcMQKQRJTMtC2Q2/98qKGrL0tEVVmrvhT4Ss4GVBGYZ9TnvivC6y5vPZs9U+bpTuB
 VS2h9DZnz4J9dyMaIf4/y6sbdRAg4MBSxKbXJYC8/CiFk61+AbriuiXiEfCRoSGnoS8/
 X6cBR+j2EMB9WNl/Z8OCiFTLba16H6EU4F3oxJ5hrrHa2g4oe26xS11vM7BIIG40uEDw
 LpZX58yISIn7oPeKt1jDt5Lb565m2LxiJa3z4ZccP01FGmh62sB1u04GwddMTNA2EMjU
 5KcLgcTs7RzSd9T0IP7GvawWPHRMslDOV57JgdBivDsiNKglopktibzIh5WvpsuZsXUg
 xaTQ==
X-Gm-Message-State: AOJu0YzqT0FFwiZcLU/q3w7BKEXJ33LnzsO/PXZBzVJkOT7CFMeoxbOn
 n4q6hAU3zLhT/S+SRTYYSuQEUBCdbAbZr5MubEPUBZBoyWRuPTFTxKmSKLZ3h+EWgVJyJ6VNTF4
 =
X-Gm-Gg: ASbGnctf7ldvbNyUHOcDjmAslk2zKcULWXGO+KxQ5AhmDGzVzIP14evRoD0d64Cxxf3
 tBe8gyNI9TvkuAJ10nLVP2lEhFnrDAc6grBxIO5Cnp8LBwHISB28HHqdupHCf9zY7DlkdzC9hpO
 3R3KoTN/G7MEExj7SY9X81s4aROnz1Bwi3/uEC0rc/+sLTKs+hY9Iq40p35z3LvDSQWWOieEZ4Y
 9r/8PvTby/kAHByq1xhzALYf2JG/cYcdA4dCYZWTVFhzSBPCRxZOA4C/xo6g8nSwq7WFynz10w/
 KAewxZlXgvxQCTo5busTnjgpyRWO7xw=
X-Google-Smtp-Source: AGHT+IGQc7JmFo6v8UsVUCr2N4ucnYNgJdtRNe/kAl1dRAN3Sn+3s16EPCv0fCgnVnnZ/bGKG6OTOA==
X-Received: by 2002:a05:6602:7287:b0:843:e8d0:a728 with SMTP id
 ca18e2360f4ac-851b618dc7bmr1332474639f.4.1737410063260; 
 Mon, 20 Jan 2025 13:54:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jens Wiklander <jens.wiklander@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/28] test: Split optee tests into three functions
Date: Mon, 20 Jan 2025 14:53:19 -0700
Message-ID: <20250120215340.617194-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

These tests run three different checks on the nodes, but the logic is
currently all in one tests.

Split the code out into three different tests, which do different setup
and then run the same checks.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/optee/cmd_ut_optee.c | 57 +++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/test/optee/cmd_ut_optee.c b/test/optee/cmd_ut_optee.c
index 792de304c15..71833e5f6ab 100644
--- a/test/optee/cmd_ut_optee.c
+++ b/test/optee/cmd_ut_optee.c
@@ -81,7 +81,6 @@ static int optee_fdt_firmware(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-OPTEE_TEST(optee_fdt_firmware, 0);
 
 static int optee_fdt_protected_memory(struct unit_test_state *uts)
 {
@@ -124,38 +123,62 @@ static int optee_fdt_protected_memory(struct unit_test_state *uts)
 
 	return CMD_RET_SUCCESS;
 }
-OPTEE_TEST(optee_fdt_protected_memory, 0);
 
-int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+/* (1) Try to copy optee nodes from empty dt */
+static int optee_fdt_copy_empty(struct unit_test_state *uts)
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(optee);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(optee);
-	struct unit_test_state *uts;
-	void *fdt_optee = &__dtb_test_optee_optee_begin;
 	void *fdt_no_optee = &__dtb_test_optee_no_optee_begin;
-	void *fdt_base = &__dtb_test_optee_base_begin;
-	int ret = -ENOMEM;
 
-	/*
-	 * (1) Try to copy optee nodes from empty dt.
-	 * This should still run successfully.
-	 */
+	/* This should still run successfully */
 	ut_assertok(optee_copy_fdt_nodes(fdt_no_optee, fdt));
 
 	expect_success = false;
-	ret = cmd_ut_category("optee", "", tests, n_ents, argc, argv);
+	ut_assertok(optee_fdt_firmware(uts));
+	ut_assertok(optee_fdt_protected_memory(uts));
+
+	return 0;
+}
+OPTEE_TEST(optee_fdt_copy_empty, 0);
+
+/* (2) Try to copy optee nodes from prefilled dt */
+static int optee_fdt_copy_prefilled(struct unit_test_state *uts)
+{
+	void *fdt_optee = &__dtb_test_optee_optee_begin;
 
-	/* (2) Try to copy optee nodes from prefilled dt */
 	ut_assertok(optee_copy_fdt_nodes(fdt_optee, fdt));
 
 	expect_success = true;
-	ret = cmd_ut_category("optee", "", tests, n_ents, argc, argv);
+	ut_assertok(optee_fdt_firmware(uts));
+	ut_assertok(optee_fdt_protected_memory(uts));
+
+	return 0;
+}
+OPTEE_TEST(optee_fdt_copy_prefilled, 0);
+
+/* (3) Try to copy OP-TEE nodes into a already filled DT */
+static int optee_fdt_copy_already_filled(struct unit_test_state *uts)
+{
+	void *fdt_optee = &__dtb_test_optee_optee_begin;
 
-	/* (3) Try to copy OP-TEE nodes into a already filled DT */
 	ut_assertok(fdt_open_into(fdt_optee, fdt, FDT_COPY_SIZE));
 	ut_assertok(optee_copy_fdt_nodes(fdt_optee, fdt));
 
 	expect_success = true;
+	ut_assertok(optee_fdt_firmware(uts));
+	ut_assertok(optee_fdt_protected_memory(uts));
+
+	return 0;
+}
+OPTEE_TEST(optee_fdt_copy_already_filled, 0);
+
+int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct unit_test *tests = UNIT_TEST_SUITE_START(optee);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(optee);
+	struct unit_test_state *uts;
+	void *fdt_base = &__dtb_test_optee_base_begin;
+	int ret = -ENOMEM;
+
 	ret = cmd_ut_category("optee", "", tests, n_ents, argc, argv);
 
 	free(fdt);
-- 
2.43.0

