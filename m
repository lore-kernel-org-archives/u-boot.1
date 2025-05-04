Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE6DC369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30801829A1;
	Sun,  4 May 2025 15:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UWBqMEa1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F8FA82163; Sun,  4 May 2025 15:24:20 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 185AB82A3B
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f624291db6so5310313a12.3
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365056; x=1746969856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f949689vMouEiPJ3CAs6KESQZQ1U5J9WG/JyKlNyJ+Y=;
 b=UWBqMEa17+OUWsgTxqJwKXUvzI0yptLs3tYWJIN63wo1e4JmZ0pxtQEIGlsiVjcT43
 fE/JdLqhYuWEhs3HiSKVTQppJ2oOg7fh+gRW+kc4xSy2hAEMpCUxTTyb6LoQq06isLA5
 /7tbXdPeAsESnVfMTkFdyqi+Qhn3a//Xz5iMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365056; x=1746969856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f949689vMouEiPJ3CAs6KESQZQ1U5J9WG/JyKlNyJ+Y=;
 b=ADzHhN0NenD9faiFV1Iq8Mk3ZGA9Y1ekp/6voPvvMmrz4O8/NRiksiK+TXDP3ElMTY
 +OEJsPeDLHDu1rGcaq9q8zMq99SOkTxj3/3LfIDlMRcpEZh67cJ9fMHQoMn0UTP/wd7H
 YoNlBhtS1IJBFOe0b7zVKm1bJHN1h2d5frA6elBBfNHlQr6xVU/JWgudc88L5sn3f6GH
 H6zERekRal34BwYr9br9lerDLktQQubqCLWBYex72y5Kmc97Ce2fGa3WKIUw29uRAuFK
 3goe0CAXJjWF1uRbyRakZ5xT7c5pyN/9m56E3BkGLfb1f/kvVIbQX1MYH44lbFLWYsWO
 bMGg==
X-Gm-Message-State: AOJu0YwUX1nDCpB96pJ2veqLqgn7URQhe7Ki8gzzb7kauF/G0dbyrxZf
 roL5mcQaZwgx93Uyroy8SXEnQk2NcjG6Qmv62FT1AQgZac21rE8UWahCK6y1/Edug+K11DkvhMw
 fd1CCKmo=
X-Gm-Gg: ASbGncvPZxP0JF12xqke+OKSNUDugOTEWMji9zRqNw9VtUyzy6+QpkKr7OwfV0/ysgV
 Xi3riGA6N7Ir5q98Dva6RqX/Yrv7ljf3SKOiEBDG3GeVQubG5HOgXtqlhWga8uiM0V2r3Xtd5qh
 Yqhj5QpV4muVw/b28GuPi0+d1bGgTinbBh/4itz+IcLHEvK+Apcu5/696B/mDzk9/xuuuOb4/5f
 g5/rb8w6GbD2ZGUJA4U92IDP80l+mnerVLMWCRquDQwlJFrcQR/X+YRtQ7e2Fi7UINE/FWiQ38a
 0gCTE0fFCeWPJJkv38pzM1i5GYaEU21YQ51aCGE4y7POlG4=
X-Google-Smtp-Source: AGHT+IFOe3LB95g/OnZ9NBzmGPa5pFHWHnSwSkTMiwTGR+wexZjdUuMmvZs9j2N27N+LQf52UoAHzw==
X-Received: by 2002:a17:907:a08e:b0:ace:9d4e:d0cd with SMTP id
 a640c23a62f3a-ad1a48bd2c0mr357867766b.7.1746365056525; 
 Sun, 04 May 2025 06:24:16 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/30] u_boot_pylib: Allow disabling colour output
Date: Sun,  4 May 2025 15:23:24 +0200
Message-ID: <20250504132356.2317305-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

When running tests there is no situation in which we want ANSI output as
it makes it much harder to see what is going on in logs, tests, etc.

Provide a way to disable this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/u_boot_pylib/tout.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/u_boot_pylib/tout.py b/tools/u_boot_pylib/tout.py
index 6bd2806f88f..37849d1450e 100644
--- a/tools/u_boot_pylib/tout.py
+++ b/tools/u_boot_pylib/tout.py
@@ -155,7 +155,7 @@ def user_output(msg):
     """
     _output(0, msg)
 
-def init(_verbose=WARNING, stdout=sys.stdout):
+def init(_verbose=WARNING, stdout=sys.stdout, allow_colour=True):
     """Initialize a new output object.
 
     Args:
@@ -166,7 +166,8 @@ def init(_verbose=WARNING, stdout=sys.stdout):
 
     verbose = _verbose
     _progress = ''                    # Our last progress message
-    _color = terminal.Color()
+    _color = terminal.Color(terminal.COLOR_IF_TERMINAL if allow_colour
+                            else terminal.COLOR_NEVER)
     _stdout = stdout
 
     # TODO(sjg): Move this into Chromite libraries when we have them
-- 
2.43.0

