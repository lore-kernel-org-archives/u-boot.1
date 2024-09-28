Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5B6CF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 273D388D75;
	Sat, 28 Sep 2024 22:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QUQ3tMyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7FD88D92; Sat, 28 Sep 2024 22:01:17 +0200 (CEST)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 961F488D89
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x144.google.com with SMTP id
 e9e14a558f8ab-3a0c8c40560so15083165ab.2
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553667; x=1728158467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VYClQkEwM1JKhhmg6XCWJXdwZECdviF6m1ipb2Bg1k=;
 b=QUQ3tMyT4CbENUtb/AoLaIb/GUYVkZkDYEWZrYJLgCIuLaNVQM2Yob07KfsLetXjQ3
 t6drQNqW0p8UlnE5vB0PIRMDvNZB3xFRBSkh3DWQavtJdIEoSld07uhU3n/mFv/PNRT2
 x3/2MH2aWTwN4J/aHLVnmK5yz3nw6N3pc686w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553667; x=1728158467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3VYClQkEwM1JKhhmg6XCWJXdwZECdviF6m1ipb2Bg1k=;
 b=Cq2FUtupms3VcODNb2Rnio6Ycvx6qtTA87cLkviE/RkguUxovazo6fIPn7nrlU1drm
 LnBJCvhQ+zi74QbJIEAMiAt2YmwcpmJohYzPOzJVMR5BB7XYDfH8f6E8kyvNBNUOUlTw
 G6PXjX9ZXAG/eL+EGNwA5iFDCM28QBe+tKtQcAjY3TkxPoaNmiqISGcl7C2VEArLoICO
 /kl6+0H/HSWhVYstMR3ZNMCQ/+entQIhpIiDXRoHZm2tmeCSl3C4l0/cpQG2On58rYVg
 ppgyvEqJneS5RtcDA+ERxEGe2tS46R4+KpUiPFp9wkw6FN3NQAxWxT4OBhIGH7fVxDna
 lVQQ==
X-Gm-Message-State: AOJu0YxUwMAlk7mrlJTlO0Fzw6JeA+0/PG6Dw08SEvtdYLkJ8rH5JfXO
 AdYEbCa8zou8HtqD67c4jPr3Q+94w80j2yF+2QPAH1CYX4f/LKGcnhJGij7hRyb5+2+atutnTCc
 HEQUa
X-Google-Smtp-Source: AGHT+IG/cKMwfiNe43yrY8BV9oJhD/TO7OZHS0O/EvC/QwPQ18/FyBwCmx0aMQO0+2T18T7dL0Qibg==
X-Received: by 2002:a05:6e02:188f:b0:3a1:a179:bb54 with SMTP id
 e9e14a558f8ab-3a344fd82c0mr73543225ab.0.1727553666974; 
 Sat, 28 Sep 2024 13:01:06 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:01:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 20/30] qconfig: Update tool for new Makefile variables
Date: Sat, 28 Sep 2024 14:00:20 -0600
Message-Id: <20240928200030.194546-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

(no changes since v1)

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

