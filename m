Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA403C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC85182B12;
	Sat, 10 May 2025 13:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ItR+tj2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558B982B16; Sat, 10 May 2025 13:06:25 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A81A8091A
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad243b49ef1so4776066b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875182; x=1747479982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9z9b267PC7wZPrQnfvsH5aSJ0j1JOmMtBV3K/0dbI8=;
 b=ItR+tj2xzGk0OpNwYzER2iugzj15YeUFm5svSIPr0VeVDr3mjBJXT32Qb6gZSiNRgg
 u96t0NER/nmrcRWtfJrKNeRZuRMft8gAaIkW8pifDvPSEcbcxHjJCxo4pMfnKwNLBkGR
 uz6WG7oaWEgZGro1hXMzVIL9Xy2NG4a6yQ0Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875182; x=1747479982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9z9b267PC7wZPrQnfvsH5aSJ0j1JOmMtBV3K/0dbI8=;
 b=SPmUf5WkKYbjQPxvbZoydWjydZpbjt9PFl9z6V0chmWTnBv1FJFZFowBRML+k2YzKu
 T22ecL25eddpDUgnnjKzG3tzLM4R2V+Cg2JZaMNsJjhspZHMz6d26X8JgzraNJ+0qq85
 IQuz2CeCuGW7L8P12v8Ujs9ibXOTWm/WGXweIIResLZCgm3s5J21ML60n3WKstFD9kxV
 lvRRrB4xT9lzG3LQsWWE8X8X236d6H/sbKeKBgL8P6HGXPaI0J4SCdnGp18bvVBPe1mm
 u6O9bAuQR9wFK00OMMa8O7rMkdm3s1luPeZQCT7kOFCFoEqDuveZMWdMM1NP061RBjBT
 ai/w==
X-Gm-Message-State: AOJu0YzHb4ahMPL9dBn6iuPNYqHhgIVZ4Va6KzDIm/jUAvUY5aBXAAPN
 ukpFfaagwLrt2Pax1f/YTOkKloRAmuzhQkvJc7oZExGvupEu8dv0Uy4/baaxUzkUvyPNxbPu7m3
 xTD7K6b0gag==
X-Gm-Gg: ASbGnctsIhtKe2dcWGYkNY4OAxxaqKBt0c0j3COHzhP3s43euTbt/aftNj7MBllotec
 fAmUmlXLVor+3of8PK4Ffc3PBX6IyQLUAaDLEzyYZwR3+/pJ3iQTsxaxRHo9LCaMENMn1zNQMWc
 T54gdsjHz1CtD2STPpM2/VOg0cnj06seyPTBWfIMXqnJJuQ/DDC9G3Tf29A2b51olvVG1snKB5m
 SsbiX+o89JAvISA36NzBL2zdTNYTMKxZr1o+D4xV96OBIJM2ruBU2Ij3UvWvfrNLt/U+sGqLXX5
 +vPebhnTT38/tr1fKkfCC54b6wpFitsjirAsa1KpuWxcB0c=
X-Google-Smtp-Source: AGHT+IH9KYqvMU1a68ZWcGkLArVP+y5vnLLebbGhFslzb68eS9tCZ7PWn253Ce9/4v7Oa0n49nuKBg==
X-Received: by 2002:a17:907:d9e:b0:ad1:dbec:44d3 with SMTP id
 a640c23a62f3a-ad218f79625mr773490166b.27.1746875181896; 
 Sat, 10 May 2025 04:06:21 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/25] patman: Implement the patchwork subcommand
Date: Sat, 10 May 2025 13:05:12 +0200
Message-ID: <20250510110535.1453745-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

Add a command to allow setting and getting the patchwork project. This
is needed so that patman can use the correct ID when talking to the
patchwork server.

To support testing, allow passing in the test database, patchwork
object and Cseries object. Fake versions can then easily be provided for
certain test cases.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 25 +++++++++++++++++++++++++
 tools/patman/control.py | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 1b2a32c99f7..5943aa7e47c 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -116,6 +116,29 @@ def _add_show_comments(parser):
                         help='Show comments from each patch')
 
 
+def add_patchwork_subparser(subparsers):
+    """Add the 'patchwork' subparser
+
+    Args:
+        subparsers (argparse action): Subparser parent
+
+    Return:
+        ArgumentParser: patchwork subparser
+    """
+    patchwork = subparsers.add_parser(
+        'patchwork',
+        help='Manage patchwork connection')
+    patchwork.defaults_cmds = [
+        ['set-project', 'U-Boot'],
+    ]
+    patchwork_subparsers = patchwork.add_subparsers(dest='subcmd')
+    patchwork_subparsers.add_parser('get-project')
+    uset = patchwork_subparsers.add_parser('set-project')
+    uset.add_argument(
+        'project_name', help="Patchwork project name, e.g. 'U-Boot'")
+    return patchwork
+
+
 def add_send_subparser(subparsers):
     """Add the 'send' subparser
 
@@ -201,6 +224,7 @@ def setup_parser():
 
     subparsers = parser.add_subparsers(dest='cmd')
     add_send_subparser(subparsers)
+    patchwork = add_patchwork_subparser(subparsers)
     add_status_subparser(subparsers)
 
     # Only add the 'test' action if the test data files are available.
@@ -211,6 +235,7 @@ def setup_parser():
 
     parsers = {
         'main': parser,
+        'patchwork': patchwork,
         }
     return parsers
 
diff --git a/tools/patman/control.py b/tools/patman/control.py
index ec94b23421c..a7d381c3008 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -113,11 +113,42 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
                                  show_comments, False, pwork)
 
 
-def do_patman(args):
+def patchwork(args, test_db=None, pwork=None):
+    """Process a 'patchwork' subcommand
+    Args:
+        args (Namespace): Arguments to process
+        test_db (str or None): Directory containing the test database, None to
+            use the normal one
+        pwork (Patchwork): Patchwork object to use
+    """
+    cser = cseries.Cseries(test_db)
+    try:
+        cser.open_database()
+        if args.subcmd == 'set-project':
+            if not pwork:
+                pwork = Patchwork(args.patchwork_url)
+            cser.project_set(pwork, args.project_name)
+        elif args.subcmd == 'get-project':
+            info = cser.project_get()
+            if not info:
+                raise ValueError("Project has not been set; use 'patman patchwork set-project'")
+            name, pwid, link_name = info
+            print(f"Project '{name}' patchwork-ID {pwid} link-name {link_name}")
+        else:
+            raise ValueError(f"Unknown patchwork subcommand '{args.subcmd}'")
+    finally:
+        cser.close_database()
+
+def do_patman(args, test_db=None, pwork=None, cser=None):
     """Process a patman command
 
     Args:
         args (Namespace): Arguments to process
+        test_db (str or None): Directory containing the test database, None to
+            use the normal one
+        pwork (Patchwork): Patchwork object to use, or None to create one
+        cser (Cseries): Cseries object to use when executing the command,
+            or None to create one
     """
     if args.full_help:
         with resources.path('patman', 'README.rst') as readme:
@@ -150,6 +181,8 @@ def do_patman(args):
             patchwork_status(args.branch, args.count, args.start, args.end,
                              args.dest_branch, args.force, args.show_comments,
                              args.patchwork_url)
+        elif args.cmd == 'patchwork':
+            patchwork(args, test_db, pwork)
     except Exception as exc:
         terminal.tprint(f'patman: {type(exc).__name__}: {exc}',
                         colour=terminal.Color.RED)
-- 
2.43.0

