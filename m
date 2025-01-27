Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C715C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920AC8142E;
	Mon, 27 Jan 2025 14:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="apRqEWYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4265381423; Mon, 27 Jan 2025 14:41:19 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485EE81265
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 14:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so29431195e9.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737985277; x=1738590077; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gfHWT9IzET3FKpYUeoy/BBIliaCDXtVKIm0+wczvAbI=;
 b=apRqEWYylGqHcG8TV9J+1UC2bbZKJ9GZxPynIQOALZz5qPuDR4lIq4l7geVM+nIaaF
 C3x3+h8h27jSQ+g4SOuL1Me9F4p1CZXFUTywN1OGBSz9Ytg+al5v6BC+7Nz9SxeepWiO
 /0AXOdfDfFaHy+rM3Ajjal5nr2mmowwpnot7D28AwhQCR8XQIhtGvGLdY6ABcA3TePDX
 33zDMLYrJYw53KCnhjvuS+XQvrwjIAnrow5iEYr3DdiMfnsWR7T8HKjzThNPVGJjM09k
 axI0xxMfQLseZKTQfjKT83lqBgWwaW7EESt48blwLOq1pQ114+y1FPuZIMlhB9GFrhs0
 cbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737985277; x=1738590077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfHWT9IzET3FKpYUeoy/BBIliaCDXtVKIm0+wczvAbI=;
 b=GKhKx6NBKiiZJgQ+UCcXeV/qq71G72nwBPAkmlMuoG2w3mb8ua30Ri4+n1Qmx+gE4E
 za82rfbC7P0PcPMkMW/rOHdKWlgdtXeODX9tu63OceOmgryHwOY+YyWSL/+6yO+iGha5
 AvUBa4UKIlwijzTrANPYIbhvayljoaoOIpF1FgiSIdzhKLVdPElKJUV4rvjMr5PYMSQd
 nTybL+8g22TLzNfTjIbsaK9rP7EPJQQ1OjqHBaEr/7EUjIRmXaG27gSfO9Yrh+56v89D
 Om9PpB5NUsH4QUk07x5/E/8AzsOAwdTmoltOFD7Y114+O+9Kl08n7etw7ymTfo1DqQx/
 OOQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwDotL0wWBALzlWI20xL25UsiwGb6WIyK9Egt5CF3T1cFxApPvK3Ede3PHrE+c7l9V9oVzu9k=@lists.denx.de
X-Gm-Message-State: AOJu0YxIug3FQ6XsI3g8QZchgbPqGTgaLMzLOvfnv3hLqOUhIdIuyUU+
 zeWOsIo1Bc9tsVfNj2b+cq9EZGLFuVSDNmHHAHu+9al/E1AH5TW0
X-Gm-Gg: ASbGncvKBgWj9AgwHqdA2GrRHtUVC1VYTXdIPY3LOUNhT+3t/nPPUCsdYfqatqeTIou
 1pJTlwmIYQRPJYGgW9XJDvAafWeJIDA0uUGxlxTxs1TW0ZjLmWgpsgV/g6admJgRnJMrrz5Byr6
 ScverdtAXKrelOI8kAw6lI/5NNyfET9+azzXi5UOwbr1rNs3/PzDkwv8uCOSyeCX7AbqZF6HLly
 rH7zYKPvh6PdUZtS47sXqVS+xSeFMywDInEylb+SRg+LuXkn4BlbvTa9WpiiaOrOxEDfm2b01t+
 mbKYYOeEFbg2h1e9+PlOUa1JPBulWOTw3VVVeipC/3SMnoMpMSfmYwFovUkw
X-Google-Smtp-Source: AGHT+IFGHR4VTCXG2fx/eeSmJGFHZKHvdyDCjzKdUjy9d0J77U26/dNC6ugFV9qLDLZIOOAtjmcHMg==
X-Received: by 2002:a05:6000:1818:b0:385:fd07:85f8 with SMTP id
 ffacd0b85a97d-38bf57a149fmr28669030f8f.29.1737985276655; 
 Mon, 27 Jan 2025 05:41:16 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm10873900f8f.89.2025.01.27.05.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 05:41:16 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 John Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 5/8] mediatek: mt7988: move gpio-controller up and rename
 pinctrl to pio
Date: Mon, 27 Jan 2025 14:40:42 +0100
Message-ID: <20250127134046.26345-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127134046.26345-1-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
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

Move gpio-controller up to pinctrl node and rename label to "pio" to
match the label used in upstream kernel linux.

Update any DTS that reference the pinctrl to follow the new naming and
structure.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7988-rfb.dts    | 2 +-
 arch/arm/dts/mt7988-sd-rfb.dts | 2 +-
 arch/arm/dts/mt7988.dtsi       | 8 +++-----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/mt7988-rfb.dts b/arch/arm/dts/mt7988-rfb.dts
index 2579d7099fb..1694ef8d9c3 100644
--- a/arch/arm/dts/mt7988-rfb.dts
+++ b/arch/arm/dts/mt7988-rfb.dts
@@ -80,7 +80,7 @@
 	status = "disabled";
 };
 
-&pinctrl {
+&pio {
 	i2c1_pins: i2c1-pins {
 		mux {
 			function = "i2c";
diff --git a/arch/arm/dts/mt7988-sd-rfb.dts b/arch/arm/dts/mt7988-sd-rfb.dts
index 38727a271b2..63e923137c2 100644
--- a/arch/arm/dts/mt7988-sd-rfb.dts
+++ b/arch/arm/dts/mt7988-sd-rfb.dts
@@ -53,7 +53,7 @@
 	};
 };
 
-&pinctrl {
+&pio {
 	i2c1_pins: i2c1-pins {
 		mux {
 			function = "i2c";
diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index ee2ad2dbe6e..2d57c6f5709 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -110,7 +110,7 @@
 		#clock-cells = <1>;
 	};
 
-	pinctrl: pinctrl@1001f000 {
+	pio: pinctrl@1001f000 {
 		compatible = "mediatek,mt7988-pinctrl";
 		reg = <0 0x1001f000 0 0x1000>,
 		      <0 0x11c10000 0 0x1000>,
@@ -122,10 +122,8 @@
 		reg-names = "gpio", "iocfg_tr", "iocfg_br",
 			    "iocfg_rb", "iocfg_lb", "iocfg_tl",
 			    "eint";
-		gpio: gpio-controller {
-			gpio-controller;
-			#gpio-cells = <2>;
-		};
+		gpio-controller;
+		#gpio-cells = <2>;
 	};
 
 	sgmiisys0: syscon@10060000 {
-- 
2.47.1

