Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9FBC3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C210F88AD2;
	Thu, 18 Jul 2024 19:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LYnH/D1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C053988B14; Thu, 18 Jul 2024 19:36:40 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4759688B16
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52ea5765e75so800194e87.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324196; x=1721928996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ue0QbSzgNQ5B1TK87pANzgVrklqUS9UvEnbBVZ5YOQM=;
 b=LYnH/D1gXF1ZudAjo+IZk+y3/gmlB5QsQDppCNFa+1+zmc+uRycc9FzwKmqhTdN9Y2
 1pecf40Kw0nzXr/ARUyKIqRcx+BcIPe5Fd3+F/VGeHRqtLfzalYRY5wA/Ub9SyO3nIUK
 TmijBd+3f8bZUHpgfuJ2nH5cdegV+ywDFwHKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324196; x=1721928996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ue0QbSzgNQ5B1TK87pANzgVrklqUS9UvEnbBVZ5YOQM=;
 b=egOBXiTb5YRva+2+i5nuQxMIQRjunJFbfez2I+aOacTAsDmWsyj+li2c/iA6mIa5oD
 FOva+TWNEyUBLuALeEQ6LGaYkFZFlBursDvs10Am2TpnS2KmyX89RBmCUIHuvjE6Bgpn
 0e7MHsKXk3chC1t81oKz1rdaM3h0cAyP3IW/rdruqEvgZgwV2Cd7muX3hQRHJRoO3oj7
 wZ+QdOsdgPQ8NO9xF7SmmQ1LLScC7MvYr94XjHR72RwqWeZ8DJlTR3fTvPLEf+TcSCQN
 kFnu1ESazsj1+jKTdiaVIfaJvW9xgziUQ/ajiZLov23/KT37dXYZnv+8/7zfv/kRJW6e
 35sQ==
X-Gm-Message-State: AOJu0YwyQOuN3kAMfBRdWxr72IRaYtdNl4Eo0VCOMq9/BOmYpHUKcuv8
 hL8qDQzt71+FmKoLZPojHEBWJipCAueHuAV362A3IvyUZoUxNdgPUjTc5sIWaKqViXvEW+PT7Xw
 =
X-Google-Smtp-Source: AGHT+IHDPaYtnVYrAZBSK4nmr/UARhWTflv8mIs705RV5V3/9dRM5NOtUoCT0JVw+BTNNBalYWBpyw==
X-Received: by 2002:a05:6512:1281:b0:52b:bf8e:ffea with SMTP id
 2adb3069b0e04-52ee54113d0mr4136429e87.40.1721324196268; 
 Thu, 18 Jul 2024 10:36:36 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH 02/20] i2c: Remove board_i2c_init()
Date: Thu, 18 Jul 2024 18:35:53 +0100
Message-Id: <20240718173611.4014274-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

This function is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/i2c.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/i2c.h b/include/i2c.h
index 4e59009cd93..8d91b24b43b 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -972,14 +972,6 @@ enum {
 	I2C_8, I2C_9, I2C_10,
 };
 
-/**
- * Get FDT values for i2c bus.
- *
- * @param blob  Device tree blbo
- * Return: the number of I2C bus
- */
-void board_i2c_init(const void *blob);
-
 /**
  * Find the I2C bus number by given a FDT I2C node.
  *
-- 
2.34.1

