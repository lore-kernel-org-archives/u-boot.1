Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872A5C54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 11:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B72870AB;
	Mon, 25 Mar 2024 12:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T+4KpqEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A41870AB; Mon, 25 Mar 2024 12:47:22 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DFBC87EB2
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 12:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a45f257b81fso491580666b.0
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 04:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711367239; x=1711972039; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqoHV8cGciX4Ao/8p4+nn/qyhtF2e1hKDNhD04oySek=;
 b=T+4KpqEcv8nNO4u4tkxZJWt1G31OisO7XNwItr5OIr80jSotl1G3WwjCM0OVKpBVND
 I+7JTc6pkpIDVVMV9mVArQBqNOLvZMnMLmYYeslEm0AULMXMvmAMeTQK6DAChgTB/s8/
 d2jnO35vVjabJtwOHxUdujG7TYSBwPPk+RDM+NW/CnrLr+gtuZQ2Is4y3DYYDhLrFES4
 JuSVjBbHvYsQjFJ1X/tY18AVftJl6jp74tnTvSlPCtALRNaE8oAcjhQP6beNL6dqa1y+
 WwD8lr0/d9bre39K+xiDAKs5cVxwWN14Si2oz8z7tKSrF5Nszz8CJMvAltP2c4cpQ8rr
 s4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711367239; x=1711972039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yqoHV8cGciX4Ao/8p4+nn/qyhtF2e1hKDNhD04oySek=;
 b=q9aF0eMB5acuxNyBJ1ecIvWhUfTBa1pvkoA7yFlTWmzrXJhtGQ8ltSqpMfM+bDVfGI
 DDYyulNKh5NawvV0fUK4Fju9Kjsdt892clsQXA65BRXUtWHWYcDmqu/yX/OvIt/2M4CB
 s/oV0M6GWIKjSo3NBRS7csnTN3Gb6Bb9FFYKXBziorq/1I5z1YL6xhYPgKz2eTmsnSoV
 D+yooxYuS+ljjLmz3eUe8uOOnGSraQwRhnqQLg7VvCzOuBuM1lrXu8OTnH0aWTiIYRB+
 CS7cVLEglXzXZa9DSGnQD/knW2Zwnk1/iAX0D+wYpKrMSpMHR5fgyazDrmL+e3By6BUM
 sqZA==
X-Gm-Message-State: AOJu0Yx8lBkEqt+r52haS9GNuUemdVAGtXrbU+tTcHHzxddIg0hAaB6O
 PWm+xVzK6wR71gUbvgWCQknogY5etjnfnyGCv8FUBQQ5EXJoUuX0h7ApIML57tM=
X-Google-Smtp-Source: AGHT+IEv/yPQpfgbEnMD98LbVDTkrBYrTTtaLwJclxKVdfnZbFv3DBmp7oehAP/qtuf1QELa5wqVMA==
X-Received: by 2002:a17:907:9958:b0:a46:7794:2c00 with SMTP id
 kl24-20020a170907995800b00a4677942c00mr4616701ejc.40.1711367239352; 
 Mon, 25 Mar 2024 04:47:19 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:da6e:975d:104b:c525])
 by smtp.gmail.com with ESMTPSA id
 jy10-20020a170907762a00b00a461e10094asm2988864ejc.95.2024.03.25.04.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 04:47:19 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Gaurav Jain <gaurav.jain@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Breno Matheus Lima <breno.lima@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: [PATCH v1 3/3] configs: colibri-imx7: allow accessing job-rings from
 non-TrustZone
Date: Mon, 25 Mar 2024 12:46:42 +0100
Message-Id: <20240325114642.3664840-4-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325114642.3664840-1-ghidoliemanuele@gmail.com>
References: <20240325114642.3664840-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Set FSL_CAAM_JR_NTZ_ACCESS configuration since colibri-imx7
uses Freescale CAAM Job Ring linux driver

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/colibri_imx7_defconfig      | 1 +
 configs/colibri_imx7_emmc_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index 0c6a272ddfc6..16f923b07c22 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -72,6 +72,7 @@ CONFIG_SERVERIP="192.168.10.1"
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_FSL_CAAM_JR_NTZ_ACCESS=y
 CONFIG_DFU_NAND=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x81100000
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index 8dd9fe6e6a38..7c6a725ea9a2 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -61,6 +61,7 @@ CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.168.10.1"
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_FSL_CAAM_JR_NTZ_ACCESS=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x81100000
 CONFIG_FASTBOOT_FLASH=y
-- 
2.34.1

