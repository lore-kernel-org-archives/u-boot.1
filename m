Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E8CC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45956809A4;
	Mon, 20 Jan 2025 22:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EpGDYBFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D01C8083F; Mon, 20 Jan 2025 22:54:29 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F349807C4
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3cf8e017abcso6896995ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410065; x=1738014865; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gV0nzFAOrcG4h6m5v2fSVVBNkUOShBPQgFVY3jYVLvs=;
 b=EpGDYBFlfp2v9WHrUURdZkwRTOVWldJQVCfJqUdAMbqLOLqDnl/3/CrPS5nc96AYjU
 niHIrcZjgZFoHFFaD51JwMcbt/HyXVqE6aBZ1k8S4JD+h7s20KW3PEAg4dcogd1Vqq6O
 ZsACtZL0TAYsO+65gfon3RcmmjNIXbN3+jYXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410065; x=1738014865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gV0nzFAOrcG4h6m5v2fSVVBNkUOShBPQgFVY3jYVLvs=;
 b=fny2Ue6FH+A8YLQCr/ig8xO2fCLITT46LpVng9RLDVvGeWdFcVA1tM+Af8iB4Edgwp
 aFS5vOZhg4vBqNDohogApz+CP011lncjdYSHXNUPlmp/qcEuYlyqv1SLJI5wa88N97Pb
 OPuYWk2mBVXeWRnnsa4RfUEutjFd+GlcnDoJ1UK01Z+kZYsQme3lZg0jyAIdTOaGTPKT
 2Qp1YplFT7viTCsdOEDSjtlmDcG6vEZxoCpxOu93Ki/pZhk4ClKf+M0jKJyT8abT468N
 0vvPTWxTN4HJpc9yqUR6mUPAtLv3EltU0LJXsrG9zriasl7Z7vYMBcco8qG0odHe8vNb
 0a3g==
X-Gm-Message-State: AOJu0Yz0h5CmEdNzKdqpNLsuT3pNrSfTvKMcTAgeQ3D0lACMC9zjNalu
 g/jPJqAIiyYoPjEYCHcdQpUVpE/FX8HQ9B3h58TlMjbJv1e3baZ46KCeNH9qPrKah7l5XLXiVJI
 =
X-Gm-Gg: ASbGncv27Lh+jn29m8alFtP4yP0HKqNF4KPpNVeNh/IwFNHe+UPY77eW8Dllj/UIWRv
 Z3CS6L1vQP5lmsrinmpx7vqCY2oRpFHl9giRtKLNKNtqWlV8YydXn3RbO2PYZXGwUahVLJlzIti
 S1rPLTMJzPdp6OTg3wA0wOSqRcceTOhzLwIOCNrUKxCB3MKKFW3ECDSqmn6N1NSXshWmxz3l3Jq
 yD2E4ULBcQX94Dsvgv2qHP1ZTJLh57Hl8ErjWwQskssod474k0WsV5nIXd1G9uMd9hIqUJsAd22
 qvagSMysCTbBHbRcFiH1DQK9I+ndOdI=
X-Google-Smtp-Source: AGHT+IEdpgWWDdlbGkX5b1YxGXRduvFOviDDCY6wk1A8BBGTsBlq/g6/zd+w9FumKNK8Jgo89pBhmQ==
X-Received: by 2002:a05:6e02:248d:b0:3ce:5a7c:6b5d with SMTP id
 e9e14a558f8ab-3cf743aba4amr129532895ab.2.1737410065319; 
 Mon, 20 Jan 2025 13:54:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jens Wiklander <jens.wiklander@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/28] test: Drop the function for running optee tests
Date: Mon, 20 Jan 2025 14:53:20 -0700
Message-ID: <20250120215340.617194-21-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h     |  2 --
 test/cmd_ut.c             |  4 +---
 test/optee/cmd_ut_optee.c | 14 --------------
 3 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 692633dcaa4..a2f982bf6fa 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -34,6 +34,4 @@ int cmd_ut_category(struct unit_test_state *uts, const char *name,
 		    const char *prefix, struct unit_test *tests, int n_ents,
 		    int argc, char *const argv[]);
 
-int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 1885c78be41..6d1e20ef02e 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -141,9 +141,7 @@ static struct suite suites[] = {
 	SUITE(mbr, "mbr command"),
 	SUITE(measurement, "TPM-based measured boot"),
 	SUITE(mem, "memory-related commands"),
-#ifdef CONFIG_UT_OPTEE
-	SUITE_CMD(optee, do_ut_optee, "OP-TEE"),
-#endif
+	SUITE(optee, "OP-TEE"),
 	SUITE(pci_mps, "PCI Express Maximum Payload Size"),
 	SUITE(seama, "seama command parameters loading and decoding"),
 	SUITE(setexpr, "setexpr command"),
diff --git a/test/optee/cmd_ut_optee.c b/test/optee/cmd_ut_optee.c
index 71833e5f6ab..df7b877025f 100644
--- a/test/optee/cmd_ut_optee.c
+++ b/test/optee/cmd_ut_optee.c
@@ -170,17 +170,3 @@ static int optee_fdt_copy_already_filled(struct unit_test_state *uts)
 	return 0;
 }
 OPTEE_TEST(optee_fdt_copy_already_filled, 0);
-
-int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(optee);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(optee);
-	struct unit_test_state *uts;
-	void *fdt_base = &__dtb_test_optee_base_begin;
-	int ret = -ENOMEM;
-
-	ret = cmd_ut_category("optee", "", tests, n_ents, argc, argv);
-
-	free(fdt);
-	return ret;
-}
-- 
2.43.0

