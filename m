Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53216C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3C0582A39;
	Thu,  8 May 2025 09:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JNAiRz8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEB9282AAA; Thu,  8 May 2025 09:29:46 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C9E28059D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso4233625e9.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689383; x=1747294183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNGNT2zij6ZH5uklZeIp5GYjiO1EPBzT6fKGcFsQRGE=;
 b=JNAiRz8W9QTEAoxos2fbckpe7n7oP3xfgh7XhwJQPWbX+Rjz82wcfdW0ULUS+YptyM
 AEl5T4xpeF2yN74C+qHGoemuzdOIRdsTL2TvTwdP8HW6xW29NhR2RMvxIrUPYcnnOz4C
 nMJiFSaNeY7U9FtchV48dW+0nQ9ca430o5xdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689383; x=1747294183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNGNT2zij6ZH5uklZeIp5GYjiO1EPBzT6fKGcFsQRGE=;
 b=Vu4dVLVo+sHPFw2fPLzP8doN3TvGHSV1HUK+fIxLIpA4gBvGUahnBOGCDEOzIyf9DV
 H/jo3m/TGjY34nSLayE2nSdIuhLpwr5qOWFU9/IfkEQOkmnlHowqIrpge/WKK39WMVRP
 QFEshdXt2xrtAZMBVL5KHytjN0X6x5CQDjYvIyTxW5TFGOvGmsLBu7INbxxMDHrqpcN/
 ihr3NIQ2xpYHU3CIqoLf57mN+8OO4YB2iDbBzoAo8pa6vi5/Gd/WE5ASVUBHu1CilK8B
 N7tRMNxwB6Op/B/oCCYvAIXr9SmIp4toZz0mKuc4ULFwBFAo4/TRBzxFwyz8fZfvx/hY
 tqDw==
X-Gm-Message-State: AOJu0YyRtg8ZazxNRDcc2n/idWzQGxvegJ/iIwAWSVjONTXBYN7vPnEn
 VHzlM3Gi0ZHrW24MxuixO4HUyW/WgEfeyGUv2kr7Tv8l81N2ya0FWQ03vFjSnX+8gY0WnWGiQ8b
 2a/e3YHVDRWVj
X-Gm-Gg: ASbGnct8J+WY04YgY9Aph7fQCFtSnAqxSqCHOOFHpdlNmLTN7hHChdxpLKKtLnIK8ZY
 2dtnhFhHQTH+3ge1WWtRAOkywuOgmoF8PiEt3oBFTqI/6XVcYikUv0z3VhZ3Mh8kqHlIgU26HGr
 TMpmsUGlzTC1HPdjUSiomGYb0APOfczj4oxLHLfNa54VFfWkkqv73WCDU+P2sIKGrka/iyFN0fO
 lSlJSiduQSzXdLz+rYqEyboAaKgJ5O1fVyDbCBcFnkz7pm3wZ9PHOFGsmzOzeX13lW/13LybR4n
 t9+lJwkZpKS76ArJTtEsxueWQjMTAaAypd8H7lOL6pVjXFUl
X-Google-Smtp-Source: AGHT+IGJinxZKapGKOQivDmvuwksDIwT9VaTbJ9anX8oMPI5hwTskNN5WkvU466GHKUnSNvJuNKcPA==
X-Received: by 2002:a05:600c:8114:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-441d44e50d4mr43178425e9.28.1746689383306; 
 Thu, 08 May 2025 00:29:43 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/20] patman: Split subparsers into their own functions
Date: Thu,  8 May 2025 09:28:40 +0200
Message-ID: <20250508072907.207175-17-sjg@chromium.org>
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

Simplify the main parser by moving subparser code into separate
functions. Fix a few pylint warnings while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 142 ++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 55 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index e5ac4fb1684..cb4e68c7cd8 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -20,65 +20,38 @@ from patman import settings
 PATMAN_DIR = pathlib.Path(__file__).parent
 HAS_TESTS = os.path.exists(PATMAN_DIR / "func_test.py")
 
