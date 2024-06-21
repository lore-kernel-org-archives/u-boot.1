Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE3FC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E067188664;
	Fri, 21 Jun 2024 21:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ldZtPCn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D550A8863C; Fri, 21 Jun 2024 21:52:40 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3AA7885F2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-376266a65c8so8905825ab.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999557; x=1719604357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/158Sh8+v1ZkQJMtknG4TlaZN92RnsK/VaOuS3pByk=;
 b=ldZtPCn9+ED9ascBJwGzVbmEgZ9zHrVWnomQeSoXdCTsXAuvTIodwfyHb5I5EBaPGR
 3WKyJ35ffKYoGGWIt3ZoWUa63h20KlMRDYaenkBi4aQLnrtqU+k4vsiHxRkPh/dzu3wq
 qEhXSu9Q0BwrxGPLh5HY6La2psqngjuiW+Csc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999557; x=1719604357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/158Sh8+v1ZkQJMtknG4TlaZN92RnsK/VaOuS3pByk=;
 b=gmecBFlFOSkbt2YTrBJE9EwLG0BRRHpxuKMsM0wdW+G78fOJzfoOMc7Yh78/BGbsAN
 QAiiup9fsxdiR2ftAEhp92GrCWT4u3ErHmop6tvK8w31Yox2/I39OBK44/g1B7FGo96m
 X9leRfwGkI3m0jziFVxGhGer2QlSWZQ3etvwhSKuE0zWxWtDaaHh3pY7TjaiquG8EwSH
 aiDqFbZ/L8fY3uWQk2H1Dw/Ccz89YBnKqYrTRcrneXgj2nyfSaLamCLJ7LUwf4et+h85
 8JDmqHeo1QNm4Gb/78zBA4p5ktqcsn9254FX2ruqxCXQ1N4EEDzK/ZHvvERGeUBXubhV
 7aqA==
X-Gm-Message-State: AOJu0YwTUAdDtt3gBh1vqn1WAzxr4WZKyc3xD2QDJ59MtEjlg1egVwNc
 VZ2a4Z0uj8j1jbo9AX4UFzknFkPiZLVGwWU0fsxRapYDGwDdi5Va+y2LCtl59bt+Zn1DGtPQHym
 VUg==
X-Google-Smtp-Source: AGHT+IHUlbEaA2twAp5mpUbXvupBp6eCIyVNoiE2BLIaisbcZdC75e46dfJ5noxyERwGFLS7rSGJzg==
X-Received: by 2002:a05:6602:6c15:b0:7eb:6cbc:8856 with SMTP id
 ca18e2360f4ac-7f13edb1690mr1061808239f.2.1718999557320; 
 Fri, 21 Jun 2024 12:52:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 35/43] test: Tidy up remaining exceptions
Date: Fri, 21 Jun 2024 13:51:56 -0600
Message-Id: <20240621195204.2675252-36-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

Use the new handle_exception() function from ConsoleBase also.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index b656a1f38cd..dbf54eadd0f 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -14,7 +14,7 @@ import pytest
 import re
 import sys
 import u_boot_spawn
-from u_boot_spawn import BootFail, Timeout, Unexpected
+from u_boot_spawn import BootFail, Timeout, Unexpected, handle_exception
 
 # Regexes for text we expect U-Boot to send to the console.
 pattern_u_boot_spl_signon = re.compile('(U-Boot SPL \\d{4}\\.\\d{2}[^\r\n]*\\))')
@@ -268,12 +268,12 @@ class ConsoleBase(object):
             # indentation.
             return self.p.before.strip('\r\n')
         except Timeout as exc:
-            self.log.error(str(exc))
-            self.cleanup_spawn()
+            handle_exception(self.config, self, self.log, exc, 'Lab failure',
+                             True)
             raise
-        except BootFail as ex:
-            self.log.error(str(ex))
-            self.cleanup_spawn()
+        except BootFail as exc:
+            handle_exception(self.config, self, self.log, exc, 'Boot fail',
+                             True, self.get_spawn_output())
             raise
         finally:
             self.log.timestamp()
-- 
2.34.1

