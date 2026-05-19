Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9B2CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0702848DC;
	Wed, 20 May 2026 01:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wg7MTdtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C62C84912; Wed, 20 May 2026 01:33:05 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 339738488F
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-68470763896so2191281eaf.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233580; x=1779838380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbraLQoCE8n69ubkOp8TaPs7TPRY2tt12S8ALZCfZLU=;
 b=Wg7MTdtE0VZattGDQOMzgwQTUYfDkgF1a0p4T9V8vSzGWRcxp6Hr/L7kn8h0CkwqqO
 ipoU5kin1xUT78vcXQsKpAKIevZH2qYVbJyG1YY3FsKFR9IF6cts+CBk3FGnmSg11FNH
 CvoiL//xWQJrft1gTQKWAMTPjRlm8T0rxmlZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233580; x=1779838380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HbraLQoCE8n69ubkOp8TaPs7TPRY2tt12S8ALZCfZLU=;
 b=XiBusuZQ8T6ghiwZZ0/RHmYS4/iqu21m0IaFicYq4Q/HcyGj7f1LMbpN0Xr8n4uvU3
 H5Ig4FHdiQ3brwUmgmI5tGM+irplS7e5ThzHgEh2UA5pRtJoo/vQRFF7iYkYoYW1koZW
 oYXIUZgUKpJQ/q7+t3h8CY6Pad9Rdq9Y4xW8aY9TABmUHYunqKr4K4AUtlp3odY1J9ir
 xBnlNp3gMv39S9KGD24JSwSxv7bcCx8kcUKYM9IQTpE9ad0kCEhHUAQ8dbqbYYWndJz+
 5MeEsWZhkXrgE5Y5eQ8UsKLpTfxS8c1Vvflz0sP+Pe52A1tsA9nheqCB1tPVgtNVkVIX
 1c0w==
X-Gm-Message-State: AOJu0YyNjJIy8Jqqbxc3VhKf7sPWHrBUPMP1fm9/7yd+0ADp8L+TmCc6
 C/FHM6Yjh6hYXztuiCTkaSSiWt8FfjdY/iX2ZxuV6c3O0VdN2h4F55hfKkNSTrEQhK8SsXDWIkJ
 6+FfF8L+0
X-Gm-Gg: Acq92OEwOXYsGlVr0b1I7nHGHEv3k2VabCS4NDzaPFd80cVUi3BKNrEcno/cSZ+OTsv
 PSJurS/ffleEu7VpvLopRQ0jtxMBW1KxAtT2if3QjWdcGabeaUmhoMWMGNjcK47NRGdTWUkUMXO
 si2fUxnan1MtWV44kGI9jBFVuJYUO05waVu6GCgY06hOYKuEO739HfgO20enssF0+uTEUUJZByi
 SCbq4SNe81a86Ixhs+m+VmyEEqY0R1ibnxbPzW18mnLSi5BNqMyzF51qzsxdJkf9582WhIEnIuf
 2LZpABaZQ2YiFvRNK12JkxLGETPsz6zSAhTpfqt/mTrjZySrRBOQLzgbDnAO/+Dr6EY/mqLRng+
 Rl98WjarWY3WXm91ZhQXfnZkGaOHMHku0ejMC9+dybUf57oDlgiMLVljjpODRHjIRNx+cd8vlPf
 wdOxMPKrcFToATOvy8lQ==
X-Received: by 2002:a05:6820:290e:b0:696:63dc:cac9 with SMTP id
 006d021491bc7-69c942fdf14mr12990374eaf.23.1779233580260; 
 Tue, 19 May 2026 16:33:00 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH v2 13/17] lib: getopt: Drop printed error messages and the
 silent variant
Date: Tue, 19 May 2026 17:31:39 -0600
Message-ID: <20260519233207.2765755-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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

Drop both printf() calls and the bool silent parameter that gates
them. Rename __getopt() to getopt() (the function is now small
enough not to need an inline trampoline), and turn getopt_silent()
into a static-inline alias of getopt() so the existing unit tests
keep working without change.

Saves around 60-120 bytes per arch (116 on sandbox, see following
buildman delta on firefly-rk3399).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/getopt.h | 21 ++++++++++-----------
 lib/getopt.c     |  6 +-----
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/include/getopt.h b/include/getopt.h
index 52aabcc19ac..5ecd60d4d1b 100644
--- a/include/getopt.h
+++ b/include/getopt.h
@@ -61,8 +61,6 @@ struct getopt_state {
 void getopt_init_state(struct getopt_state *gs, int argc,
 		       char *const argv[]);
 
-int __getopt(struct getopt_state *gs, const char *optstring, bool silent);
-
 /**
  * getopt() - Parse short command-line options
  * @gs: Internal state and out-of-band return arguments. This must be
@@ -89,6 +87,10 @@ int __getopt(struct getopt_state *gs, const char *optstring, bool silent);
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
@@ -122,21 +124,18 @@ int __getopt(struct getopt_state *gs, const char *optstring, bool silent);
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
  *
- * Same as getopt(), except no error messages are printed.
+ * getopt() no longer prints error messages, so this is identical to
+ * getopt(). Kept for callers (notably the unit tests) that named it
+ * explicitly.
  */
 static inline int getopt_silent(struct getopt_state *gs, const char *optstring)
 {
-	return __getopt(gs, optstring, true);
+	return getopt(gs, optstring);
 }
 
 /**
diff --git a/lib/getopt.c b/lib/getopt.c
index 0179ae4d5ea..5e907477e57 100644
--- a/lib/getopt.c
+++ b/lib/getopt.c
@@ -27,7 +27,7 @@ void getopt_init_state(struct getopt_state *gs, int argc, char *const argv[])
 	gs->nonopts = 0;
 }
 
-int __getopt(struct getopt_state *gs, const char *optstring, bool silent)
+int getopt(struct getopt_state *gs, const char *optstring)
 {
 	char curopt;	/* current option character */
 	const char *curoptp;	/* pointer to the current option in optstring */
@@ -92,8 +92,6 @@ int __getopt(struct getopt_state *gs, const char *optstring, bool silent)
 	curoptp = strchr(optstring, curopt);
 
 	if (!curoptp) {
-		if (!silent)
-			printf("%s: invalid option -- %c\n", argv[0], curopt);
 		gs->opt = curopt;
 		gs->arg_index++;
 		return '?';
@@ -148,8 +146,6 @@ int __getopt(struct getopt_state *gs, const char *optstring, bool silent)
 	gs->arg_index = 1;
 
 	if (gs->index + gs->nonopts >= argc || argv[gs->index][0] == '-') {
-		if (!silent)
-			printf("option requires an argument -- %c\n", curopt);
 		gs->opt = curopt;
 		return ':';
 	}
-- 
2.43.0

