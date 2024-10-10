Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE4BCEDDA3
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 00:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F8A88EE6;
	Thu, 10 Oct 2024 02:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JY6Xplhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210F688E65; Thu, 10 Oct 2024 02:29:26 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E1F788AE4
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 02:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-710f388621fso235242a34.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 17:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728520162; x=1729124962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17tC4QrjgwdjLY0xnQIIBSN7j7r0pb7I13sqJTduxvY=;
 b=JY6Xplhq/Ed9WUuheWGJNj/RfpGVDqRw7oz8xSMcgFyMXPq1XolU5tckr3AVvcLaY4
 Rvy3eUa7Rfw4jxPickq4B/gstSNthF9fo4G1O51g1Y8u2pe0C4ljqKCh63t2XFgF1+Bv
 b4JwuN+VdSDjR9neSAj4ysn/Kt4L0oH7q0bZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728520162; x=1729124962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17tC4QrjgwdjLY0xnQIIBSN7j7r0pb7I13sqJTduxvY=;
 b=T3NQ+E0J0p9ZXOmTjpFCyF/qX14qfqrhFYmBcTRI46xBgP20/dxoo7bsxqQkJTGgD1
 whKcLBO1zVpdXYpeK5v1Mp6w5bF0TE2hmDW0bgfBbR15E1OE5X03YxuRRCK8al2gcxPE
 Ppv5NGOge456p1bCY/JiwpdUX4+Sg9Zo1tvtk9HghBUrGB3HbCcccB53DclOIXBgSL9N
 EHXn4X/yMOyhQb6lUJYBcUKYC2HMupZ5Hb/4rgnZA9DB6K8M2sCyWE70t8Ry2OBzuGAx
 fmn/GSRUwxxwqield2cUoT2F876f/OUOP+/WLZUXMf7ny1BOqc6H5Ov83VRgYBtedMU5
 dR/g==
X-Gm-Message-State: AOJu0YwQ1jMN5QAZQm381FwsSQ2Bk9bo2SNjPLFIiJN4K6ARoyjkRj0l
 09wkcUIx3kR7sRSRjYAi2DMy/8eWTS449BF1zsStY42pI0P2fGTMQsM0p/r9di0dCbyp/BuUv6I
 i56BM
X-Google-Smtp-Source: AGHT+IEgVuMYbQnNkX0iIpRHjcZOjkbI8plAoC6naPplSP1aQTq7SkzfKbrz+caux705tW38yOyuCw==
X-Received: by 2002:a05:6830:6d11:b0:716:a3d9:bdfe with SMTP id
 46e09a7af769-716a4214e61mr3690497a34.22.1728520162095; 
 Wed, 09 Oct 2024 17:29:22 -0700 (PDT)
Received: from chromium.org (c-73-153-3-119.hsd1.co.comcast.net.
 [73.153.3.119]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-717cfed7536sm9073a34.2.2024.10.09.17.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 17:29:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v7 5/8] test: Separate out the exception handling
Date: Wed,  9 Oct 2024 18:29:02 -0600
Message-ID: <20241010002907.19383-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010002907.19383-1-sjg@chromium.org>
References: <20241010002907.19383-1-sjg@chromium.org>
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

The tests currently catch a very broad Exception in each case. This is
thrown even in the event of a coding error.

We want to handle exceptions differently depending on their severity,
so that we can avoid hour-long delays waiting for a board that is
clearly broken.

As a first step, create some new exception types, separating out those
which are simply an unexpected result from executed a command, from
those which indicate some kind of hardware failure.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Fix 'board' typo

 test/py/u_boot_console_base.py | 26 ++++++++++++++------------
 test/py/u_boot_spawn.py        | 11 +++++++++++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 4d6cf3f95a4..0be6c760206 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -14,6 +14,7 @@ import pytest
 import re
 import sys
 import u_boot_spawn
