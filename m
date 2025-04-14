Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E570C369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D1481FAA;
	Mon, 14 Apr 2025 08:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="frcuiSTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40CF181F54; Mon, 14 Apr 2025 08:01:07 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3DE981F6B
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso751332266b.3
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 23:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744610464; x=1745215264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUuRer/YogXx5e3MagUUu6um6pXVW6qQ8VnFlnBRKWs=;
 b=frcuiSTyLWBmmdbEQAtswP9EESnXs88XOw4MwmpYASkIYidewzop4VcIcw2LW+FrJZ
 ZO0DHP8+goA0WGO7xWLKpipEdAulnbjwO+6CjwGs1CcWZSy1qyrPqaSrMLZdmkLlkoAm
 na6r7TodpQBNuQDErodelSzzNQjSLABZGZKIVibJSlTmGXM5VRnqble/2yJZSdqbD9O6
 wNbeeERd7wt59kkJlqrhN7BEKfYUd9cFNORwNDTo88pjEjGs9SoABDT0VyTTBBWThd/s
 EaYLkSAeTDbcudFHkJ9R/QoxSyeOzJsJ/XG1rtaovG2rn0xLoW7yZEA8xZjvTeLmpu+x
 dD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744610464; x=1745215264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUuRer/YogXx5e3MagUUu6um6pXVW6qQ8VnFlnBRKWs=;
 b=gqVd7k9PkhzZE6+QahagoCxwLOCi9Os5yupofOrelvg7VDTFfXJln20BB/hTFMyMGB
 M8RI3jYCngaNWnRvJVRCDLYK+5dM2RKhZvJ0hsJVDVdoXIewIckqHvaNUGjxnqSM3dgM
 m5fbmnVEod50PTgKe3g0XbqylRCWYBlYs+620oZyONSF7CMuvWgwR/QtE+RyP7uv/PP4
 xWD7I51qIaOFLOH+FmYx2kbl47ip9EJ0BOdEcvb0cl3xeRL/RzZ/LBj7KaaECpuxuq47
 PKgoJsp5EK+TGckxXDz+wcSdz7Y+Ns5nXhW7B+UHQ5CHwqrSgjOYyVRbppnlsVY5+H4J
 00UQ==
X-Gm-Message-State: AOJu0Yye5VNTEc84SP8y9SjPzE483UveKxA1JDHAveYIdioZKKqA53YQ
 ztG8VsOtlfdowWyKbTrAUXrAv3YV3Df1HKSaIKhmFubQcbjfKn4m
X-Gm-Gg: ASbGncuAsdhG+zrfYp9NH9bVOUeJ863VmwLzWxMNko0myCrMBnfEtDnPgUjWZRXBRdu
 0QJ1VGnEwgAkaJpMGaCOPZ876LVSmj/2sx9dH0h+Sm9jTHHxx3hHcQmQjsTOKJidIrfuQT1ai6+
 RLILGoLvg/LcDV7cAw4tijW+IhtXc+/GTeKUO4QM856wtvlKXykrzBZs19sy8L7aKYukHpoz/Dm
 rRRFy8K6L9uX3KwqP5c2aJUT6TZ7cLdteoRKFD7BGjZ9jyOZw12uKRVM7l47EoHogM2E0iNDCwh
 UGJrjAvwlqAeHfglgaezPyBTAZGAe00c
X-Google-Smtp-Source: AGHT+IGdBqGGcx/LMHo/RAZIjILQWtx+UjIZT75RLNlDFU/3x/dhqAe0djtugW7NWbq6/RjbosB0hw==
X-Received: by 2002:a17:907:3f0e:b0:ac7:3911:35e7 with SMTP id
 a640c23a62f3a-acad36dc8e4mr894485166b.59.1744610464237; 
 Sun, 13 Apr 2025 23:01:04 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce7fd1sm838050466b.168.2025.04.13.23.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 23:01:03 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Artur Kowalski <arturkow2000@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/9] gpio: tegra_gpio: implement rfree operation
Date: Mon, 14 Apr 2025 09:00:11 +0300
Message-ID: <20250414060021.14545-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414060021.14545-1-clamor95@gmail.com>
References: <20250414060021.14545-1-clamor95@gmail.com>
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

Releasing a GPIO on Tegra necessitates changing its configuration to SFIO
to activate its special function. Without this reconfiguration, the special
function will be unavailable.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/tegra_gpio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpio/tegra_gpio.c b/drivers/gpio/tegra_gpio.c
index b83df351e74..3d1e18854f2 100644
--- a/drivers/gpio/tegra_gpio.c
+++ b/drivers/gpio/tegra_gpio.c
@@ -248,6 +248,16 @@ static int tegra_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
 	return 0;
 }
 
+static int tegra_gpio_rfree(struct udevice *dev, unsigned int offset)
+{
+	struct tegra_port_info *state = dev_get_priv(dev);
+
+	/* Set the pin as a SFIO */
+	set_config(state->base_gpio + offset, CFG_SFIO);
+
+	return 0;
+}
+
 static const struct dm_gpio_ops gpio_tegra_ops = {
 	.direction_input	= tegra_gpio_direction_input,
 	.direction_output	= tegra_gpio_direction_output,
@@ -255,6 +265,7 @@ static const struct dm_gpio_ops gpio_tegra_ops = {
 	.set_value		= tegra_gpio_set_value,
 	.get_function		= tegra_gpio_get_function,
 	.xlate			= tegra_gpio_xlate,
+	.rfree			= tegra_gpio_rfree,
 };
 
 /*
-- 
2.43.0

