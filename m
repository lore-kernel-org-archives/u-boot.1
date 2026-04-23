Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BE5FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E33842E7;
	Sat, 25 Apr 2026 22:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="enrnSsSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28A9E8435B; Sat, 25 Apr 2026 22:25:16 +0200 (CEST)
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com
 [IPv6:2607:f8b0:4864:20::a44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E0684099
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-vk1-xa44.google.com with SMTP id
 71dfb90a1353d-56d93355337so5502635e0c.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1777148713; x=1777753513;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3j+JXdPBzJYO4sYTQbHuDmaA7mFTuPfLaQOSgFGtfhU=;
 b=enrnSsSzUTN9cJZcR8hbIJVziSa0QQRBUfB5NSH4yKOT1ZaskaIxIsePTloVywf0Jm
 /GNVd53hGkUMtLm6vVOmjoT7FXXPfroFqFQ8Xmzj8Kb2/vd8yo2LzDQGmMVhI8iUOqcn
 XNhK71jWlzMAUSZ97RdBLuGt8NPel1ZYTQGn1l3JLyIZXiMl2gsTxsxVEpPHUfERQsbc
 VnHJORCBvA4u0sTRVZANA2UaBAQ09xV1BgppLQWJedv4Rq33JlqN8OBji3UMbujrrGRN
 vcZxWpi/DZjK9xBnxp0T3W7Tjfa/EBuB+Zq4fCSYF8YnQioPd7VTdnaHQ1B1MDRH7EW3
 OvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777148713; x=1777753513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3j+JXdPBzJYO4sYTQbHuDmaA7mFTuPfLaQOSgFGtfhU=;
 b=Kc0DrIikyYuT3mJLaOnPVtcc0+pd2RreNiR4dfmpHXRwoTlqPKAfANlBNsXJwlCslk
 0XntVjTkKLR/b9GNGDPYta2FRjHH3+SgdeXKWibzJJ7E9QiQuUfeWKJeW1ee0kG27vWb
 t2aHrzX17zhBptu3jdburUqr4dRJ4gMMJe+1Vl8Xbj0Js6VD6M+6sA2dL6zsnO86bgDq
 irFHey7WXatCDCXh0TFfFP6RpEEkerNchURxG3OG8FPA/Nt/5dUuLxDKM/XBXzlAWaQi
 2w1ZkeIoKwjPwxr/o+eWLtVs/g1y+CaAmdKpy5eRxDxRs7LWyeg4jvnoGCZmPWFPvxoZ
 lSTA==
X-Gm-Message-State: AOJu0Ywfa3tHQgMFqRm1s2yXvmU67kiIP/oo4J6CpDZnsFTRp1kDRD2q
 eV3cpcjKzV6wkfnZYc9s1cXuzSe0IqyNKmtt5la64pd8QFJxayRFN3IV72M0kEDUJDpY1Pqs8LS
 rBDyLTxpLVzH2
X-Gm-Gg: AeBDietu/pSuyL8b2zG2KJAg+s/wg42utpZ1o3eWJvD76A1DjmxQMev5ZakTRNjv5TY
 nWN62Bf8E0EXUl2ikX/t+V4ke6dtGEFrdaZw9kYXgxmCR0oGIlIwEl2HBGSkPghfN7lXRq+5Rke
 5eQN775qdHEcwX+2KvoOqQSpFT/eXWT96xwKBDsyRBXrX1KiMD27gXzhvkn8cVBtEtpS6bLh0zH
 n5rExrKGYEdA3eOaY/eJcQNUv5Fj7t63KlhOSpNi8Rdugh1BUADcsrxEayodh+6E8A91vZdXLMs
 75Df0OgEzF1s3a0MPoA6D1a2nUCOpOGTb03dCxQC4S+d7QWqFGCP6Uei/V7BIxFgIgMv6BHQujt
 7fHIkxdrgZg9GTeZgwnM8C3Tc6OEQZYcpM4O2GP3EIOq+1mMVOkpN02tnB322Dd5d6fp7fSdr3v
 GidSfJweiYg9tXLKN7Vd66zdEFgaLvbSt9XGQPwUFhhKE8y2o6vh9a
X-Received: by 2002:a05:7300:6d23:b0:2ca:9b08:e7d2 with SMTP id
 5a478bee46e88-2e478a34148mr16447657eec.22.1776959187971; 
 Thu, 23 Apr 2026 08:46:27 -0700 (PDT)
Received: from desktop.. ([2804:7f0:6401:dc31:4200:1760:44a0:9daa])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa5c86sm33732055eec.1.2026.04.23.08.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:46:27 -0700 (PDT)
From: Sergio Prado <sergio.prado@e-labworks.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 y.moog@phytec.de, xypron.glpk@gmx.de, sergio.prado@e-labworks.com,
 jerome.forissier@arm.com, afd@ti.com, quentin.schulz@cherry.de,
 Wojciech.Dubowik@mt.com
Subject: [PATCH v3 1/2] binman: bintool: add extra_env parameter to run_cmd
Date: Thu, 23 Apr 2026 12:45:35 -0300
Message-Id: <20260423154536.768603-2-sergio.prado@e-labworks.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423154536.768603-1-sergio.prado@e-labworks.com>
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
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

Add an optional extra_env dict parameter to run_cmd() and
run_cmd_result(). When provided, the key/value pairs are merged into
the subprocess environment for that invocation only, leaving the parent
process environment unchanged.

This might be needed by bintools that must inject environment variables
into specific tool calls without polluting the global environment.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 tools/binman/bintool.py | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 9c76c8881a46..9d4f31b8afa1 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -272,7 +272,8 @@ class Bintool:
                 show_status(col.RED, 'Failures', status[FAIL])
         return not status[FAIL]
 
-    def run_cmd_result(self, *args, binary=False, raise_on_error=True):
+    def run_cmd_result(self, *args, binary=False, raise_on_error=True,
+                       extra_env=None):
         """Run the bintool using command-line arguments
 
         Args:
@@ -281,6 +282,8 @@ class Bintool:
             binary (bool): True to return output as bytes instead of str
             raise_on_error (bool): True to raise a ValueError exception if the
                 tool returns a non-zero return code
+            extra_env (dict): Extra environment variables to set for this
+                invocation, or None
 
         Returns:
             CommandResult: Resulting output from the bintool, or None if the
@@ -291,6 +294,10 @@ class Bintool:
         name = os.path.expanduser(self.name)  # Expand paths containing ~
         all_args = (name,) + args
         env = tools.get_env_with_path()
+        if extra_env:
+            if env is None:
+                env = dict(os.environ)
+            env.update(extra_env)
         tout.debug(f"bintool: {' '.join(all_args)}")
         result = command.run_pipe(
             [all_args], capture=True, capture_stderr=True, env=env,
@@ -315,18 +322,20 @@ class Bintool:
             tout.debug(result.stderr)
         return result
 
-    def run_cmd(self, *args, binary=False):
+    def run_cmd(self, *args, binary=False, extra_env=None):
         """Run the bintool using command-line arguments
 
         Args:
             args (list of str): Arguments to provide, in addition to the bintool
                 name
             binary (bool): True to return output as bytes instead of str
+            extra_env (dict): Extra environment variables to set for this
+                invocation, or None
 
         Returns:
             str or bytes: Resulting stdout from the bintool
         """
-        result = self.run_cmd_result(*args, binary=binary)
+        result = self.run_cmd_result(*args, binary=binary, extra_env=extra_env)
         if result:
             return result.stdout
 
-- 
2.34.1

