Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA875C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C73809D0;
	Wed, 15 Jan 2025 14:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g/vSjASS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA4AA809A5; Wed, 15 Jan 2025 14:31:55 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D94F580A0A
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a7d7db4d89so18252535ab.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947911; x=1737552711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtNEUdoC/N4OXuvUyqlBwFAdwcsIAsTDf4a6x2X5HFs=;
 b=g/vSjASSO/uxxYb1ZE0Yn4dt3C2ek5OlJx8S2WlU1X/gCaC3AvkNIlWTG0XJvfot70
 AK1iyEum3ujaITF9UDF/V6RVWt6KgYHg5OrA5w/u/FhZJwevjz0cJAflO9qkzG9Gdd2L
 4+tcq4aI8ZicYS0DPWiiNOP5RBYgzN2md0+0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947911; x=1737552711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XtNEUdoC/N4OXuvUyqlBwFAdwcsIAsTDf4a6x2X5HFs=;
 b=otRo7UnwIbPgd0oIBx0+cImiA0EvZwDjcVkZPgEiy4u49Xdm+XGYt3AUKYXjBZRy1k
 bivN+6z6SCvNKE4EbFfx8kKnEjDSqeJaE1z2uqlOPVWVoOKnCzMj3FcG6xogx7JzMa8C
 KO6dUr8llvrRzSFgMuMccqvB3IA0S5eV2pQ25GhsVSyQ8WKHNWpV4ZZu5+dgkz2xxSCU
 jsbWyaoY7u8j8n1myZeU9EuXRAN0XvMPW9E8hrz8AHU49T06EYjixo2DVMEw3Y5bmcO5
 xM0Xho8JzdgV6AvAdV7NXKc1mrsPGFPpqVPAlCM/Y0am23WIIbYgncTq61xumhTw0rjn
 8Dxg==
X-Gm-Message-State: AOJu0Yx6fE/N+Fvev3l2k8iiJ/REE2hb9zqFdNxrCpU1DEabAatEp7WX
 8VGJTQjt2eNPXHSBOdyYDE5Ua3FhglJDm2oqVzN1/gUYZenBbUMFdcEBBE6Qzd9mH6snzTaVSqk
 =
X-Gm-Gg: ASbGnctWm/k0P82a0YbMVW5wb5GUKFdz+gp+aq8kPo8EzF9IsXb3Brgl3m9EAifHSQw
 hCThxH9G3SKhv+Pm4Gckm2HfErP5B8CrUYRDznL1OdMGstYyicOK2unZa6Og1H+m6OsQ0nVC8Zg
 XkT8Etz25CkkSczGceBgT3ItoRS7MFu96M7WER0GYZE/SA04Kk+rTcPrgsdgwZqSfOFsRnHKm9M
 fxhLARC4LFJalTn2s0UzNME+ufY9IBYdv3M8lM1qc2DSenRAtxUZzBSEZWQsUoEE394NBMS1MNz
 msrRKyPWXYAinfOJVA==
X-Google-Smtp-Source: AGHT+IGn+5slzZ3zdJWBBfftc3z2P7BUsQqjSQ8wc3AVpMQj0hAsPh105MQCTot4ca6aIf9OSgm1ww==
X-Received: by 2002:a05:6e02:3984:b0:3ce:874d:f7ef with SMTP id
 e9e14a558f8ab-3ce874df891mr19524275ab.22.1736947911065; 
 Wed, 15 Jan 2025 05:31:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/43] test: Drop the function for running fdt tests
Date: Wed, 15 Jan 2025 06:30:48 -0700
Message-Id: <20250115133114.590375-19-sjg@chromium.org>
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
 test/cmd/fdt.c        | 8 --------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 70b9af1fd05..bf3a9851322 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -37,7 +37,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
-int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 74fd603bb02..ab6dbd45e54 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -1462,11 +1462,3 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	return 0;
 }
 FDT_TEST(fdt_test_apply, UTF_CONSOLE);
-
-int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(fdt);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(fdt);
-
-	return cmd_ut_category("fdt", "fdt_test_", tests, n_ents, argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 88a32129f0a..f6c28c73981 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -140,7 +140,7 @@ static struct suite suites[] = {
 #endif
 	SUITE(exit),
 #ifdef CONFIG_CMD_FDT
-	SUITE_CMD(fdt, do_ut_fdt),
+	SUITE(fdt),
 #endif
 #ifdef CONFIG_CONSOLE_TRUETYPE
 	SUITE_CMD(font, do_ut_font),
-- 
2.34.1

