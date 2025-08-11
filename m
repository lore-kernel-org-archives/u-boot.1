Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9F5C87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159AD832FE;
	Mon, 11 Aug 2025 15:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="hcy3Uo4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 566CD83335; Mon, 11 Aug 2025 15:12:36 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE4B83020
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 44A2DC970D; Mon, 11 Aug 2025 15:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1754917953; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=jYh0sWfgLhd0bw8yGxfy/uyNBTWf2QPXUsh3JE6kZMY=;
 b=hcy3Uo4A5mP7UdKK8nfAcGLUUBmCDcPRruNgWAUMqRm2KXidQHc6mvzxa91t6jvvmpIEhi
 32sMEghPUYI2P7ZF4xv9Oye2BwXaWb+aqwTdwX05Wf/I5eMjUN130qbb/L8r5T2lEMi64Q
 OWjvJKmu50/2ZV4EnjBtzFfTObTpRvS6KQpifD9SouRqZmp7CeJU2KaU9iCt6V/VAlXseY
 LVd6elHUDq5b34sOQR7teEXPZb+hw2ihTLWH3PiwRtCLPGj5j+TPWAT8YsEJ9vENAHNlcS
 aN3H0dfWkyRTJeC5OeNdy8DNDUYv6kWlBmAvRkw7vzhSXVSvbtM8sa0v6zIoqA==
From: Frieder Schrempf <frieder@fris.de>
To: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, Joy Zou <joy.zou@nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH 0/6] Use correct LDO5 control registers for PCA9450
Date: Mon, 11 Aug 2025 15:11:56 +0200
Message-ID: <20250811131213.211124-1-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
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

This is a port for the following series in Linux, which is already
available in mainline:

https://patchwork.kernel.org/project/linux-arm-kernel/cover/20241218152842.97483-1-frieder@fris.de/

This aligns the PMIC driver with current Linux and allows to use
upstream devicetrees in U-Boot.

Frieder Schrempf (6):
  Revert "pmic: pca9450: Add optional SD_VSEL GPIO for LDO5"
  pmic: pca9450: Fix enable register for LDO5
  pmic: pca9450: Fix control register for LDO5
  pmic: pca9450: Handle hardware with fixed SD_VSEL for LDO5
  arm: dts: imx8mp-data-modul-edm-sbc: Remove deprecated sd-vsel-gpios
  arm: dts: imx8mp-dhcom-som: Remove deprecated sd-vsel-gpios

 arch/arm/dts/imx8mp-data-modul-edm-sbc.dts |  1 -
 arch/arm/dts/imx8mp-dhcom-som.dtsi         |  1 -
 drivers/power/pmic/pca9450.c               | 22 -------------
 drivers/power/regulator/pca9450.c          | 37 ++++++++++++++++++++--
 4 files changed, 34 insertions(+), 27 deletions(-)

-- 
2.50.1

