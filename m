Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED3BC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36DF288AD2;
	Mon, 26 Aug 2024 18:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="NW/2cSNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4865088A08; Mon, 26 Aug 2024 18:49:14 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B0078852A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1724690952; x=1727282952;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XU0dQoorOCHAv/br+1zcpBOotCDqoq+TgDBt9WbWluE=;
 b=NW/2cSNviwVjIwJ5ASIIzm57waLoZ4yhwYny3q36e2YDUDR87fOWKJN+kV6Mm1KF
 S9wncKExw6vUWY0bNwQOTmqB3mbdYZe6l4maqn45PpyuOk3qUWvTCilUhwIaYlqv
 aA4q4aIGw9QmyIR2G8nbP6wBsM3LjwBBEci/WWA6Cds=;
X-AuditID: ac14000a-03e52700000021bc-ba-66ccb2082e43
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 21.BB.08636.802BCC66;
 Mon, 26 Aug 2024 18:49:12 +0200 (CEST)
Received: from llp-Hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 26 Aug
 2024 18:49:11 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Mon, 26 Aug 2024 18:49:06 +0200
Subject: [PATCH 2/2] board: phytec: phycore_imx8mp: Add mtd spi partitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240826-wip-bhahn-add_qspi_support-v1-2-0ea7840b940a@phytec.de>
References: <20240826-wip-bhahn-add_qspi_support-v1-0-0ea7840b940a@phytec.de>
In-Reply-To: <20240826-wip-bhahn-add_qspi_support-v1-0-0ea7840b940a@phytec.de>
To: Teresa Remmet <t.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724690951; l=2782;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=XU0dQoorOCHAv/br+1zcpBOotCDqoq+TgDBt9WbWluE=;
 b=PZWRJIDi1hU0w2dYKyVAXo5sADY2758qM1oW9A/aoE0Eqg/3s+YBo9eRLCDgyiUEp5/mF2Jwv
 b6UOSg9Xz+1D8eg9AlWli7Iu+OvGS6dSRql24De+LY1mt2wlDIXOOMm
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWyRpKBR5dj05k0gycdrBZTJ21mt3i7t5Pd
 ovudugOzx6sDq9g9zt7ZwejR393CGsAcxWWTkpqTWZZapG+XwJWxd4tFwQPRiue/PrE2MM4W
 6mLk5JAQMJH4v7aPuYuRi0NIYAmTxMxNZ5hAEkICDxklprUXgthsAmoSu968ZgWxWQRUJY4u
 vMcCYgsLeEm8anoIVs8rIChxcuYToDgHB7OApsT6XfogYWYBeYntb+cwQ5T4SqyYdgFqvK/E
 /6OnwMZwCvhJnF1+lw3EFhFIl9j24jsrxJgoiXcTgyDOFJb4vHsNG8iZEgK7mSRW7/3JDlIj
 IZAosfO1HMRIWYmb57ewQdTLS0w795oZwg6VOLJpNdMERpFZSA6dhXDoLCSHLmBkXsUolJuZ
 nJ1alJmtV5BRWZKarJeSuokRFPoiDFw7GPvmeBxiZOJgPMQowcGsJMIrd/lkmhBvSmJlVWpR
 fnxRaU5q8SFGaQ4WJXHe1R3BqUIC6YklqdmpqQWpRTBZJg5OqQbG6JMxG2PiM3KzhI+smKc2
 SSdi8ar5Ap/T0zvifk03s3tyt+SaoSvjWlNnzgvV00p8H8+3EnuxeX+GjMj5yyoFrtlBJ6zC
 Xu9bpnbO7XTwtqYlhUr6jywub1GO/Dj1/uKuqQYWt/pfvFGZcaC8jeswX+qZmuREtZ0P8hS3
 nIqTtHnBfIw3T/WMEktxRqKhFnNRcSIAIG+iimsCAAA=
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

Depending on if a SPI-NOR flash is populated add the mtd partition
table to the device tree. For this we have to also probe the
flash before booting.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/phycore_imx8mp/phycore-imx8mp.c   | 34 ++++++++++++++++++++++++++
 board/phytec/phycore_imx8mp/phycore_imx8mp.env |  4 +++
 2 files changed, 38 insertions(+)

diff --git a/board/phytec/phycore_imx8mp/phycore-imx8mp.c b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
index ef9513618449..bf2d5ce01fa5 100644
--- a/board/phytec/phycore_imx8mp/phycore-imx8mp.c
+++ b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
@@ -10,10 +10,34 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <env.h>
 #include <init.h>
+#include <fdt_support.h>
+#include <jffs2/load_kernel.h>
 #include <miiphy.h>
+#include <mtd_node.h>
+
+#include "../common/imx8m_som_detection.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define EEPROM_ADDR		0x51
+#define EEPROM_ADDR_FALLBACK	0x59
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	u8 spi = phytec_get_imx8m_spi(NULL);
+	/* Do nothing if no SPI is populated */
+	if (!spi)
+		return 0;
+
+	static const struct node_info nodes[] = {
+		{ "jedec,spi-nor", MTD_DEV_TYPE_NOR, },
+	};
+
+	fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
+
+	return 0;
+}
+
 static int setup_fec(void)
 {
 	struct iomuxc_gpr_base_regs *gpr =
@@ -27,6 +51,11 @@ static int setup_fec(void)
 
 int board_init(void)
 {
+	int ret = phytec_eeprom_data_setup_fallback(NULL, 0,
+			EEPROM_ADDR, EEPROM_ADDR_FALLBACK);
+	if (ret)
+		printf("%s: EEPROM data init failed\n", __func__);
+
 	setup_fec();
 
 	return 0;
@@ -39,6 +68,11 @@ int board_mmc_get_env_dev(int devno)
 
 int board_late_init(void)
 {
+	u8 spi = phytec_get_imx8m_spi(NULL);
+
+	if (spi != 0 && spi != PHYTEC_EEPROM_INVAL)
+		env_set("spiprobe", "sf probe");
+
 	switch (get_boot_device()) {
 	case SD2_BOOT:
 		env_set_ulong("mmcdev", 1);
diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index f8f878e8f3a6..e5b49756132a 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -7,6 +7,7 @@ bootcmd=
 	fi;
 	mmc dev ${mmcdev};
 	if mmc rescan; then
+		run spiprobe;
 		if test ${doraucboot} = 1; then
 			run raucinit;
 		fi;
@@ -27,6 +28,9 @@ fdt_addr_r=0x48000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
 ip_dyn=yes
+mtdparts=30bb0000.spi:3840k(u-boot),128k(env),128k(env_redund),-(none)
+mtdids=nor0=30bb0000.spi
+spiprobe=true
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 mmcargs=

-- 
2.34.1

