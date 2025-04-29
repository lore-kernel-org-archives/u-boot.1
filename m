Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B95C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329E982982;
	Tue, 29 Apr 2025 15:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iqGAV6Cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99410829D4; Tue, 29 Apr 2025 15:24:17 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F28FE8297E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7301c227512so3650036a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933051; x=1746537851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qACEZVhoHPZ7kkdhERVrXeNTJvhOpX5RU2Sq4GEIX8=;
 b=iqGAV6CcbrPAV3L4FOhdk77Kv0ntftmsWeJbJALB40esxCYhjxxHc0nVwwAEQwSKCr
 pp3uQffvhz2kzYzkpdjBf0iKhuFhnhDntr1Rm5GTFpVbYk40tXmVH/7r1C4MD2kYu1Mi
 arm+OvspSe8g2IzArcSkbSy0n3KLzeeO+3QcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933051; x=1746537851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qACEZVhoHPZ7kkdhERVrXeNTJvhOpX5RU2Sq4GEIX8=;
 b=dqFG3m1J3F2aXlB45P6LeCu5BASpyjPvGnI0u/+CRjffD01VThuRP5VyXg86otvE6V
 laNywIps0BFSNLVOQEhl54YyvPfXCGz9l9VbjOkUHpiVDUpdR6MnN3v+4AFTr+6AXRey
 dYEGsCMaXZ6H4j8egVJsopGtLZqGAeKCJ9+EcGJKv/cihKY1yQaAPKZiPT1t4v/SyXPY
 qPYfUj5uRe5pYp1LyQVUAMNapjlIzUEHuugYDbt+rINx2vtC/NXrNUC0ntz6g7F6fvdg
 VYJ7mBYKe1O2R41kDWIDWEZKqetsWfYIgTmhc0SWCSP4p2pAIuhh6R8o5ELhiKJrAjBi
 2Dxg==
X-Gm-Message-State: AOJu0Yz4czggZLQpz4pzdv6OnM3Z+vMF+D18oxsj8rO0wwfS4xuDNI55
 3Z7uPa5TEuU+tZBV7cg12VW18WaWDBo1TwozEmwIAydoDpner48vRLZyw7cB9lZ29vsXjoUfMFA
 =
X-Gm-Gg: ASbGnct9LpNV24vgmsLpmVte6yIWzW5aTcqShm4pEpY1XwzRUdYjO61jTMbX/+1g/rG
 RK7No0ONKVWSllinfCd5r6KDTnco+6elkK/5n4eN6lwd+d8lTa+AEAW4Vi3x1Nmr5by1vS/T8jo
 DROaq/owKMgYZM29LMPmRN6Sbyzyuj3h4eSvZX1ofpM5Oa/X6Zge1yddkP3GC6pJQ13s4IQqFEc
 /+PpRH4dNjq0LqMYoiYOKrNAIMl9ZKO85r0TiRREvlBfFUiHxx0Boan8wPmq1yLlIg7qVF939Sb
 UOGrKAitrKQZpK9m/OXFR3NGBUyM4RhfKvr6EMQNu+mkoJNOjMFRNb9zWW8twTb5lcoQvH78dFP
 GTw==
X-Google-Smtp-Source: AGHT+IEzyGub5rFRAK/ZlQwi6gsQBOH6MOZhK5CuWqLijEdvNKsIgVf5KAZYt/UYjHdPP2Q5+fb7eg==
X-Received: by 2002:a05:6830:4704:b0:72b:9965:d997 with SMTP id
 46e09a7af769-7308a579cc7mr1424891a34.18.1745933050688; 
 Tue, 29 Apr 2025 06:24:10 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/30] patman: Tidy up the start-up code
Date: Tue, 29 Apr 2025 07:22:09 -0600
Message-ID: <20250429132239.251756-13-sjg@chromium.org>
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

Much of this was written before the other Python tools and they have
evolved. Make a few updates:

- Rather than calling sys.exit(), return the exit code from the control
  module and use it in __main__
- Set up tout as it is used in some places
- We now have quite a few tests, so update the comment about that

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__main__.py |  8 ++++++--
 tools/patman/control.py  | 24 ++++++++++++------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index db78ea603c2..6aadf767eca 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -15,6 +15,7 @@ our_path = os.path.dirname(os.path.realpath(__file__))
 sys.path.append(os.path.join(our_path, '..'))
 
 # Our modules
+from u_boot_pylib import tout
 from patman import cmdline
 from patman import control
 from u_boot_pylib import test_util
@@ -31,7 +32,9 @@ def run_patman():
     if not args.debug:
         sys.tracebacklimit = 0
 
-    # Run our meagre tests
+    tout.init(tout.INFO if args.verbose else tout.WARNING)
+
+    # Run our reasonably good tests
     if args.cmd == 'test':
         # pylint: disable=C0415
         from patman import func_test
@@ -46,7 +49,8 @@ def run_patman():
 
     # Process commits, produce patches files, check them, email them
     else:
-        control.do_patman(args)
+        exit_code = control.do_patman(args)
+        sys.exit(exit_code)
 
 
 if __name__ == "__main__":
diff --git a/tools/patman/control.py b/tools/patman/control.py
index 990e07f8766..a050bd2f551 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -280,18 +280,18 @@ def do_patman(args):
                 args.ignore_bad_tags = True
             send(args)
 
-    # Check status of patches in patchwork
-    elif args.cmd == 'status':
-        ret_code = 0
-        try:
+    ret_code = 0
+    try:
+        # Check status of patches in patchwork
+        if args.cmd == 'status':
             patchwork_status(args.branch, args.count, args.start, args.end,
                              args.dest_branch, args.force, args.show_comments,
                              args.patchwork_url)
-        except Exception as exc:
-            terminal.tprint(f'patman: {type(exc).__name__}: {exc}',
-                            colour=terminal.Color.RED)
-            if args.debug:
-                print()
-                traceback.print_exc()
-            ret_code = 1
-        sys.exit(ret_code)
+    except Exception as exc:
+        terminal.tprint(f'patman: {type(exc).__name__}: {exc}',
+                        colour=terminal.Color.RED)
+        if args.debug:
+            print()
+            traceback.print_exc()
+        ret_code = 1
+    return ret_code
-- 
2.43.0

