Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB62C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A24CB883A8;
	Tue, 18 Jun 2024 20:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B8AdXnLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E6888365; Tue, 18 Jun 2024 20:46:52 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239CC88335
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hnagalla@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IIkl4Q063003;
 Tue, 18 Jun 2024 13:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718736407;
 bh=ftTznrqkTK4rPyV85+Zwsk4EJpoVH2/2YBxAIl0/qVs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=B8AdXnLEW0wlvGFqf4684B5ycRhPHfnVfRuSivDDVaW8TPy9iN+k26tEFInRcFl9s
 yhyk5l09UEPWsXHFHPlPT53rofCz2X9UVnmyFPxSCie/+HxTIHyV1dguTORNFVOaUo
 Hm8UfZMBAWLxXjKarKbBPppRsaPrwu2tLRSQmhXM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IIklfl002802
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Jun 2024 13:46:47 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 13:46:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 13:46:47 -0500
Received: from localhost ([10.249.48.175])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IIklEK046723;
 Tue, 18 Jun 2024 13:46:47 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <devarsht@ti.com>, <afd@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [PATCH 2/3] configs: am62x_evm_a53_defconfig: Enable M4 remote proc
 driver
Date: Tue, 18 Jun 2024 13:46:35 -0500
Message-ID: <20240618184636.30642-3-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240618184636.30642-1-hnagalla@ti.com>
References: <20240618184636.30642-1-hnagalla@ti.com>
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

Enable configs needed to add M4 remote proc driver to AM62.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 configs/am62x_evm_a53_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 6c708dcb05..ea826d95ec 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -96,6 +96,7 @@ CONFIG_POWER_DOMAIN=y
 CONFIG_TI_SCI_POWER_DOMAIN=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_REMOTEPROC_TI_K3_M4F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
@@ -111,3 +112,4 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_EFI_SET_TIME=y
+CONFIG_CMD_REMOTEPROC=y
-- 
2.34.1

