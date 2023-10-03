Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBB5E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A828726B;
	Tue,  3 Oct 2023 08:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JazBeyRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2DE87264; Tue,  3 Oct 2023 08:37:00 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0675487255
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-502e7d66c1eso619417e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315018; x=1696919818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQSt33mDfykgXpHfjQwWV6c/kowMeFN4AoeV3KhvKhI=;
 b=JazBeyRvEI2aFpX5ebzRD4s4m2eRUM6piCrLxcKvCTt98eJFbmr9U2mxA6NxJqS53+
 tiQNx/CjMqfQklwAatJaFVc/Qgyc7fDep5BAV9eXoziD9pPe6gWNSsfcPGTUXP+Cv9nC
 GsOy1WFtObXcFCwC6/CTI6jaG2OJHC0cn+hR1EklYldr8vNtSxZ5z0MMfbo1Dbnaj6Aa
 /HwAdzOPCGQJYVAsYuk0m94VeOfic21aX2t4dNshQk1R0trb9iiE8k9WN2iNzU/aakwo
 q/ux30Q5mFOfhef/egKiBbEH7JmYYwxzEU3132eAZclS7KPoIeelRejnNcKQlujOFjtg
 CgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315018; x=1696919818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQSt33mDfykgXpHfjQwWV6c/kowMeFN4AoeV3KhvKhI=;
 b=f8aySN70hUJJpxRzvPzuYRb/HYmn4h2VTrVCFXP8Yasi/EZ98yzsxKl19nln8NqOOv
 lL1zZhDqgkk3TV2QPIjSjwsFlx4K48boTDruidkGeyT5AVZqO2J5n7xTxMfyq3yY7ZKB
 7970rYgZrFS0GJdOl3vAKEtjd2ZYOwY6nw6WNtpMptpOzeyOBAYJ/7toIGjdmLUBRuKH
 B4Ha6u6YDxYYikW1hKZMZdQcBaD+z/jdwjiyPTy/gRTi17KS5uD3RVz/6X3hPrj4TJit
 aSA6hjwjucoYWAdpXo/uzsge8hv3PFEnVOiZ+xVGa13CHzHbu30gjsWIXhO63aTMANRX
 MIlg==
X-Gm-Message-State: AOJu0YwHs/NdL/elZ/nMXBnmrDROypabJg7/+4S/I5ZkhzbGpLZJz0Ab
 sblDsC8TPHFDyRdqc05+KeI=
X-Google-Smtp-Source: AGHT+IE5CispNXgZSvpTY7iLpsgVnZPE3l6JR5FOFCw2SJ52lG3GyQDQ5G+qP2i5SGweHBIkJByJ6Q==
X-Received: by 2002:a05:6512:1595:b0:500:b828:7a04 with SMTP id
 bp21-20020a056512159500b00500b8287a04mr12921900lfb.18.1696315018262; 
 Mon, 02 Oct 2023 23:36:58 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:36:58 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 03/16] configs: transformer_t30: support booting from USB
Date: Tue,  3 Oct 2023 09:36:34 +0300
Message-Id: <20231003063647.42770-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

Change boot logic to primary try to boot from USB in dock, then
from microSD and lastly from eMMC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/tf600t.config             | 2 +-
 configs/transformer_t30_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/tf600t.config b/configs/tf600t.config
index 89d8db4eb1..18ab4fbd87 100644
--- a/configs/tf600t.config
+++ b/configs/tf600t.config
@@ -1,4 +1,4 @@
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf600t"
 CONFIG_TRANSFORMER_SPI_BOOT=y
-CONFIG_BOOTCOMMAND="setenv gpio_button 222; if run check_button; then poweroff; fi; setenv gpio_button 132; if run check_button; then echo Starting SPI flash update ...; run update_spi; fi; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
+CONFIG_BOOTCOMMAND="setenv gpio_button 222; if run check_button; then poweroff; fi; setenv gpio_button 132; if run check_button; then echo Starting SPI flash update ...; run update_spi; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4d00
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 576b00b82a..0f83ae7247 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -20,7 +20,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
+CONFIG_BOOTCOMMAND="setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.39.2

