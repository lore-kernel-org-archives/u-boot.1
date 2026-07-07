Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33907C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F2A8496E;
	Tue,  7 Jul 2026 13:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KXt7SEMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5665849BA; Tue,  7 Jul 2026 13:36:11 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A30580087
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-43bfe209e45so1851569fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424168; x=1784028968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dsju8TfV58bHj19zKvy+JC4HDh7uQre5ZfH31b9lfjI=;
 b=KXt7SEMUFhTdkFELdjsyQOc03ZlVYg+ybGiTnNo5yJmXNXEv3YDGOi7pRuqn8f1xkC
 NzRG+C4tx1Pk2M4eUzLOcmRNFeVFtSHI1l19IpOZL0aAWift36St5RkIxb8aZjkXpi7A
 sGtr1vj19RpqXS6c4MsIlOuC86DPbuvswzBDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424168; x=1784028968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dsju8TfV58bHj19zKvy+JC4HDh7uQre5ZfH31b9lfjI=;
 b=N73FoFy7oGeTw3bB8Elde2y200vDpM08lG5JjDeOh3yjsE0tj4iar+8Oa2y9URYoOB
 oWAxfSXvK82y4zbcZzhEeC/KjthTgq8clmizXPQhrdSvtfnBJbCUmd1uBfrAduRam5UR
 sIttoEPfO4Z/2hfYWAowrVuaAj1asWt/zLL5r6QMjzUFcB4p4Jpa811jWTKf3KunQPoD
 4Q+8vXqe0bOcUeqHhTOihPYEpu+wgJeQF4j2xjLyCk4zVS8loI7GQ4m33gxeRdQUWZt0
 Elvz04TFfDJcVthwmx0IJT/yKdcqM8Fl2GvqBrqWJUqb6sUMqK/iXIk2XxqrXLhblDVZ
 +Sdg==
X-Gm-Message-State: AOJu0YxzQfu1J/Jopa1KAdNNNOk1JfwwDuZupq6PCPWPm4hIP01PiYEV
 y/ATOD01pDccvb5ITrfF+quONzacs5pmSLiO5IQAkFpl4HAfY8kYLQDXgVQ8IpBbhPr8tvmeGaK
 rTGhfQA==
X-Gm-Gg: AfdE7cn2a90X4SxbcUzqmH4ZmkSXVl6HsWelcvJh/FM8ORGwQa2POyKAJopkIK/4A9R
 pP2cc33sMjoxoSlu0JIFtgleMEvjc1mGLAtADTHk+EyGvVkJDguDB8dKK+/ATPW5sW58WR9gBxS
 dAhWs0inGMtmbZZ8pq6CilydjP+9qjMTIAnJ9EvAcXXIeFsb/I0ryJO6fNUzlLQkDoizP6u+H35
 iTkIvpfDdAVknsI+5rt8y86Tvb/v6HrarKesJKJHMxIZp+b+Ki5OIw9GvJtbS2hMvdcbv6ygq0U
 2qFAynQJ0T3kW0BrifwX4gV6BGN9MROkHLM1xXQB1VUqAhikTvRrw4zUcYlxsZtGWacBPi+JTS/
 1GO+cneZQ6h/Xh26JRugitdIYcXRlsWxSaygfRFNFJj6EnxmyHJifwLaMveSop8q4LmSirZoqta
 0uZeCIZIA=
X-Received: by 2002:a05:6871:3402:b0:448:558c:d8cb with SMTP id
 586e51a60fabf-451064d6a57mr2940786fac.41.1783424167795; 
 Tue, 07 Jul 2026 04:36:07 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/13] qconfig: Ignore defconfigs containing #include
Date: Tue,  7 Jul 2026 05:35:04 -0600
Message-ID: <20260707113538.3382145-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707113538.3382145-1-sjg@chromium.org>
References: <20260707113538.3382145-1-sjg@chromium.org>
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

Report these files in the summary, along with a count of files which
synced OK.

Link: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/28
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 9d59568dfbc..a01481de207 100755
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
+            # Files with #include get mangled as savedefconfig doesn't
+            # know how to deal with them. Ignore them
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
@@ -1664,7 +1677,9 @@ def move_done(progress):
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

