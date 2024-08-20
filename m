Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4C5C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 15:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A863488D80;
	Tue, 20 Aug 2024 17:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724166006;
	bh=PvggasZTTXiqW6ETOT+IOW4ZdHJr0ra8DExQVgYZgC0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QUVB56lF4Q+5MBecTYsWSOJWfgX4ldd1z29qIqw/Ls+Ppxe5JoUNx5oimuCttzj9a
	 sXtrmtAyxVVpTeAyE37MBKFx4zQXfrOyomRhd7srdPQAL75sGzyeL1hJwzXp6a7MAf
	 o1i+BK3Ov4eoOz97VxaNHM58XzDEv0/JiWaWvn4zSN7brqPoS376S/63eoGQhK/Qqw
	 uXIxr3qJarMpFpa8c+6YIBn04MfR8E2Rh4OrFyaDeS1qoMYRYTolUjgtAaLJfedOGt
	 GQQKBQL8rfBbZ40bN+ZFsDmNZFdhWe/Iup0PD3cG+eSC//sgfw1Ynd5SIWRWdyvHMC
	 u7HRSFN6zmmtA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3A6EB88A2D;
 Tue, 20 Aug 2024 17:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724166004;
 bh=PvggasZTTXiqW6ETOT+IOW4ZdHJr0ra8DExQVgYZgC0=;
 h=From:To:Cc:Subject:Date:From;
 b=YFI9iSsTP0rjQNQBblV68E2GqnQlsfBjw74lvodDh35UtusSXqRHbxuvZrlO9gF4i
 OvYII0fD+2krZWM8/3q8v/oxEWSwNpvM1Vc9dvzX7HnxNBFziz/zEvJwbcbefEAWEL
 LcuVvZIczfTHsxe1H/jTUHy+5AUANJWy2ymuf4kEvUlXQTONsMNi+bcnx+7ff6HVWD
 rUVAfvkA9QA+wghOIP8PQKaMnQsotYaRVeOgUDhXYrCnRXTqTFGwrncGAUYXP/zMFi
 3Kd0TqbG0SfkTyfMtYUP5H+qQ1JGJJiYmQsOgKRFWiUvXAKkwOj6Xi56pxVjNxRVYO
 TuNTObnczqTHA==
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, Cem Tenruh <c.tenruh@phytec.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2] config: imx: Define CFG_SYS_UBOOT_BASE for Phytec's imx8mm
 SoM QSPI boot
Date: Tue, 20 Aug 2024 16:59:44 +0200
Message-Id: <20240820145944.3048128-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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

The image offset when booting from SPI-NOR (QSPI, FSPI driver) is
different than one for SD card / eMMC as extra space (0x1000) is consumed
by FSPI configuration header (CONFIG_FSPI_CONF_HEADER).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Avoid line breaks with defines
---
 include/configs/phycore_imx8mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/configs/phycore_imx8mm.h b/include/configs/phycore_imx8mm.h
index 0910ae2d87..a445d842ac 100644
--- a/include/configs/phycore_imx8mm.h
+++ b/include/configs/phycore_imx8mm.h
@@ -11,8 +11,15 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
+#define UBOOT_ITB_OFFSET			0x57C00
+#define FSPI_CONF_BLOCK_SIZE		0x1000
+#define UBOOT_ITB_OFFSET_FSPI (UBOOT_ITB_OFFSET + FSPI_CONF_BLOCK_SIZE)
+#ifdef CONFIG_FSPI_CONF_HEADER
+#define CFG_SYS_UBOOT_BASE (QSPI0_AMBA_BASE + UBOOT_ITB_OFFSET_FSPI)
+#else
 #define CFG_SYS_UBOOT_BASE \
 		(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
+#endif
 
 #ifdef CONFIG_SPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
-- 
2.39.2

