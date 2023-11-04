Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C97DC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 16:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C008712E;
	Sat,  4 Nov 2023 17:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ksyhd/AD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7045686F50; Sat,  4 Nov 2023 17:25:43 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA22987092
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 17:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7a669a4ec51so111936339f.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699115134; x=1699719934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPIAinNV0gSmK41jN4CgwPMYogxEl1TAWNeFg3x+UN0=;
 b=ksyhd/ADtOIMRIni1phIuO5CzhwSni+MGqpc+YoNNKvptmBNXwGb84dSt42F3ynAnu
 UDEEQCXRwi6JbSFxUa9XjTECIciXClqNBpCFTPmtx+al6jAzrUo0d+FxOh4sktmhDCd3
 lcpdrDklV8NN5SICFLiNpSHQEaBtrkCob3aCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699115134; x=1699719934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPIAinNV0gSmK41jN4CgwPMYogxEl1TAWNeFg3x+UN0=;
 b=wHbJwuSmDtmyqZEUbzgJAAhpNHVELLy5uV0/q8w7a4+QXA59P3tI55eor5nDmkQgCc
 jXfkQCeiTm87DSp/NyKMcCT4IaVMV9do6lFYLZw0qFFeyydYxPbsRhy+w0uZxGlHZJ8g
 A5EIQ6bn3yT+zbBc+jbibP3y4RzJzXPpq90TgXOdK84F4ffPRufsVcPalgYLk1ku09vY
 iuvGkCLCM8ftfz85qdMT2N/Z1rUPixpN0YmQU5DQDWTi4HPT7/HbgEQAOaTHd5lE1/a9
 +demnhEeumtPPd0l0Nbroh1LPSA2VBxgjeLZJ0HAmyWrEx8t2MCtHs6YviSqKwPhtDKx
 zFSQ==
X-Gm-Message-State: AOJu0YzLE1sP4rFKe40/fo5k8lm4nxA6Le+RVocSfNpPsUuGzY5SFtL5
 ob/mDokqG4HI0wIkDZ1mQ5EKs0BYWkc2cZuL/mxr6w==
X-Google-Smtp-Source: AGHT+IFklQyTZ0HZLDrp+6mbpz9c3zO9jV3DQMf05OnV7arzzlY8LzUnW4fYpQClSg7sPhWDg70mbA==
X-Received: by 2002:a05:6602:2c55:b0:787:8cf:fd08 with SMTP id
 x21-20020a0566022c5500b0078708cffd08mr32702243iov.17.1699115134207; 
 Sat, 04 Nov 2023 09:25:34 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a028784000000b0042bb296863asm1119013jai.56.2023.11.04.09.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 09:25:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/5] patman: Correct easy pylint warnings in __main__
Date: Sat,  4 Nov 2023 10:25:22 -0600
Message-ID: <20231104162527.1736401-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231104162527.1736401-1-sjg@chromium.org>
References: <20231104162527.1736401-1-sjg@chromium.org>
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

Tidy up the code a little to reduce the number of pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__main__.py | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index 87850295e704..3ca858cd3157 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -16,10 +16,10 @@ import re
 import sys
 import traceback
 
-if __name__ == "__main__":
-    # Allow 'from patman import xxx to work'
-    our_path = os.path.dirname(os.path.realpath(__file__))
-    sys.path.append(os.path.join(our_path, '..'))
+# Allow 'from patman import xxx to work'
+# pylint: disable=C0413
+our_path = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(our_path, '..'))
 
 # Our modules
 from patman import cmdline
@@ -43,6 +43,7 @@ def run_patman():
 
     # Run our meagre tests
     if args.cmd == 'test':
+        # pylint: disable=C0415
         from patman import func_test
         from patman import test_checkpatch
 
@@ -58,16 +59,15 @@ def run_patman():
         # Called from git with a patch filename as argument
         # Printout a list of additional CC recipients for this patch
         if args.cc_cmd:
-            fd = open(args.cc_cmd, 'r')
-            re_line = re.compile('(\S*) (.*)')
-            for line in fd.readlines():
-                match = re_line.match(line)
-                if match and match.group(1) == args.patchfiles[0]:
-                    for cc in match.group(2).split('\0'):
-                        cc = cc.strip()
-                        if cc:
-                            print(cc)
-            fd.close()
+            re_line = re.compile(r'(\S*) (.*)')
+            with open(args.cc_cmd, 'r', encoding='utf-8') as inf:
+                for line in inf.readlines():
+                    match = re_line.match(line)
+                    if match and match.group(1) == args.patchfiles[0]:
+                        for cca in match.group(2).split('\0'):
+                            cca = cca.strip()
+                            if cca:
+                                print(cca)
 
         elif args.full_help:
             with importlib.resources.path('patman', 'README.rst') as readme:
@@ -85,8 +85,8 @@ def run_patman():
             control.patchwork_status(args.branch, args.count, args.start, args.end,
                                      args.dest_branch, args.force,
                                      args.show_comments, args.patchwork_url)
-        except Exception as e:
-            terminal.tprint('patman: %s: %s' % (type(e).__name__, e),
+        except Exception as exc:
+            terminal.tprint(f'patman: {type(exc).__name__}: {exc}',
                             colour=terminal.Color.RED)
             if args.debug:
                 print()
-- 
2.42.0.869.gea05f2083d-goog

