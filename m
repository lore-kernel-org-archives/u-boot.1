Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE67C3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5E2A82D39;
	Mon,  7 Apr 2025 12:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JAzSocAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E510682CEA; Mon,  7 Apr 2025 12:52:52 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8256982CE7
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7376dd56f60so2909220b3a.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744023168; x=1744627968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6tZAsUSPapT+d+Gnk68d63xfHtbBSC05ESE5sdMBfU=;
 b=JAzSocAyXnAwp1ouEVcfK3iZGiEMpljjAggFru4/ryRJBL0LiwNP7e7+Qcq8gATatd
 Fm2lP9n4a+4rLp8nxH9GwGJ3ns/qDqRnaiN99Z49f9xl17ayqTIjy2lXkVOXZlS2mTaS
 vUfq0CS48dZIN08q09cNdwVtx3eHisbVPSrtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744023168; x=1744627968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6tZAsUSPapT+d+Gnk68d63xfHtbBSC05ESE5sdMBfU=;
 b=Lq04fAPYff3U5TVTs2pIOKtHj3zIO6Az3dfOcWtHOfaEDp7FnVy27tEtX/Fw+/hIDR
 O0xsfKM+HxZxsDBDb1qA/D5yafsH767avrd3OyU42+rj8RBO2y+vVumZsOO8cwDUJ5EH
 DDKwPh7nmCwbyIcNqFFQfUJSIs7rSh+nK29G/fhduFbxyRb3gmFw/wa0O6+hHjVg4HUT
 JruZ8vJxmj3G5cNXIqlPjLdGR1hed5MXlRyJyG5yIFMsunq1JLEiW0m7Dxved5JnPF29
 AJqq6FnxdOKvZcAcq8OSPuqJikyRNGNl5J1BXS7fOaUgQaHNtr7RufOK14cnzX7Ll9qt
 4qRQ==
X-Gm-Message-State: AOJu0YwLTmsdocLLGoCmDdbxyoHXZEzajh0FKfI8/XFJTRsCsvavozNr
 T7dwfiHef4qGFwSubH9a0jgbEHH2oLLv5O7gY5QaFF9TBrXwDg4kUJ5whPZrSYZMW+xXgxJyVIb
 mcw==
X-Gm-Gg: ASbGncu/cJAdEMISnftwkY49LVDdcICLxTkU/6s9uBRiTIK2YsPsrd2t+icU4nukVSA
 7TwnNpllgIUcg44wSQsY1/oxMkcrvJLFizrxB7ThhTK0+ieTtacFpQHlL5EKirjdCkgDL3NP+90
 7bjsp7KOhNWdKWVJFczyuxSZK/lbWsiYPPFLDLS9g3tXEbKnmRTKEkicWwmO33ajlm2VeEuBI+d
 BKDuvvN2iREd9FBHVYnvIGz6Pyl7GtFZmZCZRehVygcxHamxbeeey0vuDb8AYMOtizFgdX3Wjrd
 Dh0er2ewFDe4gJXUCYecq9pEE1Sdg8cf/ZlJpw==
X-Google-Smtp-Source: AGHT+IG69xV3nBY6nvK4bIHysXvV/s8Rpu74iSKCuo9lRRiaYCLJzaaQFLW0Frer8cPrqg3G2U/6qw==
X-Received: by 2002:a05:6a00:2285:b0:736:32d2:aa82 with SMTP id
 d2e1a72fcca58-739e71403c1mr16725368b3a.23.1744023168298; 
 Mon, 07 Apr 2025 03:52:48 -0700 (PDT)
