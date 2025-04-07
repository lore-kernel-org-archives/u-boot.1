Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0B5C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E19F882CF4;
	Mon,  7 Apr 2025 12:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CGag2+Wg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9985782991; Mon,  7 Apr 2025 12:52:25 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A2D82E28
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so4254475b3a.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744023141; x=1744627941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qr5M3EDudi1pzoyLL+wxicRajYSuPnR6L7gRE6DhCw=;
 b=CGag2+Wg7ar/LuTY5z6huyN/9bjmYT9TnT/Y6wRN0c38O8iXLS0sSyquC/1I5LhZLH
 41hlSoACPzwwn6OtoW9rdBtUqQyWfaR2FLyZ/hMNeNoV9XzNamKm4Vg5ziDf3CIUOL8F
 FV0GHTsPl0PGuYTjQDsdW+TwJjhs4ChA1LAlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744023141; x=1744627941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/qr5M3EDudi1pzoyLL+wxicRajYSuPnR6L7gRE6DhCw=;
 b=iscSduhkg/xRLB/AexxTkCmyERgwyOOfugMGeH8Jiogx2KnKycDDQ+AGx4Sya42VfB
 VPOCQPw1EYIyNt0Vi7av8ieMLCl0VU0hFz9Szdm4RJCf4r4GtO4er+PWH+i5QMhEz9fv
 VEAkhI5m0z81b+hSG0JeYSFoiYaRC0GofA/v8XKhxyYMIrgxA67Ls63qVg5pMYlAx8a9
 X+wObgCwyTVrHeGJ7nj1kuDHVP7+L6fmzoMatODFcVGer4MgsPmru6GqBWxqaWyNjQwZ
 EwlHfGM8hA94SmSP7l+qHzaFLo9qBx/DSpHPuoZgowZcgT+jJmb1XHN8R3XDxIs9VINq
 Mj0A==
X-Gm-Message-State: AOJu0Ywq7cW9m68ZsRjn7n9BwFr9avKawcw6x5wcCaLw5+8oiYvqh/si
 m2gdLYl2nc9vD5+EePQZKxm9c0/y3HOEwZ9nTj2tzjU8vqZao0ywHczcNnoNDaKCbOQPzohVxcG
 lug==
X-Gm-Gg: ASbGncuPlocDRWy/pdD7yAbZwDYg2bH6rWZyr6jMCf/1dAOJekirt4I87guyCl2h/Ti
 6Afvnl09dULc69JkV80FLnY1UTXBi3DOG7HEIcd9c1zVhll01rSVCxko30sp/qTnNzwucKttV4O
 NhMoTISILSUtG4ERf7WU4b8HVz6KY5cWx9wUiaa44obuEx4LEUhy/lIOnW27UcBjyWYgam4Z86G
 MyMdHeIsaeZeXaaQ5Ys3PqLToRCu3EnykXyNq0WDDd+wFS70QMzZ+3amUr7DvUiRavsEu5f+pCG
 67dz8NNL9rEhP5ojTPYU5uJl7aEl2yE+opSrIA==
X-Google-Smtp-Source: AGHT+IF32aLfnvkKBSLl/HjAfGdAz04XtVqgxY+u5o+c5Tp2HIZy65luwFOuad9VkY7L8LDM4SgGMg==
X-Received: by 2002:a05:6a00:843:b0:736:43d6:f008 with SMTP id
 d2e1a72fcca58-73b6aa6c7f6mr11762997b3a.12.1744023140890; 
 Mon, 07 Apr 2025 03:52:20 -0700 (PDT)
