Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8CEC54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 14:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D95C82C8B;
	Thu, 29 May 2025 16:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KGvbRXGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC6B982DF2; Thu, 29 May 2025 16:15:12 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8578182A53
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 16:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d948ce7d9dso3697705ab.2
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748528108; x=1749132908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hK2OLjDhvEATKeVmuERIbD3D0MxuWUPaCzYK5pBGcGg=;
 b=KGvbRXGKBqt+BfbjBktZ31977E9CnjoW3O4oZAZRJoGtK2NrsICuaWlXvNfOgZrLEY
 0gOxxqGfO41FBDmoYmIxUtm8A6DDnkOhJH4Ek/cYH7y5R2ZbwGLKCOq+v/GMvdOYUQa1
 mOpDOL0pzeR9u0Bl5ur1nCWgeeTajvE+1oZXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748528108; x=1749132908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hK2OLjDhvEATKeVmuERIbD3D0MxuWUPaCzYK5pBGcGg=;
 b=wLILjlH+PSZ8RssC+3M9zmakzls4ihC7JLXQEBru0XhQ5yc0RccLvzZgv3UoLKi0KU
 Jd174BPEF8C/tflDoRW5x4t1UNp9yyGcYOKyb1zaOi7jrpUR6dBRwcWKJLVEdhhdCqaA
 OvxprH5M3YheEAMsQ5LaNhloI3exBA6TQPcGOON+BXqmoS5ZS1/7VrUiC3aZB5T/c4ie
 meuqo5LPBstmXxyi/nni5Fw3srlZ8r3WoLP61DjPqDU82vPngyaJctd0QSyyhfgwFeYH
 5gb9gMyZ3yHFHBxCXJCvJUb/+jZOJZA5ntheTh9tVBySwCDNFH4THEqkn1WyXu+zUNrK
 td2Q==
X-Gm-Message-State: AOJu0YwO85mkHP1NlCfl/H/oi1iA/NUjnydkkVw46Cu5HO+n8OMK6gkE
 p9/Ekl5mvJmDnP745S+SEXjyxv0jOuiBdZC1OJduwVs5VcASZ3XZVs6UrFPzu01E8ZMxhkArfp8
 TDB1cLk6z
X-Gm-Gg: ASbGncvu52pywJ+CuyN7DJHqMEbG8qR0rY9OSBgEkdZAv+6V7h8Gm8dJTUPqvdUnP1U
 YufCDYgrEhd1QuYMxfabhLMxET2iRbkrZcAeq19T/Uenhg4yOLxpiWc+PBfCqDAChmP1jmQQxPv
 S+XjhYp7CoQ13dFrr8b5NcavusEAPxqDmHTI9Jm1yj9bWVv4oYZMmm0/+UxccvRqAZssCMJ7anH
 NHet2yq1MKcucXBVFo8gh/Z7V/3+aEssesf5QSB1YrRVHhQSTcWiz00GvyAQjtw5F7kVXuUnBir
 yF63xMG6IynZqBf6PspQv8AdygQPWzfbr4LG87c3s+u6gGBr7JQ4bNqjw1UCAU1FKp6IJfTZhTi
 xFgWd6xSrYmrNji1uqusFUcs=
X-Google-Smtp-Source: AGHT+IF7rYlYVzYPvazYlg+d1RjcMi87fpWdcGnKftGU2zSpkDd4VeguRM047tNXNSbu4sAOTm83ag==
X-Received: by 2002:a05:6e02:16cf:b0:3dc:8b29:3092 with SMTP id
 e9e14a558f8ab-3dc9b670688mr198004575ab.5.1748528107161; 
 Thu, 29 May 2025 07:15:07 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd9354632csm3273235ab.33.2025.05.29.07.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 07:15:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] test/py: Correct handling of exceptions
Date: Thu, 29 May 2025 08:14:52 -0600
Message-ID: <20250529141500.2123363-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529141500.2123363-1-sjg@chromium.org>
References: <20250529141500.2123363-1-sjg@chromium.org>
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

If an Unexpected exception is thrown in a test, an undefined variable
error is reported. Fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 85d7dae377a ("test: Detect dead connections")
---

 test/py/conftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index eec0b5488e4..8ce680a92a0 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -515,7 +515,7 @@ def ubman(request):
     except BootFail as err:
         handle_exception(ubconfig, ubman_fix, log, err, 'Boot fail', True,
                          ubman_fix.get_spawn_output())
-    except Unexpected:
+    except Unexpected as err:
         handle_exception(ubconfig, ubman_fix, log, err, 'Unexpected test output',
                          False)
     return ubman_fix
-- 
2.43.0

base-commit: 2f3766949bbea7aa5a472157561d387fd94205d2
branch: py-fix