-def setup_parser():
-    """Set up command-line parser
 
-    Returns:
-        argparse.Parser object
-    """
-    epilog = '''Create patches from commits in a branch, check them and email
-        them as specified by tags you place in the commits. Use -n to do a dry
-        run first.'''
+def add_send_subparser(subparsers):
+    """Add the 'send' subparser
 
-    parser = argparse.ArgumentParser(epilog=epilog)
-    parser.add_argument('-b', '--branch', type=str,
-        help="Branch to process (by default, the current branch)")
-    parser.add_argument('-c', '--count', dest='count', type=int,
-        default=-1, help='Automatically create patches from top n commits')
-    parser.add_argument('-e', '--end', type=int, default=0,
-        help='Commits to skip at end of patch list')
-    parser.add_argument('-D', '--debug', action='store_true',
-        help='Enabling debugging (provides a full traceback on error)')
-    parser.add_argument(
-        '-N', '--no-capture', action='store_true',
-        help='Disable capturing of console output in tests')
-    parser.add_argument('-p', '--project', default=project.detect_project(),
-                        help="Project name; affects default option values and "
-                        "aliases [default: %(default)s]")
-    parser.add_argument('-P', '--patchwork-url',
-                        default='https://patchwork.ozlabs.org',
-                        help='URL of patchwork server [default: %(default)s]')
-    parser.add_argument('-s', '--start', dest='start', type=int,
-        default=0, help='Commit to start creating patches from (0 = HEAD)')
-    parser.add_argument(
-        '-v', '--verbose', action='store_true', dest='verbose', default=False,
-        help='Verbose output of errors and warnings')
-    parser.add_argument(
-        '-X', '--test-preserve-dirs', action='store_true',
-        help='Preserve and display test-created directories')
-    parser.add_argument(
-        '-H', '--full-help', action='store_true', dest='full_help',
-        default=False, help='Display the README file')
+    Args:
+        subparsers (argparse action): Subparser parent
 
-    subparsers = parser.add_subparsers(dest='cmd')
+    Return:
+        ArgumentParser: send subparser
+    """
     send = subparsers.add_parser(
         'send', help='Format, check and email patches (default command)')
-    send.add_argument('-i', '--ignore-errors', action='store_true',
-           dest='ignore_errors', default=False,
-           help='Send patches email even if patch errors are found')
-    send.add_argument('-l', '--limit-cc', dest='limit', type=int, default=None,
-           help='Limit the cc list to LIMIT entries [default: %(default)s]')
-    send.add_argument('-m', '--no-maintainers', action='store_false',
-           dest='add_maintainers', default=True,
-           help="Don't cc the file maintainers automatically")
+    send.add_argument(
+        '-i', '--ignore-errors', action='store_true',
+        dest='ignore_errors', default=False,
+        help='Send patches email even if patch errors are found')
+    send.add_argument(
+        '-l', '--limit-cc', dest='limit', type=int, default=None,
+        help='Limit the cc list to LIMIT entries [default: %(default)s]')
+    send.add_argument(
+        '-m', '--no-maintainers', action='store_false',
+        dest='add_maintainers', default=True,
+        help="Don't cc the file maintainers automatically")
     send.add_argument(
         '--get-maintainer-script', dest='get_maintainer_script', type=str,
         action='store',
         default=os.path.join(gitutil.get_top_level(), 'scripts',
                              'get_maintainer.pl') + ' --norolestats',
         help='File name of the get_maintainer.pl (or compatible) script.')
-    send.add_argument('-n', '--dry-run', action='store_true', dest='dry_run',
-           default=False, help="Do a dry run (create but don't email patches)")
+    send.add_argument(
+        '-n', '--dry-run', action='store_true', dest='dry_run',
+        default=False, help="Do a dry run (create but don't email patches)")
     send.add_argument('-r', '--in-reply-to', type=str, action='store',
                       help="Message ID that this series is in reply to")
     send.add_argument('-t', '--ignore-bad-tags', action='store_true',
@@ -86,8 +59,9 @@ def setup_parser():
                       help='Ignore bad tags / aliases (default=warn)')
     send.add_argument('-T', '--thread', action='store_true', dest='thread',
                       default=False, help='Create patches as a single thread')