+from u_boot_spawn import BootFail, Timeout, Unexpected
 
 # Regexes for text we expect U-Boot to send to the console.
 pattern_u_boot_spl_signon = re.compile('(U-Boot SPL \\d{4}\\.\\d{2}[^\r\n]*\\))')
@@ -189,13 +190,13 @@ class ConsoleBase(object):
                     m = self.p.expect([pattern_u_boot_spl_signon] +
                                       self.bad_patterns)
                     if m != 0:
-                        raise Exception('Bad pattern found on SPL console: ' +
+                        raise BootFail('Bad pattern found on SPL console: ' +
                                         self.bad_pattern_ids[m - 1])
                     env_spl_banner_times -= 1
 
                 m = self.p.expect([pattern_u_boot_main_signon] + self.bad_patterns)
                 if m != 0:
-                    raise Exception('Bad pattern found on console: ' +
+                    raise BootFail('Bad pattern found on console: ' +
                                     self.bad_pattern_ids[m - 1])
             self.u_boot_version_string = self.p.after
             while True:
@@ -206,13 +207,9 @@ class ConsoleBase(object):
                 if m == 1:
                     self.p.send(' ')
                     continue
-                raise Exception('Bad pattern found on console: ' +
+                raise BootFail('Bad pattern found on console: ' +
                                 self.bad_pattern_ids[m - 2])
 
-        except Exception as ex:
-            self.log.error(str(ex))
-            self.cleanup_spawn()
-            raise
         finally:
             self.log.timestamp()
 
@@ -278,7 +275,7 @@ class ConsoleBase(object):
                 m = self.p.expect([chunk] + self.bad_patterns)
                 if m != 0:
                     self.at_prompt = False
-                    raise Exception('Bad pattern found on console: ' +
+                    raise BootFail('Bad pattern found on console: ' +
                                     self.bad_pattern_ids[m - 1])
             if not wait_for_prompt:
                 return
@@ -288,14 +285,18 @@ class ConsoleBase(object):
                 m = self.p.expect([self.prompt_compiled] + self.bad_patterns)
                 if m != 0:
                     self.at_prompt = False
-                    raise Exception('Bad pattern found on console: ' +
+                    raise BootFail('Missing prompt on console: ' +
                                     self.bad_pattern_ids[m - 1])
             self.at_prompt = True
             self.at_prompt_logevt = self.logstream.logfile.cur_evt
             # Only strip \r\n; space/TAB might be significant if testing
             # indentation.
             return self.p.before.strip('\r\n')
-        except Exception as ex:
+        except Timeout as exc:
+            self.log.error(str(exc))
+            self.cleanup_spawn()
+            raise
+        except BootFail as ex:
             self.log.error(str(ex))
             self.cleanup_spawn()
             raise
@@ -354,8 +355,9 @@ class ConsoleBase(object):
             text = re.escape(text)
         m = self.p.expect([text] + self.bad_patterns)
         if m != 0:
-            raise Exception('Bad pattern found on console: ' +
-                            self.bad_pattern_ids[m - 1])
+            raise Unexpected(
+                "Unexpected pattern found on console (exp '{text}': " +
+                self.bad_pattern_ids[m - 1])
 
     def drain_console(self):
         """Read from and log the U-Boot console for a short time.
diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 69a2cd55816..bcba7b5cd43 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -16,6 +16,17 @@ import traceback
 class Timeout(Exception):
     """An exception sub-class that indicates that a timeout occurred."""
 
+class BootFail(Exception):
+    """An exception sub-class that indicates that a boot failure occurred.
+
+    This is used when a bad pattern is seen when waiting for the boot prompt.
+    It is regarded as fatal, to avoid trying to boot the again and again to no
+    avail.
+    """
+
+class Unexpected(Exception):
+    """An exception sub-class that indicates that unexpected test was seen."""
+
 class Spawn:
     """Represents the stdio of a freshly created sub-process. Commands may be
     sent to the process, and responses waited for.
-- 
2.43.0

