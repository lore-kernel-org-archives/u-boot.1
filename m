Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7582EE77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D25A806F9;
	Mon,  6 Jan 2025 15:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WzLeUMU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23912806E6; Mon,  6 Jan 2025 15:33:38 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F34FA805D5
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a8aed87a0dso47533125ab.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174014; x=1736778814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/cxmW22g0vasVwb77y/wKLQrI2B3taWtydIYzvhIdz0=;
 b=WzLeUMU44wWuG8tAa2aFpK/EP3UtVPTEc7T8O8RZRZrcqIAUDCsntKEXCaUp9Ju9l/
 gTd2hKC+cWh3+4KfsjKRQReE0VtnQEAbvhLDodSLMJc8cvJaJCj89GKu3a01kA387e1I
 GP2rMgQpz2fp70ucJIa07t9wLaVSXdBVD0+fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174014; x=1736778814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cxmW22g0vasVwb77y/wKLQrI2B3taWtydIYzvhIdz0=;
 b=NTYTPyUhW6H+Ezw3RRNRo4P1cM1cIW9hvfTFxkuA2BMfyaTfMup9E+/qv+YQgNi5vp
 BHFVdTSrNb1szxuNCZtHozKj1F7EboRAra0mN6nz6Q6hByUNfRoS7NlzElogyeUZ7i9K
 oDor69qenwUC4KNrcptuzB2UP6wHbrKRkwE2+HwttKci1kT/ZEnUr/oDCztlhJhPpSl6
 pgdtCf8qFKQk8G3osWHp7Egyxuh5KF1oDHxEFSs3kWHc6NhsbdI/SJK1tC1rYTf9vMVd
 XZZTXqMpGrz9k0YVOTbvcPDrhO7SZ7dk8NrfWJOhxEF2dsTEAr3go/I7UuwwndHWgWoo
 QSmA==
X-Gm-Message-State: AOJu0Yydk0TyM+JSre2RLC/fPInLcLIvVPFrrNYDDcoBiJygj9BS0zby
 hn9rZKjoCzjKglGyc0HFjs/aLj1kb2LYcC/j24uUZxyhpNd5edb6RwFVWLhsu6BZGZe0vmTqNzs
 =
X-Gm-Gg: ASbGncstTqMc3aUoYbelNg50iPo4A3i+nWR8K1/LIdkCW5fyPC4CYrEAMooPkywMl4b
 TTvVbYjnW5rn3iBgmG5Cz0wu3E3c4txTtTJ4jb9Hk3yFJy7xblXl8viFV/7dyyZPVU9fSmce61M
 Kp/y+LJHMLB2jdE9LctGLLXNDGnuX7KggGiiHVQr1lMZ1B36HrmkM4vEunXMyZM7D0Zc0+3dhVp
 GyLmDzEl9u73Ini+9GOI8PKjqqqNp8wAR8stUdj3ZlTxdIAjMcDhWs1xpkJqCx9pX2Xby+m6D3u
 ZP5FNtpPkjf/bywGTA==
X-Google-Smtp-Source: AGHT+IE2cg2IQnIgewDOc6i/bLT+3FgqwARqpSoyJ/6ZWaQ6Jr9lj0f/ccsW4hbg800QvicY7rPYpg==
X-Received: by 2002:a05:6e02:3042:b0:3a7:e436:5e00 with SMTP id
 e9e14a558f8ab-3c2d2d5094emr440530115ab.14.1736174014179; 
 Mon, 06 Jan 2025 06:33:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/33] test: Fix inpected typo in upl test
Date: Mon,  6 Jan 2025 07:32:16 -0700
Message-Id: <20250106143229.3023771-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Fix a typo in the test comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_upl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_upl.py b/test/py/tests/test_upl.py
index 3164bda6b71..90125c4dc1b 100644
--- a/test/py/tests/test_upl.py
+++ b/test/py/tests/test_upl.py
@@ -17,7 +17,7 @@ def test_upl_handoff(u_boot_console):
     proper and runs a test to check that the parameters are correct.
 
     The entire FIT is loaded into memory in SPL (in upl_load_from_image()) so
-    that it can be inpected in upl_test_info_norun
+    that it can be inspected in upl_test_info_norun
     """
     cons = u_boot_console
     ram = os.path.join(cons.config.build_dir, 'ram.bin')
-- 
2.34.1

