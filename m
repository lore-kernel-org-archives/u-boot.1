Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8E0CF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 17:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D22C3889C5;
	Sat, 21 Sep 2024 19:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LrZbwB/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E7A0889CD; Sat, 21 Sep 2024 19:58:25 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E74889AE
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 19:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2068a7c9286so32023485ad.1
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726941501; x=1727546301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oWEC7Bj18Cy01PSv9znaSIhwAsCGJnjk4HQyu9k4jZo=;
 b=LrZbwB/q/YgfUNkptNIHKJeF/6hO+VCX3YVQyVknNCzJKdLFEs1Nl0+kd4D163L5HI
 Spa9JyrZbfhyxkg3B/Bd5N3ecCAOVdTjdugogIX33qiMFJgHYRszeyqzIfJkM6+3S2/h
 TSoT7k49gIyCTGt2kbn9GIpHfGrz6GTk8TEEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726941501; x=1727546301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oWEC7Bj18Cy01PSv9znaSIhwAsCGJnjk4HQyu9k4jZo=;
 b=IHlwsk9skthv9XLuBO86QdJLVhudaq9+sZAL3CbHOJGNbZInKL+r2NdWyGHJb57Vfe
 DgH3nfc0OigezhRNpCPx5ugPcJHU8YkuHXK9xRghPItVzVMQmQDRYT7ErpGk1CJlGwuN
 5pTPmB53ZpkklIXLcWxmLL1zO5iWrm4+tkISoDd5hsarfGV380nh7uJ29zxMMDx+yeRx
 RyDI2FVlIFjYc1Fs8HAzjqqS39R3nB4efXQfeOR+PbNZw2Gd0FPzQjDitvVjLnLprz7S
 gSt8g5XVZBqvPcjLwft/u9F3qoNSRvnm5vkKHQ9FUi6Ezd65+fDEjIybSgVVCWHA5m7I
 oDxQ==
X-Gm-Message-State: AOJu0YwV9/NZHRt5qiWGDaWIZc9nlWc8z/fP38MjVvFX3SPx0VcUlcDl
 h17/RGQ90kSpFWdUraOYM0Bwote4hPt/iUbwoMWGLQQPVrNIpZ6USq5bmBDvDCIqmdoN2MJtD20
 EkODg8H4=
X-Google-Smtp-Source: AGHT+IF4oqwaPcRkOt/ePSWVs4Z8SUVx12ZHuVizgbpeTsbqagRyzumSDlHHcxhWMVusGnKBzq2jrw==
X-Received: by 2002:a17:902:f54e:b0:205:721f:ec6f with SMTP id
 d9443c01a7336-208d83ca200mr104619635ad.35.1726941501283; 
 Sat, 21 Sep 2024 10:58:21 -0700 (PDT)
Received: from chromium.org ([172.58.27.60]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2079460138fsm111329645ad.77.2024.09.21.10.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2024 10:58:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] buildman: Correct some warnings about regex strings
Date: Sat, 21 Sep 2024 19:57:57 +0200
Message-ID: <20240921175800.437341-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

With Python 3.12 some warnings have cropped up. Fix them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builder.py   | 6 +++---
 tools/buildman/toolchain.py | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index 4090d328b30..cbf1345281b 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -34,7 +34,7 @@ from u_boot_pylib.terminal import tprint
 # Error in reading or end of file.
 # <<
 # which indicates that BREAK_ME has an empty default
-RE_NO_DEFAULT = re.compile(b'\((\w+)\) \[] \(NEW\)')
+RE_NO_DEFAULT = re.compile(br'\((\w+)\) \[] \(NEW\)')
 
 # Symbol types which appear in the bloat feature (-B). Others are silently
 # dropped when reading in the 'nm' output
@@ -374,9 +374,9 @@ class Builder:
 
         self._re_function = re.compile('(.*): In function.*')
         self._re_files = re.compile('In file included from.*')
-        self._re_warning = re.compile('(.*):(\d*):(\d*): warning: .*')
+        self._re_warning = re.compile(r'(.*):(\d*):(\d*): warning: .*')
         self._re_dtb_warning = re.compile('(.*): Warning .*')
-        self._re_note = re.compile('(.*):(\d*):(\d*): note: this is the location of the previous.*')
+        self._re_note = re.compile(r'(.*):(\d*):(\d*): note: this is the location of the previous.*')
         self._re_migration_warning = re.compile(r'^={21} WARNING ={22}\n.*\n=+\n',
                                                 re.MULTILINE | re.DOTALL)
 
diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 6ca79c2c0f9..da8fd1b072c 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -438,12 +438,12 @@ class Toolchains:
         This converts ${blah} within the string to the value of blah.
         This function works recursively.
 
+            Resolved string
+
         Args:
             var_dict: Dictionary containing variables and their values
             args: String containing make arguments
         Returns:
-            Resolved string
-
         >>> bsettings.setup(None)
         >>> tcs = Toolchains()
         >>> tcs.Add('fred', False)
@@ -454,7 +454,7 @@ class Toolchains:
         >>> tcs.ResolveReferences(var_dict, 'this=${oblique}_set${first}nd')
         'this=OBLIQUE_setfi2ndrstnd'
         """
-        re_var = re.compile('(\$\{[-_a-z0-9A-Z]{1,}\})')
+        re_var = re.compile(r'(\$\{[-_a-z0-9A-Z]{1,}\})')
 
         while True:
             m = re_var.search(args)
@@ -493,7 +493,7 @@ class Toolchains:
         self._make_flags['target'] = brd.target
         arg_str = self.ResolveReferences(self._make_flags,
                            self._make_flags.get(brd.target, ''))
-        args = re.findall("(?:\".*?\"|\S)+", arg_str)
+        args = re.findall(r"(?:\".*?\"|\S)+", arg_str)
         i = 0
         while i < len(args):
             args[i] = args[i].replace('"', '')
-- 
2.43.0

