Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C784EC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 10:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C1D834BC;
	Tue,  5 Aug 2025 12:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="subob61D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 245FB834D4; Tue,  5 Aug 2025 12:34:37 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A144D82E52
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 12:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-459d4d7c745so22450085e9.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754390071; x=1754994871; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N6g82YYA6+RYbdImKsThWTuBXLARtwNTH2i4F0a9vH8=;
 b=subob61D1iIlf7Ga8OlDw8zCK/j9HpYlgzRxJbXqdnUGiepx6M/jA4QHaW02bonFE8
 VAU7Y5zNizScOsd/n2zemlojHD2rrwRTtbzILrjvD70lQ3LkXD+lo8BCTCut1uTe2QQo
 YakU5EecAOsQc059R/0TljngNs/USYEoh5BAX9D7uwd6/+wTZa3/kunytI7+9Zt4JM2U
 WpNGDcK6DVoBjVQ10k0/1z2nnvc5cRskCe8kCk3lT27ORKw3X90y+UB5Fx8+jb9e/xTl
 Hh0IeN6IM2o90IA1FOx7JbWoj0JM6huzzGKd8zlJ4rHlGHj5nE0SCKoXlDsCUybwCIeL
 xkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754390071; x=1754994871;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N6g82YYA6+RYbdImKsThWTuBXLARtwNTH2i4F0a9vH8=;
 b=ZloNrS9lNi7z5hxBsK5OlqTuwG9Ch4qI5V/uRBiYw9cZtnRxqNv1soHWzmHYMCOpCA
 109YrB8oBjx4s587nSz8mqcOp9bIUVH3qEfKZ7qs6A+yDm/4SKFZQueHCB+PCrXzamX2
 IFwP64atOnSe4yWyB7b3TaDecrxUXyVIY2lhGWRezTs2h0Ec/o2NyDMx6ShixwHG36UR
 9lW4eBJ1xUNYd631Y0NvMc9P3MJbW85rqvNnnZ/8+Npv2qW8PR/5gciU2EhbU7MO7RRL
 VnvVFv31G2Ma+tf6i0pe3i7C/vGPNVx065MgvvuL7doZ9D3y/lrGybwFj4YNcZh/Yjms
 GYOw==
X-Gm-Message-State: AOJu0YwVguex9Fe6y9HhS0F4Jc9T8y3b9wHT/Pj10RPWEbzonB4qV/uh
 aKcdmSVWE9ZVCvFh4HBksZ53IZINdpnZc7rMt2A6X826Ux+eR4F+t+6RlL786BiTSUcOycSEJh6
 fh/lu
X-Gm-Gg: ASbGncu8jJoG0C+VgcRTEJdM2CnVFiKuJ4Jnu8dX+pk+kvSjxxhqFvlGFapJJYtZIxJ
 wF9lvhQD8ssoTotz8eXiCz+iKBNQXOdPPgLridSrXkpBvRtzeLDHNSp5B9K3dL2b0Bui6dyC3Qq
 fEiD2C1grZW4poERH5tONqOi4Ngtc4nh8GIwvaDpH7p+rw8kEahQl7zyfPly4Z96XaAQNMJ3t9E
 EQAawcfnxDuq794wm7KRGePrK95+RcK1sTOdQ7NV2478jNFOVIcbOn2cVZsBzriP/V0BTxi75t0
 xFOlbvAT2rI5juy7kZD0rNgswpsygTzfm9MxdtmH7c2lZu/xvM5+j+tCN9cl+NSpFlmqvwM1cZY
 Lw5+4k4bb2TKLrlpYEM1YmjDLTZ1EdogktQm2xHI7oL1F73rbhrs=
X-Google-Smtp-Source: AGHT+IHRZ4h64TX+2mZGYuiHC7hvylvJO6Y4pk7emoSFW0riRU8PDwjuHVFoXRE7CvcLW94OnB8nlA==
X-Received: by 2002:a05:600c:630c:b0:456:dc0:7d4e with SMTP id
 5b1f17b1804b1-458b6b3327cmr108378985e9.18.1754390070959; 
 Tue, 05 Aug 2025 03:34:30 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e2a28bfasm19165305e9.21.2025.08.05.03.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 03:34:30 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 11:34:29 +0100
Subject: [PATCH] net: ks8851_mll: Remove unreachable code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-ks8851_mll-v1-1-011a2a310641@linaro.org>
X-B4-Tracking: v=1; b=H4sIADTekWgC/x2N0QqDMAwAf0XybKGtFrr9yhBJazbDtBvJGIL47
 6t7PI7jdlASJoVrs4PQl5VfpYJrG8gzlgcZniqDtz7YaIN5aozBjeuymMvkKHfY+0w91CChkkm
 CJc9nsqJ+SE7xFrrz9r/chuP4AcCHSVd1AAAA
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In ks8851_mll_detect_chip the if..else code detects the case of (val &
0xfff0) != CIDER_ID and returns if found. So testing for this again will
always fail and the code is unreachable. Just remove the test and code
block.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/ks8851_mll.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ks8851_mll.c b/drivers/net/ks8851_mll.c
index cc2e826257a..2c956154d09 100644
--- a/drivers/net/ks8851_mll.c
+++ b/drivers/net/ks8851_mll.c
@@ -347,11 +347,6 @@ static int ks8851_mll_detect_chip(struct ks_net *ks)
 
 	debug("Read back KS8851 id 0x%x\n", val);
 
-	if ((val & 0xfff0) != CIDER_ID) {
-		printf(DRIVERNAME ": Unknown chip ID %04x\n", val);
-		return -1;
-	}
-
 	return 0;
 }
 

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250805-ks8851_mll-9d1ec3a42ce4

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

