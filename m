Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EE2C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40DCE88612;
	Fri, 21 Jun 2024 21:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RlAy2eFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92283885F1; Fri, 21 Jun 2024 21:52:30 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 750F7885BC
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7eb671a835fso123002939f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999547; x=1719604347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpBEunC00T23ULw/HFwfp94YTsGLgldSm0y07b4Bke8=;
 b=RlAy2eFD3StxKDXHdXRryUbw5jfESBwh0Z731wVyF1eEuWQgBKi3I0rV3Pi+MOtPhW
 ec5yzGGX1Ih8327BEG0PQXc4GfMNFWOvI+gcsnZz/gGG4kOL3shva4+C3WOtxwMcdAwG
 aYoGkdalt/oDOQT2tJfPXnvlnO+FILtdJvf84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999547; x=1719604347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpBEunC00T23ULw/HFwfp94YTsGLgldSm0y07b4Bke8=;
 b=OcqyZwRv5PZ4ydQrShTmMDDP8E3gPALiEHm7MuBRVOs9SIkCjpfzFfQB/E1+W6DP6U
 W1Lx/P2Xrc3o8J+AqoHUt6oSRBmS/jLfQvYdFbEh34VHN3jUFhaCTU8LY9PwCHTSOSfJ
 PA+iwiTbbuHryVpduhQV5lmULlewesGJFFfhLrVbl9pGOp3VyyBJSnld+bguPUVCQOjt
 RhC9j+X1lN1lwrFhTxaVtQzm9MW2otv6x4MOwfwpmlG+XPoXFTDJsdn7QJqXMoMNvqWn
 qPTxESzRVGARYSnrPwcYFyxuLPPcXOUvHBAZU6orp2aeA2m04QAxf8/7ZGcVsf7fCiU1
 uEBQ==
X-Gm-Message-State: AOJu0YxWSQJk5sIs7ko8rppqOHUXkV69+7WroRZklcy7RFKmz1PymgYZ
 J2XvNwL0cnUv4wcJw+McepEOyspdrCfM2gbS3+yNPbuY6vTx2ZzopqCGwCoSVnDACkGAvT7Mw7+
 DsA==
X-Google-Smtp-Source: AGHT+IHp9baMUKJI/l2L9cf1qKG+g07w/AQ+9TyvaJEgbj4AHjFbbZ7Z/x2kD+i6vVCvIhJFgEYKzg==
X-Received: by 2002:a05:6602:6002:b0:7eb:cc55:af1d with SMTP id
 ca18e2360f4ac-7f13ee5e9dfmr1124536039f.12.1718999547060; 
 Fri, 21 Jun 2024 12:52:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 22/43] test: Pass stderr to stdout
Date: Fri, 21 Jun 2024 13:51:43 -0600
Message-Id: <20240621195204.2675252-23-sjg@chromium.org>
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

Some tests may output things to stderr. Ensure that this output is not
dropped, by redirecting it to stdout

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_spawn.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
index 7c48d96210e..7421da49aa9 100644
--- a/test/py/u_boot_spawn.py
+++ b/test/py/u_boot_spawn.py
@@ -10,6 +10,7 @@ import re
 import pty
 import signal
 import select
+import sys
 import time
 import traceback
 
@@ -57,6 +58,7 @@ class Spawn:
                 signal.signal(signal.SIGHUP, signal.SIG_DFL)
                 if cwd:
                     os.chdir(cwd)
+                sys.stderr = sys.stdout
                 os.execvp(args[0], args)
             except:
                 print('CHILD EXECEPTION:')
-- 
2.34.1

