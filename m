Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269C8CF2590
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 05:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACF8E88D9E;
	Mon, 14 Oct 2024 07:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vF+Zwj1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A74F88E58; Mon, 14 Oct 2024 07:39:54 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21D7788F16
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 07:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E5dg1E032351;
 Mon, 14 Oct 2024 00:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728884382;
 bh=yvaPLr+wbMDqG8zEZSSHLIFlQcEqTGJesrEf39qsp6I=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vF+Zwj1Fs+yNdH3zyPEL7mjHlv6k+XJIZEwRBCVtsOCh3DNupVY2+xR9fJgpCjWH1
 HGQsGltcxQpNklWFNser5BdaPKtJKIo3A5Vr+RPZS3wFW817wNQdq4CT3HduVYJCu+
 y3KUMymwtqIEcFsM7HyEj8/THSx6jeSizC23zpW8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49E5dgpB015532
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Oct 2024 00:39:42 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 00:39:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 00:39:42 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E5dPne122316;
 Mon, 14 Oct 2024 00:39:37 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <mkorpershoek@baylibre.com>, <nm@ti.com>,
 <n-francis@ti.com>, <a-limaye@ti.com>, <seanga2@gmail.com>,
 <sjg@chromium.org>, <marex@denx.de>, <john@phrozen.org>,
 <ansuelsmth@gmail.com>, <sumit.garg@linaro.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <Oliver.Gaskell@analog.com>, <robert.marko@sartura.hr>,
 <semen.protsenko@linaro.org>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH v3 2/2] configs: j7200_evm_a72_defconfig: Enable configs for
 PCI support
Date: Mon, 14 Oct 2024 11:09:24 +0530
Message-ID: <20241014053924.4027491-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241014053924.4027491-1-s-vadapalli@ti.com>
References: <20241014053924.4027491-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

TI's J7200 SoC has a single instance of PCIe Controller namely PCIe1 which
is a Cadence PCIe Controller. To support PCIe functionality with the PCIe1
instance of PCIe, enable the corresponding configs.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v2:
https://patchwork.ozlabs.org/project/uboot/patch/20241011130258.3452687-3-s-vadapalli@ti.com/
No changes since v2.

v1:
https://patchwork.ozlabs.org/project/uboot/patch/20240821145908.3408573-3-s-vadapalli@ti.com/
Changes since v1:
- Updated j7200_evm_a72_defconfig to enable NVMe configs since NVMe is
  now supported with this series.

Regards,
Siddharth.

 configs/j7200_evm_a72_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 2fbfda5cf8..12745a9adc 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -32,6 +32,7 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_PSCI_RESET is not set
+CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
@@ -71,6 +72,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
@@ -153,6 +155,9 @@ CONFIG_MUX_MMIO=y
 CONFIG_PHY_TI_DP83869=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_NVME_PCI=y
+CONFIG_PCI_CONFIG_HOST_BRIDGE=y
+CONFIG_PCIE_CDNS_TI=y
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_PHY_CADENCE_TORRENT=y
-- 
2.40.1

