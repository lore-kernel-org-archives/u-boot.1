Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1832F36C51
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 08:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 280FB842A4;
	Mon, 20 Apr 2026 10:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="f6zDL1Uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A7A58426E; Mon, 20 Apr 2026 09:49:29 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474CC83693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DF83F3F129
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776671366;
 bh=8ZwmdDQep1SdIjUDi9MdmGUbTqoIvotlY/qyRLmOGzY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=f6zDL1UuLtuP8u94cmOL63A23ea/ULQiJMkHWbpnOp4ah8tbu8XrKl99Q6NDlHgMg
 KicIOxGLIs9xnK4ul0Zt/mQYo75f8A7dJZZDldrbDccYaGNCRZ+N5dLyurnwu7aCtI
 zZ2quEgjwcylMqaj6/638Sgv5bF1xhFrbSSHEACDy+Dq4BBLAJD2Nppk9IrSGNsEs5
 X0J9I97iNCCg/1drXPt/dU2gnm9Km5Cx9PkJCqArrF/G2fFzxXfG5Kpo8r1AJ+oewe
 lHwdc9wju0oacrsPN3Yj/5ZgLTRbe78fjoQ17HVQ6qClGPBc79EEF1VBO+vwKG8xfb
 iFKheUfvJ25RWIR1R2Mew3+U2u4w8rvtl9NjnBvIMKJHkOMmWptDY/5Omk6ag6+Dv6
 e5LVBsXlYRSah4UR7ieBtAxZlfYJESajDHNJIL4bsvmHLuMkBIE/nuHbGv2v5Gyi46
 rYZNPFMoHnigq+OsrDL6b/kTkxYglDkpOV+PyvC4UaRX17l8QGSDLL/86pz0ntJuGn
 Q9dUQ6Us/LmILlifp3Pf6qe5oz3+07e7NOTioXTSpDKOpYhvzLjpQ6OK+N+zKn7RSK
 fUbBtyu2eKcWmX/AAbGtu2Er+O0QE/Twj/6GyM49s7tlBHDRuJMhve8EHrouuHjWgN
 6KwYpmcrYWChwo9z+umR3qnE=
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f0f2b2641so2014417b3a.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 00:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776671365; x=1777276165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZwmdDQep1SdIjUDi9MdmGUbTqoIvotlY/qyRLmOGzY=;
 b=EGzeWM0D9ERNThTYXBIEUKRP8o4dIGk0KKFtcoemVrPvpeQ8UwTtnFeGWCkkakgVej
 D/Lp/w5mAITrUskT2Km8xQ2FSNaZnF1gTdsHmrBMxmCreg8HCUa0Y96jmASfksx57dd8
 ToHMHxoZsyppuwiKlNTFy5N74qMAO1qHCjnMjmvWKzIpF0ZhEiWs+ITbzhZEngIXy9SP
 5VeQvzf8EPt6g1oi2jfseSDtdWVHoJGtTYV0g0sh/cj7cAXqUSnxomqEpo8+Uxp/8sJt
 ANatnXZPVA2nNaNF2e1oOwUIEDqZFiMLH/2QBWQMMov29vv+HQBjKqWD3evmR7Urb1Wz
 XuQw==
X-Gm-Message-State: AOJu0YyhdIuC5wOCaoYfxAp9RJ5pHzM5svJ832up1MOy4utHCtrhECIc
 GIYKEhFR8ToxU5202p8zVH3KTsf9AzIZdqGuW0QLSY0oA1bHfO03GaVjhxOQ6gbbdfNXvXs7xOg
 pvmPIt/WdTiAYlxfaJp+KuWxzipXv4nRqcYqOHtgPfSnhN5OOTXPUV7ILw80xY49iyNi6fc48fW
 8yvIM=
X-Gm-Gg: AeBDietFKvvEM/wETyl6V4n++MLkAS8IvjRTdh45TMx7FMvuOEKqxOKFDROrWLbFBBT
 A6+RfgtEh51Q1kh9lyKS7aWJDil0aBoJC6kxxB5BKnhx3DNu+L1aKRsFwN4lDqqVenivZTYHJCP
 MCB7mxq1zQRQR72QcOD74cGIKmPL/Ay1H26yOVCg036RGnQfMyZpSOO8pTkv/hYHz3J5TVbuzRt
 3F8UcdltzwuFj6YxVVIQBUsjjSa/x8uwacnuZyoxEmNqMySI9YKdqCDWEVOqoae7oiGxJww5Eff
 Vnb/LEkgNQFGTs20034lYFc16GpLZ7BkKeXQgbbc+aXWZXEmA/zjIrHJc01gpjuQ/UACs62u8Kq
 l4SROqUVRGgG3HVwfE5HQ8W0MM77Y4UrTvPzw0rytzO/rppr6ojqRjrbGfZK7L7+zWDaPF0F1te
 Sx3nVmxtc=
X-Received: by 2002:a05:6a00:1956:b0:824:afe1:f7e3 with SMTP id
 d2e1a72fcca58-82f8c82bc5fmr13716621b3a.15.1776671364962; 
 Mon, 20 Apr 2026 00:49:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:1956:b0:824:afe1:f7e3 with SMTP id
 d2e1a72fcca58-82f8c82bc5fmr13716586b3a.15.1776671364347; 
 Mon, 20 Apr 2026 00:49:24 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981a0asm10134077b3a.3.2026.04.20.00.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 00:49:23 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] test: fit: Use shared make_fname from fit_util
Date: Mon, 20 Apr 2026 07:48:05 +0000
Message-ID: <20260420074827.3917463-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 10:08:02 +0200
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

test_fit.py declares a local make_fname closure that is byte-identical
to fit_util.make_fname. Drop the local copy and call the shared helper
at all seven call sites so there is one definition to maintain.

No behavioural change. Both implementations return
os.path.join(ubman.config.build_dir, basename).

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit.py | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 619f73153a0..3b60f814c85 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -119,16 +119,6 @@ host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('dtc')
 def test_fit(ubman):
-    def make_fname(leaf):
-        """Make a temporary filename
-
-        Args:
-            leaf: Leaf name of file to create (within temporary directory)
-        Return:
-            Temporary filename
-        """
-        return os.path.join(ubman.config.build_dir, leaf)
-
     def filesize(fname):
         """Get the size of a file
 
@@ -156,7 +146,7 @@ def test_fit(ubman):
         Returns:
             Filename of ramdisk created
         """
-        fname = make_fname(filename)
+        fname = fit_util.make_fname(ubman, filename)
         data = ''
         for i in range(100):
             data += '%s %d was seldom used in the middle ages\n' % (text, i)
@@ -265,12 +255,12 @@ def test_fit(ubman):
         ramdisk = make_ramdisk('test-ramdisk.bin', 'ramdisk')
         loadables1 = fit_util.make_kernel(ubman, 'test-loadables1.bin', 'lenrek')
         loadables2 = make_ramdisk('test-loadables2.bin', 'ksidmar')
-        kernel_out = make_fname('kernel-out.bin')
-        fdt = make_fname('u-boot.dtb')
-        fdt_out = make_fname('fdt-out.dtb')
-        ramdisk_out = make_fname('ramdisk-out.bin')
-        loadables1_out = make_fname('loadables1-out.bin')
-        loadables2_out = make_fname('loadables2-out.bin')
+        kernel_out = fit_util.make_fname(ubman, 'kernel-out.bin')
+        fdt = fit_util.make_fname(ubman, 'u-boot.dtb')
+        fdt_out = fit_util.make_fname(ubman, 'fdt-out.dtb')
+        ramdisk_out = fit_util.make_fname(ubman, 'ramdisk-out.bin')
+        loadables1_out = fit_util.make_fname(ubman, 'loadables1-out.bin')
+        loadables2_out = fit_util.make_fname(ubman, 'loadables2-out.bin')
 
         # Set up basic parameters with default values
         params = {
-- 
2.43.0

