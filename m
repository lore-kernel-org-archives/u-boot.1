Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3643C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99BFA809A8;
	Wed, 15 Jan 2025 14:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ec+hhQBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8096D80B9B; Wed, 15 Jan 2025 14:32:10 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 597F8809A8
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3ce87e92906so2070225ab.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947926; x=1737552726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4joxtZA4MV8GT5mv/QwRIA2UYl4F8O+Vo8zkunr+QE=;
 b=Ec+hhQBGjdRCbitaz14HbZYn82pLrsIHQo9R7AY+mRjbUEGWBceRrruOr+RqRlNoyj
 p7cmNGVA4ii8f9k6/d70K4j4u0dv7jxiV33Awt57CLlwTRmxLioZ+TFhyqUQ69ojwwgF
 NVCWtCNm8knROKSo6e0XOqNf2kWdTZ0jcXo5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947926; x=1737552726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4joxtZA4MV8GT5mv/QwRIA2UYl4F8O+Vo8zkunr+QE=;
 b=T1r0yoXHchDdXGK4qCdg+cm/bu6ImMJMlXxuZe9XzY4CCGhAkh1DNCzvw+Xl962Ku9
 uGUWGh4PYRCZt7Tjau32pYnfnxdGp+Lt21W20SEL0E3a/Jc4uvHzr/ukol9Pu9xYJDJL
 0giCzTD+wsDhpSkdD3K9J1wmFRJ6pJ9FbszTTtcMR/esaC/tjoi9ClX0ThHeO/QYhi5s
 MQsTTw+IUVQddgg9VBojk3coozJhzZUpysJXmCL0sVcY/dJE7dhfAuHA1wBMiN8qpHXw
 TBUc6kxikN35XqOc34QAvkDgIvVe3Uhs3FRTZytc57dgq1USZDEgUvZI3xl9DtggSaSt
 EU6A==
X-Gm-Message-State: AOJu0YzrnCyPLIeGmE94ihVP/ABbqijxRtZX4D/yhXIBG9kZehznbIg6
 WJKitGfxYSgAOasxJsS6jXFoNzsn5CUzaLDSZy1VUkSTj/Z7g0fXUXRXnwNSeHBYzlsJr0w3w+M
 =
X-Gm-Gg: ASbGncs2oH9dnJWlOsceUrPwAS1KN0QeQcNvDtJGeLkgfdh1NktxQ+Al1PyEz2Ajjvu
 6zYROtrhZq6nVq4OvJFI0HQWmGx5j11L9Jzc5aWMRqfgqGtzS1OkiO5nqQt06JBorQH8T+SQzXa
 VoziV+vkQv6NZzHWNhx9JhpEjbu5I42SMNCwqUd+/GlyWZN8j2zebHu55rgySfVcCTI/uAT1ptG
 V1wiCbVcYg8UZWbfewHC/u7PGzvPgxU9QsagB0dJZU/edlCgjq8C+T4cjeaAvK3XZYihpOAFwAz
 Nfna/ecr3cfKdjwHTQ==
X-Google-Smtp-Source: AGHT+IEZM77UWxHzUOE0N5kAZfOJjLfHn3knzIRDiVVPzJI8mQssO269Qvxdul2KfHop/AMzhMKOiQ==
X-Received: by 2002:a05:6e02:1f07:b0:3a6:b445:dc92 with SMTP id
 e9e14a558f8ab-3ce3a9c8491mr212632615ab.10.1736947926307; 
 Wed, 15 Jan 2025 05:32:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 27/43] test: Drop the function for running bootm tests
Date: Wed, 15 Jan 2025 06:30:57 -0700
Message-Id: <20250115133114.590375-28-sjg@chromium.org>
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

 include/test/suites.h | 1 -
 test/boot/bootm.c     | 9 ---------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 32b7e8e3d5a..77af692be3c 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -32,7 +32,6 @@ int cmd_ut_category(const char *name, const char *prefix,
 
 int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/boot/bootm.c b/test/boot/bootm.c
index c8e32023acb..1ce5c3cd6bf 100644
--- a/test/boot/bootm.c
+++ b/test/boot/bootm.c
@@ -256,12 +256,3 @@ static int bootm_test_subst_both(struct unit_test_state *uts)
 	return 0;
 }
 BOOTM_TEST(bootm_test_subst_both, 0);
-
-int do_ut_bootm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(bootm);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(bootm);
-
-	return cmd_ut_category("bootm", "bootm_test_", tests, n_ents,
-			       argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index e0e01510016..eb5ef099cb8 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -170,7 +170,7 @@ static struct suite suites[] = {
 #endif
 #ifdef CONFIG_SANDBOX
 	SUITE(bloblist),
-	SUITE_CMD(bootm, do_ut_bootm),
+	SUITE(bootm),
 #endif
 #ifdef CONFIG_CMD_ADDRMAP
 	SUITE_CMD(addrmap, do_ut_addrmap),
-- 
2.34.1

