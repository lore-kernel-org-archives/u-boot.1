Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9443C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 623A484BCD;
	Wed,  1 Jul 2026 13:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dwujfrkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 391E384BCD; Wed,  1 Jul 2026 13:47:07 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD4584BC6
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-44841e9f651so334674fac.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906423; x=1783511223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4Mk0IreOf/uWtoXJurIwUnopRC8C53OBpPJC/dh90g=;
 b=dwujfrkIk7AwwVBrAEaICL5LF86m6UhZZHTWkBNHhtfYIng6Iim6VaxgkxEOjjzWP/
 sUidsostBLVo4swATOOucAenTVRZYb7K6jR8UHQrwd5eYJQcdNgwZWg4liBYBzx+2Xog
 9VQKzXTvtfD6upTUwKP4EgJViFuEZbPTDpCRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906423; x=1783511223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y4Mk0IreOf/uWtoXJurIwUnopRC8C53OBpPJC/dh90g=;
 b=kai5p8j+Y7pLo1EjgmxY1G9YPoZgjt561ZvRHuoEgQoaefWw/hfDEDlhLqKBTGZasR
 cQ8I+7KOVMeVdxtufI4bdNyrzX2IgBbqFGiCinp/jieKQj066LOPybVohKtKXI9Y3Mff
 ktTr0I9TEttozYOFmPao4UuImQIDPFZBN9xXir/2XgkvFsXHB/GeAX+70qDUJdGsrXbe
 CrzVrxON2DMSuhp8p6YiOnJeo5brvOLk5MIXGYzDmowHIrBwoGKx/u69MeHkq6vxpMj6
 PFwH47dWG2xQ7U9bWvtH8Vx7013dR3NuM+AEfio7J8hkmetU4heZ7f7alQM9/AWS7Xhv
 F2oQ==
X-Gm-Message-State: AOJu0YxFw3KJzVjlWiaYVe5Nl0QcXmQhSmqavgSTQGxzN1Zgzhk0JLBb
 XKjWh77xWcCLKwPW4aUUrF53uekL8Sj4SqvtxyqiAOaadn3oZYryGRN+j87HY+6oiEVk9BAJM3y
 QUwM=
X-Gm-Gg: AfdE7ckvdA48kiDGOw9EspWxO8opRPWyOEzF73y5+F2Zlf9a7AWXEKthsDeuBABck62
 /H2Xmnoz6UjZJ8p7DcKxAKz6ogiW2ZoIhOQd2uajP0BtUH20ltcP0x+nQRzZZoOygDMyok40ZUf
 3THDz9NMQMmkBv3cFrBWvQ+NGXRjxJ3MVhkMlD7UOB48rERk4MlsIt4WRDS4bz0Y7jm3Ha7ZIiv
 vai4EXmugEd6hZxDguNqxV8Tzof2OPRcXRAvqvw+5vNrmmcq45MMx2SsszFbmVHr4uRkHUjXBbm
 cgAy5VO1fpRTLkiDuSdSOxLfP322EFmFRVerCrfudl9Zr56IFYUiuPjKCxggVTDCbqv12Lp9Vaj
 XQ0yYRUdOHTnsVnVhEEmwW2+nkTKpzBiM9IxvTo/G/q4DkZhqnpAHmSAt6uNmED+ESnQ1LKD2mx
 WUbmtvtkw5ciHEq0H44A==
X-Received: by 2002:a05:6808:398c:b0:495:fa8f:6ddb with SMTP id
 5614622812f47-4960ef2058bmr803074b6e.28.1782906422627; 
 Wed, 01 Jul 2026 04:47:02 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 03/14] lib: getopt: Drop printed error messages and the
 silent variant
Date: Wed,  1 Jul 2026 05:42:23 -0600
Message-ID: <20260701114248.1396125-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701114248.1396125-1-sjg@chromium.org>
References: <20260701114248.1396125-1-sjg@chromium.org>
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

Inside __getopt() two printf() calls report 'invalid option' and
'option requires an argument'. Every U-Boot caller that uses getopt()
already detects '?' and ':' return values and prints its own usage
via CMD_RET_USAGE, so the messages are redundant. They also bring
in two format strings and the printf() argument plumbing.

Drop both printf() calls and the 'silent' that gates them. Rename
__getopt() to getopt() (the function is now small enough not to need an
inline trampoline), and turn getopt_silent() into a static-inline alias
of getopt() so the existing unit tests keep working without change.

Update the bdinfo help test, which expected getopt() to print
'bdinfo: invalid option -- h' for an unknown option; with the messages
gone, 'bdinfo -h' falls straight through to the usage text.

