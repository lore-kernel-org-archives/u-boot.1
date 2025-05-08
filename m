Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE46C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23D8E82A56;
	Thu,  8 May 2025 09:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XSdapWop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D4F782A71; Thu,  8 May 2025 09:29:44 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C636B82A65
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso513477f8f.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689380; x=1747294180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOa0wyA7U9/FgzDS8DRRlwNCO6W61HeqvRM7Kw5Xg94=;
 b=XSdapWopmerkcx3IZE9kiLP/PdZPBO+9/OQnq7DAKx1N8ELy/hD9cQ/4NACfg5M4hF
 3Pkn/D/1sFkuhx0nQ0FSiWIL02tdQ0vqF2oQGV3qsEE29tBTP94EdI5xOq13e+J9gmY6
 f/nGfMRHn64Z00qBDpgWLj6wMG1SwgW/NPvcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689380; x=1747294180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOa0wyA7U9/FgzDS8DRRlwNCO6W61HeqvRM7Kw5Xg94=;
 b=FdstJCYvq7D1g3TQCrHPvPW+m1h1dlT/ilJCZqm+ZNzSS/GprnMR9uyUZnRLTSLFh7
 payHv4Qcn475FLymQR/Vpuub4gLdJMlz8cXWMZLs4BdlHhXjq+6lAqW8zfT6xac3U8uj
 kX2wilXCTYlUVAB95z1uygSttZXyjIgYWmAroU25Q+f86iLGUsOgPc9G7faD/DlKSQnb
 Uki4TklwiFXgWztpDJEsVIQiSgxI8PtlNJlJkX851XK/MnV9WZaNqqq3VIlpP7Xxh3eA
 NJyRJt3abPmIElGBihF8SAECtJ2FYHKdB5ElYX5Aar2cduDJ4N9vUwF8/nqyzxUfNS61
 ATbw==
X-Gm-Message-State: AOJu0YzUgk/aetIBYMTRCbZj9yp1FI44MraqCtMD1mTZr87A1+i+Gr9U
 p+5+JILYh/NL1/LNZtBuNEizDgwgSmcD+r3wwudTDtBJaaTgtdDr9T9nQ0zZORZpm6v10yiwgaR
 E1R4dwZZjLo/a
X-Gm-Gg: ASbGncuDjS3354fUqFKSsGYC1r/8pQPxDeiKN5rpgHWpOrc4GujxUEKey8lVI1fR+5y
 K4qNMmmOtR8Gqq1d0+RFp0L7piDbRWyTUxqaD/uCqJ6cRCi2fdhiPLnFmSrBD6fzl/AbJsJJ1J5
 1uiqKeeZJMzossU4JH9u0B+hvVDqMs6v7g2DUySKOPNBOhICzI6Gy7kCAtre9F6A2dglJMVWdpY
 ANR4Yu6vA18eswyyL3WngAK+yHtSqGlRx6hX8uPRMOgxByOGpkXEQZ/27/P1rxw5BWCKOnQ6aOI
 JGSDvGloHzfRD8l0dVRCygSxs0DBYLewNMNFAA==
X-Google-Smtp-Source: AGHT+IHqx8QilrvlKe75tA6ZnEqg1lQ5PpxtcNGwX+O+vRAj7CjZzTedNHrv9a6u3sE99NBbQHQglA==
X-Received: by 2002:a05:6000:430d:b0:3a0:b8b0:4418 with SMTP id
 ffacd0b85a97d-3a0b8b045f4mr2451247f8f.50.1746689379734; 
 Thu, 08 May 2025 00:29:39 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brandon Maier <brandon.maier@collins.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/20] patman: Split parser creation from parsing
Date: Thu,  8 May 2025 09:28:38 +0200
Message-ID: <20250508072907.207175-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

Tests may want to parse their own arguments. Refactor the parser code to
support this and allow settings to receive arguments as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py       | 32 +++++++++++++++++++++++++-------
 tools/patman/settings.py      | 28 ++++++++++++++++++----------
 tools/patman/test_settings.py |  2 +-
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index cf32716b8e0..e5ac4fb1684 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -20,13 +20,11 @@ from patman import settings
 PATMAN_DIR = pathlib.Path(__file__).parent
 HAS_TESTS = os.path.exists(PATMAN_DIR / "func_test.py")
 
-def parse_args():
-    """Parse command line arguments from sys.argv[]
+def setup_parser():
+    """Set up command-line parser
 
     Returns:
