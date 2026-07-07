Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F714C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 518D584A52;
	Tue,  7 Jul 2026 17:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="b4suXQsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF52D84A52; Tue,  7 Jul 2026 17:22:47 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C4D84A92
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-384c94c9414so2513996a91.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783437763; x=1784042563;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LzFglR2GGAlw+R4ZH4aINvyMn+L4dnTITQAFLwuAq7A=;
 b=b4suXQsYufuFcxY9OC2RTD5F5hfD5fs9DClaj7dwPiLRd+KKklvxYP3Mat8waSswoA
 cPQb6MYPHyaLwolrxYq25xd8mhTE+kD/wLypTF05+Aia79F6852EkTdoSwbRYVl9+qT1
 qK8LB3pJBNkNv2YzPgl7fnSKRQu/BhNlcO4sC5SfvSUf97vr4xY0KrEOzUjjoxfo45nZ
 1tLowLyKw6N7+wGy+FspzAdBHQ1U+anW18AbQc3kqrv7X+5E/n8FqpBZb7vPd+A4KHsi
 f61ae70itTBKeDy+4uSY4YjPnfP3FJKiiVH32LPaPpdXAgx2PO6aFyHynOASU3X8Ot2Z
 Figw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437763; x=1784042563;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LzFglR2GGAlw+R4ZH4aINvyMn+L4dnTITQAFLwuAq7A=;
 b=m23RPPI01pgoDIsxCMPJcnpKpNySG2lctsHWr2a3hEW8JNeDzKL7yER8mnHa0KQfFw
 ds1uny3C3R0h90CL8h//+KKUD4RDM4CDWgdEqCVqaGjgJPofGJ8SwmVX6edHhTOnt5Y3
 goibT+IM5Y6S2AQvNHqhCTBXjZxYwEaf+j0lplplyd+EkWy3NEq1s5M5Ey6gAm9A99Vg
 NrmoSNtCufy1C5ON6OBqWe6TpbXm3n2JPphcTQwDWVImlgLdgsT7WZjpX0OcmnWbOYwM
 NrF44BFEXu7Jinz0Jlt5qs8+7mVyorWpPIMFnfrI5L0O23HaOQeuPnG/o6i0hL0M/W7h
 Eywg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqyxBE/yJdFU1T1PGkfu8ijWH55sw5huZ9y8A3Svayj1kHOeiI2KOoc82jElIlfW+316D/EJ78=@lists.denx.de
X-Gm-Message-State: AOJu0Yyfvcx2OQ95b654xGKggg0mdx5+n8L2SDzSULwuSh5qj+MJ8OOv
 vqAJPt0Rt7a8x/MjwI6vVoXkLp1kKYmNuFDtaCYwhXAefJv+g9iZVWC9CwxutGOon0o=
X-Gm-Gg: AfdE7ckFq9jpw6vZWrwz80YPtwvmV7dH3d1yzZ+/pkPbchnDOY+F+8DBC+FbYodK1Dr
 w57HXJyFJ8x1jLGoBtWLSmPdxu7DsbbGbAhzUgdESG4HCzP8IGJhD2ahCOpQYAgESn+6xBorRzz
 2GwkvazNa2f2kQ3uWlmw63Yg2t0Yfk/CSkDgRpmpYaoA/Osq8wKCoE5sVBZ7j/jJvgqKEZK5Yh6
 e5VW1nNdVd/fQ71FsbJDCgL2siMmGgTGRXTOF9R+DjXW43vmDFtQhO/NoErK5laFOaf4Z1GpZ6s
 Ge3mx9Q+0aqxjAEe52xmnCgXD3r1xrQvzupJ1B5rjAXJCrQMzI+Ck35tGj7zDE7wzWFSoHXveAx
 7Y/OaDC7+iRrdjisR/1r72HApd5R7cMIS1HEWjP+vBoAU9p4xxO2QO16p9eocPC4Idpil266UZ7
 IhAiBui0L81vTGC6J4MSELbzT/JCNptWG4HREYtIqumurXiopetJp6vpBYxKapOfe9lXgYsBWHS
 mfHIcU2jPlJa+9G4+ElKU09IZ5CRD/XZiV4PiZAGDuLsgqfRb985JBy5jkBiIjR
X-Received: by 2002:a17:90b:4ace:b0:37f:c28a:de61 with SMTP id
 98e67ed59e1d1-38756fc98bfmr5489792a91.17.1783437763541; 
 Tue, 07 Jul 2026 08:22:43 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483ddd1sm9594997eec.9.2026.07.07.08.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:22:42 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 07 Jul 2026 23:21:47 +0800
Subject: [PATCH v4 06/10] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-m4-v4-6-dbd01185f911@riscstar.com>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
In-Reply-To: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
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
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Enable high-speed MMC modes.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
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
index 81409c844a6..886679367a9 100644
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
@@ -87,6 +89,21 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_MEM=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x000a0000
 CONFIG_CMD_SPI=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
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

