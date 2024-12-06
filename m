Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9047E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4147688815;
	Fri,  6 Dec 2024 23:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jn0BpVjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08EEB8870D; Fri,  6 Dec 2024 23:57:18 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61A088815
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-46686a258c2so24064311cf.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525834; x=1734130634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPouc1XXuLoKka/JGIsG0i0OsBuMBfzWPvr2c1bXqVo=;
 b=jn0BpVjIgS6CAthqzPaV4O+/VYQFQ+Fdhq5Xz1kO9g8le/9vfrXY9K07/9uB1ZQN96
 Wp2PTldSizAqML9XbZG7MB7C0MDFuIHPxKLlhGJ+W+YdLlQ7I5lb+1RXR4xDpMEtlHJK
 rbIik7Uqtq0YQ8tMqITSkVZdyrEq4eLJ2kRBG05otixhegX2MQ2cNsLJdLsI0Ju834qs
 6aOECjY38CITuZWgGI30dlGom3Uj0bxCSrtzzT71pHtxZpHTjInbr0hEYOWoksdgQKPI
 m6bCOSxsW6WIvsjfMRFEnRDACnZGp/n1C1FdueCfec1/UYAFMvaUDpk0stOi8eK4BV2Z
 jNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525834; x=1734130634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPouc1XXuLoKka/JGIsG0i0OsBuMBfzWPvr2c1bXqVo=;
 b=pN3++U9ueTUzl/nU0ddPbqLUL0P5YK3nJMZCkN7/xNe700xWl6EWZC+S8w9lRfzFvS
 4RDpB6LfdyfJNnD/blPQxlKFhs7v0bca1MdiyWRmYUng8TNYzFa6ufqPBPMbOjn+eUwg
 uWAY5DFaQmNpN1tA1SGl9sc/sw20YtS4X21jap6Ux52tTRSN4SfKlnrOln+sFPpmaEji
 DKveeCwF3+nrwfxZTtCcTGKxeQkG9KLjFtCRk6AfaSftDegZG2DUF7P/qDckA1/U8+Kl
 kH1KN76F8BJsPU+oMoHh6a1xw6zAssHRoLVA3s/flP8yrw/MM9RoGrrE9nbAXOGDA5Ic
 hBJQ==
X-Gm-Message-State: AOJu0Yyo86DUtuhgRp91PDiKFZWZhYlRHzhpLl/xx2B/3KiWLIhDuFNZ
 jhpk46gfNqygXWFPcs0Wch/L5F6QGiV/ALAuZGl4lKbyOE7MvHbUoC6PFfJnLsN3PTPm1dHnbDT
 h
X-Gm-Gg: ASbGncu7kNIU0U09IrbZFQf1yHG/bKY+Xsheh3f98spY0VeJMJobYYxInqzJBWUkq8z
 PBYfEgrbZHT0LQwUq7zCTkZIgxWqQhatPid2HcvwcmLQ7klLjYCT0uCZMKueTyyAsYVz+aiKzcT
 CN/u6YJi09CY1opkluMCcgdy5qYrJY/ig1iiScW9AYqYZrBXH6zWjQb5B7SJzZ5IVjsQ4rNfME0
 g5EbtMpJiMK6L9CnlxnF9F/r/SgjiISlApat3eMfbEuAuAYVXe+sbWgPyhJjP1m78tjL61nqxdq
 xqwzwZFnq1XLGd8m/80AOzyd3zWhOLFWMN08i4IIDx/G6MaI
X-Google-Smtp-Source: AGHT+IEhDxFIPFb/ASICwDnqtziL/KN3aDeNnVSJn8e57LldEyytlQpZUshkZBBtgDxEKuzGoWQP9A==
X-Received: by 2002:ac8:5d12:0:b0:466:a254:7341 with SMTP id
 d75a77b69052e-46734cc4565mr85789161cf.17.1733525833114; 
 Fri, 06 Dec 2024 14:57:13 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm26080871cf.34.2024.12.06.14.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:57:12 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <michal.simek@amd.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 10/10] configs: Enable sysinfo for QEMU Arm64
Date: Fri,  6 Dec 2024 14:54:27 -0800
Message-Id: <20241206225438.13866-11-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206225438.13866-1-raymond.mao@linaro.org>
References: <20241206225438.13866-1-raymond.mao@linaro.org>
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

Enable sysinfo smbios by default for arm64.
When SYSINFO_SMBIOS is enabled, disable QFW_SMBIOS.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2
- None.
Changes in v3
- add CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE

 configs/qemu_arm64_defconfig | 3 +++
 drivers/misc/Kconfig         | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 8dffb91e93b..31656699d82 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -62,6 +62,8 @@ CONFIG_PCIE_ECAM_GENERIC=y
 CONFIG_SCSI=y
 CONFIG_DEBUG_UART_PL011=y
 CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_PSCI=y
@@ -71,3 +73,4 @@ CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
+CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6009d55f400..da84b35e804 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -568,7 +568,7 @@ config QFW_MMIO
 config QFW_SMBIOS
 	bool
 	default y
-	depends on QFW && SMBIOS && !SANDBOX
+	depends on QFW && SMBIOS && !SANDBOX && !SYSINFO_SMBIOS
 	help
 	  Hidden option to read SMBIOS tables from QEMU.
 
-- 
2.25.1

