Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B264CF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2540A88E91;
	Mon, 30 Sep 2024 03:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qg2pwcyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3EFD88DD1; Mon, 30 Sep 2024 03:51:10 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922D288EEB
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-3a340f9dd8aso22159035ab.2
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661054; x=1728265854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMHCxhRl2a4XO1HAXh8d6e+ly2pBj6ekp+rEM8U3auI=;
 b=Qg2pwcyVwajkJ3+lIYukF1gI/bYk6jpknXDN02IQojdlFtRWLSfmbWcveCkYEIXqZ+
 arSlmyfhUehWMxEshk2gA33O+INxO9DtqV9/zqvhO5xAjekUomTtnlMsP9HNqfwTWzp6
 qqeHlY4XYRKP4bvxfehDHc3+i0Q+AJlYkZBnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661054; x=1728265854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sMHCxhRl2a4XO1HAXh8d6e+ly2pBj6ekp+rEM8U3auI=;
 b=sllm6KrmNbqlIrQgL/8uwzCnuOL+Lwrlm+AxPVbbK0oKrKMq4U8r9Ijng3hPppamVr
 JF6iSSApc1QlHt71EbXIzpI5iOeaU+Pb9uvICfzcUSB/ZKfDQItX/9GbMiHmfUL+a97/
 D3iqTsD3IZHE2DOgMrpugousqq6CLddeXoNlWqif5PgKOBmheVzyIL9eBmY/7JVmUKFr
 xk7YrWtPAbV5T7a8L65RedbrGI4fggOI3rP7S17R78IW1F/zQnqSv/E8+FlqKXdVJZJz
 KjLYI/kCGYRbiFByERUjRiILRQE0UKpcVRW98AtzvDzLfMghFSYxF3tUVZZSB0dJt5zU
 B81A==
X-Gm-Message-State: AOJu0YyEU988glOGVPc0bXPDZtmgN49qRVPCJtdiGaTtilJUS8/SbBTu
 uJHlb19tWByy9vdYJlrvZCwpw3DkIOPrDWX15JYkid1LDgdf3Z8ZL7EORIe0OkgHM3A/FtKPS/g
 TnPkq
X-Google-Smtp-Source: AGHT+IErAgg1bLltksOVIpJf4IwcgRIssjf0rmJxm22ruZ1cYORUWGrcnE/RPRxU0nTvFsDSj8U6Qw==
X-Received: by 2002:a05:6e02:12ee:b0:3a2:aed1:1285 with SMTP id
 e9e14a558f8ab-3a344fc8e06mr104519535ab.0.1727661054206; 
 Sun, 29 Sep 2024 18:50:54 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 33/33] qconfig: Update tool for new Makefile variables
Date: Sun, 29 Sep 2024 19:49:56 -0600
Message-Id: <20240930014956.1434060-34-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

Take account of the new XPL_ and PHASE_ instead of the old SPL_ and
SPL_TPL_

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Drop patches not stricly necessary for the conversion
- Rebase to -next
- Update cover letter re code size

 tools/qconfig.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 7b4934b726d..058d72cf4bc 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1175,7 +1175,7 @@ def prefix_config(cfg):
     return oper + cfg
 
 
-RE_MK_CONFIGS = re.compile(r'CONFIG_(\$\(SPL_(?:TPL_)?\))?([A-Za-z0-9_]*)')
+RE_MK_CONFIGS = re.compile(r'CONFIG_(\$\(XPL_\)|\$\(PHASE_\))?([A-Za-z0-9_]*)')
 RE_IFDEF = re.compile(r'(ifdef|ifndef)')
 RE_C_CONFIGS = re.compile(r'CONFIG_([A-Za-z0-9_]*)')
 RE_CONFIG_IS = re.compile(r'CONFIG_IS_ENABLED\(([A-Za-z0-9_]*)\)')
@@ -1186,7 +1186,7 @@ class ConfigUse:
         """Set up a new ConfigUse
 
         Args:
-            cfg (str): CONFIG option, without any CONFIG_ or SPL_ prefix
+            cfg (str): CONFIG option, without any CONFIG_ or xPL_ prefix
             is_spl (bool): True if this option relates to SPL
             fname (str): Makefile filename where the CONFIG option was found
             rest (str): Line of the Makefile
@@ -1319,7 +1319,7 @@ def do_scan_source(path, do_update):
                 key (ConfigUse): object
                 value (list of str): matching lines
             spl_mode (int): If MODE_SPL, look at source code which implies
-                an SPL_ option, but for which there is none;
+                an xPL_ option, but for which there is none;
                 for MOD_PROPER, look at source code which implies a Proper
                 option (i.e. use of CONFIG_IS_ENABLED() or $(XPL_) or
                 $(PHASE_) but for which there none;
@@ -1341,7 +1341,7 @@ def do_scan_source(path, do_update):
             if spl_mode == MODE_SPL:
                 check = use.is_spl
 
-                # If it is an SPL symbol, try prepending all SPL_ prefixes to
+                # If it is an SPL symbol, try prepending all xPL_ prefixes to
                 # find at least one SPL symbol
                 if use.is_spl:
                     for prefix in SPL_PREFIXES:
@@ -1354,7 +1354,7 @@ def do_scan_source(path, do_update):
                     continue
             elif spl_mode == MODE_PROPER:
                 # Try to find the Proper version of this symbol, i.e. without
-                # the SPL_ prefix
+                # the xPL_ prefix
                 proper_name = is_not_proper(name)
                 if proper_name:
                     name = proper_name
@@ -1450,7 +1450,7 @@ def do_scan_source(path, do_update):
     show_uses(not_found)
     spl_not_found |= {is_not_proper(key) or key for key in not_found.keys()}
 
-    print('\nCONFIG options used as Proper in Makefiles but without a non-SPL_ variant:')
+    print('\nCONFIG options used as Proper in Makefiles but without a non-xPL_ variant:')
     not_found = check_not_found(all_uses, MODE_PROPER)
     show_uses(not_found)
     proper_not_found |= {not_found.keys()}
@@ -1468,16 +1468,16 @@ def do_scan_source(path, do_update):
     show_uses(not_found)
     spl_not_found |= {is_not_proper(key) or key for key in not_found.keys()}
 
-    print('\nCONFIG options used as Proper in source but without a non-SPL_ variant:')
+    print('\nCONFIG options used as Proper in source but without a non-xPL_ variant:')
     not_found = check_not_found(all_uses, MODE_PROPER)
     show_uses(not_found)
     proper_not_found |= {not_found.keys()}
 
-    print('\nCONFIG options used as SPL but without an SPL_ variant:')
+    print('\nCONFIG options used as SPL but without an xPL_ variant:')
     for item in sorted(spl_not_found):
         print(f'   {item}')
 
-    print('\nCONFIG options used as Proper but without a non-SPL_ variant:')
+    print('\nCONFIG options used as Proper but without a non-xPL_ variant:')
     for item in sorted(proper_not_found):
         print(f'   {item}')
 
-- 
2.34.1

