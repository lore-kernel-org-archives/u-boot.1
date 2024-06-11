Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3C3C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08EB388816;
	Tue, 11 Jun 2024 22:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hzB6ebVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC758880C; Tue, 11 Jun 2024 22:02:45 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820728859A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3737b250ef9so23345495ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136162; x=1718740962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xg2oQgv83oGzuWGSGX51RYeJuk1rjdPiV5Aas551pAc=;
 b=hzB6ebVebGuGKvnC2az1tx/KfIeohOHVkKDha5Pmg/Cp3dMGmSi3kpu65SeeZPHMwF
 vuZXvVOFeUEASTqU7C35YffXcXoDx5mrDlyMA9iOBn7vDoVSVL91HycfCEJ/xk9tGd8H
 lD4gFI0lFevyNCFuyhAkPisE4Q8b0x8wvcy9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136162; x=1718740962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xg2oQgv83oGzuWGSGX51RYeJuk1rjdPiV5Aas551pAc=;
 b=gbiGuB1nDlcAuzECLyETMzNnOVFjmraMBcm4poMLyo2EEfuIJZHbsd7b3+KbtTX5EN
 zuSgYlgaQNf22RrdotZPtqcxIihq5U9jfcn54+chbpQdZosO3rxHQ2Xre5/BV+nrJFE7
 2K6LKpXTsbLhIjDRi8T/sthCmYN6LzsyXyWwilGSuH0UYAn8erYALtmFtpRfIlYoTpkj
 0CTj8VE9HdREdLPQ7ROzmeYpy4lDjpYNXM7/IMM96meGoYOZGksv84/2lXR1KagxpH4h
 6xAFtlZb4W6B5q5T6Wzvwa0mokHwSO3YWCVYzH3jraudC/CBXam10H96xFL2S6cigoIX
 wM+Q==
X-Gm-Message-State: AOJu0Yxokn9SHjuULV5hL1jm+xUtqjdPSLG+nTkvsthRkB9+m5Czg9gs
 HqnemMdxjlbvhfw2XwpCi3tuDDJ3QqimEgSA0i/2dp1hjMyAO0cQ5lCiI1K6UlPEfiwS1HHqhrR
 Shg==
X-Google-Smtp-Source: AGHT+IEY9DmMzAWqfFa5XhZzL4inT+g7mGbac1scNKIPsZL6cR5HJYBzjhj/Yr0QfqQBs1NpTZULxw==
X-Received: by 2002:a05:6e02:12c2:b0:374:9c67:1df6 with SMTP id
 e9e14a558f8ab-3758035fd9emr158833145ab.22.1718136161995; 
 Tue, 11 Jun 2024 13:02:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 35/42] test: Tidy up remaining exceptions
Date: Tue, 11 Jun 2024 14:01:49 -0600
Message-Id: <20240611200156.2245525-36-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

