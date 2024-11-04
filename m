Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF91D1CA08
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E7889035;
	Mon,  4 Nov 2024 23:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZzqBkooR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5058788D29; Mon,  4 Nov 2024 23:46:16 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEBB988FAB
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e5f9712991so2335930b6e.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 14:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730760371; x=1731365171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gsQKYlsyzZGJXcBRGgi/aCrzfwb9avdxnsCa5P0xBS4=;
 b=ZzqBkooR8uMtwZthJaHJLsJzf7O4lc3MZzyH7JZ5Y9A6mnZdWnYQ/pKG9pPTdrHbit
 GyciNqZRdVHOF0jiQJTJA+BoSyYtbScZ+HGlBWFobK6eW+G20VMpoCW8y0mCMg32K23f
 xRFprogKvRU4wKIaN6qXmXd+kBCm2NEQjRN3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730760371; x=1731365171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gsQKYlsyzZGJXcBRGgi/aCrzfwb9avdxnsCa5P0xBS4=;
 b=BaiXDW427kT+u0Fj5nUVX+L6zMn+y6Gw4k23OMY3hGwtWZ1CHAGqtM9IscUYURGeZn
 wviefwEnEjPKdHGRQoJfaLktp+Xo/VZ8JL9ak25RH7q+DaUXOgYLAU/DojVIdXysG/fe
 aNQERUtwB8VT/x2kd+4tNCIGTjaY9CYLCuykhpdE0OH5g30+SSfmLwnng+jffExdv1gl
 KmehBnIxM1Zp3EiEgRJHvCSO+NwXO5ewUk5cs0pNUJlrd66zDOdtoQvvTaAdBtv1IXAR
 Nfz3uNJn1cj99UP7ZwzfurMF+g2IML28ZnZq41BmxWcal8ZxFWzNGiy746PjVGwafH4i
 CUYQ==
X-Gm-Message-State: AOJu0Yz5CFGNhFnDEyeNU5yBXsU251SIZ5LXIjGd0tFjrz6m/IHOopFN
 QJ6XuUY7mugvGBFHAENNpIKBubb0Shzq61I1wh3ZvtdgBxN23j4J+RyNcpDy2/EU12oBX57sbVQ
 =
X-Google-Smtp-Source: AGHT+IGNm1CgCcvesAEZoA9v35pkzLO62esWEbfUOInavDAx5sc2oo0dIpHQCtQ2Hy8+2v8pmGKCCA==
X-Received: by 2002:a05:6808:23c9:b0:3e5:dba3:2480 with SMTP id
 5614622812f47-3e758c5a8a2mr12033831b6e.15.1730760371643; 
 Mon, 04 Nov 2024 14:46:11 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a97b009csm25535945ab.4.2024.11.04.14.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:46:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v8 05/11] test: Introduce lab mode
Date: Mon,  4 Nov 2024 15:45:32 -0700
Message-ID: <20241104224550.677442-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104224550.677442-1-sjg@chromium.org>
References: <20241104224550.677442-1-sjg@chromium.org>
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
index 311e649d55b..573d76dd832 100644
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
2.43.0

