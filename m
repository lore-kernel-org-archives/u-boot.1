Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9A606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NxXbPBge;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=K+fVuFOr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD3F24078C;
	Mon, 26 Oct 2026 17:34:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yITch1A49Q27; Mon, 26 Oct 2026 17:34:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5BC184077F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793036085;
	b=ZSMUrSR0GbryBjFMETx01udNWPQPATzWNycNKx+9iqcvi/4F2C5Ik6w62m6XaihjdRSF
	 p2j0NhrioTdsEH9GOx/qaHQjJBpnIUXL8vUXK9LP2X2X0qPwJ9LhQQnalptSi3qGKYz6v
	 V2mr1SJGtA14yyNSm7RtgId3GioOPArxTxCSpiQN46gbA/iT3us3WpFZJ55mtROgoxtMP
	 PtwrOAti2KXkVqQuZA9nzS/Rjyhy6LU1cVTdJP7yWUkD83j2wS/wXjO62/Fc+D0u5NOJi
	 bfrO1p3EpWsJFlKzQsWN27QSbtGwSmeYO/UaxpS6rbnpYWEaYlIx1eLxeSgalztPjmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793036085;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3OYyyZecNUTMOM0PJtPeJMe3kB1hlq/xWKQPgrwAlcQ=;
	b=KdaLzJ7lvzS1o6m4n3STcdNUAOVVXTOT6bYnG159yiu8qVacRDI0EiRFl23eduO+68fd
	 8ZPX+T//kUzzWVjK2OvBNvP3/IlHKKXGgqNkLcnjN3fzL9GsCaMxJXhSXDDP9z0EHm9p+
	 W7G/ZApDitoi27HbhNZkpg+nhsyi4Z2F03AuGNChGvQWGs5rxXopw7DkxYuM6ZyFm44KO
	 czaBDT234HF4/2pqolcMGc/UsTWLJ6RdYZZFPyfNchhz82guT3kGXik50DEa/ULB625/1
	 eJwnyUOco3UirsoCOFIkLDWbEinmbCOqNSkY95L1nWCZYxPuaHtx9vS1/BFWyi0BgPQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793036085;
	bh=3OYyyZecNUTMOM0PJtPeJMe3kB1hlq/xWKQPgrwAlcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NxXbPBgeJWytMQLv4GF+0xWlPhHIbWOwZ86u+Qd/85N0ZjdUUyKSEibFGrSZxO+dl
	 tjujSGGbWlFGTN1ZanlIUC+NvNNtOGdaZN32Gsyz55NiWgzCRyMra9AEyIz3Tt6lmB
	 JC7rbhXimgvqVGHoqJE0FIWPKFhLPqN5lpU1JcpD8xPYnS5OFmaSEhCPO9iguqVqGi
	 kLAKAc6lFzzsJIednXhv4Vi5xZnFI2g3bZh232mDQh6LaJHQYy9tbO9eErYiKvUmK8
	 a1jYKC1gu80/D6tyKwWMq2H0Rzgpe4vfmkQqgzE43YCz6RX/7DGwvJvTG0FKY7LPk2
	 F0eMCrwrZ1l4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BC184077F;
	Mon, 26 Oct 2026 17:34:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA08A4B8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB93480DDB
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:41:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yyo_MnWYyJqx for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 15:41:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E49180DCE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793029297;
 b=T7HNPwH4UHuEVlzB+J7ShifMLTGQDQayy4XdOQZJksNeh7x04S/c0Bg96aipknGpNW76
 UiyfsXKJzFMW15aYk/+EKBIbUp/89doi942B7uNZNg0i8tOzKvZINq5jfyhNsOA6ijre3
 gaSJIjxZimw+fLneXRWVOMaW2zy+URm6XKaZQaFmSjde9yoc+yoV0bElFCyHXBMjn5D1R
 aSY41QAMKZaNz6dDhiJBT4eop0otPG6W+ef/oBLfRqdRPT73diptYJ2vlMNn/SBIxMfBq
 kTD/wAUlgFCQmzA9JAa6ZJxhhbiIAoWBEykBuZCBTTDaLPL2Z98upPSoZlPEVTXQtng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793029297;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=3OYyyZecNUTMOM0PJtPeJMe3kB1hlq/xWKQPgrwAlcQ=;
 b=SxqV32d/pyVWrNOJZWsM6vY2DacTE7/c0B1FIyQ3IzNd+zNRPS/XtT8JRDT3iB/6VF3Z
 bWH65PHcGJYTwtXlvVDPhAdnOxocuJAfPe+z4tz1tQeROXnd+vDYNsBl9Q3VnlZD0E/GM
 QDiCpIV9mGkV+F0L05p01fE6Q+fN9uYryfQq46q7ifIPA61ifwR9XqeQeXZ04ooacv/v+
 NfQYNYEMD7YlWZ0+XT/uUrbvq9JsEuS1nMqeT5TZvGQB2NTlm8zAQapF+qL3ToRK/A38h
 5kMH0pearEvdruDxQNrRnCx45JuIBsE/1aQxMcw31E53W9mNFmB0prm+fVbCH0rjhcw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=K+fVuFOr; 
 arc=none smtp.remote-ip=220.197.31.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.2;
 helo=m16.mail.163.com; envelope-from=roberhu001@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=K+fVuFOr
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E49180DCE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
 Content-Type; bh=3OYyyZecNUTMOM0PJtPeJMe3kB1hlq/xWKQPgrwAlcQ=;
 b=K+fVuFOrjgzRrHnXsroH2RlcZ4hGllglP7knvqlnNl7m2+sOlU4IVB8cog/XLT
 4NlWr18KGmMDYjx3ljXKSRJo3R3DT8wveIYzoFbEZ8X7AztDt9r5+ladcwQTcCsl
 lb3xP04ln0dB7xvNpQJfPk1/rylQ1PVD8MSOO4Q4YGyBA=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgCnn6X6c99q3RLgCA--.14756S3;
 Mon, 26 Oct 2026 23:38:43 +0800 (CST)
