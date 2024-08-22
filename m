Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB3FC52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A0188E9D;
	Thu, 22 Aug 2024 04:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QBeUpaog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 060DA88E68; Thu, 22 Aug 2024 04:56:51 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D29D8863B
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81fe38c7255so19723539f.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295407; x=1724900207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsYn/7DjZxJm+0gcVgdsuoh0XrMyXJi91lp22nAzzhA=;
 b=QBeUpaogL3W7PAPh6uQ4l4kKlgIsrLUmWzhiSriB5x0jakq+GOappMnsLGe7s85U6d
 dTGeYDQWZPUlC6bjuptcuACw9clQwrrafg2FpfPU2yScwyVHaDux6SECL/J+YHOUEvre
 BuYMlJLjj9p44Xu02/DjbRg9XwmIFrw5hqs2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295407; x=1724900207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsYn/7DjZxJm+0gcVgdsuoh0XrMyXJi91lp22nAzzhA=;
 b=MA4IFS7MzlBiRzwbpS4qdDvHNBCTbZNdX4uIfcDvYy7vpchoWTQYMCrmbCy6lnL932
 N8RE/cNm7QxNbLgZJRC8qVWbZ5MVl1p9nCeLaLtxJXVYn/R1SYMVDHFrbRRclpTnccTR
 mCknB9nKAujIv8VeNOySZZPse1HJY4q3PA4bCvBWWKjbECzcY8jcjQUj+gL2VpNrgWml
 HILhjZwoYmcsYZxA5AT2To2TDdL4JYei7z71LXTQbrDpz06sX4iRRU6vIHTIAOmPCCAB
 VWM8xrEr29aUF7NrxdlWd2N+ayawcSqBVxGOqteUihls92q9jwr45GIdDr5ypBTVJ5yZ
 WGag==
X-Gm-Message-State: AOJu0YwB20uhFi6ziHKpOCcPsX8BoqLdgpLSG+ihKOOf2C4VItx0RG9X
 azt6IHyRnM5V8Oa9w4bUyqXcanwAXkS6do5s/9tTP1PLA/eGQVM3i7cZSgEP59fY6nK8WogvFOM
 =
X-Google-Smtp-Source: AGHT+IG67eSQM6mFgAoXGOEc5gaRPWML7dPlfEETahWgfVoZjv005MT3GIEBmdFboJudcitUDp8JTQ==
X-Received: by 2002:a05:6602:140f:b0:824:d703:fdef with SMTP id
 ca18e2360f4ac-8252f2fa7ecmr621875839f.2.1724295406978; 
 Wed, 21 Aug 2024 19:56:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 10/19] test: Separate out the exception handling
Date: Wed, 21 Aug 2024 20:56:22 -0600
Message-Id: <20240822025631.1838434-11-sjg@chromium.org>
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
index cb0d8f702ba..57ea845ad4c 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -17,6 +17,17 @@ import traceback
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
2.34.1

