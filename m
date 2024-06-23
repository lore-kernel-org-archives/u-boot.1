Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD980C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43DC88477;
	Sun, 23 Jun 2024 22:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h40tm5cX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36E8B8855C; Sun, 23 Jun 2024 22:30:48 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DF0E88528
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7eb7a2f062cso143199939f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174644; x=1719779444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wB8IlpEyasJ77UcuVJ/mSH9PPTejySs9mrOW63czuxA=;
 b=h40tm5cX9OsVac2lQWp8UzUD9dNk6N7zX8865XguLPr9h7AtgBCdewPyb2s7XkuEVv
 5soyfcA+s7hjX6PpwKHRONLWSNqwPbPHDXLsMmJhDSVxvuHlboq6jKTFtuVahX62tDrL
 Q/RPHb0s/7Ivri7Fh5gzMg1AmY39X08DYpKFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174644; x=1719779444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wB8IlpEyasJ77UcuVJ/mSH9PPTejySs9mrOW63czuxA=;
 b=ESjy4a+Hhx1Cf3AcLcv7YQYlgy6vxSwWR2NA4B4lm5PFRCYChBCi+2JplirTRwSeH8
 MKRTFBTdlC6sqGPgLC5CtA77FI/mAmtt0zPEu3xpAIDJw2PqvqhUa6ctADUnI2ldXGs3
 I5W6IqhihjNszxlMRlhwwD1d4I1PEnzd6H8q+Z7XAMEKH+Y6Vj+zpwP1xAxv06dCaEy4
 T8ChGi/vKwWHFMyNWt37fbigeyYF2JjgkI7Ms9qrze9C31Rvp7jId51LxOeZiSCxwjZH
 kN4jgS40OzVyRo/txzTSRFZOd1U7Enweg9pgJGoHXuiOjNCWBsji/BgRQMikQFjGLPuh
 2nug==
X-Gm-Message-State: AOJu0YxXDRWnqIWu4HQMouu+qpJw9SwiltPWO5uEMFwXm+sYuq6T9eSr
 oYYA2umiZXSMKloPyjH5+8Ee4qxqfz24KaH2WPt2xXWMe4VYNGcy+o1PhOYk+qziDRmqfncI63S
 jug==
X-Google-Smtp-Source: AGHT+IHhvHQzdIo1kieH3RigX5pbhiY2n9vLfJXDzuKII7FAnnxh0UUsWACarAa8Aqca+uErDl7LGQ==
X-Received: by 2002:a05:6602:6d8e:b0:7ea:da27:e59e with SMTP id
 ca18e2360f4ac-7f3a7554742mr294903539f.12.1719174643690; 
 Sun, 23 Jun 2024 13:30:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 09/14] log: Allow tests to pass with CONFIG_LOGF_FUNC_PAD set
Date: Sun, 23 Jun 2024 14:30:28 -0600
Message-Id: <20240623203033.1566505-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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

