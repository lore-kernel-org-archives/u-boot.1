Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A5DC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CCAC879A8;
	Tue, 24 Oct 2023 20:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IYBmt5mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26B938798B; Tue, 24 Oct 2023 20:18:42 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3721787986
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso445375ad.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698171517; x=1698776317; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2XFiMcnUcppKjZJlWV7qAxiCDli3d++cCATOvzvdH3c=;
 b=IYBmt5mwr3i+2mKDgJhBJYVXrEoOeFKW7ZvU4+9yX33otIg7Eb93iH3vpS+z2eXUDk
 SOZFoWreavWZE0XRlNtmjo0HYlsWkkVMHAoXzmXk7PChKA13MddrXu+HzNA4PbXEXwKM
 Iv+zoZ935FGaT9a6dWzLZZuG0hhNRp92tEn6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698171517; x=1698776317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2XFiMcnUcppKjZJlWV7qAxiCDli3d++cCATOvzvdH3c=;
 b=bX9NDnINAcrflwEnHYj3dC09NXzOZOOjwEkkRpyoLRYgukdHguVqx5Jwi01Xn5ruzn
 z7MsFx/Kr8G+jhFIiHoPfHqeRRK9AI+ssgbHj+6EXXbYwMCRm5alT0CfnHdnCsKCFBE2
 jB9ipL2LTKRVygCCQw24oYIJ1mkZH1dpuRGuWVb9fM8GJLDa4ScxLaJkwsqPG0OjvlgQ
 0f5+RA/L7EE7wGB+7eVOXP611vt25G2Xnz94HNYbeFV8bFMMUyf3iq83s+WCBa2tHiVz
 u3aotXhDxZ/RGJSb7mVjExnatpMyaFLBklGtv2p7vyBcsZlov37zXBOqms7aKelcABrb
 KtxQ==
X-Gm-Message-State: AOJu0Yy+TSL+Inn39REda/aAn4WzlJ28AzJXxX7iC7XPFubx0xFA1+eY
 i5MGhUbecBlHBMHP93OrLq5dak8SI4K6zQ59NcpZgA==
X-Google-Smtp-Source: AGHT+IGDbPSl5AHh4BehQvUtXIV87FAPaVv2XmLN4v/OAt/W5ILb9XIfbvX9W+rJhHmwQzsMlSCXFQ==
X-Received: by 2002:a17:902:f542:b0:1bf:193a:70b6 with SMTP id
 h2-20020a170902f54200b001bf193a70b6mr16593935plf.5.1698171517072; 
 Tue, 24 Oct 2023 11:18:37 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c62c9d7289sm7718691pld.104.2023.10.24.11.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 11:18:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] bootstd: Handle a few special cases in cmdline_set_arg()
Date: Wed, 25 Oct 2023 07:17:36 +1300
Message-ID: <20231025071736.1.Idf6184075aeff5599d9205c7efd61b10869cccea@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024181740.1938934-1-sjg@chromium.org>
References: <20231024181740.1938934-1-sjg@chromium.org>
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

Two bugs have appeared:

- arguments can have an equals sign embedded in them, which must be
  considered part of the value
- arguments must fully match the name; partial matches should be
  ignored

Fix these and add a test to cover both.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow.c      |  5 +++--
 test/boot/bootflow.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index be543c8588cc..6922e7e0c4e7 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -752,7 +752,7 @@ int cmdline_set_arg(char *buf, int maxlen, const char *cmdline,
 					in_quote = false;
 				continue;
 			}
-			if (*p == '=') {
+			if (*p == '=' && !arg_end) {
 				arg_end = p;
 				val = p + 1;
 			} else if (*p == '"') {
@@ -788,7 +788,8 @@ int cmdline_set_arg(char *buf, int maxlen, const char *cmdline,
 		}
 
 		/* if this is the target arg, update it */
-		if (!strncmp(from, set_arg, arg_end - from)) {
+		if (arg_end - from == set_arg_len &&
+		    !strncmp(from, set_arg, set_arg_len)) {
 			if (!buf) {
 				bool has_quote = val_end[-1] == '"';
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f5b2059140ac..f640db8a2418 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -973,6 +973,26 @@ static int bootflow_cmdline(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_cmdline, 0);
 
+/* test a few special changes to a long command line */
+static int bootflow_cmdline_special(struct unit_test_state *uts)
+{
+	char buf[500];
+	int pos;
+
+	/*
+	 * check handling of an argument which has an embedded '=', as well as
+	 * handling of a argument which partially matches ("ro" and "root")
+	 */
+	ut_asserteq(32, cmdline_set_arg(
+		buf, sizeof(buf),
+		"loglevel=7 root=PARTUUID=d68352e3 rootwait ro noinitrd",
+		"root", NULL, &pos));
+	ut_asserteq_str("loglevel=7 rootwait ro noinitrd", buf);
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_cmdline_special, 0);
+
 /* Test ChromiumOS bootmeth */
 static int bootflow_cros(struct unit_test_state *uts)
 {
-- 
2.42.0.758.gaed0368e0e-goog

