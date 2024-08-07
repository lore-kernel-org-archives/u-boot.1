Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AD3C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 13:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238DD88C72;
	Wed,  7 Aug 2024 15:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S47EjpiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0D688A7D; Wed,  7 Aug 2024 15:00:42 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A45B8890F
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 15:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7b2dbd81e3so235377966b.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723035639; x=1723640439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BIZm1KCAfSA2R/kZFLFycBnLtV/vJAlbyaVV0Yu55pc=;
 b=S47EjpiDbBFj3uhpR4va703voFw1e8b02/PQZijWak4zPC7PpBtXO+fg0oRR14v/Q8
 vmAzLOXWBWYVgd0BKEHLVpCkGn7l9MZAPDrY1UHalnAB1oXyo3N5O9pJRYK8tLxQKF78
 CiC7TOpa//DvsNdU7nh8pVg4aTuTAbQqHz3LbQHSIGbFVyhsCyVP/+dzKTlbFHO7B0Xu
 qTVuOPMIV9UPhxHuj6Wysf4nYE7oYX1gAKil3mbGx3eQU/WLeOoA0+e0m53VJou/JGTV
 oEbC6Jsp707PnZQfGNaiq5oiobHYRR0BqktGTMb11xOQf8T6qx4oHpr96W6LiwZhoQk7
 hKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723035639; x=1723640439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BIZm1KCAfSA2R/kZFLFycBnLtV/vJAlbyaVV0Yu55pc=;
 b=TnJAtVcVgRtCzPyWL5baey7DiXzmzVFWHGFmGUFGsBU1kl8MB1J3PmVEeDJ8nYF8y1
 u5I2RJfAVcNJrkwCEHJZ5PMs9/IDiSQ/+BYXDuFmCq0ppMu9rus5VMsoP+1PkV+p7fyk
 2e14AT3w33J28U0nH9idaNaORAA5XL3+OWgqvdtu4LN1h2ZR8KdM+vJpJ+j4tayIef5M
 LSIihlMA8hpY7RdNv2NeepRNnyev3mFKez63Aqsa5zgrOGFklRTGmPODD79DXPzoFD1H
 ODnHKe0FvwIwLMypYzTigPcYMqwjZnhUINcSQ0VJdaARcF+uqYuqD23HziP0HCZKFREC
 2xgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmhCmGuDfGdwQh53JpHZvENQ0m990W2cqnPaD2FoDYxNleH58ZV7mUsprl0gEpzroC+HRAC0dDRU2qe1Wk7XiZ6y6DyQ==
X-Gm-Message-State: AOJu0YziF9svRiTmQrBMbaYRO4rnqt7sF99J4UembwV4unatXAyYTWT6
 6hlyd7uj/CZ4C4Hux8jV6Anb45OPWhXUu5N7/xsMzrQURQHGJSrfAsJ2VBUDWXA=
X-Google-Smtp-Source: AGHT+IGGTkYhLZQAkkujxezyCjuI7/UpGwIoUklPHxnpWenZ0z4EHs/1le0YEyFFNh4I+27MSkW55A==
X-Received: by 2002:a17:907:3207:b0:a75:23bb:6087 with SMTP id
 a640c23a62f3a-a7dc4fa89d4mr1322018466b.29.1723035623133; 
 Wed, 07 Aug 2024 06:00:23 -0700 (PDT)
Received: from localhost.localdomain (ppp046103060252.access.hol.gr.
 [46.103.60.252]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c0e0sm642823166b.67.2024.08.07.06.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 06:00:22 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Anton.Antonov@arm.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] configs: enable efidebug and EFI http boot on QEMU aarch64
Date: Wed,  7 Aug 2024 16:00:09 +0300
Message-ID: <20240807130010.407399-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

EFI HTTP is a useful option to have by default and is working reliably on
QEMU. Let's enable it by default, since we have no size limitations.
While at it enable 'efidebug' as well, which is currently needed to
configure the EFI HTTP boot options.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 configs/qemu_arm64_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 7e166f439087..088ba39f18e1 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -33,6 +33,7 @@ CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_ENV_IS_IN_FLASH=y
@@ -68,3 +69,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
 CONFIG_TPM=y
+CONFIG_EFI_HTTP_BOOT=y
-- 
2.45.2

