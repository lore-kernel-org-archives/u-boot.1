Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BD4CEDDA3
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 00:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B084588EB5;
	Thu, 10 Oct 2024 02:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iibxJOra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBFCF88EF9; Thu, 10 Oct 2024 02:29:29 +0200 (CEST)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9755988E74
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 02:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-3e03981dad2so824174b6e.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 17:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728520166; x=1729124966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jt/aiJ0ZamHwpEPBXAUkkPBfbsDhqVMKVxCMK/3mb8=;
 b=iibxJOrayxQ4dWA4XqN9AGFX5sXlTPO/TEy4KhK+X9tspiMfsPJokosUJRtiWwAN/J
 EDP7hoCHghFLJOgPrPh2OZVjESE/1YQcAhghtpptGLJ0Yxw9r7LnBFUJKCOJy2OQNmXZ
 ha9hh4VXWH9HfbmIAAqx1ol9cBMNj/CTxr/v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728520166; x=1729124966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jt/aiJ0ZamHwpEPBXAUkkPBfbsDhqVMKVxCMK/3mb8=;
 b=nekmwTUoh5O15NktxTBvTDKLmQANgQaa+wGOEKCzNlPhrvUhotmeVUHOTya1ErWsAk
 /ZASlPAKZwVOk1BIlHWlF3OVvvmQxc4lCajmcXMTmvM8kyRxdE1Zipv3dMNOQsQmVeZh
 ccDokEz6yUrB7Lu2jDZ2sfyc6tTdwrCzI7uu3OMfknNVAY8KQa1VvdCBadAukuinoFv/
 JEW7qmspe3nCG4vi4nwmyUQXos2yEhtqqRefgk0CVZcXMuSypsnPC/oGk/LESMsxzCP5
 1QmLiYWDSLY8UnEQpEYfcNmmxasBCWhzkG28rEGeY4fWHN+PYOlS4bmQJsaIfeKTCZDj
 cE2w==
X-Gm-Message-State: AOJu0YyrTkt2XSpGJaR9rH0qrt6kGriksxrc0ZarURZuFPrwAs48Rsxr
 vmnM1MkH5CjY5BNiGVaKJqk7N3K84m3peX502a4Apg+2AxLgNA/shvN7yMjYQIS/7Q7rvkts6FN
 kqS2J
X-Google-Smtp-Source: AGHT+IEMxCGAu1JvTlLROTi/ERRtnWrEhY1pI25/emSLkNyqmbUFhUGcVkd2i8JnUBIa+rMbdAA9lg==
X-Received: by 2002:a05:6808:2005:b0:3e4:d5eb:2799 with SMTP id
 5614622812f47-3e4d7570011mr1061367b6e.14.1728520166224; 
 Wed, 09 Oct 2024 17:29:26 -0700 (PDT)
Received: from chromium.org (c-73-153-3-119.hsd1.co.comcast.net.
 [73.153.3.119]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-717cfed7536sm9073a34.2.2024.10.09.17.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 17:29:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v7 8/8] test: Fix mulptiplex_log typo
Date: Wed,  9 Oct 2024 18:29:05 -0600
Message-ID: <20241010002907.19383-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010002907.19383-1-sjg@chromium.org>
References: <20241010002907.19383-1-sjg@chromium.org>
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

Fix a typo in a comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Split out from earlier series
- Rebase on -master

 test/py/u_boot_console_base.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index aebe0dac099..d8d0bdf9fd4 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -113,7 +113,7 @@ class ConsoleBase(object):
         Can only usefully be called by sub-classes.
 
         Args:
-            log: A mulptiplex_log.Logfile object, to which the U-Boot output
+            log: A multiplexed_log.Logfile object, to which the U-Boot output
                 will be logged.
             config: A configuration data structure, as built by conftest.py.
             max_fifo_fill: The maximum number of characters to send to U-Boot
-- 
2.43.0

