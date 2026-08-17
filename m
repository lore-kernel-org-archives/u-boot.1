Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50182C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15C4A607B8;
	Mon, 17 Aug 2026 15:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id roVWSWsieScl; Mon, 17 Aug 2026 15:36:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 835DB605F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980971;
	bh=b0oDSj4fxasmoWpcNRMSRKb2yJXR6y9RpD+UDn0GDHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RnNrJnFXX1KJGeiCyzME8wzR2Txr6fjwDxrMABdrYBppQuQvsu1QhMkN7m7SXcwNn
	 5yEaY2RzulAikkulV+vKAdyZlDin2vZ6nRy8pkmenHP4ibKil0CRhs1cQu1OJb2mpf
	 WbOc62boZtxQ0ZkoRefjeZ2Ue0SQ0QxW7FFtPQcNftOr3v/KhaEq7Q4zly7WYK8pu8
	 O3RW6CcjNTxrEw7zkKltOCnRZYHr9jckP8W2XUH0r9aljHUGEIRHgia/9jGa/6ndjD
	 5TJC/6017XbnVkYqt1BvwOsi3c14PdGHHggivagGZSM2p6UWXSK8T79LxEoP5nIfYp
	 iLhA9IkETFuUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 835DB605F5;
	Mon, 17 Aug 2026 15:36:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B94A4282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AAC3740817
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2cSBu8UwghJm for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:36:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AC6D1407C2
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC6D1407C2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=VCh3BdRR
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC6D1407C2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 0F52AB00571;
 Mon, 17 Aug 2026 17:36:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980968;
 bh=fnro0FrUkJbBZrtFVmJWmRTJTvJGlbVuxMShe+uIzRo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VCh3BdRRyfRKvsXUvdgkRFtkNyPxQvmYs7Sa3jLq8x8+NoME1T9YLFXMEbFczDfhZ
 wy//lIf3TbBJ5pbljYeySeXAT3Rhf9ZnEU3c6ik1tKwz57iKEbcECj7FUwpF6FVM84
 QERr8zBin0MYvu+YxVcZfKvW2Ua31pybd4qaDH+v4yu3XGqlWRyiIxbdpsf1sUDin0
 VWoJJilUwo2M5rU20Ieav8CXJwa0oz+LLA5Slg8itD2ja4LgdZRmy8Dmd24Dwcc20E
 PP5f1z3gxjTTA34NZe59ycEMKR9Em30/GMQBTtzv2AHQe97O00pPIoDEDUl5P8H+LU
 vh7tU5zZYr0mw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 14/23] board: nbxv3: enable PCIe root complexes
 (PCIE3..PCIE6)
Date: Mon, 17 Aug 2026 17:31:32 +0200
Message-ID: <20260817153144.1951036-15-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable the four PCIe root complex controllers of the board.

Set the hotplug since the PCIe devices can be attached after Linux
start.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts | 5 +++++
 configs/nbxv3_tfa_defconfig        | 6 ++++++
 include/configs/nbxv3.h            | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index a7e9628d948..08d3aee62a7 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -116,3 +116,8 @@
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
 };
+
+&pcie3 { status = "okay"; };
+&pcie4 { status = "okay"; };
+&pcie5 { status = "okay"; };
+&pcie6 { status = "okay"; };
diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index 626f4181812..e87373a52c3 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_MONITOR_LEN=958464
 CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
 CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
 CONFIG_ENV_ADDR=0x20500000
+CONFIG_PCI=y
 CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_FSL_NUM_CC_PLLS=4
 CONFIG_REMAKE_ELF=y
@@ -28,10 +29,12 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_PBSIZE=532
 # CONFIG_ID_EEPROM is not set
+CONFIG_PCI_INIT_R=y
 CONFIG_RESET_PHY_R=y
 CONFIG_CMDLINE_PS_SUPPORT=y
 CONFIG_CMD_HISTORY=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_CONTROL=y
@@ -51,6 +54,9 @@ CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_REALTEK=y
 CONFIG_SYS_MEMAC_LITTLE_ENDIAN=y
+CONFIG_PCIE_LAYERSCAPE_RC=y
+CONFIG_PCI_IOMMU_EXTRA_MAPPINGS=y
+CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_DM_SERIAL=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_NXP_FSPI=y
diff --git a/include/configs/nbxv3.h b/include/configs/nbxv3.h
index 6ed86639a3c..287f4110a7c 100644
--- a/include/configs/nbxv3.h
+++ b/include/configs/nbxv3.h
@@ -10,4 +10,10 @@
 
 #include "lx2160a_common.h"
 
+#define CFG_EXTRA_ENV_SETTINGS						\
+	"pci_iommu_extra=pci@0x3600000,1.0.0,hp,"			\
+		"pci@0x3700000,1.0.0,hp,"				\
+		"pci@0x3800000,1.0.0,hp,"				\
+		"pci@0x3900000,1.0.0,hp\0"
+
 #endif /* __NBXV3_H */
-- 
2.43.0

