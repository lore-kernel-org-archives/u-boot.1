Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B56C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 11:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54FA81B52;
	Fri, 14 Mar 2025 12:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xbzQIEVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F4081808A2; Fri, 14 Mar 2025 12:04:23 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD10081A10
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52EB4KxP1662316
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 06:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741950260;
 bh=vgqFH6ZpwNENwM+fKimFSW5kzLgCeUwdoOhy8hWUNO0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xbzQIEVxuDO8+ZMJTvV3arNgCEHy0ZA9BoGE27VoQmgtg15gUrvq7h2gim1Q7rtoQ
 ucCZ8ibXOYF53mELc0I36fufMuGyjuGa2/JPXva+XOpqlq/DxYDDWwRhNMtJsMpw9f
 Egse37Zq5sPRljIjecGyZwqeyKRZnoNLARP6uC7o=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52EB4KPF104747
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Mar 2025 06:04:20 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 06:04:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 06:04:19 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52EB4Bqi069672;
 Fri, 14 Mar 2025 06:04:17 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>
CC: <n-francis@ti.com>, <afd@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
 <u-kumar1@ti.com>
Subject: [PATCH 2/2] configs: j7200_evm_r5: Add ESM related configs for J7200
Date: Fri, 14 Mar 2025 16:34:11 +0530
Message-ID: <20250314110411.2781732-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314110411.2781732-1-u-kumar1@ti.com>
References: <20250314110411.2781732-1-u-kumar1@ti.com>
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

From: Neha Malcom Francis <n-francis@ti.com>

Add CONFIG_ESM_K3 and CONFIG_ESM_PMIC to enable ESM initialization
in J7200.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 configs/j7200_evm_r5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index ae5849baf13..8df921c028b 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -99,7 +99,9 @@ CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_FS_LOADER=y
 CONFIG_SPL_FS_LOADER=y
+CONFIG_ESM_K3=y
 CONFIG_K3_AVS0=y
+CONFIG_ESM_PMIC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
-- 
2.34.1

