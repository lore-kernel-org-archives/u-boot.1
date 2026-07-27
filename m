Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F149EC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 07:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1CC06065A;
	Mon, 27 Jul 2026 07:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BsD4ClVSSL1R; Mon, 27 Jul 2026 07:00:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3811460627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785135605;
	bh=TlKXV/y1uIzhp/nbjDaT0H5cigt+hDBBb4zANeAr4mo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DijB3Sec3j3uGJTR1OnX+cGWZxFdf8J/1kH0HbdmZCSYj1AB+nIdUt2NVqRR3fhdU
	 CyOn12Rl4FZrFFt8O2vrCV1sQ30Bi0BkYukLD6zWv5c/beEkkQQfC2MTFerO9IWn7L
	 kVJnnUE6JXi7I2AzR8eFPY/pztcuvOSptFFxX9P3nclxA/kKxvXuvw/yqjq82keZtz
	 BZp1BdmGT82+/JmkSylKhL7IkbW4N+2pHWa321S38O5UJYUleMhS2DDt2SQOQAS0nU
	 zZXgEtXj1zSJxTj0epD/BA/aO757tbNJe6u2tRfubaoNngkXI88CvNWI8MskhgpaEd
	 Mw75C7KBVAnLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3811460627;
	Mon, 27 Jul 2026 07:00:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFF8669
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B62F14008E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EcfluRWNy2PI for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:00:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2914A40105
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2914A40105
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2914A40105
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:02 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3810c5d691bso1740433a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 00:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785135602; x=1785740402;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TlKXV/y1uIzhp/nbjDaT0H5cigt+hDBBb4zANeAr4mo=;
 b=p20WeoyckJMKcvxB5ntyU3QAndirDPI9PK3/kZAFSMx024K6imicdeajTapVH7GmEQ
 oKGOfrfkvXPwASuJG3XoI0AeqQ0uO7sTJjC8TVxeTVsB7p7men9ykv4mArD82cpFU1Le
 0/d4gJ5GT8bekR4AjIwrrNqRMsf40pfQ1+rixOamHPbRuE1cnCKJ7CtYs/Kbi+q6bD9x
 mpuiAQs4TRhT8pgqKoeIMYpENy44Z83TFXj5c5nlufAk/cOqZbAfAadI/E8XscwCm2KF
 CrLqxVC5yh0Po9GZbrL3aWJmL9AvbJB3gMzpC161mXUYO0HcSPYZG1eC2mi7UKOGKplY
 kqVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrivKpc35Fto5/W5kF/20CFX+ChoRf/6Jv9nNa4Yjk0svYgnLyfWYGHloNk9qfDMcrCpVg+ErI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyO/t9P969PZVDigaE6hZrO9+LYyPmtnb45oirPuheQ2pFKbQcT
 qUiR8Vgm2zW8VVdBFAjDncsthFiCInfuydsyNfKzJr2MuZad3WGw1QJi3r6BjfrtWiY=
X-Gm-Gg: AR+sD10tRVfe0d47MSkJm93Qp+JzJMeF7gi/C784y2tEnMpMuOVRvIXeIT5jF9/keX9
 JnGj+KP3DLI27p3h+1ghmkhIHeSfEX4X0cwlPYwCSJb/Qdo5NUKNLYCDE/K+R09jbtifQ5nAnmA
 g2InOFJRaOZ15cEgMmcV9EJYwaoKSfMph1Hq6Gx/LPlX0u9+1TB1ns9+IlihxPUuB0Cjky70ays
 cVg46AFkNZZPUO/8B0FHSNxDNIJLICnVt9qUM5iiMT3JsG6UZ97Sj8B0hTAOi7CPqDbW3LplDyn
 j5huGS/NDLytE2mH2KiTYrbt321QugYUxDOdIKJzrpupBLcTPoBm+2q4maf6Kkla7NOrhMrmF4l
 rdLxvdEA41XNEP2enphSNUruf0uCzwDTp6NGeHmnBVQGb6fEcisuEDN6EqbAxFerUWj3YrU/3vw
 jkYArlAK16HiuybpgAg06Vp40llKnp6c2opGwfS2n5rRC45JwaS3AjAjX1rAWC/SpL0bnMNPsfk
 s+ZXSG4KwJbfO9lhC1vsm76up2sfQObcbbs+H4Gle9MobMcUygF2w==
X-Received: by 2002:a05:6a20:6a09:b0:3c3:84a5:f2be with SMTP id
 adf61e73a8af0-3c67d9b2a9bmr6458724637.11.1785135602371; 
 Mon, 27 Jul 2026 00:00:02 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e52f0c6f2sm22969489c88.11.2026.07.26.23.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 00:00:01 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 27 Jul 2026 14:59:09 +0800
Subject: [PATCH v6 07/11] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-m4-v6-7-2f58566d48ca@riscstar.com>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
In-Reply-To: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
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
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785135602; x=1785740402;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TlKXV/y1uIzhp/nbjDaT0H5cigt+hDBBb4zANeAr4mo=;
 b=A2y6HCWrg/oRbh6RE2BmIbPY8f5egRsxnHR0Up5XryX9d1bo4YtUd6msw1j1IIhkHS
 GdhHtuwr6vAYHi9JsH0L7FvPjhlLOznjc5+CMWquFGxqM8jJSamIoTN3S5YUTj6qwsJl
 WGvZn0WYhEEQzzayHSxugScoz9ieVlUavXQl5WE5nQtRBTyIUUwNbWOa+j1xsspzSZ1d
 OUumHKKZUT0/aD4sPx9OCAAq0SrshgHqqdaEGe8P3qWy3GQmzDQCHGTpb5NNevn6qPoH
 +aBLSLc1VluzeUBnxMzYrhR4g7Jgz0avKgiY74a8T6NC3lLa9IwwwiSfZ5jMpCSrsxLX
 UUZQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=A2y6HCWr
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
 configs/spacemit_k1_defconfig | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index 0604c2feefc..c0ee3a29f23 100644
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
@@ -87,9 +90,26 @@ CONFIG_SPI_FLASH_WINBOND=y
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
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y

-- 
2.51.0