This saves around 120 bytes on 64-bit archs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Reword the commit message a little
- Fix the getopt_silent() kernel-doc and the bdinfo help test

 include/getopt.h  | 29 ++++++++++++++++-------------
 lib/getopt.c      |  6 +-----
 test/cmd/bdinfo.c |  1 -
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/getopt.h b/include/getopt.h
index 03db6647cc6..629c2e7d85c 100644
--- a/include/getopt.h
+++ b/include/getopt.h
@@ -25,8 +25,8 @@ struct getopt_state {
 	char *argv[CONFIG_SYS_MAXARGS + 1];
 #else
 	/**
-	 * @argv: Borrowed pointer to the caller's argv. In POSIX mode
-	 * getopt() never reorders, so no writable copy is needed.
+	 * @argv: Borrowed pointer to the caller's argv. In POSIX mode getopt()
+	 * never reorders, so no writable copy is needed.
 	 */
 	char *const *argv;
 #endif
@@ -71,8 +71,6 @@ struct getopt_state {
 void getopt_init_state(struct getopt_state *gs, int argc,
 		       char *const argv[]);
 
-int __getopt(struct getopt_state *gs, const char *optstring, bool silent);
-
 /**
  * getopt() - Parse short command-line options
  * @gs: Internal state and out-of-band return arguments. This must be
@@ -99,6 +97,10 @@ int __getopt(struct getopt_state *gs, const char *optstring, bool silent);
  * getopt() instead stops at the first non-option (POSIX ``getopt``
  * behaviour). An ``--`` argument terminates option scanning in either mode.
  *
+ * getopt() does not print any error messages; the caller is expected to
+ * detect '?' and ':' and report via its own usage string (typically
+ * CMD_RET_USAGE).
+ *
  * An example invocation of getopt() might look like::
  *
  *     char *argv[] = { "program", "-cbx", "-a", "foo", "bar", 0 };
@@ -132,21 +134,22 @@ int __getopt(struct getopt_state *gs, const char *optstring, bool silent);
  * @gs.index is always set to the index of the next unparsed argument in
  * @gs.argv.
  */
-static inline int getopt(struct getopt_state *gs, const char *optstring)
-{
-	return __getopt(gs, optstring, false);
-}
+int getopt(struct getopt_state *gs, const char *optstring);
 
 /**
- * getopt_silent() - Parse short command-line options silently
- * @gs: State
- * @optstring: Option specification
+ * getopt_silent() - Compatibility alias for getopt()
+ * @gs: getopt state
+ * @optstring: option specification, as for getopt()
+ *
+ * getopt() no longer prints error messages, so this is identical to
+ * getopt(). Kept for callers (notably the unit tests) that named it
+ * explicitly.
  *
- * Same as getopt(), except no error messages are printed.
+ * Return: same as getopt()
  */
 static inline int getopt_silent(struct getopt_state *gs, const char *optstring)
 {
-	return __getopt(gs, optstring, true);
+	return getopt(gs, optstring);
 }
 
 /**
diff --git a/lib/getopt.c b/lib/getopt.c
index 1b3dfa5f949..3b1dc7773ec 100644
--- a/lib/getopt.c
+++ b/lib/getopt.c
@@ -39,7 +39,7 @@ void getopt_init_state(struct getopt_state *gs, int argc, char *const argv[])
 	gs->arg_index = 1;
 }
 
-int __getopt(struct getopt_state *gs, const char *optstring, bool silent)
+int getopt(struct getopt_state *gs, const char *optstring)
 {
 	char curopt;	/* current option character */
 	const char *curoptp;	/* pointer to the current option in optstring */
@@ -117,8 +117,6 @@ int __getopt(struct getopt_state *gs, const char *optstring, bool silent)
 	curoptp = strchr(optstring, curopt);
 
 	if (!curoptp) {
-		if (!silent)
-			printf("%s: invalid option -- %c\n", argv[0], curopt);
 		gs->opt = curopt;
 		gs->arg_index++;
 		return '?';
@@ -173,8 +171,6 @@ int __getopt(struct getopt_state *gs, const char *optstring, bool silent)
 	gs->arg_index = 1;
 
 	if (gs->index + NONOPTS(gs) >= argc || argv[gs->index][0] == '-') {
-		if (!silent)
-			printf("option requires an argument -- %c\n", curopt);
 		gs->opt = curopt;
 		return ':';
 	}
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 7b7fb0894dd..195a86b8216 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -304,7 +304,6 @@ static int bdinfo_test_help(struct unit_test_state *uts)
 		ut_assertok(bdinfo_test_all(uts));
 	} else {
 		ut_asserteq(1, run_commandf("bdinfo -h"));
-		ut_assert_nextlinen("bdinfo: invalid option -- h");
 		ut_assert_nextlinen("bdinfo - print Board Info structure");
 		ut_assert_nextline_empty();
 		ut_assert_nextlinen("Usage:");
-- 
2.43.0

