Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2275AC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 22:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1FE688815;
	Sat,  1 Jun 2024 00:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WPU+yxzU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B4388818; Sat,  1 Jun 2024 00:32:21 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6487B8872E
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 00:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VMWFjt117438;
 Fri, 31 May 2024 17:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717194735;
 bh=pOCMhejtc24/RrLVvrMJzbm5x56KDFVtxVeOXcQTA3s=;
 h=From:To:CC:Subject:Date;
 b=WPU+yxzUWUed757B6J8TBsavCvHTGAfv+KLMCatsMKXNdndrx8aQYnQKeVAsxrquO
 PaRowuIMEnF719VxvVMswfCtb5omCXCZTP0uGnrHT36SiWXxhZ3d7Igj440NGJ5G+Q
 4TnL8esTZvQtYWx6+shZxEuDJ5eb7cbrnRaEOsz4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VMWFOu011964
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 17:32:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 17:32:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 17:32:14 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VMWExA041906;
 Fri, 31 May 2024 17:32:14 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Tom Rini <trini@konsulko.com>, Udit Kumar
 <u-kumar1@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH] configs: j784s4: Enable RTC emulation
Date: Fri, 31 May 2024 17:32:12 -0500
Message-ID: <20240531223212.2619317-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Enable RTC emulation for System Ready IR tests.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 configs/j784s4_evm_a72_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 665aa39a6bf..8ef50f690fb 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -138,6 +138,8 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_RESET_TI_SCI=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
@@ -150,3 +152,4 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_DM_THERMAL=y
+CONFIG_EFI_SET_TIME=y
-- 
2.34.1

