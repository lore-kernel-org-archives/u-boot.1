Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32A5C3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 13:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0828870B;
	Sat, 10 Aug 2024 15:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSH4LVcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F621887E8; Sat, 10 Aug 2024 15:59:50 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89C688327
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 15:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b7a3773a95so16721146d6.2
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723298387; x=1723903187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kZHV4LCFZT8c6Y+lq7Hg6pD9bv1nqY8tOaoUwSAyHHA=;
 b=cSH4LVcSuBvfhIFtCRXFQCBvxdfysdYcgchfk5VciBidIdGknGR+ZjUgA/J4y6yPOI
 MFBIOCnasOrLaATYAas5vn0gS6r2GyN7OpLPIfrPe4qVImmffU5y9JEfRtETKywJ8ffN
 lcS3dKwgiJMJ8NGsMAYCin8lrd7KYCqSt0h7QpVOpMSQjdtzAwUQzswIP6EZ8iEjI5Lk
 g3LxC0Qbdx0gmMzXmPHHOSDH6idRQsbR6gte4KQsOCWeFXGC1Kg510TH9v9CiDmDzZVL
 r7YlVm4WBANh9bFOXTUjYbwwrMsdfMi9SsNrU32oM5Up+iogWGjP5MXA8uV6maqHQiYg
 nvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723298387; x=1723903187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kZHV4LCFZT8c6Y+lq7Hg6pD9bv1nqY8tOaoUwSAyHHA=;
 b=bYF+BmeVx9C7q4aWcj4bBcSOrEmIGGmGp5hRPAuH2tvDQmNAYSfGUswOpK4hhi15rf
 dELzHyPVTGABpa5pd1Qnf7WIoOnm83D2y6xgY4Q4IKZlI1v25LXHe9fzhpaxRJzXRPmA
 ETkX5d3r4zycqp/XpPvpeyXOnkqV/F7HqAzs/E6eva/2UFLdE+XKogXSVlECcaZ6zZbV
 Ymsl99CPto6hRjJmXBbGoKPQyNTLq9Lmy9a336bnwrhpjNT9bQRj+hJgQ7oS992VSjda
 mTWGf7G4FNsqAFDCwzNbsDLdvZQ5rktKXWUUhkl07Y85/JGrZfsLEuv4CMI4IJcNSBbX
 HtOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfHLakVnyDEwnps+gMfYipHLIfR0bJNlg/k/uN9N08/DPRe6Vbk0oSnmuNmYCP6+1m3fj8XuQpRljy17JThxmAHYqYsg==
X-Gm-Message-State: AOJu0YyVkR+KR9Pqjv9kIOKjanPi7gyOw0cyi8zJ8QXFBFMWcyPHUgVE
 NMQlUDyYGFYxAU1x5nf3Ts4m/yCgZQTH0z87hFCDQRkvTnhraRZ0awGq8g==
X-Google-Smtp-Source: AGHT+IHySXc6OO1gY67Z2ct4u3obr1V2B4WjZB4GKrkZw/yMUXnui71XVwbHzFnRLbOXfIDfXpjh3Q==
X-Received: by 2002:a05:6214:4985:b0:6b2:d69d:a2d7 with SMTP id
 6a1803df08f44-6bd78e060d2mr48474026d6.19.1723298386596; 
 Sat, 10 Aug 2024 06:59:46 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-6bd82e67d2bsm7327006d6.133.2024.08.10.06.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Aug 2024 06:59:46 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] pinmux: generic: Use ENOENT instead of ENOSYS
Date: Sat, 10 Aug 2024 09:59:37 -0400
Message-Id: <20240810135937.4041797-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

ENOSYS should only be used when a subsystem is completely absent.
Convert its use in pinctrl-generic to ENOENT, which better reflects the
error condition (that a function/group/pin is missing).

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/pinctrl/pinctrl-generic.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-generic.c b/drivers/pinctrl/pinctrl-generic.c
index 2464acf0b85..81a9327eb35 100644
--- a/drivers/pinctrl/pinctrl-generic.c
+++ b/drivers/pinctrl/pinctrl-generic.c
@@ -22,7 +22,7 @@ static int pinctrl_pin_name_to_selector(struct udevice *dev, const char *pin)
 
 	if (!ops->get_pins_count || !ops->get_pin_name) {
 		dev_dbg(dev, "get_pins_count or get_pin_name missing\n");
-		return -ENOSYS;
+		return -ENOENT;
 	}
 
 	npins = ops->get_pins_count(dev);