From: Zunyi Hu <roberhu001@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>, Paul Kocialkowski <paulk@sys-base.io>,
 Johan Jonker <jbx6244@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Zunyi Hu <roberhu001@163.com>
Subject: [PATCH 1/1] sunxi: spl: add SPI NAND boot support for V3s
Date: Mon, 26 Oct 2026 23:38:23 +0800
Message-Id: <20261026153823.31110-2-roberhu001@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261026153823.31110-1-roberhu001@163.com>
References: <20261026153823.31110-1-roberhu001@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgCnn6X6c99q3RLgCA--.14756S3
X-Coremail-Antispam: 1Uf129KBjvAXoW3uw1DtFykGw48JFyDur15urg_yoW8Xw48Ao
 ZxAFsxX34rXw17Za4Ik3W3Wa18Xw1v9an7tr4ayF1fXayxCFW5Kry0vw4rtFs8Kryjyr93
 ArZYqwsIyFyagrn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRnqXPUUUUU
X-CM-SenderInfo: purev2tkxqiii6rwjhhfrp/xtbC6AOvS2rfdAPj1wAA35
X-Mailman-Approved-At: Mon, 26 Oct 2026 17:34:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an SPL loader that talks to SPI NAND the same way the Allwinner
V3s BROM does, so U-Boot proper can be fetched after BROM has loaded
SPL. BROM still reports BOOT_DEVICE_SPI for SPI NAND, so this path is
mutually exclusive with SPL_SPI_SUNXI.

Also avoid selecting SPI NOR for the environment in that case; prefer
FAT when available.

Signed-off-by: Zunyi Hu <roberhu001@163.com>
---
 arch/arm/mach-sunxi/Kconfig             |  22 ++
 arch/arm/mach-sunxi/Makefile            |   1 +
 arch/arm/mach-sunxi/spl_spinand_sunxi.c | 449 ++++++++++++++++++++++++
 board/sunxi/board.c                     |   9 +
 4 files changed, 481 insertions(+)
 create mode 100644 arch/arm/mach-sunxi/spl_spinand_sunxi.c

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b0c5d3cd903..b6c68698555 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1208,6 +1208,28 @@ config SPL_SPI_SUNXI
 	  sunxi SPI Flash. It uses the same method as the boot ROM, so does
 	  not need any extra configuration.
 
