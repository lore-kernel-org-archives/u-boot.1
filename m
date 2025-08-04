Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A89C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D35383D40;
	Mon,  4 Aug 2025 23:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jj4zLY2j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D35E083FC4; Mon,  4 Aug 2025 23:53:59 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8343483B1B
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3e3d7b135c2so62038145ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344436; x=1754949236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LJ1CIpEJp8jG54CAYayWthmjr+ep9+tSUEIirgtyhc8=;
 b=Jj4zLY2jS3fBgDMhNpbH/oiPTZ/PU5+3zzjucxYlMy5jDyPtLfRFmiWkPIWlJjzpLk
 Ike/EL/f2IcWyf4BnIsUqgFaVbD7jvLmmyMXJ+REr99YMqWISdfXeUL0To+uOS9q4asL
 ytWWjBDLTFkmBF3fdv+OAXDhijTyoLakDe2XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344436; x=1754949236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LJ1CIpEJp8jG54CAYayWthmjr+ep9+tSUEIirgtyhc8=;
 b=lDU3eHJfRMfkwk7GuFu8ULjnGDClVDxCkjuZIEs8zcvBmiBDuAqnvA6za7qer2c8qj
 4mXnKAXKGtqcXyvDx8JtO0BjSqxmzoTDXQ18CS8zIlnhNKbwofDvSaOJE0EGxxHQw3/G
 XcItQuLTlO7tRF/gjRj2s6oAwyd0zKwYWVa70qHRF44+COhTX6FABph3P5wwKXsrfcdy
 /9acTyStBqjMZyGe7Z4nyVYtG83RsI8Q6byQHMjUaDgRFOYw6/7cWoitiPWB89Nxvp1o
 yBOFZP0L+NZ9mCiMkXOx1Z7MiWfNw+pmG6w3PU9+YreKTqce45iRkD3TbCz6CNTg7rrz
 nwOg==
X-Gm-Message-State: AOJu0YxlVZhzwPMHny5sNw/qSzaOfmQL/zx8468XutzbjB26/ss35rI9
 GXh2MqBI1mxsYK8rdQopQ1GTrgcW1oFxIupfnXs4v1io1+XwIQk82fzvdvxZTUxgpSn3huwzrHN
 2ka6duUM=
X-Gm-Gg: ASbGncsIo1j32tQbfPYVk+ox3NFuQdvH7GpkcqMQ0FCNwWcbB//ZNJj/nc5crgdwTSO
 1sfEFI2irbjI3+GrZhHeIZYj9BDifJGCTVBUhSsEjr1kmMZWJNUbFbpZJ5Cs0uQ7occqZL5Um9y
 L9YcE5KrivqqHjOh3HYwl/05Q9HXJTMm6/o2KBUSQaQuiCvaZfdNRx94D/6aqsZA78zQ3ooVkLc
 xJBCQCqbBOKNwv41POEKfApc5Snyjik35CHpkNxal56/vwkn3DMQKlo8/1HsX91ndjQ9D91B/6I
 ZQE6DIL2DA68glHeo+uCwOZomIck6JGxSisTbHW042p3xmPMhZgh8wkYKm388+LOl8WhXNuUX4y
 oB2nAsoDa1rYKBtOeHal0ahuPpqiX8NJ/9sV04EEQi0ay6SXR2yQz3O4JzAcaZsw8J7Bp
X-Google-Smtp-Source: AGHT+IGQwQz8XnjWSku3wfDABEdN0TbPzfZqY8abF6gkW8R50fZ1KWoaxihz7pZdqIsoJ/hGzB4V3Q==
X-Received: by 2002:a05:6e02:2220:b0:3e4:1162:6761 with SMTP id
 e9e14a558f8ab-3e416128e06mr216270275ab.9.1754344436190; 
 Mon, 04 Aug 2025 14:53:56 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e40297c3d3sm45998025ab.6.2025.08.04.14.53.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:53:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] pwm: Tighten some pwm driver dependencies
Date: Mon,  4 Aug 2025 15:53:53 -0600
Message-ID: <20250804215354.1412604-1-trini@konsulko.com>
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

A few pwm drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/pwm/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e4c676d75c2b..06f42f699dec 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -42,7 +42,7 @@ config PWM_CROS_EC
 
 config PWM_EXYNOS
 	bool "Enable support for the Exynos PWM"
-	depends on DM_PWM
+	depends on DM_PWM && ARCH_EXYNOS
 	help
 	  This PWM is found on Samsung Exynos 5250 and other Samsung SoCs. It
 	  supports a programmable period and duty cycle. A 32-bit counter is
@@ -51,6 +51,7 @@ config PWM_EXYNOS
 
 config PWM_IMX
 	bool "Enable support for i.MX27 and later PWM"
+	depends on MACH_IMX
 	help
 	  This PWM is found i.MX27 and later i.MX SoCs.
 
@@ -70,7 +71,7 @@ config PWM_MTK
 
 config PWM_ROCKCHIP
 	bool "Enable support for the Rockchip PWM"
-	depends on DM_PWM
+	depends on DM_PWM && ARCH_ROCKCHIP
 	help
 	  This PWM is found on RK3288 and other Rockchip SoCs. It supports a
 	  programmable period and duty cycle. A 32-bit counter is used.
@@ -98,7 +99,7 @@ config PWM_SIFIVE
 
 config PWM_TEGRA
 	bool "Enable support for the Tegra PWM"
-	depends on DM_PWM
+	depends on DM_PWM && ARCH_TEGRA
 	help
 	  This PWM is found on Tegra 20 and other Nvidia SoCs. It supports
 	  four channels with a programmable period and duty cycle. Only a
@@ -115,7 +116,7 @@ config PWM_STM32
 
 config PWM_SUNXI
 	bool "Enable support for the Allwinner Sunxi PWM"
-	depends on DM_PWM
+	depends on DM_PWM && ARCH_SUNXI
 	help
 	  This PWM is found on H3, A64 and other Allwinner SoCs. It supports a
 	  programmable period and duty cycle. A 16-bit counter is used.
-- 
2.43.0

