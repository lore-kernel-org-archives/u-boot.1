Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB0910A1E7E
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38548405B;
	Thu, 26 Mar 2026 12:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="0Y1lpTBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B8B8405B; Thu, 26 Mar 2026 12:29:23 +0100 (CET)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com
 [IPv6:2607:f8b0:4864:20::1231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1CD581E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-12a74039dc6so689768c88.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774524558; x=1775129358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USJMOUjCx9IxnG7u9RZfXh0XC+O0lfcQUBfs6Z/SfC0=;
 b=0Y1lpTBA0nbkV5CinUWAIR0DAohCjTH5ZOG+ICYf5VIOn2QskyhW+j3KrHBQXX7o5f
 WFdd2JoqkQB44ErKSKi2NPQcbwEhnP2vKa+bsVJYJ7u/kB2zSwcd9QIrhVoVijGbUYCF
 7+42rD5Nl3uSFib31vb+wb/UkV0BaaoCZb+3q6V2L6MxLCQbOWvVOoaD5DussskhLlfc
 tzpFHt9oGA7mYgf/IbxrH6YceDpWz3BA2gCk1Pnf5+7wCYTmIoeA6dclvSNbX8G3WCFy
 Us4ebUpRsqQ8GYVwwkOEQtuSjqbL64TUAOonQHVVXrClFunDNdfcXWsIqK37LTPM4JGr
 7YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524558; x=1775129358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=USJMOUjCx9IxnG7u9RZfXh0XC+O0lfcQUBfs6Z/SfC0=;
 b=YaGhfTeopSzEx0H1RoiF69/fPSUYAkO6Exnpc8q/Fyv9pxCkoGHIZ0uXMe8O2nrc6U
 OMMWR1FjVSFYAfrtky0mlvygIEdL8rVJwElECK9N0OUAHnRP48h5klXD02QvxNMGvSI1
 SQDGTEqbLbMK3SmKk7N3FQIitlfzOGZyFg9JaV3W+xVlH2TJ+eypvaJ3YEKPGiT4kvCC
 NSvuYyHc8wxxjvN6waOTjCcj8Magi1M9WF6m7sgxan0pc7iWgQQLbOxLUB6KkJwhCAnB
 k4twjLwjwh2EhcIxczJ4OTLq7HXjZqtM+yTw8CBDKi4wsnqnfBTcsi6+/u1TkK4ptT2V
 n8LA==
X-Gm-Message-State: AOJu0Yy0aVmtGBKK6AiC+LFxqaLdc6RJw8ZBDN2Ad+QNFnDCgzGqjYFd
 Gy4wAlnEOOwP8A0ieLL8cGe61iMKoseQbPKF7WcPCxTHqeG+pXTLFo8yPyM3z+5u1LQweRzqHQ0
 v+136UXcZINGEgKbQQpWF1AYPu/Ju230HSE27xYX+35jC7GMJq0OdkZ7Ov7cSsENjkJrtsCOsAi
 Q1zzkOC9bjwlSYPq6eoKK7kiv6BKw0uMgBSJj2xPQtAf4=
X-Gm-Gg: ATEYQzwaCERo1wdsW64OTDgCZ1QiDiKzPhH0MHry6/TYUUS5hfBijveKOZLbrwLVIdh
 p8yrUnPbs8IdCu906qHffX/f1KtfOlPNbGdFuXpfo5J+tFkiqKE3/AUUb3gh5VyiXhyaapYOpoX
 Ha9R16sbiEP9ape3BcCx/eBiyBiPqgQkG+V5QLKc8vL/mIT6UU5/vOpJmjHYqLoAgLtbMQYKHiM
 ydUzLH4GGAQJ7+KHqDDFg0Fo4dtuanK5h7fimvkINud4ckjMrbyht3QKPv91/zxg6nVO44F+d3k
 uG2hqAaMj0s0EpBIwYM3wUDD/QTx/lCjQGPguPhS/qaDEgiouP8NZnOWiC4scg9CGnpVG3On82X
 FwK2CPRfDL27qHv11KTDMUGzDdsgt8wrSr/hnu9s2rJZGoCbH9orgfxOw9TbJFZdoQsx07nuyFx
 jDMiK5L77EvRwFyIn2GZml4BvCioHM0MSbh7x3C/tTaTIZDwaLbTPwc/H3r16y/h0F1ADWRt2HU
 Rtq31cD2e98xN1ZxDVM+OsL0gG0jOsbl2dP3v4q
X-Received: by 2002:a05:7022:6189:b0:128:d4be:7433 with SMTP id
 a92af1059eb24-12a96f0977emr3567570c88.34.1774524557628; 
 Thu, 26 Mar 2026 04:29:17 -0700 (PDT)
Received: from fedora (cpe-109-60-83-68.zg3.cable.xnet.hr. [109.60.83.68])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm3729221c88.11.2026.03.26.04.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:29:17 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 09/14] i2c: i2c-at91: allow selecting from ARCH_MICROCHIPSW
Date: Thu, 26 Mar 2026 12:26:50 +0100
Message-ID: <20260326112830.313874-9-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326112830.313874-1-robert.marko@sartura.hr>
References: <20260326112830.313874-1-robert.marko@sartura.hr>
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

AT91 I2C driver is reused by a lot of Microchip platforms, in this case we
need it for LAN969x so allow selecting it when ARCH_MICROCHIPSW is used.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/i2c/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 55465dc1d46..d7d3b4d0484 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -163,7 +163,8 @@ config SYS_I2C_ADI
 
 config SYS_I2C_AT91
 	bool "Atmel I2C driver"
-	depends on DM_I2C && ARCH_AT91
+	depends on DM_I2C
+	depends on ARCH_AT91 || ARCH_MICROCHIPSW
 	help
 	  Add support for the Atmel I2C driver. A serious problem is that there
 	  is no documented way to issue repeated START conditions for more than
-- 
2.53.0