+config SPL_SPINAND_SUNXI
+	bool "Support for SPI NAND Flash on Allwinner V3s in SPL"
+	depends on MACH_SUN8I_V3S
+	depends on !SPL_SPI_SUNXI
+	select SPL_CRC32
+	select SPL_LEGACY_IMAGE_FORMAT
+	help
+	  Enable SPI NAND boot support in SPL. When the BROM loads SPL from
+	  SPI NAND, it still reports BOOT_DEVICE_SPI. This driver then loads
+	  U-Boot proper using the same BROM-compatible page layout (SPL
+	  copies at a 32-page stride, U-Boot on an erase-block boundary).
+	  Mutually exclusive with SPL_SPI_SUNXI (same boot device id).
+	  Selects SPL_CRC32 for legacy uImage header CRC checks.
+
+config SPL_SPINAND_SUNXI_GENERIC_2K
+	bool "Use generic 2K-page profile for unknown SPI NAND chips"
+	depends on SPL_SPINAND_SUNXI
+	default y
+	help
+	  Fall back to a generic 2K-page SPI NAND profile when the JEDEC ID
+	  is not in the known chip table.
+
 config PINE64_DT_SELECTION
 	bool "Enable Pine64 device tree selection code"
 	depends on MACH_SUN50I
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index ff475d8fff5..f8c0dfc2a7d 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_DRAM_SUN8I_A33)	+= dram_sun8i_a33.o
 obj-$(CONFIG_DRAM_SUN8I_A83T)	+= dram_sun8i_a83t.o
 obj-$(CONFIG_DRAM_SUN9I)	+= dram_sun9i.o
 obj-$(CONFIG_SPL_SPI_SUNXI)	+= spl_spi_sunxi.o
+obj-$(CONFIG_SPL_SPINAND_SUNXI)	+= spl_spinand_sunxi.o
 obj-$(CONFIG_SUNXI_DRAM_DW)	+= dram_sunxi_dw.o
 obj-$(CONFIG_SUNXI_DRAM_DW)	+= dram_timings/
 obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_sun50i_h6.o dram_dw_helpers.o
