Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11570D4920C
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA01788E24;
	Mon, 18 Nov 2024 11:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kzAR+OA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1598289464; Mon, 18 Nov 2024 11:57:33 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4348912A
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AIAvTbb3639476
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2024 04:57:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731927449;
 bh=MaD7OiPAw8YuSZa3tE9rp6K+FFUHzQm8Yc1eVcerBUs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=kzAR+OA38DobkG7Z8GIhwGOqLGmWa/pxLS1BtHst1NMb/XBy/kcS5KggmfmHMGQ9S
 tCYTcJG1hErnix4qszxQ7z8PNRa9dda297juJjCRtILu9vGRnVT4VPCe5Xk9r2q2Jr
 zyaV3u/SXVvFmnDJeNqoMMR64HHmHmCVRQ67ml+4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AIAvTIe092937
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 04:57:29 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 04:57:28 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 04:57:29 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AIAvETW051199;
 Mon, 18 Nov 2024 04:57:27 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <b-padhi@ti.com>
CC: <sabiya.d@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 5/5] configs: am68_sk_r5: Add AVS Configs
Date: Mon, 18 Nov 2024 16:27:14 +0530
Message-ID: <20241118105714.1973573-6-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118105714.1973573-1-n-francis@ti.com>
References: <20241118105714.1973573-1-n-francis@ti.com>
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

From: Udit Kumar <u-kumar1@ti.com>

Add AVS and PMIC regulator configs

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 configs/am68_sk_r5_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/am68_sk_r5_defconfig b/configs/am68_sk_r5_defconfig
index f4800ef1b8a..81fa58743da 100644
--- a/configs/am68_sk_r5_defconfig
+++ b/configs/am68_sk_r5_defconfig
@@ -5,10 +5,11 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_J721S2=y
 CONFIG_TARGET_J721S2_R5_EVM=y
 
-CONFIG_K3_AVS0=n
 CONFIG_DM_REGULATOR_TPS65941=n
 CONFIG_PMIC_TPS65941=n
 
+CONFIG_SPL_DM_REGULATOR_TPS6287X=y
+
 CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"
 CONFIG_SPL_OF_LIST="k3-am68-sk-r5-base-board"
 CONFIG_OF_LIST="k3-am68-sk-r5-base-board"
-- 
2.34.1

