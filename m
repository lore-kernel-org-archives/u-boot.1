Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A885EC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 18:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2BCB810F4;
	Tue, 18 Mar 2025 19:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Pv94feNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E18C38129F; Tue, 18 Mar 2025 19:46:42 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2512E81026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 19:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52IIkcUc2708087
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Mar 2025 13:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742323598;
 bh=61rQFVRlD84LIVJRugGCwjB9MVLINC9g+FjDyDtD8Fw=;
 h=From:To:CC:Subject:Date;
 b=Pv94feNknABD/2vPxFSkaXsSJ03iEqvoZMb5UlBRnzNS7IVUvjHlHecmzdlkN6hgM
 sIKk9+elZtYtl62VH3AIviHrxf4B2nmbLvTUCUb7TTttZUIWe0icSUpnqxXjSrt9U5
 mBbF17FW+SYbjr8FfKzNQd9W6/NPFGtdXUio6E+k=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52IIkcZm025506
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Mar 2025 13:46:38 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Mar 2025 13:46:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Mar 2025 13:46:37 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52IIkXBU010776;
 Tue, 18 Mar 2025 13:46:34 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>
CC: <n-francis@ti.com>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <m-chawdhry@ti.com>, <j-keerthy@ti.com>, <m-shah@ti.com>,
 <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2] configs: am68_sk_r5: Enable AVS config
Date: Wed, 19 Mar 2025 00:16:28 +0530
Message-ID: <20250318184628.3309548-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
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

Enable AVS config

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Change log
changes in v2
Removed extra test code, which was added below tearline
link to v1: https://lore.kernel.org/all/20250314123824.2886341-1-u-kumar1@ti.com/

 configs/am68_sk_r5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/am68_sk_r5_defconfig b/configs/am68_sk_r5_defconfig
index 097bed62061..d6ef89c7b84 100644
--- a/configs/am68_sk_r5_defconfig
+++ b/configs/am68_sk_r5_defconfig
@@ -6,7 +6,6 @@ CONFIG_SOC_K3_J721S2=y
 CONFIG_TARGET_J721S2_R5_EVM=y
 
 CONFIG_ESM_K3=n
-CONFIG_K3_AVS0=n
 CONFIG_ESM_PMIC=n
 CONFIG_DM_REGULATOR_TPS65941=n
 CONFIG_PMIC_TPS65941=n
-- 
2.34.1

