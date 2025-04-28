Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C38C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364A882153;
	Mon, 28 Apr 2025 19:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="O+0QQfX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F42F820B7; Mon, 28 Apr 2025 10:38:05 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C324F826AD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso22367255e9.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745829480; x=1746434280;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ILi3H+yeXE2G7jjezEr6nEncAdbp/HHg1mNvrQYw0yk=;
 b=O+0QQfX+7Cd1jlIwt9G+AN3DrPYQPiawwolWSribLZ643/Sx+X6Dfh4zohEjmoQ1us
 zqCcsv5+fQCcWB9S8GH+q68zrsHpubW0Z/pEh5eT54joBPVE0JO95zbJtTB8tO3e86sx
 Eit5ghK23n0Kl2W280iuxg+lH3XwlR1QzddBDBZN/1INV9aUIDFJBhnyiNCIrz97SNWf
 PFg/n/MMJA5xjW3t+GnN5Ec26BFbB5kswN/bwyU5iZWW7j+PeViEwOaBmJaUbdf7J5ZM
 LHdeJBIYtNqBpfWCMTx2lHecgMyQvxG3WBpJYTInonQRI6sjg9JzhQoV3EB3O60cf4iA
 b7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745829480; x=1746434280;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILi3H+yeXE2G7jjezEr6nEncAdbp/HHg1mNvrQYw0yk=;
 b=E8iiYX+3Hb5lVmlMvhiF+Voocltnw0vNiK3vsvUkhHfzRFOkVTDwzLb8Ta+Yt+vYZV
 jL9i61iwzIHQfhXJU1oKwosA/fOfgs0WS29HrV4UQ60Zr4yv1StbROmUzLGe7yJ+cNvc
 fWDZahDyuMHKAtlNxQt6N86FOzSdIgkztcAvdv0/eu1+ABZmb4ZXUSkUk8O9j84SSZ7w
 xSdRzsbWxaZ4Jq+ENCOIwfF7qaphiL9iG9dJCm6B4m8mPuTeaNZvJFlLctrLPZbN23oz
 ODLuTGuxVf9NbE+kN4HLo6Y7jyx7FUJnsZEVe8b1QTC5oIXkwaxi+8Cze2cZ0sXeaFy7
 uefA==
X-Gm-Message-State: AOJu0Yyf1YIIKbOGRO0gXCCfUhWdc2j8GnanCKDEleeZcrN3qSW9g1Ui
 S1AGt0ckLINW3ydlx6Pm9f0N9PwVj3PkVJMlRqK1cMlwIhkfhZK0P8Svrhg7o/x7gaIxhcQX+2b
 A
X-Gm-Gg: ASbGnctbeCW/K7J9DXbvrrZ9eBnvWBaYFyXD1PgJmB9rwyOTFKmoQZ8AED7W5JwzmiA
 NxRSDkGPC4D0SYtS6aGY5oKPQQPKceVcImYzQdg6t87zI7cQ1AP9/eABakPGn0sr92JDDycULN8
 XWEIoPBk6oJQRuoWMM/D5iTcTthfKqJdUCK0P0thW1v2vjFs3hcLu8iz569n8KPEUJqRu54/USR
 ++ri7928JOcnAe2cC5W245JH+25dUsPkfXWYDhoiQzXaq7byxrwFoiCBY1IRhmLjwnJhaB6Y3nT
 ffdiLpJvklY9Z5QYhSW7YUC44lV4n9X5AcdymndB0slLGh7OYQ==
X-Google-Smtp-Source: AGHT+IHujQ1kG0TxwKPgbNbFAMOUI49U19xDBYdAnFKDmFc6f6OqiCIfx7nHUM89F9Il0ms9/tgrEw==
X-Received: by 2002:a05:600c:8112:b0:43d:609:b305 with SMTP id
 5b1f17b1804b1-440a661497bmr111490085e9.17.1745829480122; 
 Mon, 28 Apr 2025 01:38:00 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-440a52f89b2sm121139285e9.8.2025.04.28.01.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 01:37:59 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 10:37:39 +0200
Subject: [PATCH v3 6/6] ARM: dts: at91: sam9x60-curiosity: Enable watchdog node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v3-6-86f0c5d92c32@hifiphile.com>
References: <20250428-wdt-v3-0-86f0c5d92c32@hifiphile.com>
In-Reply-To: <20250428-wdt-v3-0-86f0c5d92c32@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:16 +0200
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

Enable watchdog node on SAM9X60-Curiosity board.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/dts/at91-sam9x60_curiosity.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index 1c7f0fa6a49004943e5a4ac6637db5e806cc92f3..f165fdadb9e4abd08f9166e7cbec0507616c9939 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -336,3 +336,7 @@
 &usb2 {
 	status = "okay";
 };
+
+&watchdog {
+	status = "okay";
+};

-- 
2.49.0

