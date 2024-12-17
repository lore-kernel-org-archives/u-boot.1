Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C81E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C55E801CE;
	Tue, 17 Dec 2024 22:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d+Rbal2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8DA180239; Tue, 17 Dec 2024 22:09:28 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA6A801FB
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 22:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a77980fe3aso551195ab.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 13:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734469764; x=1735074564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0dkiO0gqwi7I56f/h5hzg4Vk1b6zX2qKSb4DOq6MwtQ=;
 b=d+Rbal2WmedhINsmxwRQQmXZ6lGPoa0e5/smzYbrE0KMEB8g2L4sLlRjVPUW2cMGWV
 +2lhNDrtj/BCJspvcTri/Uj+SMTABzyU8AMldOY1UJQDJxhZs8YrLSeR6XKQtZg14b40
 de3pDG5Y7s/vKpGQp1LNL0Zt3zZOdskWiV6DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734469764; x=1735074564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0dkiO0gqwi7I56f/h5hzg4Vk1b6zX2qKSb4DOq6MwtQ=;
 b=nRCREFDeYA4qhjj2GlwfC5S7cgE5kxWROsP841P7eI0e2lAWz18H9pHvmAmAAGYGm9
 sd5TKRWoJ2Nvl2G6nGk5HcNsm9sPc+bxz4D6S+T+rtM//+Qupathp5oXLkdb75xoDsi5
 7YGT01CEbYNqeKKE6mDPvA249hmZgKUs6bQtJP7hh1oPC2hYSr/rDW/eBnhNJQVgmMG/
 xS/T1O9S+89ckA7UXq22xHesMdqRajZSK5TrN+y8e1JuuMqH2KGJnL0WwRrRd3WGHSjf
 JVeXQtU8bOJmILt1NQpEAd0yo15AFlR1ryG8lH5edhYXyk7O+8WO7HzrbHfHLsY7hzEM
 q4wA==
X-Gm-Message-State: AOJu0YwUvfkw8GHewpDi9FjIp0qZpsA0QTBvHdN718KtYK7Em/UV3wwI
 M+Iq/JxeOeYyWMcWgNKLZrOnVcmgxEGhqLHhaajD1SM02lnCsHWGgRCPPCbER8soiIE8xqXHeak
 =
X-Gm-Gg: ASbGncu1NZiwZ5UoJRXkA3pBx89jJAFlXNdNGzvYr6YODw9AkLLies9EFlugy8tBeLV
 7SiuemwjkpwNBjd3zccH3WIEjSn/gyi24Gcx9LjhHzHuvq3htX2+6AJ5Xr8xZmGcpcWW72UveHX
 yXddO+K5PdD+vOmcdn/7OK0r3haUpGBUjQVmFbTXCn8LT5niE6pOkfGyIOPXqv31TOPZhiW11Ip
 a0lAfaXSHKyjsSMSh/QFgvdSFRnixSsYrL0KGsQIifoWs7I62YkzqAe5Kr7Fxg3wcA2UDg3mFoB
 iNfO2zljFwjwJBMkJA==
X-Google-Smtp-Source: AGHT+IEIlfkh+Zk4eS0eWTcNMLA15veaWkNxGpQ62KA+nNy6tDRHjbCuVBwO61Ka8TUhU1ZB//AaFQ==
X-Received: by 2002:a92:ca09:0:b0:3a7:e8df:3fcb with SMTP id
 e9e14a558f8ab-3bde3b213f6mr1762935ab.7.1734469764205; 
 Tue, 17 Dec 2024 13:09:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b248cb72fdsm22845915ab.35.2024.12.17.13.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 13:09:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] gitlab: Add a NVIDIA Jetson TK1 board to the sjg lab
Date: Tue, 17 Dec 2024 14:09:19 -0700
Message-Id: <20241217210920.2050997-1-sjg@chromium.org>
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

I have one of these boards, with no OS loaded. Add an entry for it so
that it can be used for testing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1c15907fffa..60a841bd4d6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -707,3 +707,9 @@ colibrimx8:
   variables:
     ROLE: colibrimx8
   <<: *lab_dfn
+
+# NVIDIA Jetson TK1
+tk1:
+  variables:
+    ROLE: tk1
+  <<: *lab_dfn
-- 
2.34.1

