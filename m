Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9348FC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75AF788AEC;
	Wed, 17 Jul 2024 17:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IOeeTFGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFA2A88AE6; Wed, 17 Jul 2024 17:57:38 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA22B88AF2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-367e50f71bbso4516893f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231856; x=1721836656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zt3jA1TrKf9KblM+yQ65C7uyptVMNqp3YsccCp2OFt0=;
 b=IOeeTFGPcC+g5hrSxrE0tYVpPEIRRUJbdhcsR3qS/kqRJfBQZVdiWABmXHzsBNlzOv
 gPyd95DAEjQohmoxlxXAhLugV08JQmYleDWLnUzCrLQ/esZFW57DOU2mEuW128MaORcF
 +l18MBsnL635+/5EKe6u0zXeDOJkiQlg2LFOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231856; x=1721836656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zt3jA1TrKf9KblM+yQ65C7uyptVMNqp3YsccCp2OFt0=;
 b=YnZNRm7W/haZyyAG37kL44L5/lVjNwbC+nF6o91uu7QKS+20iu2fPAZyoUxuaylB29
 a5/ExO2h/Ohh+VP0QLlTtjDr7YObNgMNdlRItQFJvHGoUKP4vbF77fS/ihHV32aEtgiR
 UQzWCBXYQc0QygTuent9rbsAoDA6Rz0vY/A1rmpNV9UXCpWS3Jfj3w53mOA9Fk6ia/Jl
 lAUrf79AXAG8JGcQ5IOWM3m6EgW4qTQoy6y+8gmeZldHdkCt0fVDmb0saKWi4ZVXs5zP
 Jp9Cj1K7OZSNdZ5NaGSVCMYWpKn22rTsNYJr2yGmJqBWHNdl5FkJZfpjk+QNspETdjQm
 e+Zg==
X-Gm-Message-State: AOJu0YxT1Kie8GijZjm7O469Jsvqy9yXXcCmGriaX6kYWVktb/jmtRi3
 MkLVw/ePsHJhGfk/hWpBv/2pyYbK2LP2Gm4HzhUozpd8qI9CRq9dZGHEYFGJl++ywfbt/VUt1pU
 =
X-Google-Smtp-Source: AGHT+IEWp5C0/qaJjrFOytGJD/TNHuE6f7fAnL/+PSLzVFPwSZ8nUffuLUhHxVUyxuDvc3teNGjN3g==
X-Received: by 2002:a05:6000:18a6:b0:368:4634:c419 with SMTP id
 ffacd0b85a97d-3684634c53amr377281f8f.58.1721231855858; 
 Wed, 17 Jul 2024 08:57:35 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 21/24] qconfig: Use the Color object in Progress
Date: Wed, 17 Jul 2024 16:57:09 +0100
Message-Id: <20240717155712.2913651-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717155712.2913651-1-sjg@chromium.org>
References: <20240717155712.2913651-1-sjg@chromium.org>
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

Since the Progress class has the required object, use it from there
instead of passing it around.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index ec59ef4ec71..c4171cf9076 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -704,12 +704,11 @@ class ReferenceSource:
 
         return self.src_dir
 
-def move_config(args, col):
+def move_config(args):
     """Build database or sync config options to defconfig files.
 
     Args:
         args (Namespace): Program arguments
-        col (terminal.Color): Colour object
 
     Returns:
         tuple:
@@ -745,6 +744,8 @@ def move_config(args, col):
     else:
         defconfigs = get_all_defconfigs()
 
+    col = terminal.Color(terminal.COLOR_NEVER if args.nocolour
+                         else terminal.COLOR_IF_TERMINAL)
     progress = Progress(col, len(defconfigs))
     slots = Slots(toolchains, args, progress, reference_src_dir, db_queue, col)
 
@@ -1604,7 +1605,7 @@ def add_commit(configs):
     subprocess.call(['git', 'commit', '-s', '-m', msg])
 
 
-def write_db(config_db, col, progress):
+def write_db(config_db, progress):
     """Write the database to a file
 
     Args:
@@ -1613,12 +1614,12 @@ def write_db(config_db, col, progress):
             value: dict:
                 key: CONFIG option
                 value: Value of option
-        col (terminal.Color): Colour-output class
         progress (Progress): Progress indicator.
 
     Returns:
         int: exit code (0 for success)
     """
+    col = progress.col
     with open(CONFIG_DATABASE, 'w', encoding='utf-8') as outf:
         for defconfig, configs in config_db.items():
             outf.write(f'{defconfig}\n')
@@ -1631,16 +1632,16 @@ def write_db(config_db, col, progress):
     return 0
 
 
-def move_done(col, progress):
+def move_done(progress):
     """Write a message indicating that the move is done
 
     Args:
-        col (terminal.Color): Colour-output class
         progress (Progress): Progress indicator.
 
     Returns:
         int: exit code (0 for success)
     """
+    col = progress.col
     if progress.failed:
         print(col.build(col.RED, f'{progress.failure_msg}see {FAILED_LIST}', True))
     else:
@@ -1684,16 +1685,14 @@ def main():
     if args.find:
         return do_find_config(args.configs)
 
-    col = terminal.Color(terminal.COLOR_NEVER if args.nocolour
-                         else terminal.COLOR_IF_TERMINAL)
-    config_db, progress = move_config(args, col)
+    config_db, progress = move_config(args)
 
     if args.commit:
         add_commit(args.configs)
 
     if args.build_db:
-        return write_db(config_db, col, progress)
-    return move_done(col, progress)
+        return write_db(config_db, progress)
+    return move_done(progress)
 
 
 if __name__ == '__main__':
-- 
2.34.1

