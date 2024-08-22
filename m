Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1936C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCE388E83;
	Thu, 22 Aug 2024 04:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RB14s4B4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B9F288DA8; Thu, 22 Aug 2024 04:56:54 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D265288E66
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-81fdaccd75eso12876039f.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295409; x=1724900209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OekkaGKVZQKSxo/jnTMrQExGWkoBXuVQhuKWvUVL2WQ=;
 b=RB14s4B4ZX6lt+OZcRGG1R1jN1lH5Kyz0DZQVmox9OV40bcTwI+dE/Cb8bX8sI3qL0
 N8rGIyf6uTbXYeGhIOF2yhIKHX9SRzhbN+TSMS4dwYLsCpJJ/9tDtsIJixQI/qAxc8+S
 xTRv2kiM9U/Zp1ox2nD3CUDL4P91vE8824p8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295409; x=1724900209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OekkaGKVZQKSxo/jnTMrQExGWkoBXuVQhuKWvUVL2WQ=;
 b=kz5vU9em8Oj5fr35E9m2X+Ql2L9JUJ+sgTWos+VRmw+Ts/fbug8YxsQ3JctN/alApQ
 kvHMjM1rMMV2VQEj+i6XfC7o1TMDOZfOsN0S93ZUAbJlBy6GgWsMh5UDuGAoDfzsKHr6
 ankg1v30GtJOr3nDfZ9Gk+4AqBv48Y20GEtfxOJ45VvCyJPSrN7RMXtkfES/O6YstrWt
 HqHTh3g5Qv8w2e9Jv5ccl3G6fdBU6bluhW8t2N6b/aeeoXL8v187qQrvO1gW179/jmzn
 cZc5TaSjK3fVYDLjYuVjA3jYJO0Ag+AcJV0wveR4BXlo9hF0cwyotb1u9Se5/f9viBD/
 SbvQ==
X-Gm-Message-State: AOJu0YzKD0yJ01qEQ4JjlVjfpQTT2vwKIZj+mIw4ssZ1p5BQUa1IzDTs
 CAq8cuHQq6C3ZEoF2fw92oSdv9s+ejSnoj7ckPOGbuDoiF4/WP+5v0jMRRpkrsmJSattI44tzF4
 =
X-Google-Smtp-Source: AGHT+IFqMOgF2IMm/461ar3T8qx6Ddxb5m8wUkdYEkHWmDUOxa9Ff5Rvp+ZBs3wwzDhCqmB6SXkZ8A==
X-Received: by 2002:a05:6e02:17c8:b0:39a:ebcd:f2fa with SMTP id
 e9e14a558f8ab-39d6c3bc305mr52894475ab.20.1724295409395; 
 Wed, 21 Aug 2024 19:56:49 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 13/19] test: Introduce lab mode
Date: Wed, 21 Aug 2024 20:56:25 -0600
Message-Id: <20240822025631.1838434-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822025631.1838434-1-sjg@chromium.org>
References: <20240822025631.1838434-1-sjg@chromium.org>
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

There is quite a bit of code in pytest to try to start up U-Boot on a
board, with timeouts, expects, etc.

This is tedious to maintain and is peripheral to the test system's
purpose. It seems better to put this logic in the lab itself, where is
can provide such support.

With Labgrid we can use the UbootStrategy class to get the board into a
useful state, however it needs to do it. Then it can report to pytest
by writing a suitable string along with the U-Boot version it detected.

Add support for detecting 'lab mode' and simply assume that all is well
in that case. Collect the version string when Labgrid says it is ready.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 68 ++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 9474fa87ec9..bcba68f0aac 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -23,13 +23,21 @@ pattern_stop_autoboot_prompt = re.compile('Hit any key to stop autoboot: ')
 pattern_unknown_command = re.compile('Unknown command \'.*\' - try \'help\'')
 pattern_error_notification = re.compile('## Error: ')
 pattern_error_please_reset = re.compile('### ERROR ### Please RESET the board ###')
-pattern_ready_prompt = re.compile('U-Boot is ready')
+pattern_ready_prompt = re.compile('{lab ready in (.*)s: (.*)}')
+pattern_lab_mode = re.compile('{lab mode.*}')
 
 PAT_ID = 0
 PAT_RE = 1
 
 # Timeout before expecting the console to be ready (in milliseconds)
