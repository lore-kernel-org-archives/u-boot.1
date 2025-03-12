Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CEAC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 174A581D3B;
	Wed, 12 Mar 2025 19:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EKs8y4sR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F19F81BC0; Wed, 12 Mar 2025 19:15:45 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F71C81D3B
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5cd420781so118295a12.2
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803343; x=1742408143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAJo3RL5dNjfdCQGJhV7XgxBcvQUmHJT2a6uwcF/COk=;
 b=EKs8y4sRqzVhYNe+eVbq2DfLAsDfeijYhlZGgOkZZCCPBihPgwffMUDrmJsstLmGCa
 kD//nTPgdWtcOzA9gz7n1nlIubEd60KSX68MIk8LK01H+H63CCSi5PLO+U+/T4yBGvu4
 ovUnSVtZe20dPeBp3ZwB5Ngxt85ZcOsS+YpsIDbJVKtWYk9Tc8ifCcWJGz/lmmPJYAmn
 U9dfN7UUilAo7GN7CkU7zfb69+8nvp3MyFhg0ZYfiEA3s9ejDQYbizIvmtiSKqX5FGo9
 B7A4pqJd/m17QqI0shYrr6hkr9Wcl+hVeAr1j4Fzu9fYZVNE/g6YD74xxFBrAeS9W7z9
 FtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803343; x=1742408143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZAJo3RL5dNjfdCQGJhV7XgxBcvQUmHJT2a6uwcF/COk=;
 b=hYesHpSkphYZO2Q/bD/itD1LnhqTcpp9jgrD8lIlTTJ3mIwNTcZCvdkynLQ1UIlCqx
 wkoA5eRLs/Bw/7EwtbKsBazfdyrLt3wWXTsa/dWdb5ByqHbcoLlCmZwEfBnHxaCDEPrV
 4QUbmqtpSaHBnQW9QwpP5atJmUG9xDyDAGqMNTixrZFSCj7dZXfWOm4OzcrzwLM8/S1d
 v9KAqch/0fm6HBo0o/E59LpkI4mPJ0QgYlgolw+8v5YJ7f4YvSqitq7vEnJPFQtzkq2Z
 HXTu6DI24qPvDRRr2hOp2wb7y/8GfBrNJdPwLXtP+DLOWRAQF5vRsPxKl0QAmB0lHxTn
 /3wQ==
X-Gm-Message-State: AOJu0YylkWmyuvjiWT75TWCzLFScwKQwJKLtAytwU3fhlvsfeM6iiRk/
 aCo1IAVJ0lITrp2pbGusyNJBaFxbJ5waxcBi2YZd/KsDO+GXp6yUGEghQg==
X-Gm-Gg: ASbGnctG1mEDCtdFC+DRA0zyVherY35GoBM822eDdmZP30Px71OakBNB/Ys5xAIKUNo
 FYu+mRdIuxG0Mg7ajroPASflZAirinjdvkFTT8GaAgT34ImDTZ1ihFEVShuMXhw4+fIrTti8AvN
 86NvPXeW8J/C9LFN5v3NrkPVAFstBLv+ZverpyNc0MY5YJzwaAoKwc+3AYVSfZmRe7GZ4EcmtMp
 hFPlqD3vwqBkpjcVj4dXn615znlePbDPip1+z4+TV0eHhHSmVUR7F6F+wJ1A3SYxWDCwzSNJss0
 TdCIvYnPsXWHn4jOPRMNS6umICFif8EKy8Se
X-Google-Smtp-Source: AGHT+IECbQFi3oLfu2evwO5LsfY4P6ap5TCC4/h79JZKSzKOSIoXyBFrqaMudJvK5d0FKWb4NuWa4g==
X-Received: by 2002:a17:907:3558:b0:ac2:7b08:7dc3 with SMTP id
 a640c23a62f3a-ac27b08917emr1650764766b.20.1741803342580; 
 Wed, 12 Mar 2025 11:15:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac28c11561dsm641906666b.145.2025.03.12.11.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:15:42 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 09/11] video: renesas-r69328: add power supplies
Date: Wed, 12 Mar 2025 20:15:21 +0200
Message-ID: <20250312181523.121313-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312181523.121313-1-clamor95@gmail.com>
References: <20250312181523.121313-1-clamor95@gmail.com>
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

Convert enable GPIO into a set of supplies.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/renesas-r69328.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/video/renesas-r69328.c b/drivers/video/renesas-r69328.c
index 164285e3c8e..a4d03fef8a3 100644
--- a/drivers/video/renesas-r69328.c
+++ b/drivers/video/renesas-r69328.c
@@ -32,6 +32,9 @@
 #define R69328_POWER_SET	0xD1
 
 struct renesas_r69328_priv {
+	struct udevice *vdd;
+	struct udevice *vddio;
+
 	struct udevice *backlight;
 
 	struct gpio_desc enable_gpio;
@@ -159,10 +162,15 @@ static int renesas_r69328_of_to_plat(struct udevice *dev)
 		return ret;
 	}
 
-	ret = gpio_request_by_name(dev, "enable-gpios", 0,
-				   &priv->enable_gpio, GPIOD_IS_OUT);
+	ret = device_get_supply_regulator(dev, "vdd-supply", &priv->vdd);
+	if (ret) {
+		log_err("Cannot get vdd-supply: ret = %d\n", ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "vddio-supply", &priv->vddio);
 	if (ret) {
-		log_err("could not decode enable-gpios (%d)\n", ret);
+		log_err("Cannot get vddio-supply: ret = %d\n", ret);
 		return ret;
 	}
 
@@ -181,14 +189,21 @@ static int renesas_r69328_hw_init(struct udevice *dev)
 	struct renesas_r69328_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	ret = dm_gpio_set_value(&priv->enable_gpio, 1);
+	ret = regulator_set_enable_if_allowed(priv->vddio, 1);
 	if (ret) {
-		log_debug("%s: error changing enable-gpios (%d)\n",
+		log_debug("%s: enabling vddio-supply failed (%d)\n",
 			  __func__, ret);
 		return ret;
 	}
 	mdelay(5);
 
+	ret = regulator_set_enable_if_allowed(priv->vdd, 1);
+	if (ret) {
+		log_debug("%s: enabling vdd-supply failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
 	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
 	if (ret) {
 		log_debug("%s: error entering reset (%d)\n",
-- 
2.43.0

