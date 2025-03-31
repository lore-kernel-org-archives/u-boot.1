Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB54AC36011
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 19:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8087081EC0;
	Mon, 31 Mar 2025 21:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="g7UHFjdl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E430B8171B; Mon, 31 Mar 2025 21:16:33 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42AB081E06
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 21:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso46085645e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743448591; x=1744053391;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1FE33bqE57tXeTyivnPjhwylDs0bJgV+bL0/U6pEJI=;
 b=g7UHFjdl5Y3sKxYISE1JcXHo1VQYcfP9SxSWwszIucVQJ7ow2AEfnM1bucoForDVO1
 o5xy/qWgYsDC6ZRB3FQYsqtJVQDRkVhdNF5D2A2T6LyVwgoQ6OqFA0cqyDq8DyyuK790
 ScsqdOZQgDaP5Qa+60npoJmOC3t+Hi+ESxG6sRsu6YVA8iieJKq99ge0ox9gtSPaxK6O
 NeUI06PMQWj8EFoQCePr7fIr6wu1jFYONIZTrZU3NjGA8LUmOp5lTJIA8/uCH1PyCLYN
 QxtCSQYEk88CPm2il8zFNp/vbV5W+apgi8LnRplIe+mC6JflkIsPK1C3mg7IqffGJH0S
 omQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743448591; x=1744053391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w1FE33bqE57tXeTyivnPjhwylDs0bJgV+bL0/U6pEJI=;
 b=OMaAWYZWgcHSznLzt5VgrjWB7G3DVi23TrkJaLnA4KxC9/xFcmKls+uxpSuLEGfQlI
 fhMcPQahNGcjD2aV1gdrt/NK+E+KGXlmfYHEeojuEN8YgAwaNRMERlHriTkTJAXe3xOo
 Vi8+o0YUENYc23+hZ4w4Q1lL+7kAOvp/KrQDV3iyy1q8xWBS4JpxB0GEF4yEisa8UmMq
 QC+mOi2A+lna/x4koof++5KQZG8HYhetHKx3WvJBmvUNyy5GjqgyLhGWW/0c3sHurBgj
 fgNOKPenSBN1crPxmHtyKmaC8EAqjwIMpDs8nUbqqyb4TLpBiR4Y7pw9elCkdYgJtFEG
 uzAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT48ptFEz7z8XVY0fs9oRGI+wvE7oMcLnZUf0vVd5UJoGS/0vZ7Ic2yhb26HPshA/rioJXugY=@lists.denx.de
X-Gm-Message-State: AOJu0YyNiSu98sEW5CSz/I5iLnLTM0bVeuVYeG2pSER9GOkZOd7QhMe8
 CcRVacwpbQyX8B6PbZwPP5N7Hil15PKR8QhZTZWV2hYKLst+/RYULG9tfxpKNQ1qWDIXq4rzDM7
 /
X-Gm-Gg: ASbGncsQORipu2P4eyTGLjitxxlY5piPVM1uFLps3OwffJ/IIYK0zWvinFh0q/obPe6
 zyLdr+ttTi5qDBkhEISMalOejh+fBryOmJGZ9jTJ6IbO5BxhvGAGODEefnEsdwefKc5VYS47iv9
 05O1ZuG03aIsnnXYCZRqMyCPQfQHQlaoD1Qj+Z+smfWN4devTHhlhNwkfGMzCZLJ9VDwbcDu6GS
 C9gIDVtFuuMX84N+iKx5QB6CYZUrV09np6b1o6RxyLdW5ce6/A4zazaipq16Cf0Etsm6C3lHqmv
 9cai4Y6fjSMVUKF2slpDtPtBp9U2SVQNAqUxMBJnwlpzlqLWwgL5BCvJ
X-Google-Smtp-Source: AGHT+IERlKFgI8xuz2+9eolx2Asx0NSsxpLv1HfOJI4uYlN0kxgTHYZrPxycxrIV2LiutyecrscXzA==
X-Received: by 2002:a05:600c:4f4f:b0:43c:fcbc:968c with SMTP id
 5b1f17b1804b1-43db6228823mr89291855e9.7.1743448590424; 
 Mon, 31 Mar 2025 12:16:30 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede98sm173144165e9.6.2025.03.31.12.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 12:16:29 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH 2/7] arm: at91: wdt: Rename regval in priv data to mr
Date: Mon, 31 Mar 2025 21:15:11 +0200
Message-ID: <20250331191520.1805001-3-admin@hifiphile.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331191520.1805001-1-admin@hifiphile.com>
References: <20250331191520.1805001-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Mar 2025 21:19:48 +0200
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

Use the name "mr" since we are referring to timer mode register.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/include/mach/at91_wdt.h | 2 +-
 drivers/watchdog/at91sam9_wdt.c            | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index 78ad0453fd9..a5accbae521 100644
--- a/arch/arm/mach-at91/include/mach/at91_wdt.h
+++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
@@ -21,7 +21,7 @@
 
 struct at91_wdt_priv {
 	void __iomem *regs;
-	u32 regval;
+	u32 mr;
 };
 
 #endif
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index c809a8936b8..dab7b6a9b8c 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -60,11 +60,11 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	 * Since WDV is a 12-bit counter, the maximum period is
 	 * 4096 / 256 = 16 seconds.
 	 */
-	priv->regval = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
+	priv->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
 		| AT91_WDT_MR_WDDBGHLT		/* disabled in debug mode */
 		| AT91_WDT_MR_WDD(0xfff)	/* restart at any time */
 		| AT91_WDT_MR_WDV(ticks);	/* timer value */
-	writel(priv->regval, priv->regs + AT91_WDT_MR);
+	writel(priv->mr, priv->regs + AT91_WDT_MR);
 
 	return 0;
 }
@@ -74,8 +74,8 @@ static int at91_wdt_stop(struct udevice *dev)
 	struct at91_wdt_priv *priv = dev_get_priv(dev);
 
 	/* Disable Watchdog Timer */
-	priv->regval |= AT91_WDT_MR_WDDIS;
-	writel(priv->regval, priv->regs + AT91_WDT_MR);
+	priv->mr |= AT91_WDT_MR_WDDIS;
+	writel(priv->mr, priv->regs + AT91_WDT_MR);
 
 	return 0;
 }
-- 
2.49.0

