Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579F5C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 14:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B214182DF2;
	Thu, 29 May 2025 16:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jiKZenJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B224D82A53; Thu, 29 May 2025 16:15:21 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB558301F
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 16:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7d0976776dcso96467385a.2
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748528117; x=1749132917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IKwhxtJacH+YFhT8yUc6rnA2X/yW2+viRdk0qltQs9g=;
 b=jiKZenJRO6EbuvxrrwkhbSnwq/cltlxzVWOTXy1i8h3AGB7WxvTgWqx7F6Cfr7tB+3
 43nqjGF7keUE1SKV8vrWvaYakqGODajujaz73tXlFP839cqUZ7pT2H0ZxmW9ppEbM+6o
 8Yr2Gl2SL3G+0lzpdSBTQqnCV8eG7PuPRUEEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748528117; x=1749132917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IKwhxtJacH+YFhT8yUc6rnA2X/yW2+viRdk0qltQs9g=;
 b=WxjGG6oZBpf3LaSXYUfCtHLeXWHPkiMt+V+nlep0Fo6B+ntNLtVAMFsQUou78ZxxcK
 VOpSf04UK6nf1ewcNEdYJWxV5f0LByC4ZFJ5/uGKlsTkOdUevsoRfdz8vTKHMTtuuiv7
 4iBraE0qfGcAM3L/vkZlNP1eQAo3ut/Z2JNVjrAa0X+wSkIAZt8mH0YSsT6+V0WfDs9F
 27Q9pACp5yjLXG++4/D0hiKUhf1m0KyRdzi2nuuXk0Z7bbfpnxW6uQOlzdWXDR5vOTW2
 hcynlqZy9zytCj+DrvQbW8qAUYHv8n7vWJ1lBL+Rj/dPV8U05uQEUbe45V1KZCDNGfNr
 LbnQ==
X-Gm-Message-State: AOJu0YziC/K10tWfnM21I98Cot09jbsQ/7PJnylpzHl8A8MLTg5qGo7Z
 oTmN2BxCU3zkAIxfXOp0NTtT2h449jVI8+GmmLQ46dr0ZNUWbmQTlMUC9ErgtDWc9wdW3ztJr2U
 +TxdrJv+U
X-Gm-Gg: ASbGnctBLiwmAekJZHAYzymvtrywH8wJA9N5CM93GcKMWisbGH+KOPsxZD6pvCGPn1x
 wrz0rQx7P4ml9PHVD4Pju2aDp6yRh10u3MQk4ICEbf8Gs7EyrQx7yTN44xJt4yCx+VuPymPvSLa
 EhSNbHDDbxb54odGJOnLkL2sNQEmQTXvUrg1fiylzlSdn0ew9r+pRtg3hxWv9zEOq8SV7g68eAV
 dAVLA1jVG12NSJjldTwx9FlZj4ksYtBg2vRk92OX2yp/ricGvD1Sr65KhnU+s8VfTE1KEZOYbZR
 RvUL6wStiOI4HRnLrLGL97wYsMPsmdte2jT/VC2+wMQZn5WSMUEHGa0/7fHczglENwcMLIUBMAV
 nKyDWsQr1vW6m
X-Google-Smtp-Source: AGHT+IGCpZ+u6WoPsuZKC7eU60P4R6xeOgNlTuy8sobRMMmOYqWBDbPSv7+Qrx+Bma9/NXiFDk2kQA==
X-Received: by 2002:a05:6e02:16cf:b0:3dc:8b29:3092 with SMTP id
 e9e14a558f8ab-3dc9b670688mr198001075ab.5.1748528105776; 
 Thu, 29 May 2025 07:15:05 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd9354632csm3273235ab.33.2025.05.29.07.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 07:15:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] test/py: Use the correct fixture name in exception handler
Date: Thu, 29 May 2025 08:14:51 -0600
Message-ID: <20250529141500.2123363-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

If a BootFail exception is thrown in a test, it is not handled
correctly. Use the correct fixture variable 'ubman_fix' to resolve this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: d9ed4b75add ("test/py: Drop u_boot_ prefix on test files")
---

 test/py/conftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 6c3ac67979a..eec0b5488e4 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -514,7 +514,7 @@ def ubman(request):
         handle_exception(ubconfig, ubman_fix, log, err, 'Lab timeout', True)
     except BootFail as err:
         handle_exception(ubconfig, ubman_fix, log, err, 'Boot fail', True,
-                         ubman.get_spawn_output())
+                         ubman_fix.get_spawn_output())
     except Unexpected:
         handle_exception(ubconfig, ubman_fix, log, err, 'Unexpected test output',
                          False)
-- 
2.43.0

base-commit: 2f3766949bbea7aa5a472157561d387fd94205d2
branch: py-fix
