Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AE7C10F1A
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 04:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EDD987DEA;
	Sun, 12 May 2024 06:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pUfQFysV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB56C87E96; Sun, 12 May 2024 06:26:02 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C63C387E15
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 06:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (unknown [149.11.192.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3357A4081F; 
 Sun, 12 May 2024 04:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715487957;
 bh=gU+2FwcK1OVl2QS+SuChCWgC6RbE5U83lM+KlBG+WZg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=pUfQFysVBf1cg1rwpMTVYkhLsqjLC3CjxXe8l+M//DyMch4qrt0m02fM3d06sy1v+
 VwR+KdxMRRPRd0UV1ObGQZevhz2TWWPLqiw1QeY4UHpMeW/yAEp1WlzmXOYEAQgV6t
 BlfmAcGpkspPslBpaCl6shw4JnWs3bCgKTz6GHAwCGYEr1Agi+xV/sep8VdDo1gU0k
 bp/SZbIYMMvznpvCZKrp88Rri7z1SPOo63mBx9tUGeex1XzBhJz3D6K7FLBM37M2L7
 obUKoBMydh4S1nzyK3O9kw50wUtQtd0D/DChvGS/sespV5Syd8zlSBN+90PzETLF7m
 FWrmYE3AQiu4w==
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
Subject: [PATCH v4 1/5] board: starfive: function to read eMMC size
Date: Sun, 12 May 2024 06:25:22 +0200
Message-ID: <20240512042528.7766-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240512042528.7766-1-heinrich.schuchardt@canonical.com>
References: <20240512042528.7766-1-heinrich.schuchardt@canonical.com>
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
v5:
	no change
v4:
	no change
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

