Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CB5C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487B682A55;
	Tue, 29 Apr 2025 15:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZokntOxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53BA182A2F; Tue, 29 Apr 2025 15:24:38 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C816828F8
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72ecc30903cso3583927a34.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933074; x=1746537874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzjsiCKj/Ch7reYDvdRB8vtv220sObtLRIcC9qJaN+0=;
 b=ZokntOxjtzQXk8FpU1oHUysEJVGdTzfP3qeNrWxeQ2qxtgkfOLsvkZl5j84SA1lS+m
 as91HMXrYD0ENjk3k5498hUvN/8jy6McLX8gw+vuPKfeoZ77L5/lbZJacb5Mir96LTTJ
 jnE3q0+pMSbXH0+S7Rs6jyDYqyNj17Gyfmwpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933074; x=1746537874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzjsiCKj/Ch7reYDvdRB8vtv220sObtLRIcC9qJaN+0=;
 b=aNGt+2nZyGf40CxUITXl4TDnMVcAqjEfWWKvr+BHcQSFWFyp7dXhqs7RAiBW4tsmh9
 66v8qqKePGlZTGVPFUNf0W3D+8KBp8tbNN29gD06eeQKBipqGzCRM71GiQCQD74zgOkB
 k2wZeONvsQBnywj0a95i2LSdbPRvNRWPP3edtIiI1TuVMgQJ1JZ+MjIUrE4fvjvjXZOk
 IjJi7x+aoGZMGUuZB46qlSqUQDDvcIT1ipubTxAEnehSTq38MKJieC6cfTcr7hEVfyfv
 USMf/dRTn4x6yePUBVYdLRVtCq2hmiRvk8VqY/BhxNJ40/Rq4XZUkG874xBytxXE623C
 X9pA==
X-Gm-Message-State: AOJu0Yyq+Wj5avA4FpjaQvBvuqHCa6RU+rtIaI2gxUsc+Mzji3dBxIS3
 V9IUmFIkO5Okwq6DrF5IfJISfVx/9XM0x3z5cEaJ17rRdfb8g1pBYowSk088Mq2I3nL4UZVdGnU
 =
X-Gm-Gg: ASbGncumI45XlTldcvMwtSxjqzJeyfQ49910Qq/IfAQcHtMrotTz4vgcefwe9MNWCZE
 D5eVH//Ji7IcM+l9IPkX5MH1YXdwUu9S4BUPCB61SApQgP9faQ0x+S2VVZK2NlfBFmcVJrSFYiE
 d/c6lVznfjaYYNv/5C0JeXcQJSEIe/EX7xKNDsSI7FHN7ke8lP7ncD+5lNZ5acNH3vGs3oN+NlC
 pFyCPbfCfaOV8o34olEM8xpCrB/3TSIpXeW30l9yOxlpGVNtc8XfBZHpi2D3dUqiyg37idz0Uk5
 RrPuAUtFoxhp+jg67bK1tAm9tpjfhKcg5bAN4BSV51+wReFAiSxx3wfSRp4ZsncwKtBgseCJFoH
 xTg==
X-Google-Smtp-Source: AGHT+IH6wtck7PziNiCVxdYe5rv4reESoc9hxwF7/9guGfTh2PKUzJJAxsg1jReziR//JhrZ+WQY6w==
X-Received: by 2002:a05:6830:6b09:b0:72a:1e1a:e578 with SMTP id
 46e09a7af769-73088c6c56dmr2045770a34.19.1745933074314; 
 Tue, 29 Apr 2025 06:24:34 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/30] patman: Rename check_patchwork_status()
Date: Tue, 29 Apr 2025 07:22:16 -0600
Message-ID: <20250429132239.251756-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

This function actually shows the status and does some other things.

Rename it to better reflect its purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/control.py   |  4 ++--
 tools/patman/func_test.py | 14 +++++++-------
 tools/patman/status.py    |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index c33ca821aa6..06a9dfd2bca 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -99,8 +99,8 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
     # Import this here to avoid failing on other commands if the dependencies
     # are not present
     from patman import status
-    status.check_patchwork_status(series, found[0], branch, dest_branch, force,
-                                  show_comments, url)
+    status.check_and_show_status(series, found[0], branch, dest_branch, force,
+                                 show_comments, url)
 
 
 def do_patman(args):
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 50fb53787d8..31ba708ab87 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -1045,8 +1045,8 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         series = Series()
         series.commits = [commit1, commit2]
         terminal.set_print_test_mode()
-        status.check_patchwork_status(series, '1234', None, None, False, False,
-                                      None, self._fake_patchwork2)
+        status.check_and_show_status(series, '1234', None, None, False, False,
+                                     None, self._fake_patchwork2)
         lines = iter(terminal.get_print_test_lines())
         col = terminal.Color()
         self.assertEqual(terminal.PrintLine('  1 Subject 1', col.BLUE),
@@ -1159,9 +1159,9 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         # <unittest.result.TestResult run=8 errors=0 failures=0>
 
         terminal.set_print_test_mode()
-        status.check_patchwork_status(series, '1234', branch, dest_branch,
-                                      False, False, None, self._fake_patchwork3,
-                                      repo)
+        status.check_and_show_status(series, '1234', branch, dest_branch,
+                                     False, False, None, self._fake_patchwork3,
+                                     repo)
         lines = terminal.get_print_test_lines()
         self.assertEqual(12, len(lines))
         self.assertEqual(
@@ -1361,8 +1361,8 @@ Reviewed-by: %s
         series = Series()
         series.commits = [commit1, commit2]
         terminal.set_print_test_mode()
-        status.check_patchwork_status(series, '1234', None, None, False, True,
-                                      None, self._fake_patchwork2)
+        status.check_and_show_status(series, '1234', None, None, False, True,
+                                     None, self._fake_patchwork2)
         lines = iter(terminal.get_print_test_lines())
         col = terminal.Color()
         self.assertEqual(terminal.PrintLine('  1 Subject 1', col.BLUE),
diff --git a/tools/patman/status.py b/tools/patman/status.py
index 8edb4ced449..57786e496be 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -300,9 +300,9 @@ def create_branch(series, new_rtag_list, branch, dest_branch, overwrite,
             [parent.target])
     return num_added
 
-def check_patchwork_status(series, series_id, branch, dest_branch, force,
-                           show_comments, url, rest_api=call_rest_api,
-                           test_repo=None):
+def check_and_show_status(series, series_id, branch, dest_branch, force,
+                          show_comments, url, rest_api=call_rest_api,
+                          test_repo=None):
     """Check the status of a series on Patchwork
 
     This finds review tags and comments for a series in Patchwork, displaying
-- 
2.43.0

