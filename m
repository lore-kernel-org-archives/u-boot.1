Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAC1C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E186F88700;
	Tue, 11 Jun 2024 22:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BEvrRbzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE6288700; Tue, 11 Jun 2024 22:02:18 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EF1F883F4
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-36ddf683ad7so6722435ab.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136135; x=1718740935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQKfsJLU+OUD/kHdy/ujD6mUfsxlx0MiBlMmcB6yFM4=;
 b=BEvrRbzBz4hqm+sLZXM/AFTi6fCfXe7mHXgPUA4Ar1sEdLKYIBrgubI+EpfElfmDO3
 fTKwQkMpK34cx4o1Xak7L/1XA0MZ78v6PXfmYgjHIQpKnW2oxJfUbVKOjVH082Gk4OBX
 HQlkYr2pC3kTvylD1/epWicszpui2HryOZob4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136135; x=1718740935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQKfsJLU+OUD/kHdy/ujD6mUfsxlx0MiBlMmcB6yFM4=;
 b=sbyyv7Fg3gTQd44pfWWmC4ldzQNUzMLg0GZbEHrRyUVApjlEFPHSs54zvoXfNdqSle
 aNVyjOREtkBZ0mxbursEDDQ3UISzMUn92uS8uR9nrnQxt2GaCz7ZKvQF/6314LNOysla
 AEoxGOC+ffE90nMuQArr4fsRq9eo2xyhZ9Skcbyq2au8Cfvo+UzporHNOG3NUS9GVSX5
 2RTOUObZzYnVAXpIl8E0MJl67OJP0s85wODJWeKnR1vD2Ji/cYS8fAYiKFvKWDSM+RfS
 gXmprDTbUPlhEqEB2cIuRE5DL5ySme8CcwhJNUHRJ6CjI9NLj+unG0BoV4/kU7BqC47o
 5CIg==
X-Gm-Message-State: AOJu0Yz5BIbSvcg4qfWy6XQkegYSAXM6jiiXfz6EQFmjBUjReGg6PPoi
 3/r0Yl7xixHYzDQhFgwkeQ3tj36fe2u54qLjmczJg+2Mv6wmz9I0ppM3K73ievxLF643u8j2F29
 cmg==
X-Google-Smtp-Source: AGHT+IElOikStNXY/FiStZGypyQUhfk9XuX6CmKEd1ZjP5aIN0vjpZj0jFXo6nD9X11/cJ88rl3M4g==
X-Received: by 2002:a92:c244:0:b0:374:a176:e26e with SMTP id
 e9e14a558f8ab-375803a4565mr148355525ab.31.1718136134780; 
 Tue, 11 Jun 2024 13:02:14 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 01/42] trace: Update test to tolerate different trace-cmd
 version
Date: Tue, 11 Jun 2024 14:01:15 -0600
Message-Id: <20240611200156.2245525-2-sjg@chromium.org>
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

Some versions of trace-cmd (or some machines?) show one less dot in the
CPU list.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_trace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index 7c5696ce747..f41d4cf71f0 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -12,7 +12,7 @@ import u_boot_utils as util
 TMPDIR = '/tmp/test_trace'
 
 # Decode a function-graph line
-RE_LINE = re.compile(r'.*0\.\.\.\.\. \s*([0-9.]*): func.*[|](\s*)(\S.*)?([{};])$')
+RE_LINE = re.compile(r'.*0\.\.\.\.\.? \s*([0-9.]*): func.*[|](\s*)(\S.*)?([{};])$')
 
 
 def collect_trace(cons):
-- 
2.34.1