-        tuple containing:
-            options: command line options
-            args: command lin arguments
+        argparse.Parser object
     """
     epilog = '''Create patches from commits in a branch, check them and email
         them as specified by tags you place in the commits. Use -n to do a dry
@@ -132,14 +130,34 @@ def parse_args():
                         help='Force overwriting an existing branch')
     status.add_argument('-T', '--single-thread', action='store_true',
                         help='Disable multithreading when reading patchwork')
+    return parser
+
+
+def parse_args(argv=None, config_fname=None, parser=None):
+    """Parse command line arguments from sys.argv[]
+
+    Args:
+        argv (str or None): Arguments to process, or None to use sys.argv[1:]
+        config_fname (str): Config file to read, or None for default, or False
+            for an empty config
+
+    Returns:
+        tuple containing:
+            options: command line options
+            args: command lin arguments
+    """
+    if not parser:
+        parser = setup_parser()
 
     # Parse options twice: first to get the project and second to handle
     # defaults properly (which depends on project)
     # Use parse_known_args() in case 'cmd' is omitted
-    argv = sys.argv[1:]
+    if not argv:
+        argv = sys.argv[1:]
+
     args, rest = parser.parse_known_args(argv)
     if hasattr(args, 'project'):
-        settings.Setup(parser, args.project)
+        settings.Setup(parser, args.project, argv, config_fname)
         args, rest = parser.parse_known_args(argv)
 
     # If we have a command, it is safe to parse all arguments
diff --git a/tools/patman/settings.py b/tools/patman/settings.py
index d66b22be1df..7a0866cd370 100644
--- a/tools/patman/settings.py
+++ b/tools/patman/settings.py
@@ -226,7 +226,7 @@ nxp = Zhikang Zhang <zhikang.zhang@nxp.com>
     f.close()
 
 
-def _UpdateDefaults(main_parser, config):
+def _UpdateDefaults(main_parser, config, argv):
     """Update the given OptionParser defaults based on config.
 
     We'll walk through all of the settings from all parsers.
@@ -242,6 +242,7 @@ def _UpdateDefaults(main_parser, config):
             updated.
         config: An instance of _ProjectConfigParser that we will query
             for settings.
+        argv (list of str or None): Arguments to parse
     """
     # Find all the parsers and subparsers
     parsers = [main_parser]
@@ -252,6 +253,7 @@ def _UpdateDefaults(main_parser, config):
     # Collect the defaults from each parser
     defaults = {}
     parser_defaults = []
+    argv = list(argv)
     for parser in parsers:
         pdefs = parser.parse_known_args()[0]
         parser_defaults.append(pdefs)
@@ -273,9 +275,11 @@ def _UpdateDefaults(main_parser, config):
 
     # Set all the defaults and manually propagate them to subparsers
     main_parser.set_defaults(**defaults)
+    assert len(parsers) == len(parser_defaults)
     for parser, pdefs in zip(parsers, parser_defaults):
         parser.set_defaults(**{k: v for k, v in defaults.items()
                                if k in pdefs})
+    return defaults
 
 
 def _ReadAliasFile(fname):
@@ -334,7 +338,7 @@ def GetItems(config, section):
         return []
 
 
-def Setup(parser, project_name, config_fname=None):
+def Setup(parser, project_name, argv, config_fname=None):
     """Set up the settings module by reading config files.
 
     Unless `config_fname` is specified, a `.patman` config file local
@@ -347,8 +351,9 @@ def Setup(parser, project_name, config_fname=None):
         parser:         The parser to update.
         project_name:   Name of project that we're working on; we'll look
             for sections named "project_section" as well.
-        config_fname:   Config filename to read.  An error is raised if it
-            does not exist.
+        config_fname:   Config filename to read, or None for default, or False
+            for an empty config.  An error is raised if it does not exist.
+        argv (list of str or None): Arguments to parse, or None for default
     """
     # First read the git alias file if available
     _ReadAliasFile('doc/git-mailrc')
@@ -357,12 +362,15 @@ def Setup(parser, project_name, config_fname=None):
     if config_fname and not os.path.exists(config_fname):
         raise Exception(f'provided {config_fname} does not exist')
 
-    if not config_fname:
+    if config_fname is None:
         config_fname = '%s/.patman' % os.getenv('HOME')
-    has_config = os.path.exists(config_fname)
-
     git_local_config_fname = os.path.join(gitutil.get_top_level(), '.patman')
-    has_git_local_config = os.path.exists(git_local_config_fname)
+
+    has_config = False
+    has_git_local_config = False
+    if config_fname is not False:
+        has_config = os.path.exists(config_fname)
+        has_git_local_config = os.path.exists(git_local_config_fname)
 
     # Read the git local config last, so that its values override
     # those of the global config, if any.
@@ -371,7 +379,7 @@ def Setup(parser, project_name, config_fname=None):
     if has_git_local_config:
         config.read(git_local_config_fname)
 
-    if not (has_config or has_git_local_config):
+    if config_fname is not False and not (has_config or has_git_local_config):
         print("No config file found.\nCreating ~/.patman...\n")
         CreatePatmanConfigFile(config_fname)
 
@@ -382,7 +390,7 @@ def Setup(parser, project_name, config_fname=None):
     for name, value in GetItems(config, 'bounces'):
         bounces.add(value)
 
-    _UpdateDefaults(parser, config)
+    return _UpdateDefaults(parser, config, argv)
 
 
 # These are the aliases we understand, indexed by alias. Each member is a list.
diff --git a/tools/patman/test_settings.py b/tools/patman/test_settings.py
index 06b7cbc3ab6..c117836de31 100644
--- a/tools/patman/test_settings.py
+++ b/tools/patman/test_settings.py
@@ -49,7 +49,7 @@ def test_git_local_config():
                                   dest='check_patch', default=True)
 
                 # Test "global" config is used.
-                settings.Setup(parser, 'unknown', global_config.name)
+                settings.Setup(parser, 'unknown', None, global_config.name)
                 args, _ = parser.parse_known_args([])
                 assert args.project == 'u-boot'
                 send_args, _ = send.parse_known_args([])
-- 
2.43.0

