Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C438C7114C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25372889E9;
	Thu, 29 Aug 2024 00:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lAqPj2Vj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B69889A7; Thu, 29 Aug 2024 00:08:59 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E899A886E5
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39f37387c21so2517955ab.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882932; x=1725487732; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8DaFGF5/hEwxIGAsIVSejGtNXaa0RJWKjQAwyotlPc=;
 b=lAqPj2VjuAHRS6P6//yqC7npNiuhpz/5DgmABL5LpP1ZefAD9ROFFxOYv2YFT2qUx0
 saN5akZlf6O1iHb020O43UP/A4WcawY3AWFG1gUJ+fZOc+SoYTcBZyQ7BsTB/lYG8JbW
 W/RiAkPKsW643T/uSEI0fHqCj4O+3e+ib5GUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882932; x=1725487732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8DaFGF5/hEwxIGAsIVSejGtNXaa0RJWKjQAwyotlPc=;
 b=Mzf8g5gqzymOSusGLoIDC++Cv3CRdoykQPnhiGIPdDUbEq/Yisv53bfnUDaqRV579/
 5z344NgpM0mj3vjRVTA86CrWAD0cpj7a81zJW6xmkU5ffK85Y6dDlpMSkjvU5DKa9YoQ
 owQt+hH1z+yS/70e7pEC8KylyIsOtTmN/BAlKE0KgTZWI9wsNDac9+dfh2PBag/K02Ms
 l+HTiFNIL6bXhJ/xxTPaqn9QrO+9myF9ZhPGijG0V7bkjF6wxdDeNV4bmqwTWlRyV3Y4
 it7A88UgPwzHI7+OBnPRfT7koMJMWiNRrxVkXwaKsTgvw+lmq1dlb9AbyPJuudGBCH4e
 wiug==
X-Gm-Message-State: AOJu0YxS5J7l/D/6p5hIBNfosFWbIHTuf+2KzdcKgZwD6yAvdd0DUfUH
 3zQ2Twjr/1anhoeer1u3r5zKq/I7rj3IbUZbIHQFazICx1vcrH9QBoevhtGWirjA7cgjqI36DKY
 =
X-Google-Smtp-Source: AGHT+IFl474gYJ4eyfjip6pS8CNaZYmh4pKiMNrwTKTsWdMOhQreKKbjUJ2HwmrVLHkZH8eRekd8eg==
X-Received: by 2002:a05:6e02:2142:b0:375:b19d:deb4 with SMTP id
 e9e14a558f8ab-39f377dc679mr15164865ab.7.1724882932536; 
 Wed, 28 Aug 2024 15:08:52 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:08:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 03/20] test: Pass stderr to stdout
Date: Wed, 28 Aug 2024 16:08:29 -0600
Message-Id: <20240828220846.1205813-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828220846.1205813-1-sjg@chromium.org>
References: <20240828220846.1205813-1-sjg@chromium.org>
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

Some tests may output things to stderr. Ensure that this output is not
dropped, by redirecting it to stdout

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_spawn.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 97e95e07c80..81a09a9d639 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -10,6 +10,7 @@ import re
 import pty
 import signal
 import select
+import sys
 import time
 import traceback
 
@@ -59,6 +60,7 @@ class Spawn:
                 signal.signal(signal.SIGHUP, signal.SIG_DFL)
                 if cwd:
                     os.chdir(cwd)
+                sys.stderr = sys.stdout
                 os.execvp(args[0], args)
             except:
                 print('CHILD EXECEPTION:')
-- 
2.34.1

