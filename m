Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C339DC02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6602C80A37;
	Mon, 20 Jan 2025 22:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fr0r2VCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD1F8083F; Mon, 20 Jan 2025 22:27:22 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E939B8083F
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3ce87e92906so16494705ab.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408438; x=1738013238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fd8J65YP8PG/FtnFZp0JEpP5qlcYWMyt/3bR3Dwsr+M=;
 b=Fr0r2VCzcg1QrhmWhraorf19l0HBtPXbD+RlvD4XtW05kzETC6H4rYssWA0/Q5vE/i
 UxEaWHfMp7aTU2c50wW4l8adNkuxhrM8uOix5glfEJPs0vP7TCQXow+BMh4I7XtxGmqS
 K1I7lGFGYKmIEWjxdKPfowxQ2peKNm/hY1zxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408438; x=1738013238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fd8J65YP8PG/FtnFZp0JEpP5qlcYWMyt/3bR3Dwsr+M=;
 b=j08lqLZk5pGx9mObrjzB0YOHJdbV1bFWmnT5BPPvyszlPnCuTTQ891bI7X1JhUeL5e
 242TAXZxYnnr3tJ0JBKHtV2qkuQNliwL2bD3sG5GYRGpg9mJji7UDDlqNrP+2/cpAYbM
 +DPNcmF35FR0wX1RdRdeGduGxdd8fnxxm//tqo5YywchNwqwXgPmIkPzWyJQiVKwq1GH
 xK93Sd5xFGpslTIZfZ+Jdy7+lc1p4fvYuy2/kXTVrZDPgcsA21AGoTHqPZLxblY1y6XR
 6KELNO9mahfpFFf3VblcatuvqDB22YQuAaszmKTcVBDVay3VJORjveEj+kkAfDtVyMsl
 YSEg==
X-Gm-Message-State: AOJu0Yy3h7vEoXA81u7QDaWcSOha40vfn7YFtwq3Iu76UJjYDDeHUMYC
 r4yWIpZKlWbQA8aL9ML6GNBSiTxQg4k4vdw1aA3Wmy1Zq0b0Jo0jLOcH9CIWorzT/ayQuaGl8xA
 =
X-Gm-Gg: ASbGnctT2mbAiV4G6fqIAUu+Q9KH9GNHCzRccbxNagIkd2HIeh5DyK/smpKWlGdMqWv
 opiMippjtVHaoCV6LFV7ENH47soU43wWFFw/SlIAyBjB8RlnCdY0keXm+3UrIWU6cbxH/V6Ztfo
 SOk1K4SFUnF0/5zzTtfb9DxSRl3/3jPVC/3utJhOwNqQZPyBwk+de3IZJ8TuWIyq3LTGq33gILK
 JCDTM9h5J5gs7ijldyDJuNekuqVVAiTCNLitRRfwuBX+TEBDC7U4IVJ7q0Ut1BLW85Y+Vhi9FBE
 NMGUAKwRjE49q9+6Gk/6cy/3BarEgQA=
X-Google-Smtp-Source: AGHT+IFkpxO4TqHiJ5T/EjjDSFACEsYE4m/+4KO20xSEc7hnQ5G3laHbym45cSkWF7WPdqFbYzXzoA==
X-Received: by 2002:a05:6e02:219b:b0:3ce:665b:cdf7 with SMTP id
 e9e14a558f8ab-3cf7447c268mr100409095ab.14.1737408438222; 
 Mon, 20 Jan 2025 13:27:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 27/44] test: Drop the function for running bootm tests
Date: Mon, 20 Jan 2025 14:25:49 -0700
Message-ID: <20250120212613.516664-28-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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
index 93bcc5efc74..71283d6dd14 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -171,7 +171,7 @@ static struct suite suites[] = {
 #ifdef CONFIG_SANDBOX
 #if CONFIG_IS_ENABLED(BLOBLIST)
 	SUITE(bloblist),
-	SUITE_CMD(bootm, do_ut_bootm),
+	SUITE(bootm),
 #endif
 #endif
 #ifdef CONFIG_CMD_ADDRMAP
-- 
2.43.0