-TIMEOUT_MS = 30000
+TIMEOUT_MS = 30000                  # Standard timeout
+
+# Timeout for board preparation in lab mode. This needs to be enough to build
+# U-Boot, write it to the board and then boot the board. Since this process is
+# under the control of another program (e.g. Labgrid), it will failure sooner
+# if something goes way. So use a very long timeout here to cover all possible
+# situations.
+TIMEOUT_PREPARE_MS = 3 * 60 * 1000
 
 bad_pattern_defs = (
     ('spl_signon', pattern_u_boot_spl_signon),
@@ -143,6 +151,7 @@ class ConsoleBase(object):
 
         self.at_prompt = False
         self.at_prompt_logevt = None
+        self.lab_mode = False
 
     def get_spawn(self):
         # This is not called, ssubclass must define this.
@@ -176,40 +185,69 @@ class ConsoleBase(object):
             self.p.close()
         self.logstream.close()
 
+    def set_lab_mode(self):
+        """Select lab mode
+
+        This tells us that we will get a 'lab ready' message when the board is
+        ready for use. We don't need to look for signon messages.
+        """
+        self.log.info(f'test.py: Lab mode is active')
+        self.p.timeout = TIMEOUT_PREPARE_MS
+        self.lab_mode = True
+
     def wait_for_boot_prompt(self, loop_num = 1):
         """Wait for the boot up until command prompt. This is for internal use only.
         """
         try:
+            self.log.info('Waiting for U-Boot to be ready')
             bcfg = self.config.buildconfig
             config_spl_serial = bcfg.get('config_spl_serial', 'n') == 'y'
             env_spl_skipped = self.config.env.get('env__spl_skipped', False)
             env_spl_banner_times = self.config.env.get('env__spl_banner_times', 1)
 
-            while loop_num > 0:
+            while not self.lab_mode and loop_num > 0:
                 loop_num -= 1
                 while config_spl_serial and not env_spl_skipped and env_spl_banner_times > 0:
-                    m = self.p.expect([pattern_u_boot_spl_signon] +
-                                      self.bad_patterns)
-                    if m != 0:
+                    m = self.p.expect([pattern_u_boot_spl_signon,
+                                       pattern_lab_mode] + self.bad_patterns)
+                    if m == 1:
+                        self.set_lab_mode()
+                        break
+                    elif m != 0:
                         raise BootFail('Bad pattern found on SPL console: ' +
-                                        self.bad_pattern_ids[m - 1])
+                                       self.bad_pattern_ids[m - 1])
                     env_spl_banner_times -= 1
 
-                m = self.p.expect([pattern_u_boot_main_signon] + self.bad_patterns)
-                if m != 0:
-                    raise BootFail('Bad pattern found on console: ' +
-                                    self.bad_pattern_ids[m - 1])
-            self.u_boot_version_string = self.p.after
+                if not self.lab_mode:
+                    m = self.p.expect([pattern_u_boot_main_signon,
+                                       pattern_lab_mode] + self.bad_patterns)
+                    if m == 1:
+                        self.set_lab_mode()
+                    elif m != 0:
+                        raise BootFail('Bad pattern found on console: ' +
+                                       self.bad_pattern_ids[m - 1])
+            if not self.lab_mode:
+                self.u_boot_version_string = self.p.after
             while True:
                 m = self.p.expect([self.prompt_compiled, pattern_ready_prompt,
                     pattern_stop_autoboot_prompt] + self.bad_patterns)
-                if m == 0 or m == 1:
+                if m == 0:
+                    self.log.info(f'Found ready prompt {m}')
+                    break
+                elif m == 1:
+                    m = pattern_ready_prompt.search(self.p.after)
+                    self.u_boot_version_string = m.group(2)
+                    self.log.info(f'Lab: Board is ready')
+                    self.p.timeout = TIMEOUT_MS
                     break
                 if m == 2:
+                    self.log.info(f'Found autoboot prompt {m}')
                     self.p.send(' ')
                     continue
-                raise BootFail('Bad pattern found on console: ' +
-                                self.bad_pattern_ids[m - 3])
+                if not self.lab_mode:
+                    raise BootFail('Missing prompt / ready message on console: ' +
+                                   self.bad_pattern_ids[m - 3])
+            self.log.info(f'U-Boot is ready')
 
         finally:
             self.log.timestamp()
-- 
2.34.1

