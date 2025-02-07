Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A00C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3E880812;
	Fri,  7 Feb 2025 19:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LMcbFr2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B6480D28; Fri,  7 Feb 2025 19:32:37 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2983A807AE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844d7f81dd1so74880139f.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953153; x=1739557953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zI4LQ4hJg//sP1Ze4dErUJoX9X35YmfVeKjUEfqzbfk=;
 b=LMcbFr2JHS7JMZgOqHjuj8v+8FseDb0VxS429J3EZKz8ezi9YScu9YmI3HhIfgHm+C
 SeBtYMz9nr4Mh5XQmnGcUoPmqylMg8sF3Rs+emMCeIPuavTchr6TriQIOm536/Q6ztFC
 +vBhqzFET6nGAV2erxp1t7UyDw5yocsJgJJYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953153; x=1739557953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zI4LQ4hJg//sP1Ze4dErUJoX9X35YmfVeKjUEfqzbfk=;
 b=kn6McUHKCktsq29dgdXUVsQy6aisb5NH1rIVvOdmZKarQ0kSwtCAzebJ8co/wqT5fn
 TMqH34H8S/+9YeAlM5EF/ardk4zj1sB1iIDCRXzr8SMc9Ev4eqa5vOtGzn5PumeyvuN6
 cqEyUpbMkXj0mKMeGFJgHN+1MrptoUdYtj8pzTy8Ow/5pnhXsTWQc0liPt0V2mw3fLtr
 UPDRU8OtShbYfx/x9szQaSgviawfqeDVQu+dSfPWSv7PGW8/BxPuTAVNZdxt7xIBuFOb
 XlxF1USC2MLgkxuKWns2/FEqksn0314AT2hhPp/gYmH2QC+uGoWJf1MMWII4cO+DAE3k
 4FKg==
X-Gm-Message-State: AOJu0YxG0faix6Ow5QJt11QVbNKt8bt9cwT5zvyajm2cwt8PNtX4iwT8
 0hUiKTGCyanyFecbnqu8R/ozu4XWTzSbKiELYC5XAMKL6lDvIO7OZvfMXfXwlWELNvEMVJjL1/s
 =
X-Gm-Gg: ASbGncuPru6AkrRbyHHNgiSvKDCic3caQo/h5RffUXYwM15N43L2Al+DH3YdoGIsUiZ
 AGn09juJB1WQ1tU99cufMetGKSvfEU53r65AHhRqUzuT95P0Ag9XGL8Ws1B9PRa0V8MzcAGF62u
 E+kaishMSSilXApkhVGYz/FY2FbNvkAiwHgL5boeRHicIQo3Hm1eca6y25WHTaBNRbSOOYeluXc
 UDzrEhiCg1tZCtg3S8FfNleygHKEmaycbW7wO24KU7z0ruw59+AD0LPGvDk2gMNodJqM7XMNT4Z
 zAfWjVktbje8Rk7r2sSHrt5n+ZQIlVqREgQleGD9Enoym3sAG9J8
X-Google-Smtp-Source: AGHT+IHtvS2UJThSTm11mvbb64TsogCYPtK7ZwvMytWff+nsTNowRLKiKpdybY1hmkNmQZGL2szEJw==
X-Received: by 2002:a05:6602:298b:b0:841:a652:b0c8 with SMTP id
 ca18e2360f4ac-854fd87ff28mr481348339f.3.1738953153340; 
 Fri, 07 Feb 2025 10:32:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 27/29] test: Move code out of cmd_ut_category()
Date: Fri,  7 Feb 2025 11:30:58 -0700
Message-ID: <20250207183121.117663-28-sjg@chromium.org>
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

Move the logic from this function into run_suite(), on the way to having
flag parsing in the top-level 'ut' command instead of its children.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd_ut.c | 62 +++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 3925a391de1..bc2da617e51 100644
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

