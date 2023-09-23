Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301C0CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38DF186BA8;
	Sat, 23 Sep 2023 21:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TBfXffAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95BF8694A; Sat, 23 Sep 2023 21:44:50 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E12586B70
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3510ad5b542so11863765ab.2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498285; x=1696103085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/r1Dzypa5hiAtM3gE2ZAe7ZTybrq7qunLMqjKUte+Co=;
 b=TBfXffAMp/lv2JzOBovg5G1TcP5ZCbKABqeKuW6EPrrS/yjUoqqRsbSk0SBrcJUO8D
 HseLWpBl3bFPAFbg8+aaAVWppxPlC2STh5gkSy6Q43oFeIr37yikpGi2lnUOkD80S6Zz
 95KMWWfP60pyvL8u1pbQLHfxO36BUV2lFEAHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498285; x=1696103085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/r1Dzypa5hiAtM3gE2ZAe7ZTybrq7qunLMqjKUte+Co=;
 b=kO1LkyN0YUyuaJYMgaIAxpxVBXjFvcEmY05kyDQTtWlgtrRdnYpjfvauzBmX+44Lb8
 +Ku9ullyQ06LC8aKkrXRzcKb4pk1goto8GD61fIaiWrUqUOMgVENaP7P66+KvgrJnsl9
 PPCNuS6fh3CCxqas4ADvh6M9TkX6Z8AsBGZp4KARmA6x+m8w/qgm2lFm149aK9ghnscB
 keXJJ/Wz95vkDyJhB7+vCWAHclUAm04uqC8hurgpwuDfx0EcZZtOpvw/nvPEe94JD5VN
 33cDKt9K/iuOnqziaRi6SyIl5hzuZS3ObcpsRTvZrfETJqmDefRwGZNbAkrbb++GI3FY
 kszw==
X-Gm-Message-State: AOJu0Yyud2x4T3e7trHJfmHJZElbrXe/WwMeCoYSq4sUQZVsKRMZPHJz
 7J/uePfyPqlFyFnT3W+fW8RslkMAxu3bgGkUPkE=
X-Google-Smtp-Source: AGHT+IEhYQwhfKzgsr0CxFkV8ITPgpdpozyGt4XQzHPPQP16BBa99YahWu7cKGIkXfnOmFPrWOXkug==
X-Received: by 2002:a92:cd8d:0:b0:351:1d2f:5f99 with SMTP id
 r13-20020a92cd8d000000b003511d2f5f99mr4168168ilb.26.1695498284981; 
 Sat, 23 Sep 2023 12:44:44 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 16/27] moveconfig: Fix misc pylint warnings
Date: Sat, 23 Sep 2023 13:44:05 -0600
Message-ID: <20230923194424.1739224-17-sjg@chromium.org>
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

Fix various remaining pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 9b716596956b..727a5d6df864 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -233,8 +233,7 @@ def read_file(fname, as_lines=True, skip_unicode=False):
         try:
             if as_lines:
                 return [line.rstrip('\n') for line in inf.readlines()]
-            else:
-                return inf.read()
+            return inf.read()
         except UnicodeDecodeError as exc:
             if not skip_unicode:
                 raise
@@ -426,7 +425,7 @@ class Slot:
         If the subprocess is still running, wait until it finishes.
         """
         if self.state != STATE_IDLE:
-            while self.proc.poll() == None:
+            while self.proc.poll() is None:
                 pass
         shutil.rmtree(self.build_dir)
 
@@ -471,7 +470,7 @@ class Slot:
         if self.state == STATE_IDLE:
             return True
 
-        if self.proc.poll() == None:
+        if self.proc.poll() is None:
             return False
 
         if self.proc.poll() != 0:
@@ -494,7 +493,7 @@ class Slot:
         else:
             sys.exit('Internal Error. This should not happen.')
 
-        return True if self.state == STATE_IDLE else False
+        return self.state == STATE_IDLE
 
     def handle_error(self):
         """Handle error cases."""
@@ -521,13 +520,13 @@ class Slot:
 
         arch = self.parser.get_arch()
         try:
-            toolchain = self.toolchains.Select(arch)
+            tchain = self.toolchains.Select(arch)
         except ValueError:
             self.log += color_text(self.args.color, COLOR_YELLOW,
                     f"Tool chain for '{arch}' is missing.  Do nothing.\n")
             self.finish(False)
             return
-        env = toolchain.MakeEnvironment(False)
+        env = tchain.MakeEnvironment(False)
 
         cmd = list(self.make_cmd)
         cmd.append('KCONFIG_IGNORE_DUPLICATES=1')
@@ -1004,7 +1003,7 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
                             # skip imply_config because prev is a superset
                             skip = True
                             break
-                        elif count > prev_count:
+                        if count > prev_count:
                             # delete prev because imply_config is a superset
                             del imply_configs[prev]
                 if not skip:
@@ -1540,7 +1539,7 @@ doc/develop/moveconfig.rst for documentation.'''
 
     if args.scan_source:
         do_scan_source(os.getcwd(), args.update)
-        return
+        return 0
 
     if not any((args.force_sync, args.build_db, args.imply, args.find)):
         parser.print_usage()
@@ -1570,11 +1569,11 @@ doc/develop/moveconfig.rst for documentation.'''
                 imply_flags |= IMPLY_FLAGS[flag][0]
 
         do_imply_config(configs, args.add_imply, imply_flags, args.skip_added)
-        return
+        return 0
 
     if args.find:
         do_find_config(configs)
-        return
+        return 0
 
     # We are either building the database or forcing a sync of defconfigs
     config_db = {}
@@ -1610,6 +1609,8 @@ doc/develop/moveconfig.rst for documentation.'''
                 for config in sorted(configs.keys()):
                     outf.write(f'   {config}={configs[config]}\n')
                 outf.write('\n')
+    return 0
+
 
 if __name__ == '__main__':
     sys.exit(main())
-- 
2.42.0.515.g380fc7ccd1-goog

