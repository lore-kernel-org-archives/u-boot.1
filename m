Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D155FC02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C04180AE6;
	Fri,  7 Feb 2025 19:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y0lhslZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 553AB80AE6; Fri,  7 Feb 2025 19:32:19 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A53807FE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844e39439abso65522139f.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953135; x=1739557935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2B/fk99rY+y1RuN3toqbiQDOBjDylowl7USYq7r8yQ=;
 b=Y0lhslZ28WBpKCS2lqen3+/L41dLKL7vBsnjAiugW3K0yJxw5CDAPRmsAdlHCxOZ6l
 dSfAP43edBv0LKZv5i5R14NakzMQlBB0tU93MkoephnnV8LUt6V0FFXtP4zes/0TxI0g
 ljinH1J5FLuyQXXMP4OUvhKaQkFdaR0nKawGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953135; x=1739557935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2B/fk99rY+y1RuN3toqbiQDOBjDylowl7USYq7r8yQ=;
 b=OGGuhKXPkwllJ+fGukJjHZOlePlkg/j5oJqx6DylCq6LDF7DWZIl60QIavl6G0bg76
 yYLhDSQMUUAIjFQcURrvKSp3Xw1qsXt1QpEamFohdOOC/tXs3UawpmwAnLr2Ou/2K78W
 RD94b/JYY3d6rzHfOoWgHC+IsRaXJy2/FAYu9X6OKVfPJqL1lC+QqJChhgC5Tsj+0XyN
 7PE/hSwx56lYmPS9XT3U/oLFASNjvtpn9VEjPAQeJfcMy1ebRhdCmoWvIhQxBmpiaNBZ
 J7q7DI29LSWxuxXH55DUTSJORGgRxNmTOe+Slv02peORJ4O1YjRt/DG6phAVpboRNfRX
 mdyA==
X-Gm-Message-State: AOJu0Yxd73ymVbK02yUynjwRY5eQe/X0E2v+D6a4CQlYyyL8FwgZ7cEP
 m9+JcaHPpUhBdK1HqIrrVTsmvGTAfSvvIb2xPbQx5MS2oqL6Sn1DVyU9k+phpwVrDtbhJoaUmeU
 =
X-Gm-Gg: ASbGncvcUB1TivBdw5nKwiEBYteqIEEdyhnu2XNGBOZwxcRvu/kVMOWHdASoVxVKoPF
 BRK4HTMCyESH5+IvA8qbV8jtjH9wcopJhfG13K4mW/xyr9LWkb8qE45jwTt2EofBa7sL4usxKgH
 i49556fBPWPwjP0lHPf3BBVe3CctrXYf63GJQJwt+EurBdOOVFKyZWGN2bOoZ9tuElYQyLsJLRV
 Xtr5FSlGHNrMptWC7nVcY7h60q/zdmMa94SvTFuEOnlzQfWtalg3QV2BVBKYVkcJm8UExaR5aCF
 0+/xFA22QeFrIaERc01k1WkP/3KAzqb1V8T1wwBvrFpgz23nsd+5
X-Google-Smtp-Source: AGHT+IETQPKrS+F5BYt74o0tUP+8JKV0vrIm8UFGPur/9AhTyX4x+pGLvBO6c4ZxD+jh/wy1QS4dYg==
X-Received: by 2002:a05:6602:b8f:b0:843:ec8d:be00 with SMTP id
 ca18e2360f4ac-854fd90833emr454640939f.13.1738953135116; 
 Fri, 07 Feb 2025 10:32:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 20/29] test: Split optee tests into three functions
Date: Fri,  7 Feb 2025 11:30:51 -0700
Message-ID: <20250207183121.117663-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

(no changes since v1)

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

