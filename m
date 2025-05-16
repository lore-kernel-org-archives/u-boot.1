Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBA3C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455BA82AE1;
	Fri, 16 May 2025 10:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iYXwVvSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB88D82AAF; Fri, 16 May 2025 10:17:53 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFDC480050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so18596505e9.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747383471; x=1747988271;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdgVnzfu7bKyudZdAbjiud4xm/lcKQujPN7x6PEB2ew=;
 b=iYXwVvSaPVbFluOt5PJL8rOXo7ds44RJz2jaoFuB+Xb8h8Rh2ijnDwgigClfVR3lQz
 x1NCUuE8GeiLC2cFI5Ys/IJQ4Uoev/zH9eUBBDAJdj5SgICoE/QqvrHo3RHK6dubEGNs
 5gpOifaougbY9Y7QQ0m0WEfP/0ykZ5iUD0R9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383471; x=1747988271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdgVnzfu7bKyudZdAbjiud4xm/lcKQujPN7x6PEB2ew=;
 b=afDxF373v7i9xyckZm49BlUwktY8El/7bTL7uPYth0S1baZRGLOmUlsrZ4Ri6RmNeo
 Uz8a3LuSmIPGGV4m7wmmBbaSqHowtHuAhNm1elgpOeBaFQl4CqsQRsMiO9TrbsKkJGa9
 pDEv9iLRWBQPrE7mzpOe4pXrT7UVoZoxjBhZkjM2a+xYlOrcYvG4zXeXp0mBLEtmW6Kp
 UxTjOS+MOWKL+CA4xGgF9rso8ua5T6m+mDQUZVLkVBGTidCkay4i7d9Z8/Y5iLvplE3n
 NUxlQTfS0hfK7zkd089OXQMy22xmTft5m2rkoAyurSldik9sA5OMgttTKVtOQGlzX3W6
 FYOw==
X-Gm-Message-State: AOJu0Yx+LPPflV6XCSm2cXpB9SjPoMsomqKNVuGc7UFNhBmHwEK+QzKc
 836NXApFHg20wAPHEIZ0xBF4l9x2SbSjk/FUJNZCrnUdZerzxLr4c1C1S/kFGNHpwkMpYVj8Ui+
 kjXYj6T3PfPN5
X-Gm-Gg: ASbGncv6gsU7Pz3n477mIRSuCB5//V1cKsvef+1HaawjwAQ0EYLVtMWc3KTaE2D8sv8
 G5X/K2NJvFlM5Skz+mcSzJSWjXeXAoeSTu0LoF2t+PjOqY9ErTPMe0qO/U+NbalSL8tyIo1eoW6
 QX2MqCBf3IoRSjRsMfj+Wowo+Gu8UJI6funBJ1AOw+yKTt8+1HpYSoFf+TasNvRlzW4gUtTKVnQ
 9i7tHgNv1pYxQ7Qfi0MHQCKsA4WyzhBZYEt2reRYcjeWUesyHDZQbV1SAzUfnx7s7MmWLKPattU
 WN4BtGKcYb0xO6wpw0hfyyf8SUHxz+6auiVEzIN61N5HdD7CaR8GcGAfpyb4VuqcgwQ3+oi+sIa
 STKjmA1zOpTwAytk4UlRotx1hWeIvNfsJuuo4womb
X-Google-Smtp-Source: AGHT+IEq43dPZmx7nbnLHYH3yRX4bZcUalB9A0jlmQWm2Surn8aGY66x0el4Z7WmQTteft+3Nb2Zyw==
X-Received: by 2002:a05:600c:45c3:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-442fd664965mr23793605e9.24.1747383470932; 
 Fri, 16 May 2025 01:17:50 -0700 (PDT)
Received: from panicking.rbg.bshg.com (p5b26784b.dip0.t-ipconnect.de.
 [91.38.120.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d0fasm2098172f8f.8.2025.05.16.01.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:17:50 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm: dts: imx6ulz-bsh-smm-m2: Fix reset using wdt-reboot
 driver
Date: Fri, 16 May 2025 10:17:21 +0200
Message-ID: <20250516081738.2524518-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250516081738.2524518-1-michael@amarulasolutions.com>
References: <20250516081738.2524518-1-michael@amarulasolutions.com>
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

commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()")
introduced a regression that 'reset' command unable to reset
imx6ulz based BSH module's modules in the u-boot.

BSH module's imx6, imx6ulz-bsh-smm-m2.dts

Fixes: 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()")
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

 arch/arm/dts/imx6ulz-bsh-smm-m2-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/imx6ulz-bsh-smm-m2-u-boot.dtsi b/arch/arm/dts/imx6ulz-bsh-smm-m2-u-boot.dtsi
index c67622821e7..faf596255f1 100644
--- a/arch/arm/dts/imx6ulz-bsh-smm-m2-u-boot.dtsi
+++ b/arch/arm/dts/imx6ulz-bsh-smm-m2-u-boot.dtsi
@@ -5,6 +5,14 @@
  * Author: Michael Trimarchi <michael@amarulasolutions.com>
  */
 
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
+};
+
 &aips2 {
 	bootph-all;
 };
-- 
2.43.0

base-commit: 7a18328d70cddf8d9ffab046ff38def5d2f61add
branch: next
