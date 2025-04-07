Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3878CC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D950830E5;
	Mon,  7 Apr 2025 22:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ba6l3gpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C9B830EE; Mon,  7 Apr 2025 22:02:47 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5198311B
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so4158062f8f.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056164; x=1744660964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wV0Md3YNik26+zOgG2dX/kL4pu5J0Pp6WJbfijQZQSw=;
 b=ba6l3gplCLIHbLFAx+6CER2ujhszKMuSn7HZBoncEnQrgHGJ1IxZVbgWgIu6hjQP8N
 SCGs1/yLRGRXdRZQGW9wgeLQSf72H4EQ2d7khcGpSptnoIQBaEQU5e69R2lpMkhLA2YD
 jDJJr1fxJnNH4ETKxp9dKmSwROH4UfELib+rkCFvXTGwyO5YfIYyjb+52Dc1B8R3YrAt
 QnlkP6nbIsVoqVogwjFyFicFcY6RYP+WOdDpm9kfqeeDfOzsi4DSGmUAZjZ680qxHHtf
 LxB0fy5fiaFqiZV8mmXUQFm6p5JNxN0xBJp2l2nzodpVEKH2ShypjTJ8T7+OC9enPiWd
 A7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056164; x=1744660964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wV0Md3YNik26+zOgG2dX/kL4pu5J0Pp6WJbfijQZQSw=;
 b=RP667abUasPiRExg8iqXcb9pJPmLTYY2YK/bQKFAVudPmFa8++c2zwXWCGkwsarpiF
 6fcYgtIHHtU+9mqH2UNYXlEtRqiOQw0viJPbCiOqQKSs054Mou2Lafzct35fy/I20+i3
 H3ufVdRdaecWIxdQIKFTTMLQHLe8LeH15b2FnOhxW92C0oLsLS72RyHiBA5RIRZZypH6
 HAaNqmqfPXYIvo++rVUgOdWE8jZVlg0nzT/IV1ORC2I0SRFtpwOrGP8pGod6V4yOjbzC
 RH99W1watP0cNxRy8yu0F5Mhi2EooFd9m7E2UQYf17NwmJ7lcvpVM9vPTbnc7VcJhUl6
 7uWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAvKMOKAm4jP2EMPbwL6P1XjrxWjLSbAOd+QSH6QLyOKyUshjp3RibV1DXqUqzT0cqbtnh77w=@lists.denx.de
X-Gm-Message-State: AOJu0YwapxIpIbOXpDA6NSyVTMcEeofaSdGWPl/fDoW9KSINgEXa2c3X
 Sab6ZBX45+8T+mtsvhulURPbU5hM+VfvnclAOi+PHvFbaB1QXFP9
X-Gm-Gg: ASbGncsd3Osots4q9Au+N6ytqr8Gs0JnsCXjcVf7YyKFGfHKTBIRZCkhd6r8iQJ/7Ir
 UlcTyWPdok5Hg8dPKfEtDoiwo+IQ5RBY+Xo5ChP5LVrTbVqPw5sk6y0T2hCyxIe06FJKDlOOjlu
 a8ngxmonezbuXmZ4tIW+gAh0QecTvpXzKkZMB53Z2eeDo/fbnYiko/GMvGmoO1rT4inR2acgYMD
 xi3lJY2LDEv3qjZJU+59rIgESeUYMDPoJXkMIKh/0as4UNztZUmdauQvADBY/QvmVvN2iYaoQTg
 4EVuwFPP28bKYO/+3iyIGGTly1X5GXUPEo1HUIUKrjRcTYPFydR8YdkDqQUYz2m89adpmky1ySE
 bG1qz0i6dCd961w==
X-Google-Smtp-Source: AGHT+IG5T8s0voZw9xYu0Tr8srIlD0Xsmo4uMvODavAgVbtkVGVgyLjDGU2KEmOB5+gmWg14NPqJyg==
X-Received: by 2002:a05:6000:40c8:b0:391:139f:61af with SMTP id
 ffacd0b85a97d-39d0de29752mr9828907f8f.32.1744056163757; 
 Mon, 07 Apr 2025 13:02:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 09/14] spi: drop unneeded spi.h header include from
 spinand.h
Date: Mon,  7 Apr 2025 22:01:53 +0200
Message-ID: <20250407200208.25594-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
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

Drop unneeded spi.h header include from spinand.h, nothing included by
spi.h is actually used in this header and .c should correctly included
spi.h if actually needed.

Replace spi.h with linux/bitops.h as this is what is actually required
for spinand.h

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/mtd/spinand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 13b5a52f8b9..6fe6fd520a4 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -17,7 +17,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #else
-#include <spi.h>
+#include <linux/bitops.h>
 #include <spi-mem.h>
 #include <linux/mtd/nand.h>
 #endif
-- 
2.48.1

