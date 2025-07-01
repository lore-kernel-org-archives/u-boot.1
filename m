Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB711C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 13:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA5D82F8E;
	Tue,  1 Jul 2025 15:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EsdEJpsD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BBAC83022; Tue,  1 Jul 2025 15:45:46 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C8D82F6A
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 15:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ae361e8ec32so757176366b.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751377540; x=1751982340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYDzgwmVw/m7lTcJ+zzdI0wERfqLsdy7gG0/dkdLyoo=;
 b=EsdEJpsDZqRoBd01FR3nEhkFl9O1siOkfU7g4JxGu3p8eHpNpRLH4hfgIfHddSqU7Q
 OQ8om8ScsK62cHUzXVZdMzVWi/RAMwxiB750tHOlV7+Ol3aPlOHM7KLwMmSUn3so08hA
 jVPnwHZ2qX5pFSwZF4LAIugR5OHFkKpbYja9JH5p1HhrnS0SCnR83jmJXGqEHpll49GU
 7qTakl+x77hrNnc33ZEqjWxAm4Z1CBS4Vmd7kZbHjJa9PaEVtGqO4OsW2qt0qOpntdRD
 OkueCzx6gGYGlB5hs2inQdEeCYLW5BM/RGMujLbCQg+El0Qot54jijloVgK2o5zTXxfB
 cZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377540; x=1751982340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYDzgwmVw/m7lTcJ+zzdI0wERfqLsdy7gG0/dkdLyoo=;
 b=gTY2ZaRgW3DAzaeTdRX0Pa5di6p/SSqwmmbnS3mwFmdO1Sw5DLBOsWTQXU7cgeoQ0C
 XsSbxPOTaX5bvLwdjqDNQcXlKj0Yp3xkMcH9bjTIsi0/ubHdaAjjbCwwe9a4AivZv35F
 03mX/fJBeh8OyCnzwCW2fWYrGpujd/ficCoukTViBCpsxfUJES1+5+y/nzAFLOUPOdsf
 8EMu11YgZmEpGq2QFKclLYzyoV8iJDVTeEgpj+MeoUejvKv41caSd/9dprT1ZXWQWSGQ
 FH3aKa6o5TwiYEUawd+imAS+FEgYpORllsg3G7cMXcgdp/SGiXLBH35gKkBiuT3KGfuW
 vi6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg09p2nt/zobmEyujCB4jprK9pKzPfZZF679kORIU2L8xzPM6oJ7IznFYmDxZst4v+dGmbkOA=@lists.denx.de
X-Gm-Message-State: AOJu0YwbyfTeO9nSKY1O0yoWempq1p40nA97qGar9zbSZ4dTmaZossEO
 OZShl5QYZOVMm2Vjd5bNZfxdfEp2u+p+yBQM8pHwj695dS4asLLYWz5k
X-Gm-Gg: ASbGncuFOKIgpGkr1I0iuj2gDtg6Ofa5/KRoofFeAteAF9AIbYpqY+h4glvowIzmaKr
 PjcktDOgXVwGbuo9ocowM+1LWsPKqRfizVjKJYwP1ERe4TlFTtreeQr63OuinnFOvYY+u65adJi
 5oRyw75xA65xRh4SlOdFyNDZiBBJQDgBEBP4n1xAxF4nBMWMdIRPfBP9PmxjhTAVV+ywTvqwjHm
 xhYjJeryTC7YmNJ141dP85bSOUi63Dg0hpXREINuicFbg1Dnvg3/E/8km8VzdGox7bj2KQ7IlKH
 FjlSg3w4q25YvlU66C2o2AVe0fwk0dlK2HrWe+m5gLlNMhWdA8PU5Kq9OaeoRWRcwe5Vo5J+yHB
 qMcGgDGRFrP6RjZln
X-Google-Smtp-Source: AGHT+IHWablILZxz/1XVeVhJAPI1mVUEAgBNUDq51nvYb9q9wkSkpGF1Mrh6/yY5+wY6OjiK93O+qA==
X-Received: by 2002:a17:907:2daa:b0:ae0:c690:1bed with SMTP id
 a640c23a62f3a-ae35019cf4bmr1628623166b.51.1751377539802; 
 Tue, 01 Jul 2025 06:45:39 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com
 ([2001:b07:aac:705d:6d3f:7f26:74f6:c076])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae39ec1146csm288232366b.185.2025.07.01.06.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:45:39 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/5] configs: verdin-imx8mp: enable RNG support for KASLR
Date: Tue,  1 Jul 2025 15:44:57 +0200
Message-ID: <20250701134504.1076115-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
References: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Enable DM_RNG in U-Boot to automatically populate /chosen/kaslr-seed.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/verdin-imx8mp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 4cc69de041b4..065520071d15 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -162,6 +162,7 @@ CONFIG_POWER_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_POWER_I2C=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
-- 
2.43.0

