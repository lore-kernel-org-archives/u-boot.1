Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36020C8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D168F83616;
	Fri, 29 Aug 2025 10:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dJHhUdLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F538360D; Fri, 29 Aug 2025 10:16:53 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFEAE83447
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3c79f0a5fe0so1057313f8f.3
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756455411; x=1757060211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGjVQfRA1uDRqScNoyVQErcwSN82KzUbNNOYE1FMKHQ=;
 b=dJHhUdLINKe1rtjFNH6+gvNhJ9y+XcICeKDHdFP5lKfRpxww66/7IeXWg2iK0peUt7
 zbzINRr9M7zwnjNqdsg9Orzr/R555O2qSgdE4WyqJQmhgrXGk3AfZwaFpQiDlgvPQ6rk
 ZIuwxBspkt0iCaqe3d4R8ld/PpqH4qQQX2cwJ0zkus1NLT9qYHZ3LRfD78WQkIvPH/2d
 sSBRmM09tU5SkjTkMFHiwiZ6Aa7PU4hBmTRyVHgNqqat3QrRHMNChaiBtjqg6EN5yYat
 9uM/38MWu99sNHR3Tf1IcyYyAmtOzBgKJ9/Aa8xMHA3Zagj2GF3ebhAzJ3KaoAc6JHAd
 XQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455411; x=1757060211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JGjVQfRA1uDRqScNoyVQErcwSN82KzUbNNOYE1FMKHQ=;
 b=nCYf3OPVcAE7cFcUq9uWu99vSxpvbJRQFnk3LwKNOYkqsAuMfHHB7+cgrXY8G5UhcW
 CSutm7BNc5URUJzT0ko7qKpYesK0uw87C83eeNy1IPlx2BEK33FUaGjSMWqBxcxPD3B9
 PVBjKORsyFOKgwoBnreOJJ8NmT1eXeMylJxw+uZMpNIE6xioPbKCgH9mzauMDntx2pS6
 SF9BA1dk8kdW1PlzqQTVGyrE3S4SkeMECSfYFKYxhmKRPLUEDjlOUljF0uLQJTI75+s7
 /4yms7BOb5euo43KyxKWRiT1XDPQOHIavm4Lwc0MUbm5wVv9FEhhqvfVPFhKockcPBVw
 K5IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTWgkS8jvXiP7EhpnSqdu8ZUA17N4QhXn7tZ/gCv9WQOIK8CTlzOj8puHvRaTnN/PmOSONV88=@lists.denx.de
X-Gm-Message-State: AOJu0YwYlg2KLOlmHZqkzDKsMgkCeaxiTkGw3+i8HP9igfVqFQxV6LA8
 fLPQvaTBaPDHDn0sb+7KjMIA4TwC2NvkcYBI3O8uLJjWXPiEVifNzG6gmbgnXulmCL6Eym3g5/O
 w6J6B
X-Gm-Gg: ASbGncsebQ/5VOZtqyQIeq+yWCozm7UP6wqIQNnaV9RM59x7HwwFnFopLKa7Nr05KF3
 N2a8BGmv/nCz6WwgL5OAmqV4hgJYmP26p6fRnhnPY1YFMKOzjPL5P1qLitsm4tXLo36/Mw60/gq
 cafst8uq+7nbn09C9o6K0dLXCSsdwok4p5LvuzleCnIccxTKnTtZQybjP1pzKpHt9siXIn/ZeVA
 g7goyqJqibo1DTI5ToJcETglFcZdug/5Z2MDD8wZaW+YZ0rcOGRamlt9e0EPiqlhhn3GM4+4Pnd
 hlCTWJufdPdim6znsTGQqhb+iQ9aHiAH0n6gAPNwSqBGNBmMR76A3IpeTjcDxcObe7Fa6f5gqfw
 o43L7xgZm9g2OSJ0d+F6FOIWkYDovBRlJlzzx/C/DU8kLdlXklWvBH5F8MM96lXigapShH5eQ4R
 7ROFXtsx3NdlGftocFWuyU14fJLYhyNw+6fGzMblTnmYTwjpq+w7LolfzoN393g5A4JV8uoX9NM
 T70GDOJr3OxlSpgemQER/SlG0KB8hwFQgQ=
X-Google-Smtp-Source: AGHT+IEJ4LksecnY54EJEWcdWL0O2du64yIZosOyuyA3XZjqXpdh/clJ37DGMD+qvfrYGgujTx02yg==
X-Received: by 2002:a5d:5888:0:b0:3cd:4936:7217 with SMTP id
 ffacd0b85a97d-3cd49367aa5mr6105943f8f.56.1756455411079; 
 Fri, 29 Aug 2025 01:16:51 -0700 (PDT)
Received: from hera (ppp046103010177.access.hol.gr. [46.103.10.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd01csm2449008f8f.12.2025.08.29.01.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:16:50 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Yifeng Zhao <yifeng.zhao@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 u-boot@lists.denx.de
Subject: [PATCH 5/8] tool: fit_info: Mark usage() as static
Date: Fri, 29 Aug 2025 11:16:19 +0300
Message-ID: <20250829081628.2327372-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
References: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
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

The function is only used locally. Enabling -Wmissing-prototypes
triggers a warning. Mark it as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/fit_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/fit_info.c b/tools/fit_info.c
index b2642ec5b763..c9e4236d09f5 100644
--- a/tools/fit_info.c
+++ b/tools/fit_info.c
@@ -26,7 +26,7 @@
 #include <image.h>
 #include <u-boot/crc.h>
 
-void usage(char *cmdname)
+static void usage(char *cmdname)
 {
 	fprintf(stderr, "Usage: %s -f fit file -n node -p property\n"
 			 "          -f ==> set fit file which is used'\n"
-- 
2.50.1

