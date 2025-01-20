Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846ABC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61ECD807F9;
	Mon, 20 Jan 2025 22:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YF9RNk2o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C7648082A; Mon, 20 Jan 2025 22:27:05 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 189C2807B6
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844d555491eso136098539f.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408420; x=1738013220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7NXZKD6S9ahq1S+sfskqj4bhb7fdFjRTcZ98OlDRU4=;
 b=YF9RNk2or752tf+1mjKPDIvZHHTmH3p/BHwV6lZ6Ss1XSJcAa+371AC8YMHhZj7ycL
 HP6JDuxlM/hyVaeWsrL8OjdlDDAQn+kuCSLQ2FyiXKHRVUdc/rGzHLhIyd+QL9x3DGUq
 nBQ2+ri3HyZKhTn+Vv+Yz5B66yUBVdP70SVeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408420; x=1738013220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7NXZKD6S9ahq1S+sfskqj4bhb7fdFjRTcZ98OlDRU4=;
 b=sNC4pFJSoz7ZurGKxys/wVCtr8vGrqLKJQh4g9gM0UTwv8wO/LI72BYTtJNlNMUPME
 YcmShXgLRCZ1Lt2o+xL+IPkAgsC2tCQz2DZcCQaSoUkcM7j5MAFCFwvkE4cu+pUWcK6k
 K6DE8do7hRRKLV7dmve14Fp4/QC0Stu5862kPkA2rfJ5np2vVhpdLuQLd/z3x7JmneRf
 d515lVxEBk60jXOBPfJVWL087W1lfotqV5fg33W0xNIe19hGBuGduFn8H0gvO+1GaN0R
 wtDqISS4fQ1iPzoEad6dpLsviFGg/klEl0AfSUyRr+L8vWtYa1m7XL2zTZ9w2XAm9WWi
 A3mw==
X-Gm-Message-State: AOJu0YxsilVgBef1UHDDbiJLWbxrSqHBmCgg2Z5NYoNJWzL/XsEnZ6mN
 r6PHZJLlVuLG/0+xwxe3UF2SGSsNV4LnSFRmrbm0l6/W/dgXfJVU8knygq3po0HI/vAFVxRxyn8
 =
X-Gm-Gg: ASbGncu3tugfGsRZ2yOzn3Yv2MryRuJ9WGpCSgZjhCL0wAD8mTdFHGC0aln9M5Qd2tC
 j+sgv5qTv+1QSoVxtkFYQGDxi5hH2z7xB95cKalYCR5ZTmt0pF9ZD/lmuBqiJTnyF7xNEPbbkUx
 saRpQTDTCeGbbOJirod0qYklPthskuwFPyOe5yrC5Hdadmx/OlDLi78XuSFs8DaJv9LOUbLgX7b
 gZE4AMUcC+0H+9ze9kts9LfNHrXlZP1QMXkSJxn7ZIbcLjuXJ5s9TLqrcxg3CDLyZLws8Ze9PC+
 vrG6EgMSh+6Fmgq02lefOyQxdjewG6k=
X-Google-Smtp-Source: AGHT+IEqMJEEVSC1wAJhrCEKy/1nxzB53d7+7WYOeAYW0fdqRmSV9/tiQqzyNWXA+vjmXqsgWL6DCQ==
X-Received: by 2002:a92:c24b:0:b0:3cf:71a6:721f with SMTP id
 e9e14a558f8ab-3cf74495f3amr93422745ab.17.1737408420513; 
 Mon, 20 Jan 2025 13:27:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 18/44] test: Drop the function for running fdt tests
Date: Mon, 20 Jan 2025 14:25:40 -0700
Message-ID: <20250120212613.516664-19-sjg@chromium.org>
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
index 387aacb916b..0babc91d118 100644
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
2.43.0

