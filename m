Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D285DC5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 21:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A7B682B33;
	Sat,  7 Jun 2025 23:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h9U41uwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C440C82AA7; Sat,  7 Jun 2025 23:12:09 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4608059D
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 23:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4530921461aso2342725e9.0
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 14:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749330727; x=1749935527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2psi2AxWU6XtTKqenHKTIxrBxU5NZOIJuo4vEnlI3kY=;
 b=h9U41uwDGnLTSd3z5PQYDH9Jd1Ba6Shc9qBAyMrEkKw9m5ninbAWxBSxZ9UfrJ8xUf
 key6ni73Y2Ujjoo+RjFCyFF0ipPpQfd0El5nhUiWkGC9Y+7MbaEHDrpcaBdx3apjRwZv
 F3X7F4ztkUa98ueCZMjg9Q3LcokUeku7QXmWr+XxAt55B4hJBGPkx0+Uxn/Ge2KxdKus
 2Md15oDFCu/sLe/sHST3Pc057wCrcZTzkBVvjLnM8egwubJzzviqO7KpuVrv6cSm1FVu
 ++RAdHlejO5tiCMxWZI3LPVsV7NMw/rXV6AuK08jwnVDC/r1Qoe6koQgL24fxd1UHpex
 AZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749330727; x=1749935527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2psi2AxWU6XtTKqenHKTIxrBxU5NZOIJuo4vEnlI3kY=;
 b=foe3TbgORth00OnkAnNmn4rmxmipKZRE3PPx8hQnCcOJalXbD/3T30Q1o/UeZm4pEZ
 xTZ4EXL97BQkZksQEa1JszjNhOl6aWMP/Jp3wy3PQ5mhqP6w8NGuhAG4Imx9vz+frRXH
 tsZZjPl5zSssus1Jx3C7QCKdsvLHULKE3v5RAdjRXPdQ8mlniqy6Scyx4F29E6R2O4rA
 c0rZ2BQYeS+eJ2dgFIQCjntJhj+PVyG/vIDXGT960TWzZmfP8qP95zp3u/Oa8eIHNc5H
 fKfP/NtRWDUzB+6s4LBKKdkBGbtDks8S/lKIr7hepo8trWdW62A7DJWiVhXtTzeMrNW/
 jWAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOMNAQlqXcnTPtpMTita9p5wU4eRFgTrYMLz2NdFxD8kxeA3VQ3LpHH4mkN7bKvXak51sj+JQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxcHYF1kQexRngT2Cgshgm6YQc9ZOsT5VGg3Y6mMDJeyXm120xW
 0juKxerRMjqdOmEXDPYkwuXXJRdQrPHyMlT7CeX8R3hbajRskNfdQ8dv
X-Gm-Gg: ASbGnctVrIrNRhYYq3Guv9enCciUEi2s8xPOsed2qIxCkvLjG6vdkQ3P14IiFjgLooX
 wNcwZv5RKWYzYPswQNu2Rb0ooESFCKlvIB86XvwlL0tc3oC9QuX0U0mhg9r/aQZOBXD/hQ0LGA+
 M+FCfs2ZPhOy3A/GEjXgrME9B1mCRzP/Vurdek+GGT718ds84Pytt3MDIGtH50WfTY/foDoDM6L
 edqoNAriRT3N8D4TQQ4XEEKfYOrNtoAd63wBowGQJOApMOfSsQKFaaJTH8tzYQxUyxdI5+yqD0k
 9Kf2vjA3CVYPHJoD4fJHp2gAcXxUqbAhnMg0a6eAohQihJGJpnA8k249BgE9taO2UOQImhk+3DN
 4mhuzfpr4HAoETpnIgK/PmE37YRgi7sE=
X-Google-Smtp-Source: AGHT+IFuALc0l8tJkAwKgQ6NoTmmBC+lKgKoLk2FxvSYlOZv5hWCaIJHSDVEBJXWPND6c+K+0fyEXQ==
X-Received: by 2002:a05:600c:3b23:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-45201416ab1mr74371035e9.6.1749330727070; 
 Sat, 07 Jun 2025 14:12:07 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4526e155ce7sm64368245e9.10.2025.06.07.14.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 14:12:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 3/5] arm: apple: rtkit: add missing header linux/bug.h and
 linux/bitops.h
Date: Sat,  7 Jun 2025 23:11:19 +0200
Message-ID: <20250607211133.2005-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250607211133.2005-1-ansuelsmth@gmail.com>
References: <20250607211133.2005-1-ansuelsmth@gmail.com>
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

The GENMASK/GENMASK_ULL macro requires inclusion of linux/bitops.h
header. It does currently work as bitfield.h includes it indirectly
but this will change when bitfield.h will be synced with new Linux
version.

Also raw printf require linux/bug.h header (also currently included
indirectly by bitfield.h)

Explicitly include the headers to fix future compilation error.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/mach-apple/rtkit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/rtkit.c
index f3561543a35..251c6056cbd 100644
--- a/arch/arm/mach-apple/rtkit.c
+++ b/arch/arm/mach-apple/rtkit.c
@@ -9,7 +9,9 @@
 
 #include <asm/arch/rtkit.h>
 #include <linux/apple-mailbox.h>
+#include <linux/bug.h>
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
-- 
2.48.1

