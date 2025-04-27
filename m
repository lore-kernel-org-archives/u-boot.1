Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CDDC369D8
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 07:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C034182075;
	Sun, 27 Apr 2025 09:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eXIwjSYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2338211F; Sun, 27 Apr 2025 09:03:43 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FFF38210D
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 09:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53R73cRq3265234
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 27 Apr 2025 02:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745737418;
 bh=z7lP2Qk/UY9lwDhymq/HVLGvirZj5LMqk7877plW1Xw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=eXIwjSYDeYujh/UFrf0rVpSs5bKV+ezgDNWvbP66YkzT/eS6+E8s711F6ctZOo/ED
 2u6c9b8z1hkRpEZoIaDaNINHUnWNUrrs26EPT8rz761/wwKS7AuwU8iSYLFCLsGRa/
 DkSFKapfioadQpL3Ixzk2M5fBjM3EpEh99C7WIt8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53R73ch3038423
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 27 Apr 2025 02:03:38 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 27
 Apr 2025 02:03:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 27 Apr 2025 02:03:37 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53R73OuD011250;
 Sun, 27 Apr 2025 02:03:35 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <eballetbo@redhat.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <b-padhi@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>
Subject: [v3 PATCH 4/4] configs: j784s4_evm_r5: Enable ESM related configs
Date: Sun, 27 Apr 2025 12:33:23 +0530
Message-ID: <20250427070323.590449-5-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250427070323.590449-1-u-kumar1@ti.com>
References: <20250427070323.590449-1-u-kumar1@ti.com>
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

From: Andrew Halaney <ahalaney@redhat.com>

Like other TI platforms, let's enable the ESM. This allows the ESM to be
programmed during boot, and the PMIC associated with the ESM output,
enabling blocks like the RTI watchdogs to actually cause the system to
reset.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com> (Rebased with master)
---
 configs/j784s4_evm_r5_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index 5a5b0458b9b..8e5b777526b 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -125,6 +125,11 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_ESM_K3=y
+CONFIG_ESM_PMIC=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65941=y
+CONFIG_DM_REGULATOR_TPS65941=y
 CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR_TPS6287X=y
-- 
2.34.1

