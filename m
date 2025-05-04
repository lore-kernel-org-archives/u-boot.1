Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C48DC369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78CD382A27;
	Sun,  4 May 2025 15:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K8hHNWqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6E6829CD; Sun,  4 May 2025 15:24:28 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8CE82A55
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5f4ca707e31so5479758a12.2
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365065; x=1746969865; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WaWjMLeOAH9pr88Rstzys+Cr5atIyhdlBODCNdNSLH0=;
 b=K8hHNWqZL5m0PktzD+wOefVNphsL+he36nNx70dhkTmn6gTARmjF3K11W0XfUWmn1W
 VMi59gTGhRIN3cdQtT0ij78znLB/l/3VZ1VgA4tX+MNQgxVXyzRkVwmgky15nI2OU5jZ
 jJC6y5pCD30cy8nFaDXb0W3H0UOSmyrK0UzUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365065; x=1746969865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaWjMLeOAH9pr88Rstzys+Cr5atIyhdlBODCNdNSLH0=;
 b=jrCGc7kVWy1Lrn7xQXD2Is9BUmhApn7QZext7ANMGUFrqQ3errJue6OoNKPOG80wlS
 BpviLP1piFiWFsEfrBSLZ9bgDK8TZeZCN2i23hkUVFvy6X8uXs7nTmWXeyaBEhqPTNes
 TypXc51LWw89Jk/QA2+CIgvy5LHCFuEgB0/Ray42mWk7oy0m8b5paU1bdNHOl5E8sIXV
 NgodhLP8RV2i1ja4F/UnNY/mlnSHyfnC+QsVoy0XcS0zi+eLSGvMb3FZzwJe3/voIQ79
 vuN81WS1m432KUJEaxpsqajImfX5VesCm7+f3hnFzx41/Z9Qg271F+kX/xX+XhTnpJ1y
 9MYQ==
X-Gm-Message-State: AOJu0YzRupcD7hYUC/cTpiv3b9vkWJaa1hjYzoaXuHAtjE57ikwnis9m
 rxRDOcMBwZMYOCU9FjIKzKNcPTXfQaHieef3pXTdgPsAibglezk8vn62nYhASJMuhLDZTteVCd0
 pZrjZCzI=
X-Gm-Gg: ASbGncvUDnE0/B5mOUKlTlevJy4l3SSrqTPibzYQwjisiojIlMfpK9IZIgVgkVKhc33
 D03gkt5IxRFiSvOnIVMlf4Xp4oKVnG5h9LGXUpdI5ildZ3eNSgdtIOJxyP3Jus7X7l504wpPL2w
 GgVIFRsCmCXuc1IaxIU1ajasLrX2ajLmLaB3sZEEIXOSqwDcG/GaOlKqAa8tvYxixceknSWm6+O
 f/ku/8FVXy2Mr3km6pQzmyup40Aznsoo6tNIzPhehyKLj3dFeR4SwBOix7VpCo8uxx9DQfmeAQy
 us3P857fVTuCNMfdeyyFTJwPynk5mFB8qzWP
X-Google-Smtp-Source: AGHT+IHkh8gPl2w7TiM2MtEZ7uPMFbhnCqzNaaVwce1d35nmc+ZE7e/izk8VLIBwFBcOPHy8e3w3BQ==
X-Received: by 2002:a17:906:c10b:b0:ace:68ad:b4d8 with SMTP id
 a640c23a62f3a-ad1a4acf991mr373837966b.38.1746365064751; 
 Sun, 04 May 2025 06:24:24 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/30] patman: Tidy up the start-up code
Date: Sun,  4 May 2025 15:23:28 +0200
Message-ID: <20250504132356.2317305-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

(no changes since v1)

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

