Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57BDC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 05:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C61B88725;
	Tue,  2 Jul 2024 07:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ryj4PHdK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7035488738; Tue,  2 Jul 2024 07:20:36 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6306688722
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 07:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4625KWnK063543;
 Tue, 2 Jul 2024 00:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719897632;
 bh=K4wrbbF6e/FVtUkxw58EFZFhcwgeefQXakYw9CAUSaM=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=ryj4PHdKSXOin/qgYkujK0OBxxnxfLj5CrrQtKZknO5b9whE34p29O8YlElBNyPvP
 2Xcv9CCChTQeD/EwW1lmUlyrR8x2tppuNNdPqqt0f8VihEaF4YAZBm/yfuYwV9bGyw
 BzyWVuznmdS9JcXiebntPibpXwn2AvQYYa/Qln+w=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4625KWZM012893
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Jul 2024 00:20:32 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 00:20:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 00:20:31 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4625KKsL070700;
 Tue, 2 Jul 2024 00:20:28 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 2 Jul 2024 10:50:02 +0530
Subject: [PATCH v3 2/4] configs: am62p|j722s_a53: Add
 CONFIG_BOARD_LATE_INIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240702-b4-upstream-streamline-platform-v3-2-0ebd7bbd31d5@ti.com>
References: <20240702-b4-upstream-streamline-platform-v3-0-0ebd7bbd31d5@ti.com>
In-Reply-To: <20240702-b4-upstream-streamline-platform-v3-0-0ebd7bbd31d5@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719897620; l=1219;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=duOMt0P9GNoU01qQ8h8fp6FNC6ypUgSPG04bOTNnd8s=;
 b=d5hDX+sDcO7Q2Yz5V1PJFWJ4CwENP2ROuKmoL6Lq22XmS57Sl7Qfy9ScmfKVRJndVvAj6eUKA
 oLX14MRbcmLAWWocWXaItszXRcKHd/KcmcCt7Nsfrqf4MKz0EsLy5ty
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

This is called to set fdtfile based on evm.c code calling ti_set_fdt_env.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 configs/am62px_evm_a53_defconfig | 1 +
 configs/j722s_evm_a53_defconfig  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index e1c9c8535e43..87005d03dee3 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -33,6 +33,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_PAD_TO=0x0
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index da0e9f4d524d..1675cedb25ef 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -33,6 +33,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_PAD_TO=0x0
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y

-- 
2.45.1

