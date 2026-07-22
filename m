Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C651C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:07:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4C0D40904;
	Wed, 22 Jul 2026 15:07:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KgR1s_NJcILr; Wed, 22 Jul 2026 15:07:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E391E4054F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784732878;
	bh=s3Hm7IS9JBKG3hZdsjEXnOj18/bseURRcyOQnefXFqM=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yfepsahoh0alX9SpWh9LRFa6lINWydCC4la2tNcGnd+xx+G/lKT4b8bKYy8Sb5/6j
	 CpOwXYkPbEJDJxV9RXq0pgItZxSQ9799/zkPe5iLNl4Xqz3SI3qijkUJEGw8wEimq+
	 +9vOMDmSTENoAAmVlEm4FQ9sB49HsRFXUgz+pVsUXSlsv/x9ePJhzFa1Ny37KE1gx2
	 qcnIjENF/qzPoyu43Z0uRpWmUw9DgWOG2sMg6JpjeNl4V490uErBAZlooiDQWY3sZk
	 e6RHhC3OxUani83qiSdpUOcj1Ani+95hqIAupoPXRuULscp9Y4pKgctoCgeW0S/8og
	 rvhVMEKnqdcgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E391E4054F;
	Wed, 22 Jul 2026 15:07:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B8C21093
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DBC3607C1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fR5V2-Dsk1cJ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:07:55 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4C15F607C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C15F607C0
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C15F607C0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:07:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC3D8494B; Wed, 22 Jul 2026 17:07:53 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DFE3848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:07:51 +0200 (CEST)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso10744751a91.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784732870; x=1785337670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s3Hm7IS9JBKG3hZdsjEXnOj18/bseURRcyOQnefXFqM=;
 b=CMOBKXv1LETVM2P3VxMBuAhAbQ/4WW5wE5V8gaEgieEUwzLBSvwqtQ6vap7GmvVMFY
 LUP7qwlr6026Rjx4X7HaELGspF3yttDm86R3prSkWPihZgYoMtvCWJSj0EEmpG+8mWAB
 h0+xegQd8svZmqctBU0ZiGBcpZ5w8lc2j0xMF/ilb41ViKpcqOwhIID0J2vJyG5FwGhz
 pgIUNMiJ38iLLcqG6HAgfJlyeezodGlFEzLCOzHjSL/wDGLtO/N/NvGLKjzZiBpaaJpD
 69/BVd0s3A0JJMVhNxQopHcVPoEFKEy78lP9k5rzdz1shvJ/7DXTO41Im9KSZzdILJwG
 SzBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpH7LEoyXTAVHX4iBQbVruCAXwK7Q2fQpVqgdaY+x5uzGcUItNik5uGjU5exk9EBgryaqe3pfk=@lists.denx.de
X-Gm-Message-State: AOJu0YzK4qCoFnnPRNtymQNy4U6bDpctPNbUB6D46mJxbEvWZEelGFva
 jX5bHXd/jtQUeKxeRhP0jXyH74cvCz6t1GFuNRsaGvrDTjH8almOcj1cGTPDGPKXZN0=
X-Gm-Gg: AR+sD116KtdBgai4tUYgjoTyyfJAPaU38Sa25FiM5PhT3HrT7EwnN1StQzAkDi0QF8h
 eRndKTp3lTuBioXk+R648H/0X/Yq+QTdrqlI+uRS3CpTGbiEKkPDzvh6K5ySBpViteq4c4uLSSM
 OqDkilw97ggmz7WxCvm3VkMg9eNLxYG2gbjhcm0fl4KsrQxaY9KUqfQacMzpy77ZffsKWNItPwb
 R9emxwEP+D8YaT0K29LNhcZ8HUDz6DnRCogO6JjRQxrg9WPQDI8yAizw6sgpA/cuMWwUJn05Lu6
 8LujDcnQ9fUH1o5tCUi1yAmADlR/AGDc3YnAJtRHDY2HV060flr6wc9BkBqRJ42o0yuTF3n4UXd
 3XzgRYVhspqQQWX/E+0ADO++CGPxdol94l7eUqOk95/z8a7cn+PQnBwGRa3xs82RuAix4fX895A
 JNGcq8SqCnqJyxrX8YhWjhrg2E46GpBMZOoFyoVYzr+8wy2OppsJVSTNh258OiQ4XEaEdqKiHN/
 SwiAQX0dFB8ljJZxGBKjIou2KxMn9L8usWQ+ZFgBNupS8dMWinKqA==
X-Received: by 2002:a17:90b:5608:b0:38e:488f:7068 with SMTP id
 98e67ed59e1d1-38e4b43108bmr25448556a91.2.1784732869681; 
 Wed, 22 Jul 2026 08:07:49 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e088d3fsm10622267eec.25.2026.07.22.08.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:07:49 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:07:01 +0800
Subject: [PATCH v5 5/9] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-m4-v5-5-c41a951e5157@riscstar.com>
References: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
In-Reply-To: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784732870; x=1785337670;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s3Hm7IS9JBKG3hZdsjEXnOj18/bseURRcyOQnefXFqM=;
 b=soG1xv3r0TY78JVl3hT1e65/l/XKLxL0OvjjRZirhZhgkOEZLpzihIVHHlckk7Z2Gt
 p3dcW3JSWrs8GskIzwjhG+gETZ56mID+jigXcSOGDEplQCTrgCG2GeNW2TciflFNStuN
 EIUJU+TB+hF8p/XRwua2GXzhz9nNETreoR/sMEMx/G3Zx/6906cHU1q5kymn4jV37nXZ
 rH3BtmeWcxsNx/JuGu9lwZspVdCrPvS+L9l1MlpZoumwM/8cOJ2h3Nzq2fFn0aYZ5opF
 PHGdJHTpaDfLKU5N2r4eS7Nf8ceNX5Z/bE9xE29qx64tlUCgzuzntgP4xIkTDia48jeJ
 ZyOw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=soG1xv3r
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.chung@riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.b="soG1xv3r"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Eric Chung via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Eric Chung <eric.chung@riscstar.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable high-speed MMC modes.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v5:
- Remove ADMA support since it depends on CMD23 support.
- Enable PINCONF support for related power source setting.
v2:
- Enable ADMA support.
- Enable SYSCON support.
---
 board/spacemit/k1/MAINTAINERS |  1 +
 configs/spacemit_k1_defconfig | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 32d47ecc8f1..ca994e2a1fb 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -9,6 +9,7 @@ F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
+F:	drivers/mmc/spacemit_sdhci.c
 F:	drivers/pinctrl/spacemit/
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 81409c844a6..33cc881bab0 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -23,6 +23,7 @@ CONFIG_DEBUG_UART_BASE=0xd4017000
 CONFIG_DEBUG_UART_CLOCK=14700000
 CONFIG_TARGET_SPACEMIT_K1=y
 CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_ISA_ZICBOM=y
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_RISCV_MMODE=y
 # CONFIG_SPL_SMP is not set
@@ -48,6 +49,7 @@ CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
@@ -61,6 +63,7 @@ CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
 CONFIG_PINCTRL_SPACEMIT_K1=y
 CONFIG_GPIO=y
 CONFIG_DM_GPIO=y
@@ -87,6 +90,20 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_MEM=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x000a0000
 CONFIG_CMD_SPI=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SPACEMIT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x4
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_EFI_PARTITION=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_DM_SPI_FLASH=y
@@ -94,3 +111,5 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y

-- 
2.51.0

