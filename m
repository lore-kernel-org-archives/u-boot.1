Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09B7C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE2788C9D;
	Thu, 22 Aug 2024 04:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MhJCv3mL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781A888CC0; Thu, 22 Aug 2024 04:56:45 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC1588C8E
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-824ee14f7bfso14210439f.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295401; x=1724900201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYXyQsRqtsBnO3GE7g5g2m/2vv435FQ3x/HtVb7x2JY=;
 b=MhJCv3mLHLj6ftmtQL3qP4Oke0gLXKq9z/6MizaHk9O2nWRTXF1/gnpisBctt4fJ8Q
 CTPaWRrb+Pyr7qrFX3mR3ialPfQKyvWcO42zgP7vWxz9wG8mdmsExeHPkcwqGfB5MwLY
 TlVQ+gW2lUgYqiT01qBnR6LG8YG6KLeHySB40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295401; x=1724900201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYXyQsRqtsBnO3GE7g5g2m/2vv435FQ3x/HtVb7x2JY=;
 b=iWsoMGKxWXUf/Hapg8PPhWdqn8zc046aD7/Ad9Aq1AvWhuyMGjVg7vNQvWdOGCTLwt
 jlLv/A6IVcpg2qwhfGoWs9b83nvdjfGFWuG+3+Dctxnb4uJ1ZGyKktmTOJenDpc7lnzX
 bowKQxXjvfGO6snW+p61ca0k6GUGl+MS0faUZQMwH6N8m3kOyJ/0KOBhlxcKWyWe5isy
 het0T6PbgFxGQMDjiBYVSdRHALtCk5lWAObbpwQgViv37QoZ6vuD/+8l28Ge3DHwj8eT
 TOr/LK3HhIDmZvjgfx22jIw/L/E74JbNOYzHyJUQW9uOVttbm8JI+yvAkaXmdDpGr2GB
 sWCQ==
X-Gm-Message-State: AOJu0Yx2KgSO4kJbmOCpQUfcPCvwmhE3LrlMbr07KiPx0sPlaLjgsB6d
 Tt4elKr49CmcNXEJz6nWpg5dtB9JW7MOWDhe8o0jr+XdBSVQFC9NliCwmOaaxZJ8jh1LSSEe0bk
 =
X-Google-Smtp-Source: AGHT+IEZ9umIsM1ddofr/VGQeB++75pRHQhA94r/Y/KNqkLWADJ/8TgwhVQdqENWPZq2SDz5SsDSTA==
X-Received: by 2002:a05:6602:1490:b0:803:5e55:ecb2 with SMTP id
 ca18e2360f4ac-825318032f1mr463297639f.0.1724295401008; 
 Wed, 21 Aug 2024 19:56:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 02/19] test: Use a constant for the test timeout
Date: Wed, 21 Aug 2024 20:56:14 -0600
Message-Id: <20240822025631.1838434-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822025631.1838434-1-sjg@chromium.org>
References: <20240822025631.1838434-1-sjg@chromium.org>
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

Declare a constant rather than open-coding the same value twice.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 882d04cd1e9..9cc0af66356 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -27,6 +27,9 @@ pattern_ready_prompt = re.compile('U-Boot is ready')
 PAT_ID = 0
 PAT_RE = 1
 
+# Timeout before expecting the console to be ready (in milliseconds)
+TIMEOUT_MS = 30000
+
 bad_pattern_defs = (
     ('spl_signon', pattern_u_boot_spl_signon),
     ('main_signon', pattern_u_boot_main_signon),
@@ -423,7 +426,7 @@ class ConsoleBase(object):
             # Reset the console timeout value as some tests may change
             # its default value during the execution
             if not self.config.gdbserver:
-                self.p.timeout = 30000
+                self.p.timeout = TIMEOUT_MS
             return
         try:
             self.log.start_section('Starting U-Boot')
@@ -434,7 +437,7 @@ class ConsoleBase(object):
             # future, possibly per-test to be optimal. This works for 'help'
             # on board 'seaboard'.
             if not self.config.gdbserver:
-                self.p.timeout = 30000
+                self.p.timeout = TIMEOUT_MS
             self.p.logfile_read = self.logstream
             if expect_reset:
                 loop_num = 2
-- 
2.34.1

