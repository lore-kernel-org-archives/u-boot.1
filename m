Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C263C3ABAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC88F82824;
	Tue, 29 Apr 2025 15:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cf09sGYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81FE82824; Tue, 29 Apr 2025 15:23:49 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B171A8283E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72c7332128eso3586872a34.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933025; x=1746537825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCXDIznoc9fRFpus2ldXulx29HM8QbT/mqQBGBEuaag=;
 b=Cf09sGYN9wW0v1pC+JEfSV0TGnL4N8rxrJLFvOzRKDCvu1WP1BQP0XVsH8Hhbz/Ewt
 z/JR/RmVr92mKHLwK5xkPGMLoY9c3sv2mHJ+kAu/h574a6hAXVs4260RuyqkVVWtIHPz
 NCrvzlCzl5uf4QYMM/z68/cx1q1FzLJoIS07s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933025; x=1746537825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCXDIznoc9fRFpus2ldXulx29HM8QbT/mqQBGBEuaag=;
 b=hND2fe9I/21Wtunnm56jtpjQrmNGG3umZrIh0k5oKmPJcF/nIzYtb1OFunsBQFIuQB
 mjNcNpoUfKyMqr9wPnSC54Audcx4gb78paIoNbGfKlMgUQUPDwChDoWEGYJieQwOGEfh
 EqJpbYyrZQLYISoGAg6FCZOJY4MLs56rQNPvJv18sO8seFAW5m4FBeoKC/RHVLBHjWiZ
 gBGqiNBw7grEsItlb8lVaGpiG6nXou+lFGhAOZcN3HxMvv+o0c0x7fe8QINyxMWl0LUm
 FAUpdCoIrpUDDgKsQZDGLBlW37zRfLHues87mdSKENbLwGeQHJTv6NTbme9m8TLJu7nu
 LgyA==
X-Gm-Message-State: AOJu0YxDjCJJyQKHpN4Fk5vtaqi6E6HaIDbygcOZREO952+N2H0GGhJ4
 x5H1rzR6jnaZey90erX2eEEnsiLOwv2Ni/sbqvVusi7rNVgc4m+nVE5BLdj7eKcoxaCmXe9dE+s
 =
X-Gm-Gg: ASbGncvyRVe2oEv8t+rJVpX48VDnlDSJf+z8EpZGdKlq2OZcS1mOaUaJkvLytlqikTq
 asByVRoj2oDROV9q1/l8acAtToabxDc7AzEiipV0mIeKJ9DI3xDaZ048PPFqtyloqlh9RYDPntK
 k0Qq5cXzrF+tOODsnVdVNZYC8AcY6RB8g3QGstzBd7+Hk1R3orCbW4F0tpEQbTsvs611PAEtbM3
 gL7MntRIWX5Z3ZJNMrNKVshvVObkvAE7oudFrgV5SMuA3NudfqaKWQ2BbA/f0mpgHNvhLjij7Yl
 aFyeB3enz/sfpsIBnFdjTo4RFq0M58VZzIaxEG59NRN19JGVk6x77miCLQZe3C0WNSVjKWDf4o7
 ZZA==
X-Google-Smtp-Source: AGHT+IEN6m270cuUW+fPHIrcRrOXf7Owj2grHRGIYA0hVJf/VD5HOUmgBrst787HYFfbRMBhgQmikg==
X-Received: by 2002:a05:6830:f85:b0:727:876:c849 with SMTP id
 46e09a7af769-73088c6a739mr2360833a34.27.1745933025638; 
 Tue, 29 Apr 2025 06:23:45 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:23:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/30] u_boot_pylib: Allow control of capturing
Date: Tue, 29 Apr 2025 07:22:01 -0600
Message-ID: <20250429132239.251756-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

Tests often capture output so they can check it. This means that if the
test fails it is not easy to see what the output actually was.

Add a -N flag which writes out the output after it has been captured.
This is not a perfect solution but it is simple and seems to work well
in practice.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/terminal.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/u_boot_pylib/terminal.py b/tools/u_boot_pylib/terminal.py
index 84531831760..4b9a907a547 100644
--- a/tools/u_boot_pylib/terminal.py
+++ b/tools/u_boot_pylib/terminal.py
@@ -28,6 +28,13 @@ last_print_len = None
 # stackoverflow.com/questions/14693701/how-can-i-remove-the-ansi-escape-sequences-from-a-string-in-python
 ansi_escape = re.compile(r'\x1b(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
 
+# True if we are capturing console output
+CAPTURING = False
+
+# Set this to False to disable output-capturing globally
+USE_CAPTURE = True
+
+
 class PrintLine:
     """A line of text output
 
@@ -280,10 +287,17 @@ class Color(object):
 #   ...do something...
 @contextmanager
 def capture():
+    global CAPTURING
+
     capture_out, capture_err = StringIO(), StringIO()
     old_out, old_err = sys.stdout, sys.stderr
     try:
+        CAPTURING = True
         sys.stdout, sys.stderr = capture_out, capture_err
         yield capture_out, capture_err
     finally:
         sys.stdout, sys.stderr = old_out, old_err
+        CAPTURING = False
+        if not USE_CAPTURE:
+            sys.stdout.write(capture_out.getvalue())
+            sys.stderr.write(capture_err.getvalue())
-- 
2.43.0

