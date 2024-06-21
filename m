Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4688EC2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29AB38861E;
	Fri, 21 Jun 2024 21:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IN44QGVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AAA088607; Fri, 21 Jun 2024 21:52:32 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2638857F
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7eb671a835fso123004439f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999548; x=1719604348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wB8IlpEyasJ77UcuVJ/mSH9PPTejySs9mrOW63czuxA=;
 b=IN44QGVmb6F/PT3lVDh5u9gB1BPP20kRhl9avRK5klTkzW2KO2JjkgNDozWPLQ8jwO
 daR5twhJN4g9UdI/I2K7jGw3IUVPRotthNWxMBBYOPIxR/EalzIiAw+SjfCQDDfQ5Hve
 Fo6DcUeARydDuyaoXv5ocNe1SrVdTkxO97Xv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999548; x=1719604348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wB8IlpEyasJ77UcuVJ/mSH9PPTejySs9mrOW63czuxA=;
 b=Abmd2kmL1TofBzfCkRftKUjVFG0QAN505ljXnSz66fJx86AsJ83n72SmHRcDZqAH3Y
 wTZo041MuPKl3ofy1ZEbMt3up+a56Gs9RNLdSOpDVEnn/+EJy6FX0Zi4MiSVBsi90mgf
 WfJaT6qLqexXz9dqb+CRn9CXIlGpPRresEQ+Ke3xp92iiT/efqDP+k6LyuPzTWmUONIk
 xvBEsbvjuX0WvSHVvhuKpGC9f9X4sWQugmw2Ax1gR5E+4HpmsBths0BYaBXLcx21Bnuv
 9s8A6ikTxGt3rVbGifIdmQvNosoRfQQjXWNLdupKJXDX24AOVZiy++18oDb1KebFD94t
 sFxw==
X-Gm-Message-State: AOJu0YytHtNvrNTU5mR6qX6u5O1EYmONHPqTExrHitC/tVPF9k2V4N6E
 mIB9nol1ksYicYw4H1inRPhZvqenXqMJVXkwOoYx9Mz4tzVEj426eWdBNBuvH+qeRg8N9uBQEWu
 wpA==
X-Google-Smtp-Source: AGHT+IEkhhVfdmwKmsVFn95lIm1mgTGkzNrHDJs8rEMmLBQFQEbv9Kz8l1/cFoz/Vaa9DRa4yy5Mkw==
X-Received: by 2002:a05:6602:2d8b:b0:7eb:54ad:cf46 with SMTP id
 ca18e2360f4ac-7f13ee2c39fmr1045388739f.6.1718999548660; 
 Fri, 21 Jun 2024 12:52:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 24/43] log: Allow tests to pass with CONFIG_LOGF_FUNC_PAD
 set
Date: Fri, 21 Jun 2024 13:51:45 -0600
Message-Id: <20240621195204.2675252-25-sjg@chromium.org>
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

This setting pads out the function names. Adjust the test to handle
this, since some boards use it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_log.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_log.py b/test/py/tests/test_log.py
index 140dcb9aa2b..79808674bbe 100644
--- a/test/py/tests/test_log.py
+++ b/test/py/tests/test_log.py
@@ -27,13 +27,16 @@ def test_log_format(u_boot_console):
 
     cons = u_boot_console
     with cons.log.section('format'):
-        run_with_format('all', 'NOTICE.arch,file.c:123-func() msg')
+        pad = int(u_boot_console.config.buildconfig.get('config_logf_func_pad'))
+        padding = ' ' * (pad - len('func'))
+
+        run_with_format('all', f'NOTICE.arch,file.c:123-{padding}func() msg')
         output = cons.run_command('log format')
         assert output == 'Log format: clFLfm'
 
-        run_with_format('fm', 'func() msg')
-        run_with_format('clfm', 'NOTICE.arch,func() msg')
-        run_with_format('FLfm', 'file.c:123-func() msg')
+        run_with_format('fm', f'{padding}func() msg')
+        run_with_format('clfm', f'NOTICE.arch,{padding}func() msg')
+        run_with_format('FLfm', f'file.c:123-{padding}func() msg')
         run_with_format('lm', 'NOTICE. msg')
         run_with_format('m', 'msg')
 
-- 
2.34.1

