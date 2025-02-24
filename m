Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBE5C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0354080FA6;
	Tue, 25 Feb 2025 00:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kszjTApX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 589E78144F; Tue, 25 Feb 2025 00:08:32 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F5980FA6
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d2f7257181so2887535ab.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438508; x=1741043308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pS/kxdkdziTZLkwap7g/lzy+YLlHFk0XgdhOoh2qlHU=;
 b=kszjTApXmxw0SA3azCnaXKVc/eq7UoBpe+KYuYZtIce0mFwAcgeI8/rCvrivg78/yV
 WaThN1gx4WY99dmFcUKCuEz8pz1CW3jyMnrpmM9x+Z6HejrRjLJwc15BZj5jiOX9sHZc
 7Lw63DcfvAj1CYHOe7C/YQce9qK1Kn5pwVVkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438508; x=1741043308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pS/kxdkdziTZLkwap7g/lzy+YLlHFk0XgdhOoh2qlHU=;
 b=OWe502V2qegAXmTeb5fUseb05dHVMXfBv3BhMXRNXjghU1XPQnyD6G/RUGXTv5DDqE
 IlcRK6qb8DBDkePeEJ5rCO03dqtrEVB0CO87BDnidRAePDRHkJqEhGlJUFEaFwq0GYng
 09ISGeU3ZohXqe8KVh7RWfu7InsFMYqa21ZxZc1HJF7RYJK0FedK5fdsWurasUYA+NG8
 rq8FJVOOdcGfIRwKv4yC1yRxk8U9hgyA4XUK+CFJO2V9BEw2sgp1ROJwRNMF5DG/KY/F
 t2cY5v9tL8tVYQJE1JUwr2O6yQGyhlnIY5GBBuFHGXXvx7nNI+0ZxrtPfXTo1rtcGu7s
 K4yQ==
X-Gm-Message-State: AOJu0YzPC4ORxVbPbvfCVQ9AnbAGhTutmt7NW8/LTun3CbgEX2SSm2X9
 i2glKDTmxy62WIgqKdEdAtQLkn37fg27DG+YGCpJjUD4CTKskhFxqCg/eTbqNBh7EeCFoaDHx2w
 =
X-Gm-Gg: ASbGncukMIH415cioARxd6yyeOs4Xm/JcSgHsddkA5v0Y+iTlsfcezCT6TLGrQc2I6t
 L/5kEUzPEfEXSJ+1zyZYSBKEyNkGfD+b5K79k1ER97ngevKE2eeNOYeGB4PIGzClOTHRhfOakFz
 bxX1MMH8xC0UxNOnkShJBDYQQvXngBBkJaEFx21eyeOciZM/jHYD9zgTDzAOx6GGfNQjmY+IaG2
 KkpdzDDAGqjktO4VW5uyMbIQbw3GIWt5NPc3oyNYuZBMe6d88tmsPRhviI/PRa9Wpqw4xVdDL1D
 ZELbBrsQaVnM409DAKO98fel/ll/62WajPsYJcWfB2ggN1bvJ4McVQu0OlL8/+U=
X-Google-Smtp-Source: AGHT+IEwcMGAHLJEpBoeR+BjDd+TEa2XW8cCXOC1ajYfjRGKUbNezcwcSVCbxgfIjgDhbbpMTXsCpw==
X-Received: by 2002:a05:6e02:160c:b0:3d1:9999:4f62 with SMTP id
 e9e14a558f8ab-3d2cae4a741mr130475035ab.2.1740438508231; 
 Mon, 24 Feb 2025 15:08:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 43/44] RFC: test/py: Deal with timeouts
Date: Mon, 24 Feb 2025 16:06:32 -0700
Message-ID: <20250224230640.2665206-44-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

The distro test takes a little longer to shut down and restart, so
add more time to this operation.

Disable the sleep command for now, as it seems to be unreliable on
QEMU with '-cpu host'.

More thought will be needed for both of these problems.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/console_base.py     | 8 ++++----
 test/py/tests/test_sleep.py | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/test/py/console_base.py b/test/py/console_base.py
index 073ab0462dc..6d0f56f841d 100644
--- a/test/py/console_base.py
+++ b/test/py/console_base.py
@@ -464,7 +464,7 @@ class ConsoleBase(object):
         finally:
             self.p.timeout = orig_timeout
 
-    def ensure_spawned(self, expect_reset=False):
+    def ensure_spawned(self, expect_reset=False, timeout=None):
         """Ensure a connection to a correctly running U-Boot instance.
 
         This may require spawning a new Sandbox process or resetting target
@@ -485,7 +485,7 @@ class ConsoleBase(object):
             # Reset the console timeout value as some tests may change
             # its default value during the execution
             if not self.config.gdbserver:
-                self.p.timeout = TIMEOUT_MS
+                self.p.timeout = timeout or TIMEOUT_MS
             return
         try:
             self.log.start_section('Starting U-Boot')
@@ -496,7 +496,7 @@ class ConsoleBase(object):
             # future, possibly per-test to be optimal. This works for 'help'
             # on board 'seaboard'.
             if not self.config.gdbserver:
-                self.p.timeout = TIMEOUT_MS
+                self.p.timeout = timeout or TIMEOUT_MS
             self.p.logfile_read = self.logstream
             if self.config.use_running_system:
                 # Send an empty command to set up the 'expect' logic. This has
@@ -544,7 +544,7 @@ class ConsoleBase(object):
     def restart_uboot(self, expect_reset=False):
         """Shut down and restart U-Boot."""
         self.cleanup_spawn()
-        self.ensure_spawned(expect_reset)
+        self.ensure_spawned(expect_reset, 60 * 1000)
 
     def get_spawn_output(self):
         """Return the start-up output from U-Boot
diff --git a/test/py/tests/test_sleep.py b/test/py/tests/test_sleep.py
index f1bf34e05b2..2285a815813 100644
--- a/test/py/tests/test_sleep.py
+++ b/test/py/tests/test_sleep.py
@@ -19,6 +19,7 @@ env__sleep_margin = 0.25
 
 """
 
+@pytest.mark.role('!qemu-x86_64')
 def test_sleep(ubman):
     """Test the sleep command, and validate that it sleeps for approximately
     the correct amount of time."""
-- 
2.43.0

