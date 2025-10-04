Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68DBCAC5B0
	for <u-boot@archiver.kernel.org>; Sat,  4 Oct 2025 19:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C39C283759;
	Sat,  4 Oct 2025 21:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W/NA3ZcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC2683775; Sat,  4 Oct 2025 21:31:53 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 052B7836C1
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 21:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-42d7ef9a402so17836735ab.0
 for <u-boot@lists.denx.de>; Sat, 04 Oct 2025 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759606310; x=1760211110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pR7F4zqfAqlZDuiaxtvsVspvNb4gAc9wmuYpt4yBrSk=;
 b=W/NA3ZcNNH4KTluUHxIjpoKIV9Bz62gJLgaU+tgarS+Tbj9VyJXlsARrAhqCTyHorW
 ilULmxa8RWPsQ3gn6RKaWWipTJyKYj+AMJodkXCKUc7aGI/06Pvp6miUfrmclobqVFLq
 rzfrRdEmxUqiZR3fGLbqX/3AwBWN2VG7decos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759606310; x=1760211110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pR7F4zqfAqlZDuiaxtvsVspvNb4gAc9wmuYpt4yBrSk=;
 b=e40aEbSSypzv5IpnV5l80U9KRk+c00SuW1LoOy0kqOZ48radh2Y/5q1Xr2/uxws1/7
 Sbrthl3ZNc2A2ncdNWpZkycU0KPc+X87ug+sm9EsTN1yVXcsKCGTnJ/0XUT+LXHMNqJh
 o6gFxeAk+r6wrDIO0cuo99pFVPudrCWixgw+gWlwd6Pwl4PaDbu90+cYvPRWOx7knog+
 UtHqdx4piUtj1mbfIa7mTrr1JUtUx9dKANwLTvnR/Puuj/bFXB+GiTPqLUILqFBUejlH
 GeZClmmH+PugoEr3S2MTk065y1AzRqCDMWgrcp6yjhE1Xm3t0jumO4Sn/CDE3sasjpUr
 z8tA==
X-Gm-Message-State: AOJu0YyeJGG3+V9dnn+8B9uKZxHYplCH+D/n6Ha4JVKfs3V5R5V0wWtd
 hr8i6HTErhNzNC09edy/koJy13BETC0mNCHQgs/YG6w73+xvnGWarSs4liiamWAowxm8ab24evS
 Q3smT/dc=
X-Gm-Gg: ASbGncu4EsZY9J+DuiqSGVYTzRuijMaWeMo+4NRnLnMmb5a8b8aKMB7u3ikl8b73pqE
 z79rMKu+mc+idi9pHJ6G8lo+wbqX/VXxFNN7kL5lR7p/HKL+TsWCjfjW2eP/M1qClIPAx028pu6
 Ggnt7pEGqNXpJtcmKq9FwIwRaT6lxfI30LjRK9IhnkLwhKPW6FYPvZ1nah88sltth3URhmRbDhT
 K3azNMMfru2A6dJzqcF1PjLbwUc7wStuAfRMT3Eer8uPWh8AB8R1RQeCkgf/oYTVJ2dD7j87I2x
 N0KZtQNUfQLZF5D4f72XTTu743UjHScEpT+ltjuteoTlkfFPFOMnuaL/T4Vbfi+aGSc5eJUUVXB
 GYIlwxfE7bv5LO1ZNWOcD1vC4whUaGcTCY+P1CG++rjzXGfY2fZWJ5ZpiGWuCftwsrnCaBcivF1
 5Ouzfa3xNp4rUG
X-Google-Smtp-Source: AGHT+IFGFdy6JczPb3i/NdxO7LTAgN5KGJhx2CXraRCccw6mYBhIxQ07Rhu9a1g/F7uRmFy5FqbNVw==
X-Received: by 2002:a05:6e02:1d94:b0:42d:83cf:7eba with SMTP id
 e9e14a558f8ab-42e7b0be465mr88949895ab.0.1759606309687; 
 Sat, 04 Oct 2025 12:31:49 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b294ddfsm33887515ab.33.2025.10.04.12.31.48
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 12:31:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] global: Add expected space between '#include' and directive
Date: Sat,  4 Oct 2025 13:31:46 -0600
Message-ID: <20251004193147.3671498-1-trini@konsulko.com>
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

These files had '#include<file.h>' rather than '#include <file.h>' which
while functional is not the correct style.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 configs/am62x_evm_r5_ethboot_defconfig | 2 +-
 configs/am65x_evm_r5_usbdfu_defconfig  | 2 +-
 drivers/usb/common/fsl-errata.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/am62x_evm_r5_ethboot_defconfig b/configs/am62x_evm_r5_ethboot_defconfig
index 96b2c28825fe..5ad4d3f0e5cc 100644
--- a/configs/am62x_evm_r5_ethboot_defconfig
+++ b/configs/am62x_evm_r5_ethboot_defconfig
@@ -1,4 +1,4 @@
-#include<configs/am62x_evm_r5_defconfig>
+#include <configs/am62x_evm_r5_defconfig>
 
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index 3ac494f01263..f9161f1fe111 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -1,4 +1,4 @@
-#include<configs/am65x_evm_r5_defconfig>
+#include <configs/am65x_evm_r5_defconfig>
 
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
diff --git a/drivers/usb/common/fsl-errata.c b/drivers/usb/common/fsl-errata.c
index 89ae73f2ba48..66ff93b2982b 100644
--- a/drivers/usb/common/fsl-errata.c
+++ b/drivers/usb/common/fsl-errata.c
@@ -7,7 +7,7 @@
 
 #include <hwconfig.h>
 #include <fsl_errata.h>
-#include<fsl_usb.h>
+#include <fsl_usb.h>
 #if defined(CONFIG_FSL_LSCH2) || defined(CONFIG_FSL_LSCH3) || \
 	defined(CONFIG_ARM)
 #include <asm/arch/clock.h>
-- 
2.43.0

