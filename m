Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFC8C5CFCF
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 09:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D823607CD;
	Tue, 11 Aug 2026 09:43:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ugckb99rH2RV; Tue, 11 Aug 2026 09:42:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DBD8607BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786441378;
	bh=yOYoOqCqKQwR99iwRjdTYlS7pEuAKrLPOc46GD8O5xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=puDzf/pmRBgxe38B39bTmfQkYwSHSsGfUihPSnm35sYMCLAvXYikY/3GqySV0ETL3
	 mlHVxJ0G4dhpTcClOng+BDYA56D5aQDPVi6v9wMoYOBCLZn4WK8fT8+iQt7+ClBkSR
	 ZlA0owTtxMgcOP6q2HA4pftDrdvYGK8fT+gc28JScAs0g7mkH1TjRWAi7igPPOLmb+
	 hmoFOTDvdlZNaj/ZGv07jYfvt88voSUXFMeBhei9G0YFN2IB33ie7+P+oVAut5jWh0
	 ReiVHl18XvuS29c2cr2iDujgS16hKVcJb56nkhUpkHzzZocpuedjQfS5/Mqx0IhZs7
	 Pp0Gf6HZamtNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DBD8607BB;
	Tue, 11 Aug 2026 09:42:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BA3128A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E00440758
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:42:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZuxvgRpPNJY0 for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 09:42:55 +0000 (UTC)
X-Greylist: delayed 482 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 11 Aug 2026 09:42:54 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4256440759
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4256440759
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4256440759
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:42:54 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com
Subject: [PATCH 3/3] board: imx6dl-sielaff: Enable environment on SD card
Date: Tue, 11 Aug 2026 11:34:20 +0200
Message-ID: <20260811093423.212986-3-frieder@fris.de>
In-Reply-To: <20260811093423.212986-1-frieder@fris.de>
References: <20260811093423.212986-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fris.de; s=mail; t=1786440890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOYoOqCqKQwR99iwRjdTYlS7pEuAKrLPOc46GD8O5xI=;
 b=DEc0tkYHXwQ+YB9cL15HzZlvdNPDdmh3cS5nzfUMySHXPW6mMz+2somoKO8tyjXzcoXzYF
 quN8w1/HATG7lpbck6tfxTB68W+A9CxHwwpgEOSDXn/S6HMaefzYiL+oN8kl+LwHk/D+CD
 8r32rOK/n30W/M9nENIYmACRbFiM5nNEMeQeTBTExDl1NU/kwWl+KobYKEPoAWcvr4c04U
 k1UOOz7EfnePY/x7N3WbNA7ApvIQrYXMorM1cU77KFVmVT1w3xao27pzcINaBSamV7p9hn
 +loJpN5sTyPWECUSdJp7fxpDkK4HcDCQovLjGnvRJM/KILsTtFu5Zd4LnP4Wyw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=fris.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=DEc0tkYH
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Enable storing the environment on SD card and choose the env location
according to the boot device.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c | 30 +++++++++++++++++++
 configs/imx6dl_sielaff_defconfig              |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c b/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c
index 4da084ed91c..f2c206cfeb0 100644
--- a/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c
+++ b/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c
@@ -9,6 +9,7 @@
 #include <asm/arch/crm_regs.h>
 #include <asm/arch/mx6-pins.h>
 #include <asm/io.h>
+#include <env_internal.h>
 #include <init.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -109,3 +110,32 @@ int board_init(void)
 
 	return 0;
 }
+
+/*
+ * Keep the environment on the device we were booted from. The boot fuses
+ * use the SD card as primary boot device and the SPI NOR as the ECSPI
+ * recovery device, so both are valid places for the environment to live.
+ */
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+       u32 bmode;
+
+       if (prio > 0)
+               return ENVL_UNKNOWN;
+
+       if (imx6_is_ecspi_recovery_boot())
+               return ENVL_SPI_FLASH;
+
+       bmode = (imx6_src_get_boot_mode() & IMX6_BMODE_MASK) >>
+               IMX6_BMODE_SHIFT;
+
+       switch (bmode) {
+       case IMX6_BMODE_SD:
+       case IMX6_BMODE_ESD:
+       case IMX6_BMODE_MMC:
+       case IMX6_BMODE_EMMC:
+               return ENVL_MMC;
+       default:
+               return ENVL_SPI_FLASH;
+       }
+}
diff --git a/configs/imx6dl_sielaff_defconfig b/configs/imx6dl_sielaff_defconfig
index bfa4c4aa1d8..615c2935844 100644
--- a/configs/imx6dl_sielaff_defconfig
+++ b/configs/imx6dl_sielaff_defconfig
@@ -61,8 +61,10 @@ CONFIG_EFI_PARTITION=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
-- 
2.55.0

