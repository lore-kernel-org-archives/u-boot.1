Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8396FC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87A3F82E31;
	Mon,  7 Apr 2025 12:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BXuiqHjb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC1482CEA; Mon,  7 Apr 2025 12:52:45 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC06A82DB0
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7359aca7ef2so5764246b3a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744023161; x=1744627961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYospauxUdc0V5ZGry5z20Gz3bhXW9MGxFoE4E4XOY4=;
 b=BXuiqHjbXKSod8SK8ljAQISe6xT8SP/sjnuyYiLNC8pWQXUc6hVDXSvolsiXpBdMHy
 pmVOLKUUe7Iwot7vqIkst6BjtDBNIsw6SCpq2qrmdINRmt4HOBbtC8L4LJoHEas6VrG4
 OLAQgJBRxPNVtRGqa7lWu8hO3Lv9MqnwGDTII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744023161; x=1744627961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYospauxUdc0V5ZGry5z20Gz3bhXW9MGxFoE4E4XOY4=;
 b=U4gSJlBih0Y2J8Mb1j8vXgAB3VgCIXsXjfWSUGz9BBUE+zAidojEPStmUjJWucYUdl
 /VhQmzlE2eyeM1w71C/f5m/jpdNUncgyT8gXueOA3Gj4wsPDi8zbfdrarR9bU6sBQg9j
 i64AX/KFWukmScQRzjmyQ648KI3PFYsM+u/GGRwWps/lJ23X2/qExLGb2X/KVj59P+BM
 L21TsZmFy7hsbJmKXwqTJlPWTBOoLgjJxtqY9iJfOsp+cDnJacd21HEWfKyOetI5TLEz
 9F49olewzMvbtXCyswWCzjoKPl8Yj9r2TyEwR9fauXyRTKwC6fumEQMh0W42cULpnhiy
 s0Ig==
X-Gm-Message-State: AOJu0YzrZrk2vEpyK7o2Yu736PEXnzp+o3OFs2ylgV61/DRqMFxVXNst
 YgNZ+jiJthLuoidlxdHu7haOXHfFQroX83GQLxnLV0X/JZmhkG77xSxsZL6I6tj+HTOiymC35zW
 PbQ==
X-Gm-Gg: ASbGncseYQDvrXzLd4dsjL0CjWw6MJPrtcojUyq+jHZc6vjsfauu/LdFwaPzqN0tcGE
 TROYzijZ94wYssrBXhwyUok4LpyD/69czPSx4YTdb3M8idWTnjvRDrzJDBHSNiHs83xsmTzAzP6
 gmZdRAaE+g4lq1UTWNSKvbwUimsCmtIvmWaJZ4PC9fRGgQRSwaePhV95IchU2O24xFfJAg/l5ND
 JC1DXfE2iZIM3ZUqFh7+OpwK3b7tZbh2/WqQtbdfThJ+DhoSs0Rf+DJ92KMrMaEKw0lOKyGTwfA
 APfDCivYHjXgYK3SQ1GoFo+FomtjqrXaVlOcS4SR0SyOvDL5
X-Google-Smtp-Source: AGHT+IHgKm4eYZ6k1jA178kP5LYbV81tTwEqptFOghIjDk/OVcVo4OK88ojDLXZ0Xdcu2ja1Hgp0ig==
X-Received: by 2002:a05:6a21:497:b0:1fe:90c5:7d00 with SMTP id
 adf61e73a8af0-20108145e9emr18206654637.28.1744023160824; 
 Mon, 07 Apr 2025 03:52:40 -0700 (PDT)
Received: from chromium.org ([205.220.129.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee7a0sm8138736b3a.41.2025.04.07.03.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 03:52:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] patman: Pass aliases to Series.MakeCcFile()
Date: Mon,  7 Apr 2025 22:51:46 +1200
Message-ID: <20250407105151.689453-5-sjg@chromium.org>
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

Rather than accessing settings directly, pass the aliases in, so that
we can do the same from tests. With further work this will allow the
tests to work without using settings.alias

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/control.py   |  3 ++-
 tools/patman/func_test.py |  2 +-
 tools/patman/series.py    | 13 ++++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index f578336c7cc..13de9b6abfc 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -146,7 +146,8 @@ def email_patches(col, series, cover_fname, patch_files, process_tags, its_a_go,
         smtp_server (str): SMTP server to use to send patches (None for default)
     """
     cc_file = series.MakeCcFile(process_tags, cover_fname, not ignore_bad_tags,
-                                add_maintainers, limit, get_maintainer_script)
+                                add_maintainers, limit, get_maintainer_script,
+                                settings.alias)
 
     # Email the patches out (giving the user time to check / cancel)
     cmd = ''
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index b8fb49c34ba..c87c938808c 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -229,7 +229,7 @@ class TestFunctional(unittest.TestCase):
             series.DoChecks()
             cc_file = series.MakeCcFile(process_tags, cover_fname,
                                         not ignore_bad_tags, add_maintainers,
-                                        None, get_maintainer_script)
+                                        None, get_maintainer_script, alias)
             cmd = gitutil.email_patches(
                 series, cover_fname, args, dry_run, not ignore_bad_tags,
                 cc_file, alias, in_reply_to=in_reply_to, thread=None)
diff --git a/tools/patman/series.py b/tools/patman/series.py
index 51ae7f04c89..4322882abd5 100644
--- a/tools/patman/series.py
+++ b/tools/patman/series.py
@@ -242,7 +242,7 @@ class Series(dict):
 
     def GetCcForCommit(self, commit, process_tags, warn_on_error,
                        add_maintainers, limit, get_maintainer_script,
-                       all_skips):
+                       all_skips, alias):
         """Get the email CCs to use with a particular commit
 
         Uses subject tags and get_maintainers.pl script to find people to cc
@@ -262,6 +262,9 @@ class Series(dict):
             all_skips (set of str): Updated to include the set of bouncing email
                 addresses that were dropped from the output. This is essentially
                 a return value from this function.
+            alias (dict): Alias dictionary
+                key: alias
+                value: list of aliases or email addresses
 
         Returns:
             list of str: List of email addresses to cc
@@ -284,7 +287,7 @@ class Series(dict):
         return cc
 
     def MakeCcFile(self, process_tags, cover_fname, warn_on_error,
-                   add_maintainers, limit, get_maintainer_script):
+                   add_maintainers, limit, get_maintainer_script, alias):
         """Make a cc file for us to use for per-commit Cc automation
 
         Also stores in self._generated_cc to make ShowActions() faster.
@@ -300,6 +303,9 @@ class Series(dict):
             limit (int): Limit the length of the Cc list (None if no limit)
             get_maintainer_script (str): The file name of the get_maintainer.pl
                 script (or compatible).
+            alias (dict): Alias dictionary
+                key: alias
+                value: list of aliases or email addresses
         Return:
             Filename of temp file created
         """
@@ -314,7 +320,8 @@ class Series(dict):
                 commit.seq = i
                 commit.future = executor.submit(
                     self.GetCcForCommit, commit, process_tags, warn_on_error,
-                    add_maintainers, limit, get_maintainer_script, all_skips)
+                    add_maintainers, limit, get_maintainer_script, all_skips,
+                    alias)
 
             # Show progress any commits that are taking forever
             lastlen = 0
-- 
2.43.0