-    send.add_argument('--cc-cmd', dest='cc_cmd', type=str, action='store',
-           default=None, help='Output cc list for patch file (used by git)')
+    send.add_argument(
+        '--cc-cmd', dest='cc_cmd', type=str, action='store',
+        default=None, help='Output cc list for patch file (used by git)')
     send.add_argument('--no-binary', action='store_true', dest='ignore_binary',
                       default=False,
                       help="Do not output contents of changes in binary files")
@@ -112,13 +86,18 @@ def setup_parser():
                       help='Preserve Change-Id tags in patches to send.')
 
     send.add_argument('patchfiles', nargs='*')
+    return send
 
-    # Only add the 'test' action if the test data files are available.
-    if HAS_TESTS:
-        test_parser = subparsers.add_parser('test', help='Run tests')
-        test_parser.add_argument('testname', type=str, default=None, nargs='?',
-                                 help="Specify the test to run")
 
+def add_status_subparser(subparsers):
+    """Add the 'status' subparser
+
+    Args:
+        subparsers (argparse action): Subparser parent
+
+    Return:
+        ArgumentParser: status subparser
+    """
     status = subparsers.add_parser('status',
                                    help='Check status of patches in patchwork')
     status.add_argument('-C', '--show-comments', action='store_true',
@@ -130,6 +109,59 @@ def setup_parser():
                         help='Force overwriting an existing branch')
     status.add_argument('-T', '--single-thread', action='store_true',
                         help='Disable multithreading when reading patchwork')
+    return status
+
+
+def setup_parser():
+    """Set up command-line parser
+
+    Returns:
+        argparse.Parser object
+    """
+    epilog = '''Create patches from commits in a branch, check them and email
+        them as specified by tags you place in the commits. Use -n to do a dry
+        run first.'''
+
+    parser = argparse.ArgumentParser(epilog=epilog)
+    parser.add_argument('-b', '--branch', type=str,
+        help="Branch to process (by default, the current branch)")
+    parser.add_argument('-c', '--count', dest='count', type=int,
+        default=-1, help='Automatically create patches from top n commits')
+    parser.add_argument('-e', '--end', type=int, default=0,
+        help='Commits to skip at end of patch list')
+    parser.add_argument('-D', '--debug', action='store_true',
+        help='Enabling debugging (provides a full traceback on error)')
+    parser.add_argument(
+        '-N', '--no-capture', action='store_true',
+        help='Disable capturing of console output in tests')
+    parser.add_argument('-p', '--project', default=project.detect_project(),
+                        help="Project name; affects default option values and "
+                        "aliases [default: %(default)s]")
+    parser.add_argument('-P', '--patchwork-url',
+                        default='https://patchwork.ozlabs.org',
+                        help='URL of patchwork server [default: %(default)s]')
+    parser.add_argument('-s', '--start', dest='start', type=int,
+        default=0, help='Commit to start creating patches from (0 = HEAD)')
+    parser.add_argument(
+        '-v', '--verbose', action='store_true', dest='verbose', default=False,
+        help='Verbose output of errors and warnings')
+    parser.add_argument(
+        '-X', '--test-preserve-dirs', action='store_true',
+        help='Preserve and display test-created directories')
+    parser.add_argument(
+        '-H', '--full-help', action='store_true', dest='full_help',
+        default=False, help='Display the README file')
+
+    subparsers = parser.add_subparsers(dest='cmd')
+    add_send_subparser(subparsers)
+    add_status_subparser(subparsers)
+
+    # Only add the 'test' action if the test data files are available.
+    if HAS_TESTS:
+        test_parser = subparsers.add_parser('test', help='Run tests')
+        test_parser.add_argument('testname', type=str, default=None, nargs='?',
+                                 help="Specify the test to run")
+
     return parser
 
 
-- 
2.43.0

