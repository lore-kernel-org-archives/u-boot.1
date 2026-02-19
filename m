Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B608E9A055
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169F983D5D;
	Thu, 19 Feb 2026 18:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Okt95Iwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A350283D8A; Thu, 19 Feb 2026 18:53:20 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C9083D3D
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-436263e31abso1128946f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771523598; x=1772128398;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n6vp1Ccy3dOUzENEylKbE8hDLMdMo6/xDG45phrs0rM=;
 b=Okt95IwyxupZqePqkcMo8V0KsxkKzlnGQFMx1HdKEZ67IchKgQ6Mvoi7hAiWKc8sby
 RNaTnIaSLC5K1rpn3gPlxyQdFUpG5PbihwP5TrBwGLWxBF6zgDWZM3PsygsXSJReGwbw
 VmwpPVmat7MIZBkQf6gLuKpvgBcZUFsU8TLIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523598; x=1772128398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6vp1Ccy3dOUzENEylKbE8hDLMdMo6/xDG45phrs0rM=;
 b=QUMwC5QlfEiAfy1Li/xzZCjOq4r+mb2pB8DIF2c2qCukSvn9AY2Q6FfPJX5b7rofb/
 EuEyFcD+3Ay8R4mqShbfWKnU5VIcF9HAP+zokhUSaf7kzehVTRf89/eF5QCZFLU9DNOi
 gHqj54wPiF7msKpeZzkMp+vBDQoX4tLTxK0d+JxETZ+ebFATcAuUwln3+CAHvgBcDPyb
 +VXk0akVXbfjCoHHXEuHQWKXOe2IwX2rfXKUuFiIVwNLEwGnIg5wf6kE+YfuA0O/Mq++
 ULrjCzaPkFzyE2ngoy3FV+xtqJBGppwoKqfSvv7VIL4F86PJcnkLyk5wDp5o1jGWhn5k
 7k3w==
X-Gm-Message-State: AOJu0Ywv9fibouBHQNIck+Aa7O6hZqVB2LTT3ZL+b+iBkJBclGBTFzFy
 HaYjdRk0LKpj9Q6NOo973+IYuvqe/evB662v4t/qNR2/bchA2khwZRts0txJ8lTRaWVkyeStb68
 PEUfo
X-Gm-Gg: AZuq6aKyimaHh550lq+tIfobL3+gKdpVFnEhVpAM5dXd83hbTgPeCXRlV58uqZAijY+
 UfL8rNJaegwPqq9qN6/p8Xup7fJmAHGhgwdPfp9LSe7yq2CdyY+OiO6mTPchPFCBnuRoGcKYaJv
 BjTA/6lBjCl9JWCW8nFN6rM9y0qcpPsxqjgt3qzHS89CzsX7NGdPs5XQ44oZiF2pmWjSG9OH7jM
 F2LPkAwu1Yjk5A4Dv3UbYaLbm54vVpZGZG3E3yRIAPYnmAaW+WnI+mDRAuX59RMdB5rE1Qw/Pk2
 0gQVDRkyS4IG8pWFQSe9TzdEt6EHE7+ZrlCjMsz43Hdkn495k61pUBw00aNEM4xg0EBAyq3hOLI
 xd4+dpvEGCaFJxNn1cdqVEy/ZIEVslF/mV/XVFUrdaNQtb5FyGMVkYvgiIIWCSa5UP0xfubozqK
 8sRoj2O9YWrkosMU+GC6JtLOadxVjX3TcZ/s4LY/STefXS2oHgvUH99yRcTGCnio99MYAeS6Et2
 bS03G1dCHM4kilTwVR5jRlECXYxQiv9xLNWj+BBCwOHqWDnT//9Nl+ImarQLgOtH5A045P2f7E8
 T2P3afx6P8ZTYbgekBPbkG84
X-Received: by 2002:a05:6000:2585:b0:437:6dac:4578 with SMTP id
 ffacd0b85a97d-4379791b7a4mr43510542f8f.42.1771523597951; 
 Thu, 19 Feb 2026 09:53:17 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac7d91sm52370312f8f.26.2026.02.19.09.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:53:17 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] video: Kconfig: fix indentation of help text
Date: Thu, 19 Feb 2026 18:52:55 +0100
Message-ID: <20260219175301.2839586-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

Fix the indentation of the help text for VIDEO_LCD_NOVATEK_NT35510 and
VIDEO_LCD_ORISETECH_OTM8009A to align with the standard Kconfig format.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 08c9b0207884..8ce660804072 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -566,15 +566,15 @@ config VIDEO_LCD_NOVATEK_NT35510
 	bool "Novatek NT35510 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Novatek nt35510
-	dsi panel.
+	  Say Y here if you want to enable support for Novatek nt35510
+	  dsi panel.
 
 config VIDEO_LCD_ORISETECH_OTM8009A
 	bool "OTM8009A DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Orise Technology
-	otm8009a 480x800 dsi 2dl panel.
+	  Say Y here if you want to enable support for Orise Technology
+	  otm8009a 480x800 dsi 2dl panel.
 
 config VIDEO_LCD_LG_LD070WX3
 	bool "LD070WX3 DSI LCD panel support"
-- 
2.43.0

base-commit: 7dca54ef4c44c82bdc6716ac6cdc84c22c66e9ed
branch: video-kconfig-help-text
