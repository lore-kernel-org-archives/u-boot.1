Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A64C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C60A882EB8;
	Wed,  2 Jul 2025 03:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tYhZdhNZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4373C82103; Wed,  2 Jul 2025 03:04:37 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EE0783022
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2efc0ed41efso1932353fac.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418274; x=1752023074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8tnQi0FrpLVtI6wlxRr12CBAUTu/7m7NAreMxk5l5yw=;
 b=tYhZdhNZJMifBuXj4TJy+7/i//NzMmLTgwawXniI/95m4rq5H7ukZh8sD09XMgXBhK
 irI0HOXfzrVV3iW2FjOgyINCTzxJQypXkOEuIFrgZveI+S/KhKLcrmLrgi4lAs41y411
 i4gFFgaqotVEJ66MCHVsX8SgFIqY6uX77wYfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418274; x=1752023074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8tnQi0FrpLVtI6wlxRr12CBAUTu/7m7NAreMxk5l5yw=;
 b=EBJmaLW2sKCJ3zFKSimPh3BtFw5rCDV45J7dQOF8Jkt7QxaX7qX7PsrOFZz4UZ1myS
 EKyhHe1IJMADe57VbwJ0VrexCC7HzuAaxzPnJ2ISHt7W4wTLW+dArtmpuQf5zcN7oP6y
 Np81D56cGY9qhxWBjXyeb6EEV4p8qVOq4/JoZShkjEWYg0f8SoaBn7sTi+CZSRbP+eTV
 4KCEvz+gdvtfoKDl31UbWpaoqPHPAU6flY7Y1a7rIZBn9uBFl48Dn336ZJBTWV58YivB
 9fofcDRiGHqP46D/DzLSkhzsNO3uuE45iVWRelYNK0IFz45vZDhSHHfjVJMpRFO7l2Ts
 /7lQ==
X-Gm-Message-State: AOJu0YxcykgbEXVGVlOKTrIYICDoTyEjf0lmE72/zcsfCjKPf/Y5bxlB
 tgSCDFWD/U0HUQG19zaVIzFpaT7nfZW2rfOwtyuIZbeEB19YetnhJTp5JLOxXjWq37+CbLtPEtv
 F1GAVNXc=
X-Gm-Gg: ASbGncseafi34V5j/M/LxnFBnqSPVZqtUvBDN+i1RBv/fAipuN4zEidE5fT6PRZfzPD
 ucxAF343XuJJikV+L6vO81el7Pc7h1UOqMF3K8fqP5yFOsQ0iR6S8J0cw8MMEqbsukTzFJPv9pa
 CH395hOYlOwsLC5NeLOQU4E3S9c1e5twOig4tVOGMvoJy+9gdmHIr84PBfAPAp+e7V36bfl9zk/
 7DU5MasqyhtoxMLSbVluXkR50R71W1JDsvEtt4fTdbmMTGV0Y+53pcTZs2HlXUnLRKM/9Xkpy86
 VKK/lMHsP/4gcEuPXpxZnYsF4vEt70QfCoSyHEQ5FFukPFle9vxSq1vg3vkZyGY6Tw1OHVmkoci
 8mrK9e2hG8F0xGbUroAEFRWo=
X-Google-Smtp-Source: AGHT+IHCHnoin0ADUOV1rH4QcH1M/cDlY8+UnXPdtNcXFM7MTQT0ft0H4tG6eOaAK77TAKU7JNXzSQ==
X-Received: by 2002:a05:6870:558f:b0:2d9:3868:b310 with SMTP id
 586e51a60fabf-2f5a89fdb15mr700109fac.11.1751418273790; 
 Tue, 01 Jul 2025 18:04:33 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb0089cesm2345034a34.25.2025.07.01.18.04.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] adc: Tighten some adc driver dependencies
Date: Tue,  1 Jul 2025 19:04:32 -0600
Message-ID: <20250702010432.18977-1-trini@konsulko.com>
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

A few adc drivers cannot build without access to some platform specific
header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/adc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/adc/Kconfig b/drivers/adc/Kconfig
index 37235f557a3c..2b45f9e5ebad 100644
--- a/drivers/adc/Kconfig
+++ b/drivers/adc/Kconfig
@@ -18,7 +18,7 @@ config SPL_ADC
 
 config ADC_EXYNOS
 	bool "Enable Exynos 54xx ADC driver"
-	depends on ADC
+	depends on ADC && ARCH_EXYNOS5
 	help
 	  This enables basic driver for Exynos ADC compatible with Exynos54xx.
 	  It provides:
@@ -49,7 +49,7 @@ config SARADC_MESON
 
 config SARADC_ROCKCHIP
 	bool "Enable Rockchip SARADC driver"
-	depends on ADC
+	depends on ADC && ARCH_ROCKCHIP
 	help
 	  This enables driver for Rockchip SARADC.
 	  It provides:
-- 
2.43.0

