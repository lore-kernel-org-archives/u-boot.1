Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C826D10C03
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 20:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93BDD8908A;
	Sat, 26 Oct 2024 22:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ydd0FQNV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c0yxP/VI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174E489020; Sat, 26 Oct 2024 22:18:46 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB5589079
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 22:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XbWFB4CLMz9sp9;
 Sat, 26 Oct 2024 22:18:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zwf2pykDhtfOtwKhWgFo9DuxzuccW0MTRwhofwAR37w=;
 b=Ydd0FQNVk4VP34OgHbpDD0peRo1hkEBMpjFdME1h/zkYopYjbDWX5LtnVDjGUT+rov7iXf
 0brh9ri5re79M/zh1HIZADwVnRIDgKUvyHfP/4ibcfLThKnKLz6kIbGybksDOOcRu6j/Nq
 wtxQ7jwaYzSQ7Xd7jSzWILxZuCKagCymwfoeVWAnm7wlU7uJCfWW8WwsAv570h8iHKyW7+
 RoNdV2K33wJR16jQvj8Hn9kc87hVvlaKzuJCya6ZYcBBEQbY4Wz36KMcxtw8/X+NrVcoSO
 T5D4qj/mnsN3eufWOvRT9x/6q8CQbxt9NiDOk8adbE1TUwGLKtDVqN8hbE8rbA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zwf2pykDhtfOtwKhWgFo9DuxzuccW0MTRwhofwAR37w=;
 b=c0yxP/VIuoClZynnvASD/nIncCYZtWAIRX19a0I/6ssAeNqsZac+BXP5lgS/o59msfqjmv
 iCkg14rC/FldA2bqWGQX8cO3mduSDxlbed4JeP73hTGN0uOjoyJG+UemUnrCCVAgbLBqcp
 gzZZ0EI+obm+FbYSKAhOWvzyLQENAVWOHGP6qJePlTh9yP94HJX9WS7LhIn9dV8NWdRpAo
 6SK5mE84TuHrjZomeRCvcaEuxszrLO+J6iwhVGPiiYoUcJYLEVCLQMiusNbp3afoGO86Cq
 CpSZr4RJECx2biRfGrF8WxdEKZF65n9kFdAgmhV9Vtf018MNWvnfLYFMnT9Pzg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 8/9] mtd: spi-nor: Rename SPI_ADVANCE to SPI_STACKED_PARALLEL
Date: Sat, 26 Oct 2024 22:16:25 +0200
Message-ID: <20241026201741.171073-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: eeu7ya3y4t6a3arbtzouekkerqu65mwh
X-MBO-RS-ID: 791edde0a828d7b17f7
X-Rspamd-Queue-Id: 4XbWFB4CLMz9sp9
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

The SPI_ADVANCE description does not explain what the switch does.
It does not have anything to do with any advanced functionality, it
only gates off support for stacked and parallel SPI NORs. Rename the
Kconfig symbol, update description, and move it right next to Xilinx
hardware as it seems to be specific to this hardware. Make sure the
symbol is also protected by if DM_SPI in Kconfig.

Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Pratyush Yadav <p.yadav@ti.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/mtd/spi/spi-nor-core.c |  4 ++--
 drivers/spi/Kconfig            | 12 ++++++------
 include/linux/mtd/spi-nor.h    |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index c1ee466bcc0..74aec6b60c4 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3047,7 +3047,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			       const struct flash_info *info,
 			       struct spi_nor_flash_parameter *params)
 {
-#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_ADVANCE)
+#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
 	struct udevice *dev = nor->spi->dev;
 	u64 flash_size[SNOR_FLASH_CNT_MAX] = {0};
 	u32 idx = 0, i = 0;
@@ -3172,7 +3172,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 
 		spi_nor_post_sfdp_fixups(nor, params);
 	}
-#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_ADVANCE)
+#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
 	/*
 	 * The flashes that are connected in stacked mode should be of same make.
 	 * Except the flash size all other properties are identical for all the
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index fa817ec4883..fd5cb3694f6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -20,12 +20,6 @@ menuconfig SPI
 
 if SPI
 
-config SPI_ADVANCE
-	bool "Enable the advance feature"
-	help
-	 Enable the SPI advance feature support. By default this is disabled.
-	 If you intend to use the advance feature support you should enable.
-
 config DM_SPI
 	bool "Enable Driver Model for SPI drivers"
 	depends on DM
@@ -615,6 +609,12 @@ config ZYNQMP_GQSPI
 	  This option is used to enable ZynqMP QSPI controller driver which
 	  is used to communicate with qspi flash devices.
 
+config SPI_STACKED_PARALLEL
+	bool "Enable support for stacked or parallel memories"
+	help
+	 Enable support for stacked/or parallel memories. This functionality
+	 may appear on Xilinx hardware. By default this is disabled.
+
 endif # if DM_SPI
 
 config FSL_ESPI
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 655a6d197ea..b8b207f7b5c 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -308,7 +308,7 @@ enum spi_nor_option_flags {
 	SNOR_F_BROKEN_RESET	= BIT(6),
 	SNOR_F_SOFT_RESET	= BIT(7),
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(8),
-#if defined(CONFIG_SPI_ADVANCE)
+#if defined(CONFIG_SPI_STACKED_PARALLEL)
 	SNOR_F_HAS_STACKED	= BIT(9),
 	SNOR_F_HAS_PARALLEL	= BIT(10),
 #else
-- 
2.45.2

