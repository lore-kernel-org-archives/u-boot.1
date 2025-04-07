Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816EEC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 11:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF8DA82CF4;
	Mon,  7 Apr 2025 13:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zqqTUotQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C11982D66; Mon,  7 Apr 2025 13:10:20 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B099782CEA
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 13:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso678478966b.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 04:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744024215; x=1744629015; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cKryFZ/FLDpBCKXNp3Qa1unEXPrsAiwPql/xfdaCIqo=;
 b=zqqTUotQkivyLy82dn7lovYmLHoghTpyt0IpiTIrH505JQ7qmtLKUkubWbhNQkuLyZ
 2jw4qO11Al+gs8kNXK+e7uVF0aY6A5LKkCbPR10RzbIlptT2C780LeLQ0vNj3bzcXXwa
 G6NueJNOftfkVAu7BRIVuyntcxqtZeMRb8f0ShxQahcYq6ad0ifaJPe1eHhuztw5CIrV
 Mby4GHdGNHwFT/W7yX3H9t84jv+EAwDqLs1IvrpU6cN9sXmIjo+m3XmSTYC96O1UNR7O
 0clc5SHWUYOr/FtdrTt2FcLq76MddsSYbQlYRPjL99damKYqm1BQdAmF1k7/gv68JvKN
 pIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744024215; x=1744629015;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cKryFZ/FLDpBCKXNp3Qa1unEXPrsAiwPql/xfdaCIqo=;
 b=qQ1Ir8kwKsvep8WPYnLdLbQzPhqJ5OMCUHcOYHTJ4urRm72w8UiZwuCdTUreAC27uB
 HGKb02yRjIyXcubeUuC+zdkwYDkIHVb/UFxkaFerCD0On8IxOAiQoEhy9SRN9jFztwCh
 1uTqP4qaS0NJsXGL0bYesvF9bb7N+acf/kSKiU0OFQBP2mkOJ92edH6OEzEjr1HzoEGR
 Q4XwoqFcY6vYquUPY1XXbiCsYBPoiViT2YndgSgLuOhFJ2lYByyzAPHU5jaSY8ACDfHx
 IGvfXDP+Z0XMS86yBWXXIQK7WQ6uiiuSmM3mFY7+hvG/0d4eb/IXSCna6AUOvuc5Dnw6
 fqfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMfY5/FSKotyLiWqti6Wc2C8bcRYwkPrHpMOVbmyEg30z6TAE9k+tjGZVh1Cxi37z6oK4QNSM=@lists.denx.de
X-Gm-Message-State: AOJu0YwoLSwy3DcdJyaxEl4QgqAgGgpSrC1uC7ekqxNBTO1kKefxSbOX
 USAnuXcvtOL28R6gUUD0t1Buay+zdn18ok36Lv8k7QeM+0lZQ1uqNAXcbzYcZJ4=
X-Gm-Gg: ASbGncuOvAcxE6KzPnX9eqL8KOzssrG3GLazUZnnkpd2pINM9MRTNEMrfcfViSEPDz8
 SBXsyNIDsW+yH3v373EaEi6eXedP1rzKzF9npV3Z/AYQgopTTyjURgeknjAWkDepIcvflaUacWP
 MoJXPU+0vaAFzAfLH6NwkA2tiz9vbwhZ/f5af+DDVCJpQnlqoNharNRJW7W5SuKpoTzKLoaN/xK
 yb6O0HzXN9k5qiBKiKpf/vmP651WVcqaAGmcVaa1+ctrBq9daZW7C2P8M8KFjcp1lsDrdnCpzQG
 6saKcbEHjwA+mGqg4xhZprdhpFWnM/drBzfhjVMBT1t9CFOy3GrWYTctoLUk9K4cuFT0
X-Google-Smtp-Source: AGHT+IHRfoxuqYtN+c56t3Ovb1X3T819Sueubq84Z0Mx1RYXT7UV0rmbgbsH2ylmd4/BOP/mOyPtoA==
X-Received: by 2002:a17:907:3d94:b0:ac4:3d1:e664 with SMTP id
 a640c23a62f3a-ac7e762045dmr659794266b.46.1744024214771; 
 Mon, 07 Apr 2025 04:10:14 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:3dfc:f90a:642f:d614])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe9be51sm738021266b.50.2025.04.07.04.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 04:10:14 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 13:10:00 +0200
Subject: [PATCH] IOMUX: Fix stopping unused dropped consoles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-iomux-stop-v1-1-d6485f7446fd@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIey82cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwNz3cz83NIK3eKS/ALdRNPExKQks0ST1GRDJaCGgqLUtMwKsGHRsbW
 1AF7IRvFcAAAA
X-Change-ID: 20250407-iomux-stop-a5aabb6a4ec1
To: Tom Rini <trini@konsulko.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

iomux_match_device() returns -ENOENT instead of the end index, which means
console_stop() is never called at the moment for unused consoles.

This prevents e.g. f_acm from releasing the USB gadget interface when
removing it from stdio/stderr/stdin.

Fixes: b672c1619bb9 ("IOMUX: Split out iomux_match_device() helper")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 common/iomux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/iomux.c b/common/iomux.c
index 1224c15eb718b5e78f625f57274000114d85c7de..4844df51fbec645f54d14f31e34ed717da056667 100644
--- a/common/iomux.c
+++ b/common/iomux.c
@@ -131,7 +131,7 @@ int iomux_doenv(const int console, const char *arg)
 	/* Stop dropped consoles */
 	for (i = 0; i < repeat; i++) {
 		j = iomux_match_device(cons_set, cs_idx, old_set[i]);
-		if (j == cs_idx)
+		if (j == -ENOENT)
 			console_stop(console, old_set[i]);
 	}
 

---
base-commit: 0efe8ea57fc7a1a6fc5f64fb3cf6bc4a1a4fc219
change-id: 20250407-iomux-stop-a5aabb6a4ec1

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>