Received: from chromium.org ([205.220.129.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee7a0sm8138736b3a.41.2025.04.07.03.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 03:52:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] patman: Pass the alias dict into
 gitutil.build_email_list()
Date: Mon,  7 Apr 2025 22:51:44 +1200
Message-ID: <20250407105151.689453-3-sjg@chromium.org>
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

Rather than accessing the settings module in this function, require the
alias dict to be passed in.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/series.py        | 14 ++++++++------
 tools/u_boot_pylib/gitutil.py | 18 +++++++++---------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/tools/patman/series.py b/tools/patman/series.py
index b73e9c58de4..51ae7f04c89 100644
--- a/tools/patman/series.py
+++ b/tools/patman/series.py
@@ -110,8 +110,8 @@ class Series(dict):
             cmd: The git command we would have run
             process_tags: Process tags as if they were aliases
         """
-        to_set = set(gitutil.build_email_list(self.to));
-        cc_set = set(gitutil.build_email_list(self.cc));
+        to_set = set(gitutil.build_email_list(self.to, settings.alias));
+        cc_set = set(gitutil.build_email_list(self.cc, settings.alias));
 
         col = terminal.Color()
         print('Dry run, so not doing much. But I would do this:')
@@ -140,7 +140,8 @@ class Series(dict):
         print('Postfix:\t ', self.get('postfix'))
         if self.cover:
             print('Cover: %d lines' % len(self.cover))
-            cover_cc = gitutil.build_email_list(self.get('cover_cc', ''))
+            cover_cc = gitutil.build_email_list(self.get('cover_cc', ''),
+                                                settings.alias)
             all_ccs = itertools.chain(cover_cc, *self._generated_cc.values())
             for email in sorted(set(all_ccs) - to_set - cc_set):
                     print('      Cc: ', email)
@@ -267,9 +268,9 @@ class Series(dict):
         """
         cc = []
         if process_tags:
-            cc += gitutil.build_email_list(commit.tags,
+            cc += gitutil.build_email_list(commit.tags, settings.alias,
                                            warn_on_error=warn_on_error)
-        cc += gitutil.build_email_list(commit.cc_list,
+        cc += gitutil.build_email_list(commit.cc_list, settings.alias,
                                        warn_on_error=warn_on_error)
         if type(add_maintainers) == type(cc):
             cc += add_maintainers
@@ -344,7 +345,8 @@ class Series(dict):
             print(col.build(col.YELLOW, f'Skipping "{x}"'))
 
         if cover_fname:
-            cover_cc = gitutil.build_email_list(self.get('cover_cc', ''))
+            cover_cc = gitutil.build_email_list(
+                self.get('cover_cc', ''), settings.alias)
             cover_cc = list(set(cover_cc + all_ccs))
             if limit is not None:
                 cover_cc = cover_cc[:limit]
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 8935b6cc847..7c9d0deecbb 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -361,7 +361,7 @@ def create_patches(branch, start, count, ignore_binary, series, signoff=True):
     return None, files
 
 
-def build_email_list(in_list, tag=None, alias=None, warn_on_error=True):
+def build_email_list(in_list, alias, tag=None, warn_on_error=True):
     """Build a list of email addresses based on an input list.
 
     Takes a list of email addresses and aliases, and turns this into a list
@@ -373,10 +373,10 @@ def build_email_list(in_list, tag=None, alias=None, warn_on_error=True):
 
     Args:
         in_list (list of str): List of aliases/email addresses
-        tag (str): Text to put before each address
         alias (dict): Alias dictionary:
             key: alias
             value: list of aliases or email addresses
+        tag (str): Text to put before each address
         warn_on_error (bool): True to raise an error when an alias fails to
             match, False to just print a message.
 
@@ -389,12 +389,12 @@ def build_email_list(in_list, tag=None, alias=None, warn_on_error=True):
     >>> alias['mary'] = ['Mary Poppins <m.poppins@cloud.net>']
     >>> alias['boys'] = ['fred', ' john']
     >>> alias['all'] = ['fred ', 'john', '   mary   ']
-    >>> build_email_list(['john', 'mary'], None, alias)
+    >>> build_email_list(['john', 'mary'], alias, None)
     ['j.bloggs@napier.co.nz', 'Mary Poppins <m.poppins@cloud.net>']
-    >>> build_email_list(['john', 'mary'], '--to', alias)
+    >>> build_email_list(['john', 'mary'], alias, '--to')
     ['--to "j.bloggs@napier.co.nz"', \
 '--to "Mary Poppins <m.poppins@cloud.net>"']
-    >>> build_email_list(['john', 'mary'], 'Cc', alias)
+    >>> build_email_list(['john', 'mary'], alias, 'Cc')
     ['Cc j.bloggs@napier.co.nz', 'Cc Mary Poppins <m.poppins@cloud.net>']
     """
     quote = '"' if tag and tag[0] == '-' else ''
@@ -498,7 +498,7 @@ send --cc-cmd cc-fname" cover p1 p2'
     # Restore argv[0] since we clobbered it.
     >>> sys.argv[0] = _old_argv0
     """
-    to = build_email_list(series.get('to'), '--to', alias, warn_on_error)
+    to = build_email_list(series.get('to'), settings.alias, '--to', warn_on_error)
     if not to:
         git_config_to = command.output('git', 'config', 'sendemail.to',
                                        raise_on_error=False)
@@ -510,10 +510,10 @@ send --cc-cmd cc-fname" cover p1 p2'
                   "git config sendemail.to u-boot@lists.denx.de")
             return None
     cc = build_email_list(list(set(series.get('cc')) - set(series.get('to'))),
-                          '--cc', alias, warn_on_error)
+                          settings.alias, '--cc', warn_on_error)
     if self_only:
-        to = build_email_list([os.getenv('USER')], '--to',
-                              alias, warn_on_error)
+        to = build_email_list([os.getenv('USER')], '--to', settings.alias,
+                              warn_on_error)
         cc = []
     cmd = ['git', 'send-email', '--annotate']
     if smtp_server:
-- 
2.43.0

