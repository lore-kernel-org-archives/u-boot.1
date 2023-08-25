Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38BDC71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 14:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA868643A;
	Fri, 25 Aug 2023 16:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="TXegNOkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F6986287; Fri, 25 Aug 2023 16:44:24 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 027008647A
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4ff8cf11b90so1555080e87.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692974661; x=1693579461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xBH8kqEuaVP3P7PLAKnWfHR5YjZ2t5HPob9UNDgFIrg=;
 b=TXegNOkrj2IWztC+fZYiiLY+XrHIerh4oNkRX4O4vRZu1FdbeXg7D3V0/fn8NYlMNK
 jorKrGZ+tiTwHKH+iUSOgI0zgrNkiqpBPlonzIRb21fSxXIkBIPAsQI+Kk0yYbWcaaUS
 fl6MDGlYk7B/h286UA6I3gQflJr7XnEz0sdojOs+Ulj0HNL9eYZqTTd98s4XITw+aD8P
 MTwTcmMgpkVCRSgWOImsHvtax+eaPw5+80G/qffo1ONthjanQfrzkYUaTN07Q11C8RpZ
 910/5YzVpX/fZQ+x9ya9otdcPRhELDC9ECWSCeUz/z29F807aBDOGOR19cSeR4mu4KGW
 QHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692974661; x=1693579461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xBH8kqEuaVP3P7PLAKnWfHR5YjZ2t5HPob9UNDgFIrg=;
 b=MuW9ZbL/5wmjBwRyyQpKqNQAMnIt29dH20weaoZVsfykFONq52IdjbpEYe8BunHsMM
 5eNcK7Mkx797uNTA4UmiieYDKx42xIeSqfaAl6X0LmeoWVmX8+V7CoESrVZQ0em8I4q9
 37ogd5viGswMnD8nY2sB2ByiSIionOcftC5BDnK7oQfABuG5oaioUPE8iS1JKLim+JPK
 WTttRY8OZ2z371TOKFbqPIOoOhR37+WkhumQ4V2SWNsiyU2VN5pabFp0V2xOSqKQRGBy
 zyX0EHkGtLzI+yCCqWRHyS9vr9fkpeveEqMVcHWLL43PEopo2t0FZ3F5O8OtdDVl7oGu
 v/sg==
X-Gm-Message-State: AOJu0YwWtXRetPJiLcOinJvF7HqAUMl70gy96ibNqy2Q6yavVXEwFVim
 oCiL37imiAksXudHB7HuwbY4jrCb8oXdlPMzXVI=
X-Google-Smtp-Source: AGHT+IHlFVgSlQ5J21sdx+hG1w4OozvXswAWPIANG7al5wEu1Nxju4KpuduXGnlq7/jE74Q0eRC9oQ==
X-Received: by 2002:ac2:499d:0:b0:500:9b7d:ee3c with SMTP id
 f29-20020ac2499d000000b005009b7dee3cmr4658398lfl.7.1692974660735; 
 Fri, 25 Aug 2023 07:44:20 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 h27-20020ac2597b000000b004fb745fd22fsm314900lfp.32.2023.08.25.07.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 07:44:20 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Ricardo Salveti <ricardo@foundries.io>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Bin Meng <bmeng.cn@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Jacky Bai <ping.bai@nxp.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] ARM: imx8ulp: support env in fat and ext4
Date: Fri, 25 Aug 2023 17:44:14 +0300
Message-ID: <20230825144417.32860-1-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
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

From: Ricardo Salveti <ricardo@foundries.io>

Change boot device logic to also allow environment stored in fat and
in ext4 when booting from SD or eMMC.

As the boot device check for SD and for eMMC was depending on
ENV_IS_IN_MMC being defined, change the ifdef blocks at
env_get_location to use IS_ENABLED instead for all modes, returning
NOWHERE when no valid mode is found.

Signed-off-by: Ricardo Salveti <ricardo@foundries.io>
Co-developed-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

 arch/arm/mach-imx/imx8ulp/soc.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index e23cf60d126..4c435ce94ef 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -870,33 +870,29 @@ u32 spl_arch_boot_image_offset(u32 image_offset, u32 rom_bt_dev)
 enum env_location env_get_location(enum env_operation op, int prio)
 {
 	enum boot_device dev = get_boot_device();
-	enum env_location env_loc = ENVL_UNKNOWN;
 
 	if (prio)
-		return env_loc;
+		return ENVL_UNKNOWN;
 
 	switch (dev) {
-#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
 	case QSPI_BOOT:
-		env_loc = ENVL_SPI_FLASH;
-		break;
-#endif
-#ifdef CONFIG_ENV_IS_IN_MMC
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
+			return ENVL_SPI_FLASH;
+		return ENVL_NOWHERE;
 	case SD1_BOOT:
 	case SD2_BOOT:
 	case SD3_BOOT:
 	case MMC1_BOOT:
 	case MMC2_BOOT:
 	case MMC3_BOOT:
-		env_loc =  ENVL_MMC;
-		break;
-#endif
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
+			return ENVL_MMC;
+		else if (CONFIG_IS_ENABLED(ENV_IS_IN_EXT4))
+			return ENVL_EXT4;
+		else if (CONFIG_IS_ENABLED(ENV_IS_IN_FAT))
+			return ENVL_FAT;
+		return ENVL_NOWHERE;
 	default:
-#if defined(CONFIG_ENV_IS_NOWHERE)
-		env_loc = ENVL_NOWHERE;
-#endif
-		break;
+		return ENVL_NOWHERE;
 	}
-
-	return env_loc;
 }
-- 
2.41.0

