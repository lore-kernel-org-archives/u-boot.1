Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D00C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA4D380F77;
	Sun, 16 Feb 2025 21:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z5HIcZrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED04808B6; Sun, 16 Feb 2025 21:46:05 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D35810EB
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8556e24b5a1so268771839f.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738757; x=1740343557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pS/kxdkdziTZLkwap7g/lzy+YLlHFk0XgdhOoh2qlHU=;
 b=Z5HIcZrHG6uvpXPErOfjAhIWiwqa13nEm5RC7oVPe104gg0j6x8xgCXCh6Yiwoecz3
 hHOGpQGWsSN0QNrZ0JxjLsCy+T9Lu3mvS9IZiE0IsDCxBUuhES67VzMv2m6dLU2d2S3O
 Yfk+GR4+0uyiRTaRvonxQHzY7EsBzYudvVEYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738757; x=1740343557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pS/kxdkdziTZLkwap7g/lzy+YLlHFk0XgdhOoh2qlHU=;
 b=e+519PzWlLeF/Pa/r54X2gHRpl4dN7AxrKY3qZeL1TBSmOXSyuKQZy++2+fq9YxuTw
 oPYi/YZ3KENOI9+BavCCOh0AhV40uiSOV7zu/RJNX71ivkA/xvtsGuxceRzM+/dc3ENM
 AgauhiQ3ulxWzSIuXYNErLbtaRSGj31fzB8uiBAFH71KgW/OV21UWxnmx7C7B+HDbo4+
 cDrELxlQOm69J4k1DUj5WA9/BTppRRnHh7gDwJW4TUUbWGaaO3r4mODOeZbKtSHeqxva
 AyI1D5V/aR2mhxbPZuHk7rOGknFCSo8JSb6rmHfuY4a+1XmctbzNhjMJPYYf0S4rbRBG
 0QNw==
X-Gm-Message-State: AOJu0YwRtVsBhAENVq5d6HG7kr7CaApiw6EI6D8QLfkgwrvXWuFVte94
 cJ6/a1QIsWzSI7CLfMoUEi01YB+RFmEw3SRsEWKmrgbo6rhb9R/0yZue4XqoeP4rkKTK5uu7MzI
 =
X-Gm-Gg: ASbGncslFyvYHCMS+FNGSJEJTbgcjMmj4SmHRagYBLbdH3ELGrIg0efZF4A2L5QbJxc
 gGfwVaOksEVa6d4Iky77XA1gRTV8uCFpBq6XfTmgvgNmSom0Af4oD4GYRCGPknHcshZhKLjlm4/
 aaVZvySwh0PqT+wQX68P+q4diGh9VUYSDKnD2uIAXa2xtG6hiJ7N01vj5YN8ykLj1g5I/1UJ+Ck
 3lGtjnK0BwjM+aF8v9JB5aMjbJcLWRJ+WmRD3OAbZwXq+4djw3g5PSbho2MRSQpt9B5A10dSfQo
 8pcVa60WGEHThlzbnsZFihkJ2TK64DXcqF3AGTGiFwqB6eEhYf47
X-Google-Smtp-Source: AGHT+IHTEeNtnLQsXwj8YsaPN7aW5mzSdYP4lbNK9hd1/alvOrY4N4qD3MAKYWHnJvAERDiI21YNiQ==
X-Received: by 2002:a05:6602:1489:b0:855:683d:d44f with SMTP id
 ca18e2360f4ac-85579fd3e47mr566813239f.0.1739738757516; 
 Sun, 16 Feb 2025 12:45:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 27/28] RFC: test/py: Deal with timeouts
Date: Sun, 16 Feb 2025 13:44:12 -0700
Message-ID: <20250216204421.3560012-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

