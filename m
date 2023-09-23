Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C72CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EF186B93;
	Sat, 23 Sep 2023 21:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hoVI7DDn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DF986BB8; Sat, 23 Sep 2023 21:44:55 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 628CB8477A
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34fcd1b9892so12526875ab.3
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498286; x=1696103086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeKB+5m5jzLtQ0BJZG5PMgTQaJVVZy2fMYtLbIrIs8E=;
 b=hoVI7DDnaarjqHMyPM5q3LoA20tpRCqYD4Ts2GS81wT0XVPEAGD5RnbUyP5CtdKvWj
 U+/7DJUL1D35yJTJ1wxF9ImOjMAvjcvxd+cPVTT98qShtVSOY0bWERIXjKPboXNnZMz/
 RSDfAo5PHS+qof/EpI7eiJ59ENqM2G+2rN9Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498286; x=1696103086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeKB+5m5jzLtQ0BJZG5PMgTQaJVVZy2fMYtLbIrIs8E=;
 b=aoyHHLlz1zouK1Xn1ZXH8lKNN2CxWhNrQBzOtX5ndb6DMJJF1/JoRdX3BQjMJEo5lM
 qXe+DRfMUXM7/rgT4PWxq05LW0T6hvPjbaxjKj68rd/AFxIP1jyygc1YrtlR6IKmsz+8
 6qL6ICJKRHhRe+kNzEePb3JxjdfqYIVmki4xofjnM2LpPZzx/LoYrQDmpZc6Kg4S+Ypn
 cp48Ozt3BAt7HwuJJJjsdz/EiHK4/Han4Z5mANmaNZ3OtKs8fIC7Tnnz6fJNBczn5nWy
 7gm5NJ78uFuMhdPEI111GN6dg2asrvZrRkiU2tEWWMaPsSdQUWm5bL0qV7YAvFUXLsMW
 mAYA==
X-Gm-Message-State: AOJu0YzhuSTjn9HrnacSKsMsn2mAA3NyUL6dp0k6JUFnwXP/GnXeU2Ne
 Rep4j7OjXdzkd+LtMKLronrJPfB1117IrPiZuZE=
X-Google-Smtp-Source: AGHT+IEMqDinE3wwE3ibDGdic+Q9H8llFESlLIS0lyiMiygpW2SUPXgax+lbF8HgN0rfaAoNHJMnnA==
X-Received: by 2002:a05:6e02:1545:b0:34f:6d6c:79bd with SMTP id
 j5-20020a056e02154500b0034f6d6c79bdmr3941622ilu.28.1695498286018; 
 Sat, 23 Sep 2023 12:44:46 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 17/27] moveconfig: Only show output when there is a reason
Date: Sat, 23 Sep 2023 13:44:06 -0600
Message-ID: <20230923194424.1739224-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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

There is no point in listing a board if everything went well. It makes it
harder to see the failures, particularly on a fast machine.

Suppress output unless something actually happened.

Drop the 'Syncing by savedefconfig' since this is selected by the -s and
is the same for all boards in this mode.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Fix 'Supress' typo

 tools/moveconfig.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 727a5d6df864..568386f7b9d0 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -551,7 +551,6 @@ class Slot:
         if not self.args.force_sync:
             self.finish(True)
             return
-        self.log += 'Syncing by savedefconfig (forced by option)...\n'
 
         cmd = list(self.make_cmd)
         cmd.append('savedefconfig')
@@ -581,12 +580,13 @@ class Slot:
                    successfully, or False when it fails.
         """
         # output at least 30 characters to hide the "* defconfigs out of *".
-        log = self.defconfig.ljust(30) + '\n'
+        if self.log:
+            log = self.defconfig.ljust(30) + '\n'
 
-        log += '\n'.join([ '    ' + s for s in self.log.split('\n') ])
-        # Some threads are running in parallel.
-        # Print log atomically to not mix up logs from different threads.
-        print(log, file=(sys.stdout if success else sys.stderr))
+            log += '\n'.join([ '    ' + s for s in self.log.split('\n') ])
+            # Some threads are running in parallel.
+            # Print log atomically to not mix up logs from different threads.
+            print(log, file=(sys.stdout if success else sys.stderr))
 
         if not success:
             if self.args.exit_on_error:
-- 
2.42.0.515.g380fc7ccd1-goog