@@ -35,7 +35,7 @@ static int pinctrl_pin_name_to_selector(struct udevice *dev, const char *pin)
 			return selector;
 	}
 
-	return -ENOSYS;
+	return -ENOENT;
 }
 
 /**
@@ -53,7 +53,7 @@ static int pinctrl_group_name_to_selector(struct udevice *dev,
 
 	if (!ops->get_groups_count || !ops->get_group_name) {
 		dev_dbg(dev, "get_groups_count or get_group_name missing\n");
-		return -ENOSYS;
+		return -ENOENT;
 	}
 
 	ngroups = ops->get_groups_count(dev);
@@ -66,7 +66,7 @@ static int pinctrl_group_name_to_selector(struct udevice *dev,
 			return selector;
 	}
 
-	return -ENOSYS;
+	return -ENOENT;
 }
 
 #if CONFIG_IS_ENABLED(PINMUX)
@@ -86,7 +86,7 @@ static int pinmux_func_name_to_selector(struct udevice *dev,
 	if (!ops->get_functions_count || !ops->get_function_name) {
 		dev_dbg(dev,
 			"get_functions_count or get_function_name missing\n");
-		return -ENOSYS;
+		return -ENOENT;
 	}
 
 	nfuncs = ops->get_functions_count(dev);
@@ -99,7 +99,7 @@ static int pinmux_func_name_to_selector(struct udevice *dev,
 			return selector;
 	}
 
-	return -ENOSYS;
+	return -ENOENT;
 }
 
 /**
@@ -119,14 +119,14 @@ static int pinmux_enable_setting(struct udevice *dev, bool is_group,
 	if (is_group) {
 		if (!ops->pinmux_group_set) {
 			dev_dbg(dev, "pinmux_group_set op missing\n");
-			return -ENOSYS;
+			return -ENOENT;
 		}
 
 		return ops->pinmux_group_set(dev, selector, func_selector);
 	} else {
 		if (!ops->pinmux_set) {
 			dev_dbg(dev, "pinmux_set op missing\n");
-			return -ENOSYS;
+			return -ENOENT;
 		}
 		return ops->pinmux_set(dev, selector, func_selector);
 	}
@@ -162,7 +162,7 @@ static int pinconf_prop_name_to_param(struct udevice *dev,
 
 	if (!ops->pinconf_num_params || !ops->pinconf_params) {
 		dev_dbg(dev, "pinconf_num_params or pinconf_params missing\n");
-		return -ENOSYS;
+		return -ENOENT;
 	}
 
 	p = ops->pinconf_params;
@@ -176,7 +176,7 @@ static int pinconf_prop_name_to_param(struct udevice *dev,
 		}
 	}
 
-	return -ENOSYS;
+	return -ENOENT;
 }
 
 /**
@@ -198,7 +198,7 @@ static int pinconf_enable_setting(struct udevice *dev, bool is_group,
 	if (is_group) {
 		if (!ops->pinconf_group_set) {
 			dev_dbg(dev, "pinconf_group_set op missing\n");
-			return -ENOSYS;
+			return -ENOENT;
 		}
 
 		return ops->pinconf_group_set(dev, selector, param,
@@ -206,7 +206,7 @@ static int pinconf_enable_setting(struct udevice *dev, bool is_group,
 	} else {
 		if (!ops->pinconf_set) {
 			dev_dbg(dev, "pinconf_set op missing\n");
-			return -ENOSYS;
+			return -ENOENT;
 		}
 		return ops->pinconf_set(dev, selector, param, argument);
 	}
@@ -215,7 +215,7 @@ static int pinconf_enable_setting(struct udevice *dev, bool is_group,
 static int pinconf_prop_name_to_param(struct udevice *dev,
 				      const char *property, u32 *default_value)
 {
-	return -ENOSYS;
+	return -ENOENT;
 }
 
 static int pinconf_enable_setting(struct udevice *dev, bool is_group,
-- 
2.37.1

