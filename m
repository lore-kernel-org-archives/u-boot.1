Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64403C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F68B8807F;
	Thu,  9 May 2024 16:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mIIRjPPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE12880FB; Thu,  9 May 2024 16:20:49 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C0AE88080
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hnagalla@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 449EKjTs130420;
 Thu, 9 May 2024 09:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715264445;
 bh=BVk28n1CpaMivVHxd+AkdtO9kcfd5v0ORJoYLgWMYAg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=mIIRjPPMzA1vDE3RSNyG9DoOfpbDbc0RwYgRHplLHnNrPRkzNbt9fhb8F7JVsNmoC
 CvMNTl414KsVyvPy09Goe2Q2xr7c0DibLEolhcuBXc0h3MzBAEe8FM5beYFzI55AcV
 lB+feO0xMkO0rRFYt/f+sVVKwEptoJeEGuWdWqfI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 449EKjqm030292
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 09:20:45 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 09:20:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 09:20:45 -0500
Received: from localhost ([10.250.32.135])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 449EKjoK075455;
 Thu, 9 May 2024 09:20:45 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <devarsht@ti.com>, <afd@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [PATCH 3/4] configs: am62ax: enable remote proc drivers
Date: Thu, 9 May 2024 09:20:36 -0500
Message-ID: <20240509142037.32064-4-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240509142037.32064-1-hnagalla@ti.com>
References: <20240509142037.32064-1-hnagalla@ti.com>
MIME-Version: 1.0
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

Enable K3-DSP and K3-R5FSS remote proc drivers for am62ax.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 configs/am62ax_evm_a53_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index c4556f5dd2..6b29a4b9cf 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -72,6 +72,8 @@ CONFIG_POWER_DOMAIN=y
 CONFIG_TI_SCI_POWER_DOMAIN=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_REMOTEPROC_TI_K3_R5F=y
+CONFIG_REMOTEPROC_TI_K3_DSP=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
@@ -81,3 +83,4 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_CMD_REMOTEPROC=y
-- 
2.34.1

