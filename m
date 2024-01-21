Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A84C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 11:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77792877B1;
	Sun, 21 Jan 2024 12:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lHfS+G3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDDE877E0; Sun, 21 Jan 2024 12:49:24 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A5B0877B1
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 12:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50eabfac2b7so2705037e87.0
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 03:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705837761; x=1706442561; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4VyUCChlhe1Gt3Id3girEYclxDs0AAQOBTF6fWkEZ0=;
 b=lHfS+G3TwzOqjSb612OtN9GJBW6aEbZHwobaNfXfpqDojj65bLpzzPaQ50HFiQVgd8
 QGfZrqqVysT23xX05UMvdUA2d5syllnsXyWmk8JuwCRfaOBJIAxe6actQh8CbTAEvvBx
 du1BxZ98JGffHNWpHiqNlaPHW4wXCMLgHClcjZlTZ5W4g8LeuUgcbt/MLdyJKAHPT1yQ
 JY5bO0qhKVe8rHhU/JDg1jDIsMF0F5QrboqeMeEUsvynu11j4d4DAkcHGLtyy8JqbpAt
 NywoXlK7Q7CAv1z56rKf5Bn9daVZzAFUyTpOktmrJRt+EvqqS6UecWhOoUMYL08NpF4F
 qLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705837761; x=1706442561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4VyUCChlhe1Gt3Id3girEYclxDs0AAQOBTF6fWkEZ0=;
 b=uDSU3ZJFxpcsHzHPSbrJq1HXZvmWWph4j7yprNo+/HEQSv2B+HO3NFhmRDt5MkLKV/
 LTyOkq9UnqCIMbaCc02amrpObjGVu9jb/+9njq04vq1kMJijGutu1dFvN0LpRhvFr5bH
 GGpNjUVt5Gs1sC4oQMx97RVBAdqcpIQ2FX/DFe/ARzg+1CN4k8V+U7KAcEH/21ogZbPK
 P6mxJumgBrmZobML4IKQo2WbqSdWte7yd0tUa4zWiIHEn4qA+oWdgvqX4uvsq3lIyXP3
 4YaJ16BhW9yO4sk6Iq1pXMve+m7FMBQAHtlmlHPXwiG0RMdn2XuESDw2bA9K/0nbYwLt
 LaHA==
X-Gm-Message-State: AOJu0YzZ6oHfz+o1CctY3xjarfhqV5yAoG9PI5EJ3f/tl4czrcjBESHw
 4OBDlx4SPJHa0/J6G+/KMnZ7aDIMF4eXHNY89YFi+LARhReKMc+a
X-Google-Smtp-Source: AGHT+IGRDAI74nuDX7f64SQA+py54L9xxlDj+9nPjNT7cXm4l6lPggFHtGOTJJFM9uba3jjHnykE6w==
X-Received: by 2002:a05:6512:1094:b0:50e:7c73:f4f2 with SMTP id
 j20-20020a056512109400b0050e7c73f4f2mr1061438lfg.110.1705837761257; 
 Sun, 21 Jan 2024 03:49:21 -0800 (PST)
Received: from user-PC.. ([178.134.198.138]) by smtp.gmail.com with ESMTPSA id
 d14-20020a05651233ce00b0050e7e5d6730sm1606602lfg.252.2024.01.21.03.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 03:49:21 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Maksim Kiselev <bigunclemax@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v1] sunxi: R528: add UART1 support
Date: Sun, 21 Jan 2024 14:49:08 +0300
Message-Id: <20240121114909.2909574-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Add PG6-PG7 pins configuration for the SPL to allow use UART1
on boards with the Allwinner R528/T113 family.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---

I tested this patch on LC-PI-T113 board.
This board can be found on eBay or Aliexpress, and looks like
that it is widespread enough to send this patch to the upstream :)


 arch/arm/mach-sunxi/board.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 11a4941822..9dedcd45f5 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -159,6 +159,10 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPG(3), SUN5I_GPG_UART1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPG(4), SUN5I_GPG_UART1);
 	sunxi_gpio_set_pull(SUNXI_GPG(4), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUN8I_R528)
+	sunxi_gpio_set_cfgpin(SUNXI_GPG(6), 2);
+	sunxi_gpio_set_cfgpin(SUNXI_GPG(7), 2);
+	sunxi_gpio_set_pull(SUNXI_GPG(7), SUNXI_GPIO_PULL_UP);
 #elif CONFIG_CONS_INDEX == 3 && defined(CONFIG_MACH_SUN8I_H3)
 	sunxi_gpio_set_cfgpin(SUNXI_GPA(0), SUN8I_H3_GPA_UART2);
 	sunxi_gpio_set_cfgpin(SUNXI_GPA(1), SUN8I_H3_GPA_UART2);
-- 
2.40.1

