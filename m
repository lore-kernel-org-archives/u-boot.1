Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43002C25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 07:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFE5870B4;
	Wed, 25 Oct 2023 09:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lxUJ1BjT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F9A18716C; Wed, 25 Oct 2023 09:25:36 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC1E86FE2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 09:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so7943238a12.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 00:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218733; x=1698823533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fbU+2yr6L/fmyx0oqKAB4VS1Is66G/S7LiZOcoQnnPI=;
 b=lxUJ1BjTBZijBBZo1PcjzDHj4G9nqbb0OKh6k1SFX5N3UyUlL/hpyDZEy8SmSc/AyO
 8TuGX4xf71c60TAfwAH5/1UKM4briEx/PNrdU4It8xV+4HjqLrllIm40qWWIx8cYKjCy
 r6QbyQU2Q5PPHaskdajl2wO+ipNxiBPBmXjnTgtpu+GNfhHWvuVaHkdXng66FuuUhjeO
 /8CsNJ4sia6PmjmclQch/fbJgHYRN+Jv7S8MKh2rtpkdyILEBipX8iX68hrFieK0eGyG
 3ngNLpKiq0Pglh3VfPgYaby8/7DD+uAGe0dVtyOG02N/xLQHWD86f8IoY6Dp3E9yqiUD
 K+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218733; x=1698823533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fbU+2yr6L/fmyx0oqKAB4VS1Is66G/S7LiZOcoQnnPI=;
 b=qV46DIa5BNmhhsnuhB/CcmXHhfzn/yYlqgHxwX97uHZxde//iFVd94QXKNUz51wBT7
 Y4jd72Rf9jiw/xVt3IlS+Jrt6aRZKElsHycpU348cxZx+yn9hDcycZgc4SnbZ7L5CMBp
 qkfBntoTmbdyAWJt5TrAR6eIsJCniw9yxW+KSalMwqLLQUWuMoGg8LKU1e0TkTeCoxs4
 JjpKDkBvdugIlqFwILzbYDu8DEVzXo3t6A6wi9xwaNNYUR573s7hNm71CF+8wzfYklZ3
 eZnA5H1fsNAerzojAjQ0qOBKZi2dHA5MVG0O3y0vtBkw/mMSMF6XSRa5FNMamS5h6UaC
 amWA==
X-Gm-Message-State: AOJu0YzplrznXgRBLTQBIapkSv9ONSXN+TZpwYHPVdPr3Y28N25tpTT8
 n62IVCWS3vvFAeO/oq18TMUR8vpmnBFJJasroHChAA==
X-Google-Smtp-Source: AGHT+IE0hdAUmlEJIBNJgQKaE0dUoc/Md7ecObuu2JOO0SjMhuoUtz7KokZGkPfMd0MErOHuQ3/Ukg==
X-Received: by 2002:a50:d596:0:b0:53f:b9d2:d019 with SMTP id
 v22-20020a50d596000000b0053fb9d2d019mr10674471edi.11.1698218733162; 
 Wed, 25 Oct 2023 00:25:33 -0700 (PDT)
Received: from hades.. (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 cn10-20020a0564020caa00b0053e8f1f79afsm9030363edb.30.2023.10.25.00.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:25:32 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH] test/py: always use autostart on tpm2 selftests
Date: Wed, 25 Oct 2023 10:25:25 +0300
Message-Id: <20231025072525.3960316-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
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

commit 789ed2784256 ("test/py: replace 'tpm2 init, startup, selftest' sequences")
changed some of the tpm2 init sequences to 'tpm2 autostart' instead of
calling 'tpm init', 'tpm startup TPM2_SU_CLEAR', 'tpm2 self_test full'.

The autostart command calls the afforementioned sequence and on top of
that deals with the 'tpm2 init' return codes if the tpm is already
started. Since we initialize the tpm from various subsystems now,
replace the last remaining instances of 'tpm2 init' with 'tpm2
autostart'.  Since the latter calls 'tpm2 init' anyway we will still be
implicitly testing the validity of that command

It's worth noting that since 'tpm2 autostart' performs the startup and
self tests sequences of the tpm we could drop
'test_tpm2_sandbox_self_test_full' and 'test_tpm2_startup, but let's
keep the since they test tpm commands and options

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_tpm2.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index 47392b87a98f..1d654cd4a23b 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -61,7 +61,7 @@ def test_tpm2_init(u_boot_console):
     skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
     if skip_test:
         pytest.skip('skip TPM device test')
-    u_boot_console.run_command('tpm2 init')
+    u_boot_console.run_command('tpm2 autostart')
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
 
@@ -100,7 +100,7 @@ def test_tpm2_sandbox_self_test_full(u_boot_console):
     """
     if is_sandbox(u_boot_console):
         u_boot_console.restart_uboot()
-        u_boot_console.run_command('tpm2 init')
+        u_boot_console.run_command('tpm2 autostart')
         output = u_boot_console.run_command('echo $?')
         assert output.endswith('0')
 
-- 
2.37.2

