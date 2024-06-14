Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CA9C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 15:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB7DC88199;
	Fri, 14 Jun 2024 17:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N0Lgz0nx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962C988A04; Fri, 14 Jun 2024 17:51:28 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 495C888131
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 17:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EFpLZ1130030;
 Fri, 14 Jun 2024 10:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718380281;
 bh=qz6k2MSet/2pWXuKZpp7ZEl7SiQFx2cVvOvnOglrGxI=;
 h=From:To:CC:Subject:Date;
 b=N0Lgz0nxg7iPO0KISnVOY/94nhKCNNB7nEwwDFEf3z0tZ/vFwgcRjFX4TEIQp1Md5
 dqqqNokFCuPgsyjAibzoItl4j5qZa9q0Dp9TtMUQ+864hF4GShBaH4hsQ0g1coJqP+
 AQP9zburJRl52hNum3PIKnIKbIcHxyO2gb+B0m4g=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EFpLRA052068
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 10:51:21 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 10:51:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 10:51:21 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EFpLUd090941;
 Fri, 14 Jun 2024 10:51:21 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Tom Rini <trini@konsulko.com>, Udit Kumar
 <u-kumar1@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2] configs: j784s4: Enable RTC emulation
Date: Fri, 14 Jun 2024 10:51:18 -0500
Message-ID: <20240614155118.2606211-1-j-humphreys@ti.com>
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

Changes from v1:
 - Rebased on latest -next
 Link to v1: https://lore.kernel.org/r/20240531223057.2619261-1-j-humphreys@ti.com

 configs/j784s4_evm_a72_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index bb2a21f888b..2aa16eb7270 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -143,6 +143,8 @@ CONFIG_SPL_RAM=y
 CONFIG_REMOTEPROC_TI_K3_DSP=y
 CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
@@ -155,3 +157,4 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_DM_THERMAL=y
+CONFIG_EFI_SET_TIME=y
-- 
2.34.1

