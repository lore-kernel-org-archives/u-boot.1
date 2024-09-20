Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8EDCF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C428933F;
	Fri, 20 Sep 2024 08:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FPOmipHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0DD890EC; Fri, 20 Sep 2024 08:03:06 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A5F8932B
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d0d0aea3cso200160466b.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812180; x=1727416980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdyPAt0Bnlt9kcMvdcuyr4iZ/pPvF/F+OVLjcGkuqGk=;
 b=FPOmipHJn0MimdC3QaephonM7kZuxZq49dqnJkT6Ieuxt9D7mCyd+aPEyTb7vxPeIM
 Ij9PHdh6vM1V+S+j3cmS4iOgdHYxtgBN01z+rPqA5lZ5sj45CHkgObcn0dWksXVN6hxk
 8G8bi2zQk5oTj6BIs+UFd0KuJmthLZqcdRQsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812180; x=1727416980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdyPAt0Bnlt9kcMvdcuyr4iZ/pPvF/F+OVLjcGkuqGk=;
 b=InG2dLar11foxRLo23Dxh3d3kqCxYu43DHTVd+vjTm91YbguvbUK20jevnHBpScvZk
 Cvh5Vl0ZVnDYtjrFY/d/tAQg1ANplG5+SxivFDZL74uPQWcUa5uF4/Mnxjmn80a2yOst
 CO42FjGhVHjIcTC2d8iO3ch8zpuC9CrWe8hOw8ynA1D929hOE9M/PCpBG3BqaSOAUCmW
 DIU5YE7xk/ShnPQzSQX/XU60CeuU3iKK3o3jRYLCfQ/DHXdMDdqOsiZUQetqRWE06g/O
 u4YGjvSCwLSu8SZfpt4HENHwkTvggtJrmod79skEsLVD2FOc50RmTE6XtjKD6ND28qMw
 //EA==
X-Gm-Message-State: AOJu0Yz5QAqbA7Npn/kLvn/aNxpXfQGSIlJsKg3H7C0YRFd/n6PWInZN
 fzyz2vt62o63xbcX6CUgXD438lvYTD1Okk5NHkp0LzMCxjYlvwLTCE9s7yJss6ubF6YcJASY9oO
 e60se
X-Google-Smtp-Source: AGHT+IHaRu/XgiAFTp/qi1yzQoly0IioDfGI4YY9o1nAgT9a3odxkdCZdPmiPEpymgwzb//FnJnA3A==
X-Received: by 2002:a17:907:f163:b0:a8d:6329:d8cc with SMTP id
 a640c23a62f3a-a90d4ffe173mr126461666b.25.1726812180217; 
 Thu, 19 Sep 2024 23:03:00 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:02:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 02/19] test: Use a constant for the test timeout
Date: Fri, 20 Sep 2024 08:01:37 +0200
Message-ID: <20240920060158.106612-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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
2.43.0

