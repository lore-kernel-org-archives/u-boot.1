Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4173CC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE2487F52;
	Tue, 20 Feb 2024 14:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oIW8I8GQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34EBB87F78; Tue, 20 Feb 2024 14:53:10 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA7F87F52
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-607bfa4c913so51210557b3.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708437170; x=1709041970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cFlRBun9HF6/7oAQP03rfmDvwcFqhrfjCDOyQr0WWfs=;
 b=oIW8I8GQabwzegqZ4H6X04V6tZfr4nGzI3LTg1+KIZR7v5tzHujAbENConMFfafPlU
 13MbO8Jp3qnm2MJB3/yNJdBUuCnvHulDq36iEI82hRZMHrMIzY/YKeZIjYidrKq6J4pp
 vRFmcRgMiBNv4YAAJYWQNlrRi8XHZsh9ssVKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708437170; x=1709041970;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cFlRBun9HF6/7oAQP03rfmDvwcFqhrfjCDOyQr0WWfs=;
 b=dSk9mTuCGI+M8DjTrW5H5O41AA8v0KHTxp7zHFrNy0U/srqAYZpxOgmBXYgnBickWY
 6u5kW7HYq5LdQK8XBLiAsgSNOp4PoBeG+GYJNZyvF2bbWhYgb95THOsgIZZ+eplh/kJx
 S3oDBkvSBAJNiHEIsBx8/CECNde8YGFHRW9/lMzBH5lQwk3FZ+Nr1G7idl0lHVYlVwtz
 20vRWADjpyEE3nOCreakZa8RqAjAHpaks6EnsRR4dpYn7Ovh+EpcnUiPJZDMbAW44Akf
 SBSp/NNSyoMwYcXr8RE8qf7o7bT89nfUJXxuxhFTPT79yjliZFEaed6tY3+a+sZV3K2q
 caoA==
X-Gm-Message-State: AOJu0Yy6LlYDYGLi7DOY1kQ8X+mDrslFfjavhQQ1jWnk/9uviJxzGOvF
 x6NOceYwufrzXJMkJvcP3lLZMrDfOS1MndOh9kmNoi5Qo7ygmUg82IttD7Ud+bfdXVLqBDadNcb
 m
X-Google-Smtp-Source: AGHT+IExRagDdOmQcLlULkYI/vSIt2W0cmpUrz2LRW1BmkQrieUiCkmip+GW4Q4SMuJigupLMU314w==
X-Received: by 2002:a81:a1d5:0:b0:604:a51f:c79c with SMTP id
 y204-20020a81a1d5000000b00604a51fc79cmr14034908ywg.36.1708437170266; 
 Tue, 20 Feb 2024 05:52:50 -0800 (PST)
Received: from bill-the-cat.. (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 x11-20020a814a0b000000b006085e262414sm407827ywa.81.2024.02.20.05.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:52:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH] pylibfdt: Fix "invalid escape sequence '\w'" in setup.py
Date: Tue, 20 Feb 2024 08:52:48 -0500
Message-Id: <20240220135248.1277809-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

From: Florian Schmaus <flo@geekplace.eu>

Once u-boot's build system invokes

python3 scripts/dtc/pylibfdt/setup.py --quiet build_ext --inplace

it may fail with

scripts/dtc/pylibfdt/setup.py:40: SyntaxWarning: invalid escape sequence '\w'
  RE_KEY_VALUE = re.compile('(?P<key>\w+) *(?P<plus>[+])?= *(?P<value>.*)$')

depending on the used Python version.

Explicitly mark the regex string as raw string to avoid the warning.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 scripts/dtc/pylibfdt/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/pylibfdt/setup.py b/scripts/dtc/pylibfdt/setup.py
index 8baae08770ca..c6fe5a6a446f 100755
--- a/scripts/dtc/pylibfdt/setup.py
+++ b/scripts/dtc/pylibfdt/setup.py
@@ -37,7 +37,7 @@
     long_description = fh.read()
 
 # Decodes a Makefile assignment line into key and value (and plus for +=)
-RE_KEY_VALUE = re.compile('(?P<key>\w+) *(?P<plus>[+])?= *(?P<value>.*)$')
+RE_KEY_VALUE = re.compile(r'(?P<key>\w+) *(?P<plus>[+])?= *(?P<value>.*)$')
 
 def get_top_builddir():
     if '--top-builddir' in sys.argv:
