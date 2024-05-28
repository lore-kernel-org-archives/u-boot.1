Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF15DC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 13:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07ECB884D2;
	Tue, 28 May 2024 15:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Eahqc30G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726A4884FC; Tue, 28 May 2024 15:13:27 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC738850F
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 15:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SDDMCC089673;
 Tue, 28 May 2024 08:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716902002;
 bh=Yv71GTxL3iPf9BtMrSDCKDUsLm6Ct552FcKqrR//3fw=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=Eahqc30GbQXISiU+zNaNeSH8Bymsw5YY/RknS2ntP08yBNZqg/9La4GPxqzDiaHRH
 GilVPNbwEizk5lv4PS50SGihzvzrFSyA1FCq+7eN66sMV530UvHvnCkslEzTU61t0/
 QopWiAD5SV29/qH4BGwn54/UbK6j3Q7h7cWyecoY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SDDLUi052322
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 08:13:21 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 08:13:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 08:13:21 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SDD25g099882;
 Tue, 28 May 2024 08:13:18 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 28 May 2024 18:42:58 +0530
Subject: [PATCH v2 4/4] configs: j721s2_evm_*_defconfig: Enable OSPI
 configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240528-b4-upstream-j721s2-ospi-support-v2-4-b2e372ebcdd7@ti.com>
References: <20240528-b4-upstream-j721s2-ospi-support-v2-0-b2e372ebcdd7@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-ospi-support-v2-0-b2e372ebcdd7@ti.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, "Tom
 Rini" <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Apurva Nandan <a-nandan@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716901982; l=1728;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=0/UHQYY1xWXN1CZ1qbIdU6AOWxiibriO1I3saTLW8ik=;
 b=2ddwONwoefWGFxj4K0kNPQ3meFnqXfYxZzTeCOwiWSMpB5C8Dw0d5uWvuIvzKsq8wFif73dXU
 HGL53cVSvrnBgnQ4/aUu0egdrqLbsyx8d3klcIgq48aCN0Wl9ZocpTu
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Enable OSPI related configs to boot using OSPI

Reviewed-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 configs/j721s2_evm_a72_defconfig | 3 +++
 configs/j721s2_evm_r5_defconfig  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 5ed8d00662e3..326beedea411 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -51,6 +51,7 @@ CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_MTD=y
+CONFIG_SPL_MTD_SUPPORT=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_DM_RESET=y
@@ -59,6 +60,8 @@ CONFIG_SPL_RAM_SUPPORT=y
 CONFIG_SPL_RAM_DEVICE=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SF_DEFAULT_MODE=0
+CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_THERMAL=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 3c958cafbe8f..4039841488f9 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -57,6 +57,7 @@ CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_MTD=y
+CONFIG_SPL_MTD_SUPPORT=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_DM_RESET=y
@@ -66,6 +67,8 @@ CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_REMOTEPROC=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SF_DEFAULT_MODE=0
+CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
 CONFIG_SPL_THERMAL=y

-- 
2.43.2

