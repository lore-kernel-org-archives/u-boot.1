Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5F3FB5E8B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC851841B8;
	Tue, 17 Mar 2026 02:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AdnqfkUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4869F8412F; Tue, 17 Mar 2026 02:24:32 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EEA840CF
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-46704177543so3427548b6e.2
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710666; x=1774315466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yVX8uerZLpdw/bZXpUp4gt8IZfJAa7Pgs0favoIJ+W0=;
 b=AdnqfkUhI9gfNeQk4t3pRg1CeUISVpuUZm2uxfrwg8j69XB7MtemMUmIrVf7iDwIBv
 O0H9bvPb+J1PueJHQNe4DktpFVvRO6qi0Ilwu90sv1Ki+GVZmbil9iEk2BNL1CvgkKj/
 Y6p+LjkfzW6KDFf7zvr0yHMs5xQgSmHc29bHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710666; x=1774315466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yVX8uerZLpdw/bZXpUp4gt8IZfJAa7Pgs0favoIJ+W0=;
 b=nhdvXfakUb4oM+XNrygJ9y7mxr5o187n2nzWTQVAlwi7pPTD3FTP0eTLdNH3r11xNy
 Q7anmHHMR+yqml+KHTYgxL/p22o95KlqGb0rCYrOmDQdGM7bidodmTa3xejujyAr19hv
 Baf+hub0zGlbhnt1+LN1q2xVCUmPScHkpZOxTIP+zZmgDO93bpw3axhX9t59RZ26XMGu
 bAmjli5oiBfPdBO6dLqRgiakzGzxca42GKrBRglWurEgRW6REjOQhox4VVqkkOgw4ndp
 5GJpFUvPnte6RMYreFDVrs7dF3JwdKelFqF7bkXZoc+MesqZqn62oTQBfm33+chDmM6X
 8ZMA==
X-Gm-Message-State: AOJu0Yy0RtqzFWy96u7jqv4Zw3Ri9HhWoBUbTQQ6lLUtAF+mEKvj/yCO
 GbBzA494W1yrTGAf3LyJ59HrDsA4xpHcKP40VGCkFkXrWbfgGRNhNQY4g1zvNUERcdt5qPQq33g
 vozso
X-Gm-Gg: ATEYQzz9WLPPFQINCGxYkOQNIvFjggo6PcmjSzmx1Vt1ucOTJ1NH+e9jLeHujzSeVKQ
 ZwIGsPN6RyS33OupxvenzJH+bFQJ86Ct8BagFHPjifaYeRWgm+ncan8xh54Eax7HImMxvJvoaES
 YNvC12/V2iniQgzeww1/Y08VR0SxBlozzK14JRA+8zmiwrwM2Q1b4f2ga+4vssT7M6zHiOsMO1f
 OKxKROwnQ+LhQ66OkMeg4IRmWxpmbnhStcu4FLrQveuhQ6xrPjnFYKEzF/mlcf5CiEDNkhY0KQb
 TzePY3jeQ3tiuLo0gurN7HRDIhc6qq9pOcDLwMlcmlTY9rsvf0lOZXo5bCpj7zf//my4ugS/lGY
 NoK8tCvUUUgdOXQqDSo5w4PxJCmnJ1fT4uM+oo/NnM3heZiM/4skh29XKQ1hXbI2EVpSV9pDSWo
 jwzfXhimGx5Aoy/VZrBCy8AVm7xj6qUY2/5bbK103r9j7k9cKY1ULe4wwpuzaSnbFqzgFjirlLh
 JIx8rop0pIFfDDp8sDfNkKvA9CSiZeiH1qfZ4pXWatYpNs2fhI=
X-Received: by 2002:a05:6808:11ce:b0:45e:e07d:4eff with SMTP id
 5614622812f47-467570ac928mr8061221b6e.21.1773710666422; 
 Mon, 16 Mar 2026 18:24:26 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46734164245sm10083496b6e.8.2026.03.16.18.24.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sysreset: Rework tests around SYSRESET_CMD_POWEROFF
Date: Mon, 16 Mar 2026 19:24:24 -0600
Message-ID: <20260317012424.4162441-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue around how
SYSRESET_CMD_POWEROFF is typically selected. We cannot rely only on
CMD_POWEROFF as SYSRESET_CMD_POWEROFF must also be tested for its own
dependency of SYSRESET.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/Kconfig               | 2 +-
 drivers/power/pmic/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index bc0aeb6c266e..62148f00cd36 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -212,7 +212,7 @@ config SANDBOX
 	select SUPPORT_OF_CONTROL
 	select SUPPORT_BIG_ENDIAN
 	select SUPPORT_LITTLE_ENDIAN
-	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF
+	select SYSRESET_CMD_POWEROFF if SYSRESET && CMD_POWEROFF
 	select SYS_CACHE_SHIFT_4
 	select IRQ
 	select SUPPORT_EXTENSION_SCAN if CMDLINE
diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 345b7c922635..5bc14842e666 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -384,7 +384,7 @@ config DM_PMIC_TPS80031
 config PMIC_STPMIC1
 	bool "Enable support for STMicroelectronics STPMIC1 PMIC"
 	depends on DM_I2C
-	select SYSRESET_CMD_POWEROFF if CMD_POWEROFF && !ARM_PSCI_FW
+	select SYSRESET_CMD_POWEROFF if SYSRESET && CMD_POWEROFF && !ARM_PSCI_FW
 	---help---
 	The STPMIC1 PMIC provides 4 BUCKs, 6 LDOs, 1 VREF and 2 power switches.
 	It is accessed via an I2C interface. The device is used with STM32MP1
-- 
2.43.0

