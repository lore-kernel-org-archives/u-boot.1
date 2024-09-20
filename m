Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C388CF58E2
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 346FE893E9;
	Fri, 20 Sep 2024 09:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ns4AQwjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57A9893DE; Fri, 20 Sep 2024 09:25:15 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24BD893CA
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so14273385e9.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817112; x=1727421912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8s1QELf7MweKbuaPXhfoRtb2JnDuypZTg3BlvQmhKO8=;
 b=ns4AQwjgnq+5R9ccpC8Exg9t1paPVJBQp7bO6VcyauOuMwCbDn1niRh2/ZKct52aQw
 V1lak7vQivOpECasqseiuWgESvG8dNICdfZWZQd22MsZlB1o5lLKsz5q31Ha5rF8nGBi
 CzjaEHnMUHCV6c3pan7LSqaJt6Br3ORkgpXaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817112; x=1727421912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8s1QELf7MweKbuaPXhfoRtb2JnDuypZTg3BlvQmhKO8=;
 b=DBuw5+eLBwkTp6IJKegEPX8aUevLMW/uAAQ4Vhgt61s+k4cQT9siM/8A5KjLEuRKoj
 20PZXNwEWV7tMGHCxdFZJexpEmW1w+clUw4INRq6G5+l5jmqfoFGMzA0qATy2Be49BW8
 FrL6t1UuxoxAf3hapLYt8o9lMIoXJufp5ZizBtdDvtW2maoC2wm9DXa++N91IbCkrd6T
 YS5yUTMkQ9TlZbsk5v2VrDp2uZjbew8V5xt8naPABKitD10T75Iy5eqPcyv3O0Xlzs4O
 wWyV6x/bf6jVmFpccq4bPXjypwfISrRoh54DNIkXZ9HlJuixB6VReeqz0ObTbU8B5qWa
 vlkQ==
X-Gm-Message-State: AOJu0YxSsMdzath51CVuzys1Fvf482/TvWl39EjaWX2gcIsOQodg+S4h
 abVtsFwyVqAN+JmLZ7V4ESps28PN3SNa6mDJ086fbYxn5PvOeLFEIYSxqeDksXyxXBr42ipAsSj
 k+VnP
X-Google-Smtp-Source: AGHT+IHCOlIAS9kn5yMs11qZVB9x+U8YoSB7ofy+hXuI3/1IJnVvpVRHiUgWDxpfAY/a2STnC+jziQ==
X-Received: by 2002:a05:600c:34c9:b0:42c:b22e:fc3e with SMTP id
 5b1f17b1804b1-42e7abfb808mr11122405e9.15.1726817112005; 
 Fri, 20 Sep 2024 00:25:12 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/18] arm: cache: Drop a stale comment
Date: Fri, 20 Sep 2024 09:24:34 +0200
Message-ID: <20240920072444.134997-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

This header includes more than just dummy functions, so drop this
comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index b2ae74a59f1..648edf308f6 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -4,8 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-/* for now: just dummy functions to satisfy the linker */
-
 #include <config.h>
 #include <cpu_func.h>
 #include <log.h>
-- 
2.43.0

