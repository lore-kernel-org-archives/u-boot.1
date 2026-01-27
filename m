Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C284BD340BC
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF72C84164;
	Tue, 27 Jan 2026 17:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uA0wf69s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C80C184181; Tue, 27 Jan 2026 17:51:14 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A9708410D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso90475e9.1
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769532668; x=1770137468;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ezBWhVyvZmKYOmciqa54jm6+3a0I0XPnDPsfj4xwrjQ=;
 b=uA0wf69skn7jli+qFBBqeazVQKAZmptKlZrxeEnWDx9STNz6fHibu/vtImHoSsAY3d
 Oua70ztMJL2NSHTgXZop3Xz3yHfo68FpDskqbl8M0LPFKQMwYah53DF5gxcyf8PyQFn4
 QeN1K0owsPPbduemTZlu9KasOcE6SXSVbazqHLBZHfnvqhFt1oNfnwEimcqD8fme1AKd
 BngHfQ4VRj5YnUK84h72TMoM9e2J0IsXi+hNvUVTzythxClVGX8Xdx2PyNkftH1wTRqC
 pFz8ntAG9m5q3eyYfEb89WLbW6FoUjtdmE/q6qF8LHAOgNX/f4RtSWDfjDBkh3iW8k7j
 p9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532668; x=1770137468;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ezBWhVyvZmKYOmciqa54jm6+3a0I0XPnDPsfj4xwrjQ=;
 b=lxGZqLpMoEmeMYNJEeraJe45x9HE0NSmquwMIKLLla83HRB6lz/7e9T9ROxd1dsMFn
 WVbbl5keoUC8VcS3A/s+eO1xtZY+6Z4PXWaORmybSuzGUfAnpdSH/QnRvxHaAb9GLfhE
 N5mF092UoaD0HrX/oyk/+3ioaidR6LgWoInEahJuKeiGntcm+nu4IXkw0pdeAqVKhdP8
 aZ5/5T+WZbqtSvHFw9+vd/aeI1hC1GwcTe7k9X473S6GVjKkOH6exzcfDDPYdReOEk/Z
 le+5F0HU5hVxG0HVPCibpLITKP0jnEOa+tmtIgIuRpPsD4HuPZ8CLfCqWB6/42egeOZk
 etYw==
X-Gm-Message-State: AOJu0Yz/A8U1BMEb8MM4tnf1dBYb4S1jVQpiDtAvuh2vHI4aiRusTXOy
 Ux8o3owY0Kwasqc4iiv2vZKaV9hfoVHl2ifkceu5jWLA/qXWh4X68TSGUdXZOvmVIR0=
X-Gm-Gg: AZuq6aJaaOsAYvx8QkXUEpYpmv/QjJwhmEfZ+AQrWf9UE8XMMnAiDcvbw2eb5LT2Wwp
 R1E04eSyaBzHhW2DYg9JLV2sCydxLuZA2z72//WcgznxZhCPi+x0ocdMsSrO/y9JHMbpDX79Mtk
 GVizzhvTCYk5rA3IMg811YBCEXJhMcX1SXUA6lwnSiJRHWlG1krkqIV8bTmdsG8E5iu2b/Z3Dpz
 sDqFDQbDoJwWKqO53RvLBIrum3TzQHsO9Xi90kN0kyf1M9KH2wP0cgOnuQ4pFCPzulkbFcynYmE
 8fHAS4vf3KsV9snG9XMRSwKS0+WP1DTxMEW+Aw+Xzar5X3l0jkC4AMp9/+Ks5xuqno4PjJPnUCl
 U+oPcyxRbXNTMdupRhFChQTL0e8MlbMm92jTpzG6ji5TeYiqUnpI0ILQavGFmZnNsaeKvje8OST
 H7NBtdm1f4
X-Received: by 2002:a05:600c:8011:b0:480:4a90:1afd with SMTP id
 5b1f17b1804b1-48069d44770mr23880165e9.0.1769532667946; 
 Tue, 27 Jan 2026 08:51:07 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066aaf235sm69629565e9.0.2026.01.27.08.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:51:07 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 17:48:15 +0100
Subject: [PATCH v4 01/10] arm: dts: am335x-evm: Add backlight to the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-am33-evm-oftree-v2026-01-v4-1-0dadb0710ce7@baylibre.com>
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
In-Reply-To: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=msp@baylibre.com;
 h=from:subject:message-id; bh=MOaBRsJLiMn5KFLHX+aP+ShC5FNcUUiJ60lJ1DW+oYM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyKN+sEZdimeAneKVrSNTGf/VHcmsMz81Y84zLyUZ+nZ
 99+f8rtjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZiI5FpGhqferkv6o8/aepeZ
 huX5P37gcynYUP+us/2Wy4/nVe+53M/wz9DRTcdkZs6FgshPzFwG6U/WlG30qHvwSFf43H1r/6N
 /OAE=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Add backlight phandle reference to panel node. Without this reference,
the display driver cannot control backlight, leaving the panel dark.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/dts/am335x-evm.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/am335x-evm.dts b/arch/arm/dts/am335x-evm.dts
index 1b5b627006822a9bb4df1c6433ce7eff114dc029..52ca4ff6809ad24fafbdd515fbcde840715cf20f 100644
--- a/arch/arm/dts/am335x-evm.dts
+++ b/arch/arm/dts/am335x-evm.dts
@@ -94,7 +94,7 @@
 		};
 	};
 
-	backlight {
+	pwm_backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 0>;
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
@@ -106,6 +106,7 @@
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_pins_s0>;
+		backlight = <&pwm_backlight>;
 		panel-info {
 			ac-bias           = <255>;
 			ac-bias-intrpt    = <0>;

-- 
2.51.0

