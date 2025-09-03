Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886B9CA1012
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 23:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A6B083678;
	Thu,  4 Sep 2025 01:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ktdcU9Jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C49A083695; Thu,  4 Sep 2025 01:43:34 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E09A83678
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 01:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71d60110772so5363027b3.0
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 16:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756943009; x=1757547809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJdf8QSC74anMCp2ms4NF/MROGdh7lLpYPucdHeJCLQ=;
 b=ktdcU9JdBhJXtZMTcay6m7DFaP4P+SHoj1EKYS3EZ/EHQ/Duz59wxxHMuodFts6yPw
 YOcpp0fmjWo/VD8rMIVFwOXYLk9Em3wCB5NG0MfHQ6QWQd2XsX6S5xklhMxz4uxTcU0g
 IPLLr0vVvD9vl/xqv8G0WcAYKpsXxiq29bV2h2co+3tA1klU+A6HBVEAljdcKj7gV7cn
 JBtjUOZLRVAZGdwB9J0JTYrI52vCTkgyWNwrOVfkZAAGGM0lnr+WGlp/Zei03vIU//4B
 GOPQbQZYEPgGxvk9UkcbDCaQPJ0vDfrpkGIHmAUY0OOVSU7eUtK33z1hdlv8IJ9pQh6n
 MRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756943009; x=1757547809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJdf8QSC74anMCp2ms4NF/MROGdh7lLpYPucdHeJCLQ=;
 b=UOYHHGViQtSNESoKMVtp19ZsDxfOq3NPJ/n6x15xDs46e0mUu6OMLPkRH7yl2JVhJx
 JpIDOmroCk48MOBe3tySrPShRKfTdlkElpF4AYAt2kDG2MTUaTyDcpB4DTYVmHz7drj+
 WIKeTW01ikbMkYaeWSXK6UAKpeOxcZaAdNU1ia1VZP8LE/dWqpfQoZP43sGZo/ghlME4
 YzFIq1cHuum1V3hf7J5I5FuzL2/LSZLxm/2Qy+sor0CA42I8yd/kWjtj8Gcd7Sj35ABa
 4N8MKgRL0YEursQjGsiy0pd6zZt4TuuJPnh/zphNgy020FSBg3SOraPeDmGXWH1XtAc/
 o0jw==
X-Gm-Message-State: AOJu0YwAG+cDoowIO45jby1OazoExfVAFMLqqYUWGVpAlaNv2YyFEvaA
 L/m7osJaWXMu1aDjQ8U0LChdLvTq+SnVaVOkXBa+iCPpyaFb/uxc0242L7QF
X-Gm-Gg: ASbGncui1XoNLjFgfAE6pkQlF6Q95Ocvtv0GPOp+gjCzBejgoaeTvHViYYukL8fvIpC
 rfyiXp1LKewWcYn0/cjs72XlrhKRQ7IgVbCpoS41KZBR78zJ9Zbn742R/OUXXWXTQZpZYBPl4yV
 pLPpuqI1k1TywuSgoCblFkO5q4/4tNNRo/AiQJcDVITh9a+wzPj5RINp0gTW/jm16wt5yTs49L1
 7Uzu9JVMEhrhHtdyTS7Zm6hC/6Hvhl5+9UkfHx+8/pDdbM3fNmMxfin+anwz7npZZE43AH6Hn5+
 ZbHOFRQSDaye2NOcIGC6lyzjwFiJtFCwU//3z1cb/d6SmZReJWVj2lbReFJTNvPvGVWh+i5Hot4
 4QMLloLCk4W/VLJ0eDTV9a3wv8LMHJebfhYQx1FoasYkerGVr
X-Google-Smtp-Source: AGHT+IGVCXcI+RI+0+HRJI94ZYLjRhErMPpWfp25ivl/3EJgC5NJ4rCe8z+4zMC/4hv8uSKwhEyr2A==
X-Received: by 2002:a05:690c:b96:b0:71f:d94a:3feb with SMTP id
 00721157ae682-7227640ad15mr208682337b3.24.1756943009502; 
 Wed, 03 Sep 2025 16:43:29 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-723a8503a61sm17044997b3.38.2025.09.03.16.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 16:43:29 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: philip.molloy@analog.com, adsp-linux@analog.com,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 2/2] mmc: adi_sdhci: Update headers
Date: Wed,  3 Sep 2025 19:42:02 -0400
Message-ID: <20250903234205.26787-3-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250903234205.26787-1-malysagreg@gmail.com>
References: <20250903234205.26787-1-malysagreg@gmail.com>
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

As part of the header dependency cleanup between 2025.07 and 2025.10, an
implicit route to obtain SZ_128M from linux/sizes.h was removed. This
adds an explicit reference to linux/sizes.h to fix build failures for
this driver.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>
---

 drivers/mmc/adi_sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/adi_sdhci.c b/drivers/mmc/adi_sdhci.c
index 65a22cefb71..f58897b5218 100644
--- a/drivers/mmc/adi_sdhci.c
+++ b/drivers/mmc/adi_sdhci.c
@@ -15,6 +15,7 @@
 #include <malloc.h>
 #include <sdhci.h>
 #include <asm/cache.h>
+#include <linux/sizes.h>
 
 /* 400KHz is max freq for card ID etc. Use that as min */
 #define EMMC_MIN_FREQ	400000
-- 
2.45.2

