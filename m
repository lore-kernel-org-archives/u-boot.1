Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2C9CF58CD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 988668934F;
	Fri, 20 Sep 2024 08:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EGxuwzVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 075AE89322; Fri, 20 Sep 2024 08:03:11 +0200 (CEST)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 073BE8931B
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-a8d24f98215so202035466b.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812187; x=1727416987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R58sqHGcD4y1xLHd++8m6PcOenHjcIpwQOOAH4wZJ24=;
 b=EGxuwzVDmfbPkhzBMjcUecTZxcDWSCNRZ5IPqj8K6bX2nyYdpzfL9sISHydYhXI76X
 JnsBFJNId49q/jkPG97+X0d+lRdBBvKaQEJSJzyjc6xHsPYjcHycEXK9rtGZYAm+ycgD
 AOrtiNEHObS3n7OeoZzC0VJcnFkTvL+gJpgiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812187; x=1727416987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R58sqHGcD4y1xLHd++8m6PcOenHjcIpwQOOAH4wZJ24=;
 b=hWBjXDYrGDD09UyDx9YrJBkHZv458vgLsGJXWK4gFmDCctN/NeGnei53V6KvY4kmCt
 1fKDX5D1/TE9X4suLlAavpY2EqXTCMhvZ3HcZxw/V8aoZN7DVYpkdr68bsX3+Ee4L0LJ
 C0X0oONI75ffVVoazuUvTH9kMwSgi9GAJD8YEr54mDPefkMSE6z0wujF5t7MRBlVIRwH
 sdUHuXFzVsGdYm4J9SlraKktOSwVAwPKVmBzFuaSpTrqUUgjDC9AlRj10Xp7QwNZKxQ1
 zY8Kh8iiZZLq/byEWiTLvNwIUUkYZsJKIyplx/tyC+6ypaqtA84B0XuRPfJ6B6Gh6pdp
 SR8Q==
X-Gm-Message-State: AOJu0Yz9uXw06Hkj6qtZxyAAn8ItjumDDy+vqSE94L9E96OVxjsesx5k
 Doj84UcHt5G5dZgcyUOfQ6709ceuarVKW7gaFY7Y4UMMAdNgcCHj06kYwBIIC4LUVCQgVqAxLiS
 ogxFSovY=
X-Google-Smtp-Source: AGHT+IF57+v6eD3V40T2nVNi1PjvXQ51xN2Xg/Hhxv2g8A0L7EzeJ0jAhq6Yq/pkRAykrZ8Hy4LCMA==
X-Received: by 2002:a17:907:e612:b0:a8d:3e29:a82d with SMTP id
 a640c23a62f3a-a90d5000fa9mr112021266b.37.1726812187029; 
 Thu, 19 Sep 2024 23:03:07 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 09/19] test: Separate out the exception handling
Date: Fri, 20 Sep 2024 08:01:44 +0200
Message-ID: <20240920060158.106612-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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

The tests currently catch a very board Exception in each case. This is
thrown even in the event of a coding error.

We want to handle exceptions differently depending on their severity,
so that we can avoid hour-long delays waiting for a board that is
clearly broken.

As a first step, create some new exception types, separating out those
which are simply an unexpected result from executed a command, from
those which indicate some kind of hardware failure.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 26 ++++++++++++++------------
 test/py/u_boot_spawn.py        | 11 +++++++++++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 8a9c4a576dc..fa87952694d 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -14,6 +14,7 @@ import pytest
 import re
 import sys
 import u_boot_spawn
+from u_boot_spawn import BootFail, Timeout, Unexpected
 
 # Regexes for text we expect U-Boot to send to the console.
 pattern_u_boot_spl_signon = re.compile('(U-Boot SPL \\d{4}\\.\\d{2}[^\r\n]*\\))')
@@ -190,13 +191,13 @@ class ConsoleBase(object):
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
@@ -207,13 +208,9 @@ class ConsoleBase(object):
                 if m == 2:
                     self.p.send(' ')
                     continue
-                raise Exception('Bad pattern found on console: ' +
+                raise BootFail('Bad pattern found on console: ' +
                                 self.bad_pattern_ids[m - 3])
 
-        except Exception as ex:
-            self.log.error(str(ex))
-            self.cleanup_spawn()
-            raise
         finally:
             self.log.timestamp()
 
@@ -279,7 +276,7 @@ class ConsoleBase(object):
                 m = self.p.expect([chunk] + self.bad_patterns)
                 if m != 0:
                     self.at_prompt = False
-                    raise Exception('Bad pattern found on console: ' +
+                    raise BootFail('Bad pattern found on console: ' +
                                     self.bad_pattern_ids[m - 1])
             if not wait_for_prompt:
                 return
@@ -289,14 +286,18 @@ class ConsoleBase(object):
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
@@ -355,8 +356,9 @@ class ConsoleBase(object):
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

