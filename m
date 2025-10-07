Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9167BCCD184
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2564838C2;
	Tue,  7 Oct 2025 10:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="yD1bB4hv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8446383881; Tue,  7 Oct 2025 10:18:20 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B559C838BB
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1F5ADC9A4A; Tue,  7 Oct 2025 10:18:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825098; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=2mEmwq9YZWwaYhDFGNE/2ZxuovBAHhQQsjGEuu31L6o=;
 b=yD1bB4hvFBb9qk1Vjb6Vj+CErtwoGotwLcFjcdREMPZGxlbb1IaSK4G/gL44XOFWcx3hA4
 Bv28/GP0X6hlXL3nyrBGGJBUsmrMDlZ7/lF3GU3Bhr8plemupC9Q2Kb+tsvwBBL7LPgDU1
 G8I4tzect1ClN71iMq2WwNRVqjfkqESQtCMazccvKpQjkBnYvvTPYdhQ6TVsDWRRCHYVta
 eJykTUBTw79FLsYTQj7ZnCQwC2bcc3T5qINYrJReo/zAvkhVeeQSD/O4IQgpYrVGrATaEW
 PAC4gMR8g7QoOHhnpZKbC3PPu+YbLymGgL3JZ6inbpznT3sU6vWf0Vs1ALESPQ==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/13] imx: kontron-sl-mx8mm: Add support for EEPROM on OSM-S
 module
Date: Tue,  7 Oct 2025 10:16:02 +0200
Message-ID: <20251007081640.61772-6-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Enable config options to access the EEPROM on the OSM-S i.MX8MM
SoM module.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx8mm_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 71dde10ee4f..f11e58a8433 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -60,6 +60,11 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x58000
 CONFIG_SPL_WATCHDOG=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_SYS_EEPROM_SIZE=8192
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=6
 # CONFIG_CMD_LZMADEC is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
@@ -100,6 +105,9 @@ CONFIG_CLK_IMX8MM=y
 CONFIG_DFU_SF=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SPL_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
-- 
2.51.0

