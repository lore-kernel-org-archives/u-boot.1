Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6340FCE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 499E4869EB;
	Sat, 23 Sep 2023 21:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L3DXBojm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B26C8694A; Sat, 23 Sep 2023 21:44:39 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52F48694A
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34fe6722847so15107175ab.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498275; x=1696103075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zO/BI6xYpSLfc3wucy8yMmyBF5aDqIIjT8bFuRYP7dg=;
 b=L3DXBojm7yQun2ZyXkxfdKf7Z3cGsrCwdMtKNEP9d6LrCsex4OfWK5itBjW4A7D9q/
 GPm2q7ktnlaD0FMLlaJseuN9CUc7EuOqe4FbV23C1qvWqa25K2k8bzChjTkCiU0PGWhR
 M7j6MNAtBTaCL9lMQ29maVRwQ8uKKfScetmGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498275; x=1696103075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zO/BI6xYpSLfc3wucy8yMmyBF5aDqIIjT8bFuRYP7dg=;
 b=gCP0slDZnDZ6PvRuHlK3Q4Swtoz+D7zVMY/wbW3tyZMvn1OD6CoUYvxyww7EW7gOy5
 OEn8IKaY9ZFRbpSQzkJSCZ2KqoN1LxenaGaVbGYSPTIHUSoFYaAiRX0tp6dLtESOiRms
 2dJFCemCYjAxqPzHLNP1MqmqGBTijUz3ys5nLpfrQG+pEw3wh22Sb8RS9Nd1Lw0C/EQv
 Jlrv7rzC8JfaonCd+SAwVetkicbsPqZv6BMyFNlPUHGxQyauS5NJn4nngA9XOFGYLXo5
 4YGPfRl+ilI69PFvf0LPNOBonXbozcos6wL6yB7JgYZOxcqYwCtVbIK14zoALsb5VysE
 Gy9Q==
X-Gm-Message-State: AOJu0YxWAiivBfE4osWG4LQvHchR/qtuP6eVcUwD5bxP1oKVLP++CUgd
 OMMidAfXGsZx1GrTT6SBAUN2WITkm5/sCztsVFM=
X-Google-Smtp-Source: AGHT+IHYbWSUGazy5ZeoyGdtz9TERCg4M/I73k3b98ndr/zXYj354LDGKxrXLZjtcvTttnHewNZJXw==
X-Received: by 2002:a05:6e02:1be3:b0:351:4af:4788 with SMTP id
 y3-20020a056e021be300b0035104af4788mr4976379ilv.15.1695498275389; 
 Sat, 23 Sep 2023 12:44:35 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 06/27] moveconfig: Drop check_defconfig() and
 update_dotconfig()
Date: Sat, 23 Sep 2023 13:43:55 -0600
Message-ID: <20230923194424.1739224-7-sjg@chromium.org>
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

These functions are not needed anymore. Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 62 ++-------------------------------------------
 1 file changed, 2 insertions(+), 60 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index a4e160005178..87a670f6e855 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -348,48 +348,6 @@ class KconfigParser:
 
         return arch
 
-    def update_dotconfig(self):
-        """Parse files for the config options and update the .config.
-
-        This function parses the generated .config and include/autoconf.mk
-        searching the target options.
-        Move the config option(s) to the .config as needed.
-
-        Args:
-          defconfig: defconfig name.
-
-        Returns:
-          Return a tuple of (updated flag, log string).
-          The "updated flag" is True if the .config was updated, False
-          otherwise.  The "log string" shows what happend to the .config.
-        """
-        updated = False
-        suspicious = False
-
-        autoconf_path = self.autoconf
-
-        dotconfig_lines = read_file(self.dotconfig)
-
-        autoconf_lines = read_file(autoconf_path)
-
-        log = ''
-
-        return (updated, suspicious, log)
-
-    def check_defconfig(self):
-        """Check the defconfig after savedefconfig
-
-        Returns:
-          Return additional log if moved CONFIGs were removed again by
-          'make savedefconfig'.
-        """
-
-        log = ''
-
-        defconfig_lines = read_file(self.defconfig)
-
-        return log
-
 
 class DatabaseThread(threading.Thread):
     """This thread processes results from Slot threads.
@@ -452,7 +410,6 @@ class Slot:
         self.parser = KconfigParser(args, self.build_dir)
         self.state = STATE_IDLE
         self.failed_boards = set()
-        self.suspicious_boards = set()
 
     def __del__(self):
         """Delete the working directory
@@ -588,20 +545,10 @@ class Slot:
 
     def do_savedefconfig(self):
         """Update the .config and run 'make savedefconfig'."""
-
-        (updated, suspicious, log) = self.parser.update_dotconfig()
-        if suspicious:
-            self.suspicious_boards.add(self.defconfig)
-        self.log += log
-
-        if not self.args.force_sync and not updated:
+        if not self.args.force_sync:
             self.finish(True)
             return
-        if updated:
-            self.log += color_text(self.args.color, COLOR_LIGHT_GREEN,
-                                   'Syncing by savedefconfig...\n')
-        else:
-            self.log += 'Syncing by savedefconfig (forced by option)...\n'
+        self.log += 'Syncing by savedefconfig (forced by option)...\n'
 
         cmd = list(self.make_cmd)
         cmd.append('savedefconfig')
@@ -611,11 +558,6 @@ class Slot:
 
     def update_defconfig(self):
         """Update the input defconfig and go back to the idle state."""
-
-        log = self.parser.check_defconfig()
-        if log:
-            self.suspicious_boards.add(self.defconfig)
-            self.log += log
         orig_defconfig = os.path.join('configs', self.defconfig)
         new_defconfig = os.path.join(self.build_dir, 'defconfig')
         updated = not filecmp.cmp(orig_defconfig, new_defconfig)
-- 
2.42.0.515.g380fc7ccd1-goog

