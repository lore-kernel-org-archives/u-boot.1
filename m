Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27073C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3D088BE9;
	Thu,  2 May 2024 03:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JMrTEiJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D50CE88BD9; Thu,  2 May 2024 03:31:48 +0200 (CEST)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF64088BAC
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7e3d5cfd81fso1003390241.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613504; x=1715218304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbotegWjgdVuS8y8Yf7HiZxcby2w0yxr4Ha6l832kVE=;
 b=JMrTEiJ6E13PbLmHvtit1okDoIamZHpf13wiBIEsfRwKaDAt2TfFFEDtX351jp8wqL
 fqvePhPhH2zF2Gc9Sh1ClGfgDU7JdazLywPkjuIVAg6vNKqChFrs9c4sJBgK5hekBfn/
 MXoaWpNMgicbidCKOClOglKs9lzF83B43JeRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613504; x=1715218304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbotegWjgdVuS8y8Yf7HiZxcby2w0yxr4Ha6l832kVE=;
 b=O9O9ezuMRp84SNfDzeuxNAsKDNzJt5M21ZIkofzCAOi7goePVWIy3L61A7Dov5r0g3
 RIto47A6OQJDqAAvDCcrQ1HrQC/qiLChp0GW3c50sj7nVOPN82Johc5XnXYTtGKpv6Xy
 Pz4bQRz1Z7HxMyRw+YrQVXP9dUc7XRuZvAlzfdCTFhkGjkFtUK7yZek6fFU5n3XIw8Ms
 SUvjKF0k2oeneN3Ko5ZVfrxQsSG7Is0kMDqPbb8xHm6Zr1L9Qu27R5Ksw8kWV57Wtlra
 I2HKc9GXLO7Inn62hTkJen5b62cfYo9plcZfegH/g4wRAZ+3xQ5bgr/ijFNZEid0IX0m
 HIrg==
X-Gm-Message-State: AOJu0YzPEuNZQkqgfv18FrqN5sXf+n5HSPcvUrPrwpvQkgVdQPOb2ltB
 fgPI9gTuxpo68w+io4N5/bSQrkMKTOYogTPQAJCIDtGQ0UEN0ZVOhU8/g0dkNi0hfGOag4vBXcr
 +E1gHl0Yp
X-Google-Smtp-Source: AGHT+IGCmaj66emuZ4PGr5m/2n2I3BXYTCsWu/FS4ZbjBIZ9ligRoBUlZiePAn4Bi3CEG8iYrl+9BQ==
X-Received: by 2002:a05:6122:1d50:b0:4db:223b:1c0a with SMTP id
 gd16-20020a0561221d5000b004db223b1c0amr473885vkb.11.1714613504401; 
 Wed, 01 May 2024 18:31:44 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 03/81] arm: sunxi: Add missing <linux/types.h>
Date: Wed,  1 May 2024 19:30:20 -0600
Message-Id: <20240502013138.2383421-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

These files have many "Linux" style types in them, add <linux/types.h>

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/arch-sunxi/pmic_bus.h | 2 ++
 arch/arm/include/asm/arch-sunxi/tve.h      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/arch-sunxi/pmic_bus.h b/arch/arm/include/asm/arch-sunxi/pmic_bus.h
index 5ab9b2809f29..e26459fdd3bf 100644
--- a/arch/arm/include/asm/arch-sunxi/pmic_bus.h
+++ b/arch/arm/include/asm/arch-sunxi/pmic_bus.h
@@ -8,6 +8,8 @@
 #ifndef _SUNXI_PMIC_BUS_H
 #define _SUNXI_PMIC_BUS_H
 
+#include <linux/types.h>
+
 int pmic_bus_init(void);
 int pmic_bus_read(u8 reg, u8 *data);
 int pmic_bus_write(u8 reg, u8 data);
diff --git a/arch/arm/include/asm/arch-sunxi/tve.h b/arch/arm/include/asm/arch-sunxi/tve.h
index 46cd87e79e8d..4fbb4b91c86b 100644
--- a/arch/arm/include/asm/arch-sunxi/tve.h
+++ b/arch/arm/include/asm/arch-sunxi/tve.h
@@ -9,6 +9,8 @@
 #ifndef _TVE_H
 #define _TVE_H
 
+#include <linux/types.h>
+
 enum tve_mode {
 	tve_mode_vga,
 	tve_mode_composite_pal,
-- 
2.34.1

