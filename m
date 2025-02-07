Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77C5C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:34:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7100480BAB;
	Fri,  7 Feb 2025 19:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cptN2WdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1622C80812; Fri,  7 Feb 2025 19:32:21 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5ED080C7E
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-851c4ee2a37so180582539f.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953137; x=1739557937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbF74sqRDP+Noh95qVvzSA7eWC5eg11bXf4LDMfNEwE=;
 b=cptN2WdYIwais/9kx1VuYHJfUVuzag/7V0ZKM2IygcATWyP5iMMB4SECZ3rHk94lD8
 vYC9NexfgZYfDLgp2xxALNas++PWSEoP9Hq5Ug8RDozsmg51yMt9CoecvzYiSWYZSaB9
 lNeEJnXEHZC179pN+xqwtx/J9HpYuErl/Vetw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953137; x=1739557937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbF74sqRDP+Noh95qVvzSA7eWC5eg11bXf4LDMfNEwE=;
 b=NJchdy2/P78BXFrA32gZbAYWRX5EkzmLHImVEtS55/5DbeZ5nzEC4R/fGLOgyEs1dV
 M+mT76WmJ042Fj4HQ3shwjHTlfOYMBJTVDW4AhsGcyp5qfgwRdQZduMNUOWsvRqoApiz
 n7WARXsTjN/OstPP/CElt02kEO0PF80FJs9ZIX0zd47eRl+EEaePxVM55xfddBEQkc+9
 ECs7PIeE2pyST/A+IFaMdgaG6WxgU4OLQuqAsJx8uK5VUnR2RKCLBUnNzxSFtwsgBGGx
 GyLdRoNxpACG/umQJvJCYkE5++gtN2q/DS3YTGMov/szGQRhJUncggqPuiildbI7Bgtq
 qfjA==
X-Gm-Message-State: AOJu0YzcDsvxOay3A5+m6yYiJYs3aBWRJK9O6fuxdKbo/gtaSry04WlQ
 sHB9QvbLON+1cQ2mmHPbyKn3DmWMMToHh0GPeOV8dNrPVLRfDvA3EOQb2Cno7g+/rlgaEflECtg
 =
X-Gm-Gg: ASbGncsG/qsSapE0SVGcLSFWvpHQVSLe6wv8bhtO4SjTIVlb13UUcpiBKRtmPyKakDt
 xZaDoqgwkQ9kSPU9xoE2E2d9RL8Bze8W/AapkPmFmaCdA3JyAIX418pNqcHZCiMgT7ZKbPwspWq
 wG4hAsgCH87Ej01Qng3rFwZ6WQXll69k5dWs5/NwAEhfcplyvsZZH15PJ/N6tGaCIiLScXRSJC2
 vEEWpjR/e7jFSdcKxXZYzLf+DXksyDxCQ+jk7S7qhBg/6ZH3Gseo9npT5rQTvaQEtHt84uEAAqd
 VxAULdv700qPVjGL29EPqbU9Q6zq49WyQAWtSeP/mVtgoKDD3Y4A
X-Google-Smtp-Source: AGHT+IHGKSaTCvNxEWPrl68Wmw1uJLq+pfWuvtb0F+TUJ7RPyFQuHT7dTfsAC3fxnN1INUzSTGSyKQ==
X-Received: by 2002:a05:6602:3944:b0:83a:db84:41a8 with SMTP id
 ca18e2360f4ac-854fd8ea498mr436647539f.10.1738953137123; 
 Fri, 07 Feb 2025 10:32:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 21/29] test: Drop the function for running optee tests
Date: Fri,  7 Feb 2025 11:30:52 -0700
Message-ID: <20250207183121.117663-22-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

