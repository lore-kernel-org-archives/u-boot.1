Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46DFCEDDB1
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 01:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD2C588F48;
	Thu, 10 Oct 2024 03:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="msItrEmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C344A88F2A; Thu, 10 Oct 2024 03:51:56 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9273D88E7A
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 03:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8354955f115so13978139f.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 18:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728525113; x=1729129913; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLCrRj6pAlFRGjImJoweM//OdBLyyEKrzNSfFlyshSE=;
 b=msItrEmhYx9oiz+ME+SblklaW+gO8/KRD0dG4Fz32FbZrAmxiB1QNaWAEgG4c/hnEY
 e/G5J9PV5C9OW4xQjnviCtWVAqj51R3KpD5gkp4A08pleeHWe9nnJtvmlpzNa6zGAj//
 JoykqRSMLV00kuUhodr9fiQftYvl0zAaVP7IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728525113; x=1729129913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLCrRj6pAlFRGjImJoweM//OdBLyyEKrzNSfFlyshSE=;
 b=jIwpBewShNQNW1H8G9ErJoSg5oaeG/MSHe0mYzs4h2nifhTMjPbEjOrXlhAEICAlZG
 UhuOtMZzoyB4TxdT62WU4WL5AMjmDWLcJk6BqHMhs/8T1OC8mJkck3xM6Yi3x6leBH5I
 hAZwjFvNBgf/6PDvqWt9N10O+XeQI04B+g+c6CesUYEAgY4fYmnLzY8EMaMziIJ2DI4D
 mvsDB27q4ASmj17/keC9lMx65Jo9U3b2lap6XMOZAY2+OeOB1jEFsmU1TzNghpBAL3cY
 8QoJOlOL4vHj64bHyCF/Ys0ybaV/Jv/shBVtf5mh0cOvAKX8yndljU2Lz++vF0CkW+u3
 lQSA==
X-Gm-Message-State: AOJu0YxnbxhOXqvIb2M1yk17mXRm+BTm+FH00zeBhBMx/eYSqtESGXm0
 TC2+m/2TbWaAs1rRG33RyNQ7RuXYoA464rImXGgmCb0v78SqNLzFKQahMbUkzMz0TtNOLjM50qb
 q+g==
X-Google-Smtp-Source: AGHT+IHsccOGze4wY7IdHNt9gKXw1P7vRqOHxoWbUbFizAhr5qT7179MVacggY19WoUGXjq/i6ZAvw==
X-Received: by 2002:a05:6602:340a:b0:82b:42f:41d5 with SMTP id
 ca18e2360f4ac-8353d521659mr475255039f.16.1728525113183; 
 Wed, 09 Oct 2024 18:51:53 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbadaa947fsm61870173.126.2024.10.09.18.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 18:51:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 02/11] test: Release board after tests complete
Date: Wed,  9 Oct 2024 19:51:36 -0600
Message-Id: <20241010015145.1977999-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010015145.1977999-1-sjg@chromium.org>
References: <20241010015145.1977999-1-sjg@chromium.org>
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

When a board is finished with, the lab may want to power it off, or
perform some other function. Add a new script which is called when tests
are complete.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_exec_attach.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/test/py/u_boot_console_exec_attach.py b/test/py/u_boot_console_exec_attach.py
index 8dd8cc1230c..5f4916b7da2 100644
--- a/test/py/u_boot_console_exec_attach.py
+++ b/test/py/u_boot_console_exec_attach.py
@@ -70,3 +70,13 @@ class ConsoleExecAttach(ConsoleBase):
             raise
 
         return s
+
+    def close(self):
+        super().close()
+
+        self.log.action('Releasing board')
+        args = [self.config.board_type, self.config.board_identity]
+        cmd = ['u-boot-test-release'] + args
+        runner = self.log.get_runner(cmd[0], sys.stdout)
+        runner.run(cmd)
+        runner.close()
-- 
2.34.1

