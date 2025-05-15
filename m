Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A65BC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC76F82BA1;
	Thu, 15 May 2025 15:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NVliVvYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2D982BAB; Thu, 15 May 2025 15:30:41 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FD1382958
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so7388855e9.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747315838; x=1747920638;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IAn47di+3vNW0Hs84C7sF+s8dfiKSe2ASDjp/KUWLlQ=;
 b=NVliVvYf8dKa/k9AcFAfjLF/AjSko4XocERIKYQdcrjUCWOEqJ5+S6lsWfrzrAwQPr
 yCrowfcWJZDPabkgI4r5wCc74yhOOmMcdkRbUe3EHxxHbY2Sv8sJxwtiuZhUSm6zyyZk
 KmNpUerY/Dzjx6BIZ+iNFyvVcHsCmkE3lagS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747315838; x=1747920638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IAn47di+3vNW0Hs84C7sF+s8dfiKSe2ASDjp/KUWLlQ=;
 b=n5qgIRybNdu4pC1FopymjTK+36/R08Ek9wLcKF4jENBg1in0NtrkbP0SkvXlBbEqoj
 cjhpIZvR9Z74qdNZsSW0cWCrgJx5WvRPJBexCwFjODlSVo+Kt1pORtlJrfstFvSsw+j8
 zLZ+rS6kzeQ351qSJdkMf1O8/+FmBeHmkrNyK5la8wnrxtDsZlbZoAgYF9rQiFG4JTYA
 V9gmqUnC0JR9RdmmqrjxxMV19si3bvmsB6WKglKICouOnCD+IBAxzT5jCBo2ycW801zw
 ckYSN4Ajf6JLPVx6M2mpPxbAV4LnmthA1/Z3I9XAF2r/yYaUXMWzQzJwGlkeFxCtCT39
 SMHA==
X-Gm-Message-State: AOJu0YzAzcQyl2WWKquT45fleBYPwLOkOtmIX1vFICaR+gkOiF40rtro
 I+/O4/6xg79wJOwvj3TLRyqTmJlwec0zKO9oxML3ncJ0lMN2p+eG5cWI8xkNWQNIgpwZSVeJ6AE
 NKA8t5A==
X-Gm-Gg: ASbGnctfHsw5SnjFwQRaVEcL3eZJrg0DeL6/AOwsDBHpQmHIGrgzXcc6yLi3DrEAF4g
 f9M2HP10+cDhVTxzN3nY7mKpDAp3FNyotxIbyYQpZrZdv9WsrLVY6Fz1+vPMJsS9Ksw3kGqT3xr
 k/lYd+j6mIvoHL0K1yYXVkKJ5aHo7+CS+Jr+T65m5hmwncrCd6O+47OMvvB4Estnk/Njneodk8e
 Q5C9ioy67FOXwkaUcOGuv2onvSTJUxuO4ubt/GrqWc7LFYSrrJHMQbteeYFiSoNmVmOJbzqnKkl
 AbuUe2oTQb9P/XEk0QnsjE3im7f5APyrZFZUvfqFVpJdq+hEX5dUNBSnURrwcHHDzkpjwILcN+K
 t5yonX9BgAYvUv7rvgzQDUZQONckQDTqYc04kilccuMfXISpq3tu0qg==
X-Google-Smtp-Source: AGHT+IHV+SvYtq3JASHfF0Ovtkzmya7UDih9V/Pz/k0NRCxqmaH8giLr/t52qWZmgPtsaPBx6rC8mw==
X-Received: by 2002:a05:600c:384e:b0:43d:fa58:700e with SMTP id
 5b1f17b1804b1-442f217a676mr66137925e9.33.1747315838470; 
 Thu, 15 May 2025 06:30:38 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f397b6fbsm70186185e9.39.2025.05.15.06.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 06:30:38 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] arm: imx: imx8m: soc: fix the macro name
Date: Thu, 15 May 2025 15:30:22 +0200
Message-ID: <20250515133035.815572-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

The function arch_spl_mmc_get_uboot_raw_sector() was never compiled,
even when the option CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was
enabled. So rename the macro SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION to
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

---

Changes in v2:
- Add Reviewed-by tag of Quentin Schulz

 arch/arm/mach-imx/imx8m/soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 567e8e9e81a0..806adcf145fa 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -791,7 +791,7 @@ int boot_mode_getprisec(void)
 #endif
 
 #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
-#ifdef SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
 #define IMG_CNTN_SET1_OFFSET	GENMASK(22, 19)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
@@ -826,7 +826,7 @@ unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 
 	return raw_sect;
 }
-#endif /* SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION */
+#endif /* CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION */
 #endif
 
 bool is_usb_boot(void)
-- 
2.43.0

base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
branch: fix-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
