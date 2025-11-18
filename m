Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E808ACED63B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22B1A83D5D;
	Tue, 18 Nov 2025 14:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VdoNPAcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54DCD83C96; Tue, 18 Nov 2025 11:42:18 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65CCD83D0F
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so303376366b.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462536; x=1764067336;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vFYgIn99+P8RmvLjMwZxh1y/IXw7izN5YUZYTkAxMVQ=;
 b=VdoNPAcjZF8XdE2r2XGP+RBHdq8EUC0K4iCmHYpzJuRBD8cHS5A0xV8ufSb1WCz+Cx
 C19ev160UPFjp9JnOX0TBq+gOK8VS41vcutSqSAq8JF9Vntgcbmw+GmkSijWCTcVeY+S
 fM3hp6nuDqHJLI44jXWmS8uVIQURRKV/NFvJTcAQA2mi17sIBAHrsMEPzmxAy0pdmkyg
 6Dj64NoDLEaegCnUK/yHPjKdII0OAfh0kue/GHLSwxRzW6PF6dJdPH298i3mlIKoFfoJ
 mELNMo3M7i+l54DsrrLl5tJ9EaJo+c4iCn13FxnPlas5NfIES1b6PyT7Eo8Do0UFH4Na
 VThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462536; x=1764067336;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vFYgIn99+P8RmvLjMwZxh1y/IXw7izN5YUZYTkAxMVQ=;
 b=mBrmkx7YnMl/Rnenc+0NDaYpCzPvn2/x3a8BkINQLYtT6CqS9f8xLny2Y30yn84z4a
 SNj3MdHFbFT/yP7RQ5+GAZy1I/dt+DjmAfcKlQFGYngE7eDAskTSO+R4vfg5bfxHHfxD
 mMa7vdUoFUY/JgsYi6jQcobu0TUu6icA3/LNw36POvM1A+ifyYKO+tCuRtg1jbUCgolp
 wiDV+BarjhDFhYYwPqIRCQP9t1PQtV/S9pGyDOBLXq4SFtZsUDC/KC5yDoEdnZcG7dlU
 GaJ4gItsNgBwxjiNTQKKe3hATnVHxE37Gj6O/lS8/sHWegtiJR0NMIouH5PSbexGyXRI
 QZGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWECRzxOcNlVlpuYjD+UJjMOuifNObeJlYLEGBS+JHlv+9pE0A4h3C4BqMuKoQmDHM5vHYUP7k=@lists.denx.de
X-Gm-Message-State: AOJu0YxdjA+8aDkkkqpz4FyrZShAB00CyMcW1hfCsSot9KIAj1mSMrDR
 IWZ702oXTfCetBBQqVdHuQbwX6Am7yOW0uz34CntMYSAFZXFocHd6Jsx8R9sx7pV8+U=
X-Gm-Gg: ASbGncu12jn6bexqk263f7ClOV/NQQXxwItAF9ivl9bwW7aVWU3qeefg80NVC/AhJMX
 ro6/kF4PXIjA0V+fK1LE9ad7sLnWxNNfGDBTqqxpzFIjD6/0D6faM98v9XRpuNotKODloIZWcE6
 tlMz9xtd/lrK27WsGKvy2ls8qFQASAzwFPTsDGPXFl5RHbDe8YFfS4cvig9eZoODxbxiKQLGKUI
 /NYirmAaMftKN+4tPX+CyFhnq3ernB6tGZHSZxlsy41eht7LzDnCJ2M8YjzRD/6qFQ0e4wikEP3
 QYFZtraGNaFID6Yo31gkwb7q6m55por0SFJutGWTe9mdkRESFf4nZ64V81ATQ/2b+vmtl66xBJu
 suci+GoTojVQh07gGuZF0OCu/xLZByMHucVzIdEhS5BqrSkrWS5EemqyHE+05LKAb9jnsh0HzSL
 yQk9fSuLk=
X-Google-Smtp-Source: AGHT+IG7ZVoKYdmcT6fjcSZgcMgMQVpDuAIwZLbEgtrVn0AVcoc1e7jvTG85ylvkaBZ3QvEE7Oca3w==
X-Received: by 2002:a17:906:6a1a:b0:b72:6a39:49e6 with SMTP id
 a640c23a62f3a-b75a09f4c3fmr338658366b.18.1763462535852; 
 Tue, 18 Nov 2025 02:42:15 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fb11f80sm1310503466b.32.2025.11.18.02.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:15 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:22 +0100
Subject: [PATCH 02/15] arm: dts: am335x-evm: Add backlight to the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-2-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5hm4VZwDNLwAsQWqgY5VfNyBgT95pC8D5rDwdROe18o=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZX6uaZvaljQ5nDt6/vijoFWPF6wa5431H1p0JjCq+X
 yd6o9K3o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACYiZs7wi6lBe9qcZwWMZzJi
 t6hvOXf3bviambdsVq5UCjpwSq04/DMjw+1HcU9Lb8fef7pl9cqExi05H9P+SN9blHrwf1jN0iO
 et5gB
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

