Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EAAC282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91AFA81E5D;
	Thu,  6 Mar 2025 17:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JZgHT6po";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934CD81DFA; Thu,  6 Mar 2025 17:06:30 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39BE981E47
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-855184b6473so58611139f.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277186; x=1741881986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pS/kxdkdziTZLkwap7g/lzy+YLlHFk0XgdhOoh2qlHU=;
 b=JZgHT6poKiedKMih5dfOp7j/CeTaX+MKSPdPR6R7ERHW5FQsUdbchD69gOvmK4Ae+K
 sNxFSG/WdyeTYejY17SJtzFf9gSaJ105pTmDYUTMEDXpMZie3SSILrTO4HitsymbZqDs
 QGFT00VcGo0jFQuBcPSbgeYVqeRyOcSMhEHJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277186; x=1741881986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pS/kxdkdziTZLkwap7g/lzy+YLlHFk0XgdhOoh2qlHU=;
 b=hsAhrJzRAkWH8nOjRrIYq2/RKzj+X4sa0IRw3mJI3PIKRUhqsrXOUq/OStpf3VHIHc
 fb4DCb6FO8CYXCoIwhYYijZMN0Bk0RzrR/gy9g7myTuu/gftatDq8Dr8XU4jpzntq31B
 N4ig0NhDu+Im4VbgylgFXzYJoj/7QsAsEZQm4469Z9d/Hqc4OYmGDwwgdI1pv2MUwS4t
 R5esg7Q6jmg8lGK88ku9hT7b1f0PGnCl42wPTfY58bD2Ovou4etYI0jJulAuPZVopf2D
 Ng9MWYQg94qexRUT8C5id7OxqOhQhrLcuYxYubEdetYcvCFcLgMxCODxK5vhWJDZW31n
 kQKg==
X-Gm-Message-State: AOJu0YyWuLX4bSUUgnpN0FA3aAZ9SOwFMmySUKhKt2EENsDe9zzOZX8w
 OaPVJoEx2u1Kzs8wiBKvufr7heRVRE7a8iPyqoYDY3RlY+1gRZVKTKjOHi6phmPeRJc+9iUXGsk
 =
X-Gm-Gg: ASbGncvi8yHaGMewlI2+9Z4yPlWm1fxltWBut5gG6h1bkGVJyKwauQoIGCsmMqrM4dT
 xd6xPiruM3Gilkp3RnTb48e/Bdl4ReZvCX0Mx5xtPGtc4LXFj/40YNb2VtYqX1PaGd9Np3Mhrd/
 +u0mKGsEXtIZNLx7i1dr0d5mMSZ1HwQHTFDwYwiZTM95iKW6duTVzdfHb6leZ25teHe33J6Ihvo
 bZIDAoUTZTTT1Vqt7vb63l62XSo6THsVNxuKmxVpyZt2EDMpGcVYCrAKnYPcfSAakl+DSPitxBA
 C9VIg0RyaJgFmC0ujCLWre9F10qT5xbjNU8Cab6T3beItDFXMZvKTuTqk5LUwMJbf4/jipOtt7h
 O0ZYG+A==
X-Google-Smtp-Source: AGHT+IENYrDOsKnQ0rwBHo2lFzccyGJww3HK7TUt3A4rZWaH6KW3Ois1WhrcDn4iUEQ8DIR5yG3Qjg==
X-Received: by 2002:a05:6602:3990:b0:85a:fff8:65ec with SMTP id
 ca18e2360f4ac-85b1ce5e802mr15599039f.0.1741277186339; 
 Thu, 06 Mar 2025 08:06:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:06:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 46/47] RFC: test/py: Deal with timeouts
Date: Thu,  6 Mar 2025 09:04:13 -0700
Message-ID: <20250306160428.3041057-47-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

