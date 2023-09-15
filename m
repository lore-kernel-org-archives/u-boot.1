Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85CEEEAA7A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D90686996;
	Fri, 15 Sep 2023 02:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gMVpYPXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B301C869D8; Fri, 15 Sep 2023 02:23:03 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D245869D1
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79536bc6697so55323139f.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737380; x=1695342180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHVVI/7GNqCooU03hFTIO5JiNlDhtBwTEJw2uSUs5Ec=;
 b=gMVpYPXTmI39Rwlns5ldfsQVlPTeUELyrZjAWOAjLbHD01r49D4wJ2aTMtLhttGYUI
 FdKEokfN+nxWqRijQ1SP3zCpnQYOTwUgT/SguM05yhY102Jx0gSpJr7VaqW8qRhD+hC8
 MyY9YbSUr4OAvgd06yAHcv3uQKGon9pJxxpS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737380; x=1695342180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHVVI/7GNqCooU03hFTIO5JiNlDhtBwTEJw2uSUs5Ec=;
 b=DbNtwe5huuIhZ+vlQWQDOMEsDjXF4/XnusX49mxqCRwAFv/lEae3twdWCX+Sz5+BRI
 PjjFpf99CqaiGr9+QLpLybvLT742zkKd4dNQ76an/BnIEe179lMkJb6iobRkJQPqdrnD
 yxF2oXezpLeL+RpegGqG8z9zmeql2+BSedMf4200tdK0ASLClT745vN3meKpPrJ1268y
 TleED22k/FlcwA6MAa7vDep6D1yjcRBvw58AI6xkuAeVnzay+jBQ3hhEZsUoJwaZ8B5G
 OPCqkj9wFjV+658PXtw1abemb9C5VLs483tbDi1hcpFprggiRLNKQdKoabCYWILrEuYV
 xPQw==
X-Gm-Message-State: AOJu0YyaeLTOMK0pH2hiZq4odoTfQSMM1qeuh15HO5at6E+2TZ+PNSPX
 UHXq0u18fbNfVTiXxdvEOxj8u4Yz20xdyaVJgrk=
X-Google-Smtp-Source: AGHT+IH2ThCqdD9gbP84Gdxz0MX0SRCQ8XkXn2vvwVp0/ThgmFj8cE7NUg86awqrY86WC3z52Ay4kg==
X-Received: by 2002:a05:6602:2116:b0:77e:3598:e516 with SMTP id
 x22-20020a056602211600b0077e3598e516mr65753iox.2.1694737379784; 
 Thu, 14 Sep 2023 17:22:59 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 16/27] moveconfig: Fix misc pylint warnings
Date: Thu, 14 Sep 2023 18:22:18 -0600
Message-ID: <20230915002236.798760-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

Fix various remaining pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 9b716596956b..727a5d6df864 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -233,8 +233,7 @@ def read_file(fname, as_lines=True, skip_unicode=False):
         try:
             if as_lines:
                 return [line.rstrip('\n') for line in inf.readlines()]
-            else:
-                return inf.read()
+            return inf.read()
         except UnicodeDecodeError as exc:
             if not skip_unicode:
                 raise
@@ -426,7 +425,7 @@ class Slot:
         If the subprocess is still running, wait until it finishes.
         """
         if self.state != STATE_IDLE:
-            while self.proc.poll() == None:
+            while self.proc.poll() is None:
                 pass
         shutil.rmtree(self.build_dir)
 
@@ -471,7 +470,7 @@ class Slot:
         if self.state == STATE_IDLE:
             return True
 
-        if self.proc.poll() == None:
+        if self.proc.poll() is None:
             return False
 
         if self.proc.poll() != 0:
@@ -494,7 +493,7 @@ class Slot:
         else:
             sys.exit('Internal Error. This should not happen.')
 
-        return True if self.state == STATE_IDLE else False
+        return self.state == STATE_IDLE
 
     def handle_error(self):
         """Handle error cases."""
@@ -521,13 +520,13 @@ class Slot:
 
         arch = self.parser.get_arch()
         try:
-            toolchain = self.toolchains.Select(arch)
+            tchain = self.toolchains.Select(arch)
         except ValueError:
             self.log += color_text(self.args.color, COLOR_YELLOW,
                     f"Tool chain for '{arch}' is missing.  Do nothing.\n")
             self.finish(False)
             return
-        env = toolchain.MakeEnvironment(False)
+        env = tchain.MakeEnvironment(False)
 
         cmd = list(self.make_cmd)
         cmd.append('KCONFIG_IGNORE_DUPLICATES=1')
@@ -1004,7 +1003,7 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
                             # skip imply_config because prev is a superset
                             skip = True
                             break
-                        elif count > prev_count:
+                        if count > prev_count:
                             # delete prev because imply_config is a superset
                             del imply_configs[prev]
                 if not skip:
@@ -1540,7 +1539,7 @@ doc/develop/moveconfig.rst for documentation.'''
 
     if args.scan_source:
         do_scan_source(os.getcwd(), args.update)
-        return
+        return 0
 
     if not any((args.force_sync, args.build_db, args.imply, args.find)):
         parser.print_usage()
@@ -1570,11 +1569,11 @@ doc/develop/moveconfig.rst for documentation.'''
                 imply_flags |= IMPLY_FLAGS[flag][0]
 
         do_imply_config(configs, args.add_imply, imply_flags, args.skip_added)
-        return
+        return 0
 
     if args.find:
         do_find_config(configs)
-        return
+        return 0
 
     # We are either building the database or forcing a sync of defconfigs
     config_db = {}
@@ -1610,6 +1609,8 @@ doc/develop/moveconfig.rst for documentation.'''
                 for config in sorted(configs.keys()):
                     outf.write(f'   {config}={configs[config]}\n')
                 outf.write('\n')
+    return 0
+
 
 if __name__ == '__main__':
     sys.exit(main())
-- 
2.42.0.459.ge4e396fd5e-goog