diff --git a/arch/arm/mach-sunxi/spl_spinand_sunxi.c b/arch/arm/mach-sunxi/spl_spinand_sunxi.c
new file mode 100644
index 00000000000..ef7a9a171e2
--- /dev/null
+++ b/arch/arm/mach-sunxi/spl_spinand_sunxi.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SPL loader for Allwinner SPI NAND (BROM-compatible layout).
+ *
+ * Copyright (C) 2019 Benedikt-Alexander Mokroß
+ * Copyright (C) 2026 Zunyi Hu <roberhu001@163.com>
+ *
+ * Mimics the Allwinner BROM SPI NAND read path (page load + cache read)
+ * so SPL can fetch U-Boot proper after the BROM has loaded SPL itself.
+ *
+ * Flash layout (BROM-compatible): multiple SPL copies at a 32-page stride,
+ * then U-Boot proper starting on an erase-block boundary after those copies.
+ */
+
+#include <image.h>
+#include <log.h>
+#include <mapmem.h>
+#include <spl.h>
+#include <asm/arch/spl.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <sunxi_gpio.h>
+
+#ifdef CONFIG_SPL_OS_BOOT
+#error CONFIG_SPL_OS_BOOT is not supported yet
+#endif
+
+#define SUN6I_SPI0_CCTL		0x24
+#define SUN6I_SPI0_GCR		0x04
+#define SUN6I_SPI0_TCR		0x08
+#define SUN6I_SPI0_FIFO_STA	0x1C
+#define SUN6I_SPI0_WCR		0x20
+#define SUN6I_SPI0_MBC		0x30
+#define SUN6I_SPI0_MTC		0x34
+#define SUN6I_SPI0_BCC		0x38
+#define SUN6I_SPI0_TXD		0x200
+#define SUN6I_SPI0_RXD		0x300
+
+#define SUN6I_CTL_ENABLE	BIT(0)
+#define SUN6I_CTL_MASTER	BIT(1)
+#define SUN6I_CTL_SRST		BIT(31)
+#define SUN6I_TCR_XCH		BIT(31)
+
+#define CCM_AHB_GATING0		(0x01C20000 + 0x60)
+#define CCM_SPI0_CLK		(0x01C20000 + 0xA0)
+#define SUN6I_BUS_SOFT_RST_REG0	(0x01C20000 + 0x2C0)
+
+#define AHB_RESET_SPI0_SHIFT	20
+#define AHB_GATE_OFFSET_SPI0	20
+
+#define SPI0_CLK_DIV_BY_4	0x1001
+#define DUMMY_BURST_BYTE	0x00
+#define EGON_BT0_HEADER_SIZE	40
+#define SPI_READ_MAX_SIZE	60
+/* Bound U-Boot search so a blank device cannot hang forever. */
+#define SPINAND_UBOOT_MAX_TRIES	64
+
+struct sunxi_nand_config {
+	const char *name;
+	u32 jedec_id;
+	u32 page_mask;
+	u8 page_shift;
+	u32 addr_mask;
+	u8 addr_shift;
+	u32 block_size;
+	u32 page_size;
+};
+
+struct egon_bt0_header {
+	u32 jump;
+	u8 magic[8];
+	u32 checksum;
+	u32 length;
+	u32 header_size;
+	u8 header_version[4];
+	u8 boot_vsn[4];
+	u8 egon_vsn[4];
+	u8 platform[8];
+};
+
+static const u8 egon_bt0_magic[8] = {
+	'e', 'G', 'O', 'N', '.', 'B', 'T', '0'
+};
+
+static struct sunxi_nand_config sunxi_known_nands[] = {
+	{
+		.name = "Macronix MX35LF1GE4AB",
+		.jedec_id = 0x00c212c2,
+		.page_mask = 0x00ffffff,
+		.page_shift = 11,
+		.addr_mask = 0x7ff,
+		.addr_shift = 0,
+		.block_size = 128 * 1024,
+		.page_size = 2048,
+	},
+	{
+		.name = "Winbond W25N01GVxxIG",
+		.jedec_id = 0x00efaa21,
+		.page_mask = 0x0000ffff,
+		.page_shift = 11,
+		.addr_mask = 0x7ff,
+		.addr_shift = 0,
+		.block_size = 128 * 1024,
+		.page_size = 2048,
+	},
+	{
+		/* Some W25N01G samples report device id byte 0x20. */
+		.name = "Winbond W25N01G",
+		.jedec_id = 0x00efaa20,
+		.page_mask = 0x0000ffff,
+		.page_shift = 11,
+		.addr_mask = 0x7ff,
+		.addr_shift = 0,
+		.block_size = 128 * 1024,
+		.page_size = 2048,
+	},
+	{
+		.name = "GigaDevice GD5F1GQ4",
+		.jedec_id = 0x00c8b148,
+		.page_mask = 0x00ffffff,
+		.page_shift = 11,
+		.addr_mask = 0x7ff,
+		.addr_shift = 0,
+		.block_size = 128 * 1024,
+		.page_size = 2048,
+	},
+	{ /* sentinel */ }
+};
+
+#ifdef CONFIG_SPL_SPINAND_SUNXI_GENERIC_2K
+static struct sunxi_nand_config sunxi_generic_nand_config = {
+	.name = "Generic 2K SPI-NAND",
+	.jedec_id = 0xffffffff,
+	.page_mask = 0x00ffffff,
+	.page_shift = 11,
+	.addr_mask = 0x7ff,
+	.addr_shift = 0,
+	.block_size = 128 * 1024,
+	.page_size = 2048,
+};
+#endif
+
+static struct sunxi_nand_config *sunxi_spinand_enumerate(u32 jedec_id)
+{
+	struct sunxi_nand_config *ptr = sunxi_known_nands;
+
+	while (ptr->name) {
+		if (jedec_id == ptr->jedec_id)
+			return ptr;
+		ptr++;
+	}
+#ifdef CONFIG_SPL_SPINAND_SUNXI_GENERIC_2K
+	return &sunxi_generic_nand_config;
+#else
+	return NULL;
+#endif
+}
+
+static uintptr_t spi0_base_address(void)
+{
+	/* V3s / sun6i-gen SPI0 */
+	return 0x01c68000;
+}
+
+static void spi0_pinmux_setup(unsigned int pin_function)
+{
+	unsigned int pin;
+
+	for (pin = SUNXI_GPC(0); pin <= SUNXI_GPC(2); pin++)
+		sunxi_gpio_set_cfgpin(pin, pin_function);
+	sunxi_gpio_set_cfgpin(SUNXI_GPC(3), pin_function);
+}
+
+static void spi0_enable_clock(void)
+{
+	uintptr_t base = spi0_base_address();
+
+	setbits_le32(SUN6I_BUS_SOFT_RST_REG0, BIT(AHB_RESET_SPI0_SHIFT));
+	setbits_le32(CCM_AHB_GATING0, BIT(AHB_GATE_OFFSET_SPI0));
+	writel(SPI0_CLK_DIV_BY_4, base + SUN6I_SPI0_CCTL);
+	writel(BIT(31), CCM_SPI0_CLK);
+	setbits_le32(base + SUN6I_SPI0_GCR,
+		     SUN6I_CTL_MASTER | SUN6I_CTL_ENABLE | SUN6I_CTL_SRST);
+	while (readl(base + SUN6I_SPI0_GCR) & SUN6I_CTL_SRST)
+		;
+}
+
+static void spi0_disable_clock(void)
+{
+	uintptr_t base = spi0_base_address();
+
+	clrbits_le32(base + SUN6I_SPI0_GCR, SUN6I_CTL_MASTER | SUN6I_CTL_ENABLE);
+	writel(0, CCM_SPI0_CLK);
+	clrbits_le32(CCM_AHB_GATING0, BIT(AHB_GATE_OFFSET_SPI0));
+	clrbits_le32(SUN6I_BUS_SOFT_RST_REG0, BIT(AHB_RESET_SPI0_SHIFT));
+}
+
+static void spi0_init(void)
+{
+	uintptr_t base = spi0_base_address();
+
+	spi0_pinmux_setup(SUNXI_GPC_SPI0);
+	spi0_enable_clock();
+	writel(0x01, base + SUN6I_SPI0_WCR);
+}
+
+static void spi0_deinit(void)
+{
+	spi0_disable_clock();
+	spi0_pinmux_setup(SUNXI_GPIO_DISABLE);
+}
+
+static void sunxi_spi0_load_page(struct sunxi_nand_config *config, u32 addr)
+{
+	uintptr_t base = spi0_base_address();
+	u8 status = 0x01;
+
+	addr = (addr >> config->page_shift) & config->page_mask;
+
+	writel(4, base + SUN6I_SPI0_MBC);
+	writel(4, base + SUN6I_SPI0_MTC);
+	writel(4, base + SUN6I_SPI0_BCC);
+
+	writeb(0x13, base + SUN6I_SPI0_TXD);
+	writeb((u8)(addr >> 16), base + SUN6I_SPI0_TXD);
+	writeb((u8)(addr >> 8), base + SUN6I_SPI0_TXD);
+	writeb((u8)addr, base + SUN6I_SPI0_TXD);
+	setbits_le32(base + SUN6I_SPI0_TCR, SUN6I_TCR_XCH);
+
+	while ((readl(base + SUN6I_SPI0_FIFO_STA) & 0x7f0000) > 0)
+		;
+	while ((readl(base + SUN6I_SPI0_FIFO_STA) & 0x7f) < 4)
+		;
+	readl(base + SUN6I_SPI0_RXD);
+
+	do {
+		ndelay(200);
+		writel(3, base + SUN6I_SPI0_MBC);
+		writel(2, base + SUN6I_SPI0_MTC);
+		writel(2, base + SUN6I_SPI0_BCC);
+		writeb(0x0f, base + SUN6I_SPI0_TXD);
+		writeb(0xc0, base + SUN6I_SPI0_TXD);
+		setbits_le32(base + SUN6I_SPI0_TCR, SUN6I_TCR_XCH);
+		while ((readl(base + SUN6I_SPI0_FIFO_STA) & 0x7f) < 3)
+			;
+		readb(base + SUN6I_SPI0_RXD);
+		readb(base + SUN6I_SPI0_RXD);
+		status = readb(base + SUN6I_SPI0_RXD);
+	} while (status & 0x01);
+}
+
+static void sunxi_spi0_read_cache(struct sunxi_nand_config *config,
+				  u8 *buf, u32 addr, u32 len)
+{
+	uintptr_t base = spi0_base_address();
+
+	addr = (addr >> config->addr_shift) & config->addr_mask;
+
+	writel(4 + len, base + SUN6I_SPI0_MBC);
+	writel(4, base + SUN6I_SPI0_MTC);
+	writel(4, base + SUN6I_SPI0_BCC);
+
+	writeb(0x0b, base + SUN6I_SPI0_TXD);
+	writeb((u8)(addr >> 8), base + SUN6I_SPI0_TXD);
+	writeb((u8)addr, base + SUN6I_SPI0_TXD);
+	writeb(DUMMY_BURST_BYTE, base + SUN6I_SPI0_TXD);
+	setbits_le32(base + SUN6I_SPI0_TCR, SUN6I_TCR_XCH);
+
+	while ((readl(base + SUN6I_SPI0_FIFO_STA) & 0x7f) < 4 + len)
+		;
+	readl(base + SUN6I_SPI0_RXD);
+
+	while (len-- > 0)
+		*buf++ = readb(base + SUN6I_SPI0_RXD);
+
+	ndelay(100);
+}
+
+static void spi0_read_data(struct sunxi_nand_config *config, void *buf,
+			   u32 addr, u32 len)
+{
+	u8 *buf8 = buf;
+	u32 chunk_len;
+	u32 curr_page;
+	u32 last_page = (addr >> config->page_shift) & config->page_mask;
+
+	sunxi_spi0_load_page(config, addr);
+
+	while (len > 0) {
+		curr_page = (addr >> config->page_shift) & config->page_mask;
+		if (curr_page > last_page) {
+			sunxi_spi0_load_page(config, addr);
+			last_page = curr_page;
+		}
+
+		chunk_len = min(len, (u32)SPI_READ_MAX_SIZE);
+		if ((((addr + chunk_len) >> config->page_shift) &
+		     config->page_mask) > curr_page)
+			chunk_len = ((curr_page + 1) << config->page_shift) -
+				    addr;
+
+		sunxi_spi0_read_cache(config, buf8, addr, chunk_len);
+		len -= chunk_len;
+		buf8 += chunk_len;
+		addr += chunk_len;
+	}
+}
+
+static u32 spi0_read_id(void)
+{
+	uintptr_t base = spi0_base_address();
+	u8 idbuf[3];
+
+	writel(5, base + SUN6I_SPI0_MBC);
+	writel(2, base + SUN6I_SPI0_MTC);
+	writel(2, base + SUN6I_SPI0_BCC);
+	writeb(0x9f, base + SUN6I_SPI0_TXD);
+	writeb(DUMMY_BURST_BYTE, base + SUN6I_SPI0_TXD);
+	setbits_le32(base + SUN6I_SPI0_TCR, SUN6I_TCR_XCH);
+	while ((readl(base + SUN6I_SPI0_FIFO_STA) & 0x7f) < 5)
+		;
+	readb(base + SUN6I_SPI0_RXD);
+	readb(base + SUN6I_SPI0_RXD);
+	idbuf[0] = readb(base + SUN6I_SPI0_RXD);
+	idbuf[1] = readb(base + SUN6I_SPI0_RXD);
+	idbuf[2] = readb(base + SUN6I_SPI0_RXD);
+	ndelay(100);
+
+	return idbuf[2] | (idbuf[1] << 8) | (idbuf[0] << 16);
+}
+
+static u32 sunxi_spi0_count_spls(struct sunxi_nand_config *config,
+				 struct egon_bt0_header *self)
+{
+	u8 buffer[EGON_BT0_HEADER_SIZE];
+	struct egon_bt0_header *egon = (struct egon_bt0_header *)buffer;
+	u32 entry_pages[8] = { 0, 32, 64, 96, 128, 160, 192, 224 };
+	u32 spls = 0;
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		u32 address = entry_pages[i] * config->page_size;
+		int hits = 0;
+
+		sunxi_spi0_load_page(config, address);
+		sunxi_spi0_read_cache(config, buffer, address,
+				      EGON_BT0_HEADER_SIZE);
+
+		if (!memcmp(egon->magic, egon_bt0_magic, 8)) {
+			spls++;
+			continue;
+		}
+
+		if (egon->jump == self->jump)
+			hits++;
+		if (egon->checksum == self->checksum)
+			hits++;
+		if (egon->length == self->length)
+			hits++;
+		if (egon->header_size == self->header_size)
+			hits++;
+		if (!memcmp(egon->header_version, self->header_version, 4))
+			hits++;
+		if (!memcmp(egon->boot_vsn, self->boot_vsn, 4))
+			hits++;
+		if (!memcmp(egon->egon_vsn, self->egon_vsn, 4))
+			hits++;
+		if (!memcmp(egon->platform, self->platform, 8))
+			hits++;
+		if (hits > 4)
+			spls++;
+	}
+
+	return spls;
+}
+
+static int spl_spinand_load_image(struct spl_image_info *spl_image,
+				  struct spl_boot_device *bootdev)
+{
+	struct legacy_img_hdr *header;
+	struct sunxi_nand_config *config;
+	struct egon_bt0_header *egon;
+	u32 id, uboot_offset, total_spl_size, spls;
+	int ret = -EINVAL;
+	int tries = 0;
+
+	header = (struct legacy_img_hdr *)CONFIG_TEXT_BASE;
+
+	spi0_init();
+	id = spi0_read_id();
+	if (!id) {
+		spi0_deinit();
+		printf("sunxi SPI-NAND: no device\n");
+		return -ENODEV;
+	}
+
+	config = sunxi_spinand_enumerate(id);
+	if (!config) {
+		spi0_deinit();
+		printf("sunxi SPI-NAND: unknown chip %06x\n", id);
+		return -ENODEV;
+	}
+
+	debug("sunxi SPI-NAND: %s (%06x)\n", config->name, id);
+
+	egon = map_sysmem(0x00000000, EGON_BT0_HEADER_SIZE);
+	spls = sunxi_spi0_count_spls(config, egon);
+	if (spls < 1)
+		spls = 1;
+	total_spl_size = ((config->page_size * 32) * (spls - 1)) +
+			 ((config->page_size / 1024) * egon->length);
+	/* Align U-Boot proper to an erase-block boundary after the SPL copies */
+	uboot_offset = round_up(total_spl_size, config->block_size);
+	unmap_sysmem(egon);
+
+	do {
+		debug("sunxi SPI-NAND: try U-Boot @ 0x%x\n", uboot_offset);
+		spi0_read_data(config, (void *)header, uboot_offset, 0x40);
+		if (image_check_hcrc(header)) {
+			ret = spl_parse_image_header(spl_image, bootdev, header);
+			if (!ret) {
+				spi0_read_data(config,
+					       (void *)(uintptr_t)spl_image->load_addr,
+					       uboot_offset, spl_image->size);
+				break;
+			}
+			uboot_offset += round_up(image_get_image_size(header),
+						 config->block_size);
+		} else {
+			uboot_offset += config->block_size;
+		}
+	} while (++tries < SPINAND_UBOOT_MAX_TRIES);
+
+	spi0_deinit();
+
+	if (ret)
+		printf("sunxi SPI-NAND: U-Boot not found\n");
+
+	return ret;
+}
+
+/*
+ * BROM reports SPI for SPI NAND on V3s; register on BOOT_DEVICE_SPI.
+ * Do not enable together with SPL_SPI_SUNXI (same boot device).
+ */
+SPL_LOAD_IMAGE_METHOD("sunxi SPI-NAND", 0, BOOT_DEVICE_SPI,
+		      spl_spinand_load_image);
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 3d1afec7c66..3e2fb48d981 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -160,6 +160,15 @@ enum env_location env_get_location(enum env_operation op, int prio)
 			return ENVL_NAND;
 		break;
 	case BOOT_DEVICE_SPI:
+		/*
+		 * On V3s, SPI NAND boot is still reported as BOOT_DEVICE_SPI.
+		 * Do not treat that as SPI NOR for the environment.
+		 */
+		if (IS_ENABLED(CONFIG_SPL_SPINAND_SUNXI)) {
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
+				return ENVL_FAT;
+			break;
+		}
 		if (prio == 0 && IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
 			return ENVL_SPI_FLASH;
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
-- 
2.17.1

