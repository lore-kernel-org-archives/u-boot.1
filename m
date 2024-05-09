Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848C9C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 10:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92C018847B;
	Thu,  9 May 2024 12:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="D0uz1Nxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6693588474; Thu,  9 May 2024 12:12:09 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A8488479
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 12:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (unknown [149.11.192.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3BBC53FE00; 
 Thu,  9 May 2024 10:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715249523;
 bh=D33N1+pmKw3Wgnq8J/rh3aLOqAuPUMBFGBvLJ2332no=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=D0uz1Nxp+PcqMHdLUr/Cwpj+dip1TKOyV83cBSe/joY6QIpE4ty1XorVMYtnk1U+s
 2tUM+k0GQZkg0GgYDTcLcH+kLBBNZ15qPVT8KxUN7VP6D/v5oSto6vARayKCcVkbMK
 Qz6io6uRiJuDRToElcRY7f0JLLLP5YuJ6LKEgPwsnDyN3rPdGzFB5RxSyP+TXE2sY2
 m92DtpXJErPA5S21DQk8k97KgZNuqyeTiui/ltv2pDUoHGOOkibJDpB6Wt4OoPkB8M
 M01b187n0seD5WV3yM+Pyo383yWQrEhZlo7IVV6HDNyx06VxSijeiA5aleCh9hkEPI
 HHc7kIYOBgdRA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/5] board: starfive: function to read eMMC size
Date: Thu,  9 May 2024 12:11:49 +0200
Message-ID: <20240509101155.18666-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509101155.18666-1-heinrich.schuchardt@canonical.com>
References: <20240509101155.18666-1-heinrich.schuchardt@canonical.com>
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

The EEPROM provides information about the size of the eMMC.
Provide a new function get_mmc_size_from_eeprom() to read it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: E. Shattow <lucent@gmail.com>
---
v3:
	no change
v2:
	fix typos in get_mmc_size_from_eeprom() description
---
 arch/riscv/include/asm/arch-jh7110/eeprom.h    |  7 +++++++
 board/starfive/visionfive2/Kconfig             |  9 +++++++++
 .../visionfive2/visionfive2-i2c-eeprom.c       | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
index 62d184aeb57..45ad2a5f7bc 100644
--- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
+++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
@@ -12,6 +12,13 @@
 u8 get_pcb_revision_from_eeprom(void);
 u32 get_ddr_size_from_eeprom(void);
 
+/**
+ * get_mmc_size_from_eeprom() - read eMMC size from EEPROM
+ *
+ * @return: size in GiB or 0 on error.
+ */
+u32 get_mmc_size_from_eeprom(void);
+
 /**
  * get_product_id_from_eeprom - get product ID string
  *
diff --git a/board/starfive/visionfive2/Kconfig b/board/starfive/visionfive2/Kconfig
index 2186a939646..d7e8a7a7d78 100644
--- a/board/starfive/visionfive2/Kconfig
+++ b/board/starfive/visionfive2/Kconfig
@@ -50,4 +50,13 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply PHY_LIB
 	imply PHY_MSCC
 
+config STARFIVE_NO_EMMC
+	bool "Report eMMC size as zero"
+	help
+	  The serial number string in the EEPROM is meant to report the
+	  size of onboard eMMC. Unfortunately some Milk-V Mars CM Lite
+	  modules without eMMC show a non-zero size here.
+
+	  Set to 'Y' if you have a Mars CM Lite module.
+
 endif
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index 5095a0e9fdb..9648a270494 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -548,6 +548,24 @@ u32 get_ddr_size_from_eeprom(void)
 	return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
 }
 
+u32 get_mmc_size_from_eeprom(void)
+{
+	u32 size;
+
+	if (IS_ENABLED(CONFIG_STARFIVE_NO_EMMC))
+		return 0;
+
+	if (read_eeprom())
+		return 0;
+
+	size = dectoul(&pbuf.eeprom.atom1.data.pstr[19], NULL);
+
+	if (pbuf.eeprom.atom1.data.pstr[21] == 'T')
+		size <<= 10;
+
+	return size;
+}
+
 U_BOOT_LONGHELP(mac,
 	"\n"
 	"    - display EEPROM content\n"
-- 
2.43.0

