Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5F7C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 444D8809A5;
	Mon, 20 Jan 2025 22:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kw8+QMa9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBDFE80ADC; Mon, 20 Jan 2025 22:54:40 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4C0E8083E
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844e7409f8aso146891639f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410076; x=1738014876; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BekG8gdPygY3O0fAMv+Cb7OsKG/jRyu+013dbfH9nfg=;
 b=kw8+QMa9PHDpcELgn7LPw0y1gaL6s6EpDenj2mboiIEA1MWL4FBjX80rJGFGEYHYJC
 kJeFHty56RTZdL65jj6TqImFVeWbsUl41r3KgMKCg/TeEMhRtN+D7rW9h9yvCh1WZl5K
 DWPodFywrV54ZhKEnFzvdNsZBRy99xplKB6sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410076; x=1738014876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BekG8gdPygY3O0fAMv+Cb7OsKG/jRyu+013dbfH9nfg=;
 b=jOY4U9TqrEBfLpuxreFd+yyT74gIFlOLS64U1I1IJp1xzMnkhn+iw/3DQ4WCHwZ27O
 0P77esUJG9fdRkjJ46rS2mtei+uH+Spcv3jZ8DDThV2A/FVQPh6xFDiByS73PHh5YjXs
 N+EF0CO3fkDYMo4eamrG5m/g6zrs0S2F3/DV7ALnS/iD6IZa8iKq1r8G7SU6HjGtQPfW
 5Ai1p3lR5tvz5piAwEPavaNGwuD6GHqFEvZmYoN46bMMdtw8niM1VY0EB18gmUI+VXhP
 Kra23Yu0tlOt5XqmXc667dJLfpz8bRwXCwu6G+kI5lXyYBWMZozJccEPoXBymLOUocsG
 djKg==
X-Gm-Message-State: AOJu0YyCn3BAR7qh5TZD5T2H74lOyPJ0LJflA+Q3v6PvG4DCNwrBWj94
 G3JqZBwVcEgkIiQRfOIX5LuyQWBvi3IalA77/CAu2gNLCLU0IxX+r144BxLcQ677kRPBZcHmTfE
 =
X-Gm-Gg: ASbGnctQlLEeGF6iIuUGDwV8T98zgTYH/waCi3DDCwa9WjblorlPafvvlpGqmfJ714Y
 0YlHYDdgYcSRt4QLjJ+91MyYhtEcV1zwx+tPZJLWc26MBnkIXC8BTemAbGfSEz8tJAnch3w9r5J
 l2q80HjesN5/fwUxa7xWH1x9wSYFu3hCol4PW6yFqEzhbwvEpyURieambc5axpcIEs+EqT8dmRs
 9Jj31U5HqFp5ryBZCRx0JQDrrwv7ahT20PigpAER9RVjuV2ByVB+tHQP2w2VEPlcVySx8VLlulh
 +Bvx//aBmwxrliIATyWAJSUAousUGXc=
X-Google-Smtp-Source: AGHT+IHPwrYls015VoBHA/NklTjBLyW7jT3lg8E//XctbOtYOrTAsF0nzqguQGaRKfXQTpW283Wuwg==
X-Received: by 2002:a05:6602:358d:b0:844:e21a:e805 with SMTP id
 ca18e2360f4ac-851b6287ca0mr1276033939f.9.1737410076295; 
 Mon, 20 Jan 2025 13:54:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 26/28] test: Move code out of cmd_ut_category()
Date: Mon, 20 Jan 2025 14:53:26 -0700
Message-ID: <20250120215340.617194-27-sjg@chromium.org>
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

Move the logic from this function into run_suite(), on the way to having
flag parsing in the top-level 'ut' command instead of its children.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c | 62 +++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 2ef64d1182b..2e62081a3dc 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -34,40 +34,6 @@ static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[]);
 
-static int cmd_ut_category(struct unit_test_state *uts, const char *name,
-			   const char *prefix, struct unit_test *tests,
-			   int n_ents, int argc, char *const argv[])
-{
-	const char *test_insert = NULL;
-	int runs_per_text = 1;
-	bool force_run = false;
-	int ret;
-
-	while (argc > 1 && *argv[1] == '-') {
-		const char *str = argv[1];
-
-		switch (str[1]) {
-		case 'r':
-			runs_per_text = dectoul(str + 2, NULL);
-			break;
-		case 'f':
-			force_run = true;
-			break;
-		case 'I':
-			test_insert = str + 2;
-			break;
-		}
-		argv++;
-		argc--;
-	}
-
-	ret = ut_run_list(uts, name, prefix, tests, n_ents,
-			  cmd_arg1(argc, argv), runs_per_text, force_run,
-			  test_insert);
-
-	return ret ? CMD_RET_FAILURE : 0;
-}
-
 /* declare linker-list symbols for the start and end of a suite */
 #define SUITE_DECL(_name) \
 	ll_start_decl(suite_start_ ## _name, struct unit_test, ut_ ## _name); \
@@ -157,14 +123,36 @@ static int run_suite(struct unit_test_state *uts, struct suite *ste,
 		     char *const argv[])
 {
 	int n_ents = ste->end - ste->start;
+	const char *test_insert = NULL;
+	int runs_per_text = 1;
+	bool force_run = false;
 	char prefix[30];
 	int ret;
 
-
 	/* use a standard prefix */
 	snprintf(prefix, sizeof(prefix), "%s_test_", ste->name);
-	ret = cmd_ut_category(uts, ste->name, prefix, ste->start, n_ents,
-			      argc, argv);
+
+	while (argc > 1 && *argv[1] == '-') {
+		const char *str = argv[1];
+
+		switch (str[1]) {
+		case 'r':
+			runs_per_text = dectoul(str + 2, NULL);
+			break;
+		case 'f':
+			force_run = true;
+			break;
+		case 'I':
+			test_insert = str + 2;
+			break;
+		}
+		argv++;
+		argc--;
+	}
+
+	ret = ut_run_list(uts, ste->name, prefix, ste->start, n_ents,
+			  cmd_arg1(argc, argv), runs_per_text, force_run,
+			  test_insert);
 
 	return ret;
 }
-- 
2.43.0

