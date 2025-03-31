Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A0EC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97BBD81FC0;
	Mon, 31 Mar 2025 19:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="PKyu0kGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF2C8129B; Mon, 31 Mar 2025 18:26:30 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617B281E6C
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so32549985e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743438386; x=1744043186;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leMZagHjj4LC/xN3nyFnHjhQpCZFrbioUqWVkeYMR08=;
 b=PKyu0kGegPDg4j2DGWFe2fAa9ZVOIQmUxmfm+n3Z7JC/Y9Zwr0bHTtUrg6KFXKzL7p
 ZoFd3vR0oHilylt1xKDnpnUP+XTSaPyq+CkRZWO6UOuDP2pgZJn7KKFoV7aVQifDE7PQ
 Clb6S2KC03mJ5sQ+IZPlWPJCqfMmMOxBlR5zOMmWHZ62a4mghfK5V30667vNtlBKPuBG
 oXQWPd6zFgESNvu6NH9PUXWrRzbhRxd3rCuuic+AXClceaMBLVGKVHZfrtNtlL8hMC4B
 y2jfVyR2Pg/+ex4TimL91mQhtNhfaMTLBFmbKAc4/of9L7upmCNlUKBuiODZlMnV1AOn
 9lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743438386; x=1744043186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leMZagHjj4LC/xN3nyFnHjhQpCZFrbioUqWVkeYMR08=;
 b=OsYxI76rLdJSUDpPvXIgAaFzQtI/WnL39ltzDufJphAVUhKokK4kM64GkWxr8DhGxk
 BKAbPLF9Gro62VroemSzIN5UThEXkrNiSkFx4lVlmpOSe2NTJatjc+i/v3Rp7z3+rRQJ
 8skExZfdT41ebhYkC/AXVdQZhn6ZyJtOmZ39LcqFpZTlc4/qEau930mcaZFjD+F+ESyE
 apOubVNE/uZiB6jZKsy0mvhHKJHvU6ePyKhVa0GiNGMWYPFKzRH1fM5dcFzHha6KsQez
 HjZA7THVdrQ7qUeGHxQ+mchDaZ3w+b1jYdp8CS7W6y3OlaiyA+NGbbQzcmcoxVTQ9dli
 Q8hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPu9w4BmsISi130afgSY1g3CKgBzvY2OVZv3e1XMoNYw7gwLEUhst6Z1HEfjCnOaaUUKYEzcA=@lists.denx.de
X-Gm-Message-State: AOJu0YzkYbNxM0hbFuNWixPzx8vf6zvUKv1DYZaez0WU18Ql6lCBWXLk
 qMwSiHou4FqX4Fu4IBHOkQd7eqnCLEKRktC1pepuzOAQ5Zu8/hflV5nwFMO488s=
X-Gm-Gg: ASbGncu6Exp4II52Zd/5YVxs+Xso4mOKucjzBbcH6JaBR9pErtNNKMHlGIa8mKaDLqd
 4vPd3nxELgxEe98Nh2wE6va/LS65IxMik3NgM2cjrla2+5YGlQBuUd9vwVCOWeBt3/sbKJizLPL
 O7Fy3fPxoUDkHSt541KPh2nDeyJRQiwOloCNrK0r9+nV1BzmJauR5m7z6iXCRbGR2lFuKUyw2CM
 pqwkyNj4JY75rL1ngsGv2BCmo45SOXKdVbMldJNk0S8goXpsCEIW7EuiVYoEEFSs2RXhdN7BeNH
 7uTMBHsoK0gip9WRUYHJN83WwMuMsjqZG7x+XFWUXA0uhT4QvzB5aovf
X-Google-Smtp-Source: AGHT+IGnWMY54YM48NJYNMIagqcQur7POJAViCqIzDHzJChfXEKhrPjP7fqmPw8o20CUXJFllesx5w==
X-Received: by 2002:a05:600c:470f:b0:43c:fc04:6d34 with SMTP id
 5b1f17b1804b1-43db628b92fmr78654615e9.20.1743438385601; 
 Mon, 31 Mar 2025 09:26:25 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d8fccfd9bsm127267695e9.20.2025.03.31.09.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 09:26:25 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>,
	Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/3] ARM: dts: sam9x60: Add USB gadget DT node.
Date: Mon, 31 Mar 2025 18:26:08 +0200
Message-ID: <20250331162611.1557759-3-admin@hifiphile.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331162611.1557759-1-admin@hifiphile.com>
References: <20250331162611.1557759-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Mar 2025 19:00:14 +0200
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

Add the USB gadget DT node for the sam9x60 SoC's.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/dts/sam9x60.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
index 3b684fc63d5..ea2647e5fc9 100644
--- a/arch/arm/dts/sam9x60.dtsi
+++ b/arch/arm/dts/sam9x60.dtsi
@@ -69,6 +69,19 @@
 		#size-cells = <1>;
 		ranges;
 
+		usb0: gadget@500000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "microchip,sam9x60-udc";
+			reg = <0x500000 0x100000>,
+				<0xf803c000 0x400>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_CORE 8>;
+			clock-names = "pclk", "hclk";
+			assigned-clocks = <&pmc PMC_TYPE_CORE 8>;
+			assigned-clock-rates = <480000000>;
+			status = "disabled";
+		};
+
 		usb1: usb@600000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
-- 
2.49.0

