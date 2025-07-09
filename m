Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743A8C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 00:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91CED835C9;
	Thu, 10 Jul 2025 02:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WQ7xe075";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99953835FE; Thu, 10 Jul 2025 01:49:25 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83291835CE
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 01:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidzangcs@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-61396c3f681so148288eaf.3
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 16:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752104962; x=1752709762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2RBPz/hC1CLWltD3YdFTs+mJSJEifdx1xlozXA05ys=;
 b=WQ7xe0752KaVXVX4NGgHXtT1tHUDdgj19Ux6IjCtexWZ9IkIW0UcyY4wuv5c8zvcQQ
 R4JRXz/wS0W8pwMNEsChDDQ9zPpkJThsX4bvxs88PvuWM5yqMl8xlY6h84t19NNG5D+N
 qvQvFlIClQl8MfeQB0MOvod5a2xK5QBlOcoxVBbIqeFi35rU3iL22/CGWpgJTUPsYhyB
 qDfwKoNtZyVi/JZgaALdCyc/Iqvgh7ppeUb++fK4xzC/sPUbOy99uXmFmOPD7qGVh/Di
 mlmvi0Q/GcpE1wj6vrKhwRkFjWR+9FL2P1UQJ8L8V2IyrafTZuufuEwM8f027U8BPva2
 5WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752104962; x=1752709762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y2RBPz/hC1CLWltD3YdFTs+mJSJEifdx1xlozXA05ys=;
 b=UgHD4JVmjXrbleNqVCQKQYnkqFlpbLWajZDfB27q7RJaFffCI6rEg8NtITJd8MaAEF
 s9zFOgqHrUTL7wYdHzUlQawGgk6WGMP2J4musVgZJCduk/83T4f/oj2EIoQ0t+lFRaxz
 rKfjEIbGGFpVhu5551wYFx/KsiKP0OWOlXMwTeL7slPyn3CIkts+RRiyQbfudn95K92n
 oO0KwMyxyhIRJcyx8D4pIDdMmYiJkXHpZPvMToifC3KBi+9Sv6WphLPs0K3nJWjU/64e
 iW5tmRwE+3asPgMAoHSnSLUOso+5P7dntdWWVh2Wy5Yep72pcoMP9zgtzJUV6+xmjHZe
 ikIA==
X-Gm-Message-State: AOJu0YxPf5TK7Tej+f8rKQX9dz90ev/UtV4LShWXxqW4jP2QQwO5RYEq
 NnLqZJbsMaZRjZ03MELSYrvrNVF4UDKKkJSL+mSPk+BwzEm/ub551iVMyp3L8A==
X-Gm-Gg: ASbGncuSjw8kOYtV+Q6neVJalERoy9u/Q9mfg5lm5wPLcNwG8o7pxp93E1LA1t0WhD9
 S0jEyu9wA1mQ2ZOUHswWyIF+PohcvJMih19xdvwUwts0EeqlxtuGBEyKogn55eobfmsvT8JujJm
 Q9tMuXUB7XI4tEK5w1T4VysR1NjnDOhlhBcqIMRuca3mekS32jB/5qYOssJSjYgiTeYC665UVTk
 /+m8AmH+ubTWRPmp54iZEcJVQCoWSqzftWO5WTmzrapP9RuR32ltOvCeWX4YG7bVrFshd0nw+/2
 C2goNXD59an65W0DKkYEuJ1LiFtf6r+xwBW67bClnoyqFGCh1eaJ3cYVW8Ss10BUNB7RGBs0Ztk
 OWlRHlzvX7zzxD3W1vTEQF0KanD33EIkeQJeq5Xzm4RKKjN5beA==
X-Google-Smtp-Source: AGHT+IENPrQxbVNSkd2yWBhej/cdgPT1h3OSA6u7bs3V3nN0cPx/cr+bS5/7PCZC1HnvWhqkyRckEQ==
X-Received: by 2002:a05:6870:14c4:b0:296:aef8:fe9a with SMTP id
 586e51a60fabf-2ff107c3343mr470424fac.7.1752104961999; 
 Wed, 09 Jul 2025 16:49:21 -0700 (PDT)
Received: from dva-Latitude-E6440.lan (syn-024-027-011-011.res.spectrum.com.
 [24.27.11.11]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff111c36b8sm74888fac.10.2025.07.09.16.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 16:49:21 -0700 (PDT)
From: David Zang <davidzangcs@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com,
	David Zang <davidzangcs@gmail.com>
Subject: [PATCH] soc: imx8ulp: Add celsius unit for temperature
Date: Wed,  9 Jul 2025 18:49:18 -0500
Message-Id: <20250709234918.140919-1-davidzangcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Jul 2025 02:44:51 +0200
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

Signed-off-by: David Zang <davidzangcs@gmail.com>
---
 arch/arm/mach-imx/imx8ulp/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index bbcd862caa3..5de15b59b96 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -400,7 +400,7 @@ int print_cpuinfo(void)
 	if (!ret) {
 		ret = thermal_get_temp(udev, &temp);
 		if (!ret)
-			printf("CPU current temperature: %d\n", temp);
+			printf("CPU current temperature: %dC\n", temp);
 		else
 			debug(" - failed to get CPU current temperature\n");
 	} else {
-- 
2.34.1

