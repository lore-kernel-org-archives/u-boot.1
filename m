Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6BACF2588
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 23:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563D488E12;
	Sun, 13 Oct 2024 01:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gkSlWsDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B6FD88E3C; Sun, 13 Oct 2024 01:22:41 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB0288D29
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 01:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-837ec133784so59258139f.3
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728775357; x=1729380157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7czEek8ysrKHJbVnAuV7qxEnk9+YKJO+m9Ma5UdxU98=;
 b=gkSlWsDWu7Ix1uK2XRQaLMorweqVPc+4ke26QaxrlwiLXGlr8rocCZ1OuO2b44BNor
 eBnsPusY+BaSr29sUgBLW2rrWM4WhtxlKXaxsO8jAUM6htV7ZjaDbhilka2nUZmC7hPz
 1sjEOHzVKxWjV9Aznk9y/m8jVHGwXG0Ga5/mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728775357; x=1729380157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7czEek8ysrKHJbVnAuV7qxEnk9+YKJO+m9Ma5UdxU98=;
 b=j1LIz4oEBO7BZkW4mIYBjeRdWJ67LSDO3x9EhP6GGJFN0AVyClLkt0QPGZYAS7OWv7
 izJaFRDOjCr9hvOEejrsVudtRUPXNOkdrreReCpQ1/fqjUPs0JrNgCa7doRvuZf8Ez51
 fJ3F0OoQT2RJVd2ToD+E7MXtYCSGv5p6mWn/rSRRVilLwXJQA6AnJos098a4MFo+TcBh
 huwDJ8JlEBu9qTnqtmb/cxgFhXPe5mURPl3MoQ1C0hUzAom6EEXIPB+G9mijnFUwMOD6
 chqaeywXXOGoYRAKZIDmsRz6b9nnk0F+Hfot9nMHIUSQHBM5NEWehS8VcFmths+pD4cx
 d6gg==
X-Gm-Message-State: AOJu0YyCI1lJLKOcqd4tw2X4vZn52iB+IVX59aemoh8jYQIxwNHYx4/i
 e0EnhbUHA4uIAVlG7K2mLAlrspqTNa+kCGrils7mNU2/yv0utcw+ZthMFJuD8Gvcz7GUu8zjKds
 =
X-Google-Smtp-Source: AGHT+IH3KD5UP86OwLcb75ADk+t7KLk8XdXmy7rD7hhHfnLEP/DTwSgMMPvE49vlpI0b5pu38/hzgw==
X-Received: by 2002:a05:6e02:b4e:b0:3a0:9d2b:2420 with SMTP id
 e9e14a558f8ab-3a3b5fc58b5mr53222645ab.25.1728775357429; 
 Sat, 12 Oct 2024 16:22:37 -0700 (PDT)
Received: from chromium.org ([2607:fb91:7ce:96a:8185:a50b:d0fe:b591])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbada84a35sm1228698173.117.2024.10.12.16.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Oct 2024 16:22:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] qconfig: Ignore defconfigs containing #include
Date: Sat, 12 Oct 2024 17:22:30 -0600
Message-ID: <20241012232231.5638-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012232231.5638-1-sjg@chromium.org>
References: <20241012232231.5638-1-sjg@chromium.org>
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

Running "tools/qconfig.py -s" will re-sync files with #include in them
and so un-#include them.

Ignore these and mark them as failures.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/28
---

 tools/qconfig.py | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index c5a33412c8c..ed12044f345 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -32,6 +32,8 @@ from buildman import bsettings
 from buildman import kconfiglib
 from buildman import toolchain
 from u_boot_pylib import terminal
+from u_boot_pylib.terminal import tprint
+from u_boot_pylib import tools
 
 SHOW_GNU_MAKE = 'scripts/show-gnu-make'
 SLEEP_TIME=0.03
@@ -551,14 +553,25 @@ class Slot:
         orig_defconfig = os.path.join('configs', self.defconfig)
         new_defconfig = os.path.join(self.build_dir, 'defconfig')
         updated = not filecmp.cmp(orig_defconfig, new_defconfig)
+        success = True
 
         if updated:
-            self.log.append(
-                self.col.build(self.col.BLUE, 'defconfig updated', bright=True))
+            # Files with #include get mangled as savedefconfig doesn't know how to
+            # deal with them. Ignore them
+            success = b'#include' not in tools.read_file(orig_defconfig)
+            if success:
+                self.log.append(
+                    self.col.build(self.col.BLUE, 'defconfig updated',
+                                   bright=True))
+            else:
+                self.log.append(
+                    self.col.build(self.col.RED, 'ignored due to #include',
+                                   bright=True))
+                updated = False
 
         if not self.args.dry_run and updated:
             shutil.move(new_defconfig, orig_defconfig)
-        self.finish(True)
+        self.finish(success)
 
     def finish(self, success):
         """Display log along with progress and go to the idle state.
@@ -1666,7 +1679,9 @@ def move_done(progress):
     """
     col = progress.col
     if progress.failed:
-        print(col.build(col.RED, f'{progress.failure_msg}see {FAILED_LIST}', True))
+        if progress.good:
+            tprint(f'{progress.good} OK, ', newline=False, colour=col.GREEN)
+        tprint(f'{progress.failure_msg}see {FAILED_LIST}', colour=col.RED)
     else:
         # Add enough spaces to overwrite the progress indicator
         print(col.build(
-- 
2.43.0

