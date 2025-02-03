Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAFFC02195
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 16:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EC5E801DE;
	Mon,  3 Feb 2025 17:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kfdr1eBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC63801BE; Mon,  3 Feb 2025 17:27:28 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADAAB80391
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 17:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so14283745ab.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 08:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738600044; x=1739204844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0otgoCXTOcK4ud5Cw/4tksCHeksa/5EduRnE3wJv9U=;
 b=kfdr1eBB2+eNVLuva7ef2RLMwymP5gHATIp9VgVUh1mY8zu2F9DdJlXSJ2NoxZlIgS
 Gry/1nfXTbJvC4cdyEYFaR+8P3kIUls14VDsoaAmNlFJAC+c+koaNV11v/b0SH98+hn/
 Ia/W/A1+7A7iQDXNUv3H1xxC+C//lQhH8W1LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738600044; x=1739204844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0otgoCXTOcK4ud5Cw/4tksCHeksa/5EduRnE3wJv9U=;
 b=ZfSkB2WQ3CpX9HIwkeTJnTEHj/k/RCAMpHwbVRG46D3IfyA2kn2W7IauGxqdonzUd0
 ltKYs/NbzZtfQrfWT8mkj6k4MFbB7o6QXKtObvWKdIca6GaNYjoGRXXvQ4/nHYM74Vn/
 +fFRLiRdZ0By1L5rsFO8UftuZyQPhHLmOwp39u6qxRnLygGRItbc/WnDaouCL3g8jKTI
 WiI34jjak2KitlttZhNBqsSSXpRRAQr4KJiHJQVHqpP69tLikfcbMiSjgZjbfIvuSw0d
 kQGVOFJRA8RgSTFNEI2tINNJNU2IeyWIghUp2PK8vMTp9DVT92WHdCGGrPS24XnUbJQw
 xImg==
X-Gm-Message-State: AOJu0YxILuWiNoOQgAuJTYkAqXirFYTRzIrESJmu+pukG+5nT4k3i44i
 egHPEwvkT0N7dRmE9Yr+cPyI9q3gPA1MFLc6HmAXTXvueosUloMmHcP25jChZfmcY3d5qtRiT44
 =
X-Gm-Gg: ASbGncuPixjcxzipFtlbOOA9AYx/HVGSFES8zpzWKCp0Vddtp/0PW1ehcVVwEe5RrsE
 FNQavi5Cy9igLbuk91L4SQoBgRrQJ2/qceK6QdQV9whJF+tupZb7bBeFHfawIJVGiK33AHOvRIx
 Wlig8jZB0Kfpw03xTOo+KC1Y517UOtMOTtMc/OjeLajxMNUQR8y67wWlENN3WVONJoHi3qyuomM
 DyTO8h9Oi4gP1lTBafuWAeLYWO3eyj6Qd6GyK0jh5bMYaGsqbcFD1W5Jq4HJWvCMx5bXQhkGORT
 KD7jWQbC6n9RAC7dYMN0wboqJ2ou3NU0XLrmgh2hXP/7q3fLKabd
X-Google-Smtp-Source: AGHT+IFP9KtIL92IjIjKSnyuBkT65zN8bGNgbVL+OxpuyUHKHKNEz2AW0nfGxw3eoqtyiI8ykhmdcw==
X-Received: by 2002:a05:6e02:18cf:b0:3cf:c7d3:e4b with SMTP id
 e9e14a558f8ab-3cffe6b7e26mr226685025ab.21.1738600042293; 
 Mon, 03 Feb 2025 08:27:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d01da7e688sm15935735ab.33.2025.02.03.08.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:27:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] u_boot_pylib: Add an exception-class for errors
Date: Mon,  3 Feb 2025 09:26:43 -0700
Message-ID: <20250203162704.627469-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203162704.627469-1-sjg@chromium.org>
References: <20250203162704.627469-1-sjg@chromium.org>
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

Throwing an Exception is not very friendly since it is the top-level
class of all exceptions. Declare a new class instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/gitutil.py       |  2 +-
 tools/u_boot_pylib/command.py | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/patman/gitutil.py b/tools/patman/gitutil.py
index 10ea5ff39f5..ffe05273b35 100644
--- a/tools/patman/gitutil.py
+++ b/tools/patman/gitutil.py
@@ -140,7 +140,7 @@ def get_upstream(git_dir, branch):
                                          'branch.%s.remote' % branch)
         merge = command.output_one_line('git', '--git-dir', git_dir, 'config',
                                         'branch.%s.merge' % branch)
-    except Exception:
+    except command.CommandExc:
         upstream, msg = guess_upstream(git_dir, branch)
         return upstream, msg
 
diff --git a/tools/u_boot_pylib/command.py b/tools/u_boot_pylib/command.py
index 103358420dd..4a9916bd814 100644
--- a/tools/u_boot_pylib/command.py
+++ b/tools/u_boot_pylib/command.py
@@ -13,6 +13,19 @@ from u_boot_pylib import cros_subprocess
 # When this value is None, commands are executed as normal.
 TEST_RESULT = None
 
+
+class CommandExc(Exception):
+    """Reports an exception to the caller"""
+    def __init__(self, msg, result):
+        """Set up a new exception object
+
+        Args:
+            result (CommandResult): Execution result so far
+        """
+        super().__init__(msg)
+        self.result = result
+
+
 """Shell command ease-ups for Python."""
 
 class CommandResult:
@@ -61,6 +74,8 @@ def run_pipe(pipe_list, infile=None, outfile=None,
         kwargs: Additional keyword arguments to cros_subprocess.Popen()
     Returns:
         CommandResult object
+    Raises:
+        CommandExc if an exception happens
     """
     if TEST_RESULT:
         if hasattr(TEST_RESULT, '__call__'):
@@ -95,7 +110,8 @@ def run_pipe(pipe_list, infile=None, outfile=None,
         except Exception as err:
             result.exception = err
             if raise_on_error:
-                raise Exception("Error running '%s': %s" % (user_pipestr, str))
+                raise CommandExc(f"Error running '{user_pipestr}': {err}",
+                                 result) from err
             result.return_code = 255
             return result.to_output(binary)
 
@@ -106,7 +122,7 @@ def run_pipe(pipe_list, infile=None, outfile=None,
             result.output = result.stdout.rstrip(b'\r\n')
     result.return_code = last_pipe.wait()
     if raise_on_error and result.return_code:
-        raise Exception("Error running '%s'" % user_pipestr)
+        raise CommandExc(f"Error running '{user_pipestr}'", result)
     return result.to_output(binary)
 
 def output(*cmd, **kwargs):
-- 
2.43.0

