Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E50CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B09F88FF2;
	Fri, 27 Sep 2024 00:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CnMXEIUT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64BA388F9B; Fri, 27 Sep 2024 00:45:28 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1C7288FF2
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-6c5ab2de184so9598116d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390725; x=1727995525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdjPf7VfDd9hRwJLaPsNEAhfXdfkR5Z06eSc+8m42JQ=;
 b=CnMXEIUT4lFJf7mFqDMs3dZKczvt7TFkCppTMgrz/68GTQ3+xzQfEGN3amQ759kCCI
 wSo2o/1t8QYpQtu5ijqyTr0+caEDmgl8nyP/B2sPVwh9QuY/BQvoaE0lh8B0b3xPclHn
 VtJsCL350vKxGf9qcXHpjQzU3JcW40is6ooX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390725; x=1727995525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdjPf7VfDd9hRwJLaPsNEAhfXdfkR5Z06eSc+8m42JQ=;
 b=BxC8KSTxBVGYbbRTB99MKd5J1FnyzTCIFCYBztG7SvdOEY1lYzhN1A+pKo/47D18cx
 hxY9R/ph5kDM4diTSCvan4dPJT4EIEwU6d/tJxxTs2DdAUCWXQLZ3xVRp58he71LYgAB
 Xs8zsp/UURr4LGkRy2tKzfHTWwi50+otVQV2+HEYg8DiaAF6sCooSA5L1F9Og7sFuvcN
 cyFtd+3seHrURzlYhrYCgPe1fy2tUJJ5s7wXnguzIWvQoQGRf1QTmYAH9T+HvGuBkYG8
 YlLsevpFx4gU/o0AfDeIJZv5Hjs+OxK6ft63jaXIuO8Hly0NmIG8Ybau3xI9fNoQSatP
 vQOQ==
X-Gm-Message-State: AOJu0YwjD0nS9L1/lSpL194+TgIbB5KnapdV9V1q2zqNI5+jzTaZNBtK
 LTumSavlsyowJfAh2FMegzOU9vLEtskj5mFD1IM0BO4onUZH1tLblnMUHbkNx0mMXkyWL77kTVh
 +AWs68MNJyQ==
X-Google-Smtp-Source: AGHT+IEBy6Rki0PqzRLTAOaYgdKNFKQICGt6/wP3XJiYveRbS66+d8iFh62maxtR0nKbBp1xTGsX5w==
X-Received: by 2002:a05:6214:460c:b0:6cb:2cfa:3b9f with SMTP id
 6a1803df08f44-6cb3b5ea8bamr20344836d6.17.1727390724739; 
 Thu, 26 Sep 2024 15:45:24 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:45:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 32/42] qconfig: Update tool for new Makefile variables
Date: Fri, 27 Sep 2024 00:35:57 +0200
Message-ID: <20240926223814.1276764-33-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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
2.43.0

