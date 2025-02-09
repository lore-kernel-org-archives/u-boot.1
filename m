Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90877C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8ADC807D7;
	Sun,  9 Feb 2025 15:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XK5NPa2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF95B807D7; Sun,  9 Feb 2025 15:34:15 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B74ED80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so2692728276.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739111652; x=1739716452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OM6vLoHJQPUQco5QWZKr0cK7OO4z/aMnfEu/UdokHy8=;
 b=XK5NPa2XyjGn5C7wYBHi8PyuP7zecWh1cFvaqR3hDgqGZzy/T4rYo7UiDdUUTfPmMI
 NHeIWM855cnKUyXieYIrur0gG/gp2u71/b0J10sdW9CfrQERpc2o+mZywo3Xt0MQZxSt
 L8krfpojhvSvacSnJ9q0/uPD4ggs3AtTDJ5oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111652; x=1739716452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OM6vLoHJQPUQco5QWZKr0cK7OO4z/aMnfEu/UdokHy8=;
 b=TOAuxlFK9T+C/Jo1q3MUS89qty2BxW+1OpToyGcri2KgURaxRakgjT9x97kjixuVir
 l4XpsuSF0PeLNPa0aEha2koMmdF+a7zxUc9ExgWL7gNSPkNiIy7KtTWsbbI4bikhSAsi
 1h0THligoOBDE2Beu8ZFy0fSiBWceantwdpr3w1sZp7KircgRyoy/lpJ6gIwTcvFb79p
 WD4qZ6a8jPc56mJsWYxba0XnM5KIAZhLKJi5kwxFcRX1f17FBjLxJ7NXi0cuAMynctmp
 wsExIDK1UyNnXCuZ+/yT+l72NfjGEivkbZ1vTbz3LzS4LmN/SJRAvN33oEsNTY7Blwv5
 ViQg==
X-Gm-Message-State: AOJu0Yy0ur/g8x+SzSK5ffp8zt3P0iYnh7Q2D/cY5ecdN8UITkjrP0AK
 +4GKR7GId0+yD6tk3P1c3pnxcCyJuGu5yvIGfHD76B0A7/8/GZc/u4bJpK9p7LfRmqxPmGyb7MS
 2
X-Gm-Gg: ASbGncsVgZXMcTqYVVXvIGuCuCvn871p0m8lMEHLMSQKkXmAM0HSSLnAvw95V5ZSNPJ
 +g0FCvPAumRdPNbMqg3Fq4HN0KzzkK8IuOq4r1fqEhf347ZLjEVIXWrHwdevGHSXMSUpr+DALav
 ArhhzD31LluKRrKjVlETe3Y48sFbUhVh981Ey1j+uIe1FoDgROdQ5jf+9C1Tqsh3V8cy4mTXD6D
 /guZRmxS4VMliPtAqp50mx+l5aE6YXaQjZ6Myon/Eob9105nDyR6hH7HczmmmHDXY6NSEtRlFdE
 kSTYjM74szH7IZNeYg==
X-Google-Smtp-Source: AGHT+IErsbzguZnowN3vKUgbqs+0oPmWmop2Rh9N28L36TcsUm5mMi8PIacNpztmFlL/oviyKVdtFw==
X-Received: by 2002:a05:6902:120c:b0:e5a:e655:be68 with SMTP id
 3f1490d57ef6-e5b4619ef5bmr7978779276.13.1739111652636; 
 Sun, 09 Feb 2025 06:34:12 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a221293sm1896200276.25.2025.02.09.06.34.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 06:34:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] u-boot-initial-env: Add missing dependencies
Date: Sun,  9 Feb 2025 08:34:09 -0600
Message-ID: <20250209143409.2765303-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

When performing a build consisting of only a defconfig target and then
this tool, we were missing two dependencies. Add them.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 33bb86343c5b..1f641d49f211 100644
--- a/Makefile
+++ b/Makefile
@@ -2515,7 +2515,7 @@ cmd_genenv = \
 	sed -e '/^\s*$$/d' | \
 	sort -t '=' -k 1,1 -s -o $@
 
-u-boot-initial-env: scripts_basic $(env_h) FORCE
+u-boot-initial-env: scripts_basic $(version_h) $(env_h) include/config.h FORCE
 	$(Q)$(MAKE) $(build)=tools $(objtree)/tools/printinitialenv
 	$(call if_changed,genenv)
 
-- 
2.43.0