Received: from chromium.org ([205.220.129.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee7a0sm8138736b3a.41.2025.04.07.03.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 03:52:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] patman: Update Series.ShowActions() to pass alias
Date: Mon,  7 Apr 2025 22:51:47 +1200
Message-ID: <20250407105151.689453-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407105151.689453-1-sjg@chromium.org>
References: <20250407105151.689453-1-sjg@chromium.org>
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

Instead of using settings.alias pass this value in. This allows tests to
work without using settings.alias

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/control.py   |  2 +-
 tools/patman/func_test.py |  3 +--
 tools/patman/series.py    | 17 ++++++++++-------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index 13de9b6abfc..9d7c9ef4478 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -161,7 +161,7 @@ def email_patches(col, series, cover_fname, patch_files, process_tags, its_a_go,
 
     # For a dry run, just show our actions as a sanity check
     if dry_run:
-        series.ShowActions(patch_files, cmd, process_tags)
+        series.ShowActions(patch_files, cmd, process_tags, settings.alias)
         if not its_a_go:
             print(col.build(col.RED, "Email would not be sent"))
 
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index c87c938808c..ce39f561f63 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -213,7 +213,6 @@ class TestFunctional(unittest.TestCase):
             'fred': [self.fred],
             'joe': [self.joe],
         }
-        settings.alias = alias
 
         text = self._get_text('test01.txt')
         series = patchstream.get_metadata_for_test(text)
@@ -233,7 +232,7 @@ class TestFunctional(unittest.TestCase):
             cmd = gitutil.email_patches(
                 series, cover_fname, args, dry_run, not ignore_bad_tags,
                 cc_file, alias, in_reply_to=in_reply_to, thread=None)
-            series.ShowActions(args, cmd, process_tags)
+            series.ShowActions(args, cmd, process_tags, alias)
         cc_lines = open(cc_file, encoding='utf-8').read().splitlines()
         os.remove(cc_file)
 
diff --git a/tools/patman/series.py b/tools/patman/series.py
index 4322882abd5..3ec33e022d0 100644
--- a/tools/patman/series.py
+++ b/tools/patman/series.py
@@ -102,16 +102,19 @@ class Series(dict):
         commit.check_tags()
         self.commits.append(commit)
 
-    def ShowActions(self, args, cmd, process_tags):
+    def ShowActions(self, args, cmd, process_tags, alias):
         """Show what actions we will/would perform
 
         Args:
             args: List of patch files we created
             cmd: The git command we would have run
             process_tags: Process tags as if they were aliases
+            alias (dict): Alias dictionary
+                key: alias
+                value: list of aliases or email addresses
         """
-        to_set = set(gitutil.build_email_list(self.to, settings.alias));
-        cc_set = set(gitutil.build_email_list(self.cc, settings.alias));
+        to_set = set(gitutil.build_email_list(self.to, alias));
+        cc_set = set(gitutil.build_email_list(self.cc, alias));
 
         col = terminal.Color()
         print('Dry run, so not doing much. But I would do this:')
@@ -141,7 +144,7 @@ class Series(dict):
         if self.cover:
             print('Cover: %d lines' % len(self.cover))
             cover_cc = gitutil.build_email_list(self.get('cover_cc', ''),
-                                                settings.alias)
+                                                alias)
             all_ccs = itertools.chain(cover_cc, *self._generated_cc.values())
             for email in sorted(set(all_ccs) - to_set - cc_set):
                     print('      Cc: ', email)
@@ -271,9 +274,9 @@ class Series(dict):
         """
         cc = []
         if process_tags:
-            cc += gitutil.build_email_list(commit.tags, settings.alias,
+            cc += gitutil.build_email_list(commit.tags, alias,
                                            warn_on_error=warn_on_error)
-        cc += gitutil.build_email_list(commit.cc_list, settings.alias,
+        cc += gitutil.build_email_list(commit.cc_list, alias,
                                        warn_on_error=warn_on_error)
         if type(add_maintainers) == type(cc):
             cc += add_maintainers
@@ -353,7 +356,7 @@ class Series(dict):
 
         if cover_fname:
             cover_cc = gitutil.build_email_list(
-                self.get('cover_cc', ''), settings.alias)
+                self.get('cover_cc', ''), alias)
             cover_cc = list(set(cover_cc + all_ccs))
             if limit is not None:
                 cover_cc = cover_cc[:limit]
-- 
2.43.0

