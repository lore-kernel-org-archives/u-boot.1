Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466E8C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 22:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FCA87F2A;
	Thu, 25 Apr 2024 00:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D27CVcM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5BC885B2; Thu, 25 Apr 2024 00:45:44 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA3987CF8
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 00:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78edc3e80e6so21989585a.2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 15:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713998741; x=1714603541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4yEQErP2J8d+1+lhbP64VFUjzGDjbJthpfKK+C++Mgs=;
 b=D27CVcM+MtwAStNyUwLutL8UD7ZATzpK05p/DMCcM/q2toz3NpEYaShiqkrvsspAp5
 maGpegOYX/yZ9yzXHxvI/78XLF5hoM5h7tFqvC4BhVitdUhkE6nrb8fXvAw071hEZm64
 MUU4rc2WzsfkpXvKWm27hmOTP/y+7k1bLLF1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713998741; x=1714603541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4yEQErP2J8d+1+lhbP64VFUjzGDjbJthpfKK+C++Mgs=;
 b=WJzgofWwFo8NldesP5SbkMxB67GrIPLiKhTz2nwjV8uzzJFLiT6vlutwycO5E2FFll
 A+rZ3LmYY/i863vyfR/1iKNnZGptniiMuW43hjbP4/530/ok13mYiFBBoqDot448rFoc
 l8o5S2uea3PXhE2s8zWmA5yDeyvFffOvg4Wv98q0VpK4OgM6y4Bn7i45Pm4BtBS62Wyf
 zbvGiXBdb6eQL9n3PhD6TW0YW20JXUayQyPR3Spi4z1H1wgrUWU91L3k30an+xa3+gO1
 LZnFPtXQcqe1S9gfnCFs5nQik+6SvAw47o0BqKkkc0ytNjv4YPzF2QUd/2eRVHBXaxnO
 MlgQ==
X-Gm-Message-State: AOJu0YzfBRXtbdOuzTkBaJlNqVUCHF48+Knt66XwtjBod40x2vU+u6Uq
 dqo1SxOAJfAFN+jwcd8gTlWhRJyKnFTNkEh0BeyWbNVosdUr0AoV/ZW8NzEky+GodHwJrL169Bi
 seV3J/g==
X-Google-Smtp-Source: AGHT+IGy1iiPRhBjliWQX6RUKbUgBEdgoBWN6kUnpO0opnRXhMsv7xBJujrwfAKP+jwNIG4etpTQ+A==
X-Received: by 2002:a05:620a:178c:b0:78d:69c8:7a14 with SMTP id
 ay12-20020a05620a178c00b0078d69c87a14mr5342719qkb.42.1713998741100; 
 Wed, 24 Apr 2024 15:45:41 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a05620a127500b0078d75b9fb37sm6525411qkl.32.2024.04.24.15.45.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:45:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test/py: Make the number of SPL banners seen a variable
Date: Wed, 24 Apr 2024 16:45:37 -0600
Message-Id: <20240424224537.1614937-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

Currently we have the option to tell the console code that we should
ignore the SPL banner. We also have an option to say that we can see it
a second time, and ignore it. However, some platforms such as TI AM64x
will have us see the SPL banner three times. Rather than add an
"spl3_skipped" option, rework the code. By default we expect to see the
banner once, but boards can specify seeing it as many times as they
expect to.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/u_boot_console_base.py | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 26b6de07f88f..3e01be110295 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -17,7 +17,6 @@ import u_boot_spawn
 
 # Regexes for text we expect U-Boot to send to the console.
 pattern_u_boot_spl_signon = re.compile('(U-Boot SPL \\d{4}\\.\\d{2}[^\r\n]*\\))')
-pattern_u_boot_spl2_signon = re.compile('(U-Boot SPL \\d{4}\\.\\d{2}[^\r\n]*\\))')
 pattern_u_boot_main_signon = re.compile('(U-Boot \\d{4}\\.\\d{2}[^\r\n]*\\))')
 pattern_stop_autoboot_prompt = re.compile('Hit any key to stop autoboot: ')
 pattern_unknown_command = re.compile('Unknown command \'.*\' - try \'help\'')
@@ -29,7 +28,6 @@ PAT_RE = 1
 
 bad_pattern_defs = (
     ('spl_signon', pattern_u_boot_spl_signon),
-    ('spl2_signon', pattern_u_boot_spl2_signon),
     ('main_signon', pattern_u_boot_main_signon),
     ('stop_autoboot_prompt', pattern_stop_autoboot_prompt),
     ('unknown_command', pattern_unknown_command),
@@ -152,25 +150,20 @@ class ConsoleBase(object):
         """
         try:
             bcfg = self.config.buildconfig
-            config_spl = bcfg.get('config_spl', 'n') == 'y'
             config_spl_serial = bcfg.get('config_spl_serial', 'n') == 'y'
             env_spl_skipped = self.config.env.get('env__spl_skipped', False)
-            env_spl2_skipped = self.config.env.get('env__spl2_skipped', True)
+            env_spl_banner_times = self.config.env.get('env__spl_banner_times', 1)
 
             while loop_num > 0:
                 loop_num -= 1
-                if config_spl and config_spl_serial and not env_spl_skipped:
+                while config_spl_serial and not env_spl_skipped and env_spl_banner_times > 0:
                     m = self.p.expect([pattern_u_boot_spl_signon] +
                                       self.bad_patterns)
                     if m != 0:
                         raise Exception('Bad pattern found on SPL console: ' +
                                         self.bad_pattern_ids[m - 1])
-                if not env_spl2_skipped:
-                    m = self.p.expect([pattern_u_boot_spl2_signon] +
-                                      self.bad_patterns)
-                    if m != 0:
-                        raise Exception('Bad pattern found on SPL2 console: ' +
-                                        self.bad_pattern_ids[m - 1])
+                    env_spl_banner_times -= 1
+
                 m = self.p.expect([pattern_u_boot_main_signon] + self.bad_patterns)
                 if m != 0:
                     raise Exception('Bad pattern found on console: ' +
-- 
2.34.1

