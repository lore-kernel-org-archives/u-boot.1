Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA070C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 15:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3660A876E7;
	Mon, 12 Feb 2024 16:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y/vjpSWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7073A875E9; Mon, 12 Feb 2024 16:53:40 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D025874B1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 16:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CFrYvl056955;
 Mon, 12 Feb 2024 09:53:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707753214;
 bh=yPcHjAHna+qD8VqbR5TOa0i4cDrLpksWMuIsnHSs1r0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=y/vjpSWvXmYz4cpAs7t8I1aK4DFAiSFLoIj0xXvrhQFXVbcpfSt7Y8K36t2dNMKfk
 f+ofhKxsSBogLf6RBubYLnRSNuqSfmGyB0C1QI91b7hV6GP7IrGFc7ru/YaDP1sUIa
 Kxwg7bUc+O7SQrzzcYdxvqZyipP8hNmcio5UF0Z4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CFrYF6118500
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Feb 2024 09:53:34 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 09:53:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 09:53:33 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CFrX1t028864;
 Mon, 12 Feb 2024 09:53:33 -0600
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/4] configs: am62x_beagleplay_r5_defconfig: Enable
 SPL_BOARD_INIT
Date: Mon, 12 Feb 2024 09:53:30 -0600
Message-ID: <20240212155332.541949-3-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212155332.541949-1-nm@ti.com>
References: <20240212155332.541949-1-nm@ti.com>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
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

Enable CONFIG_SPL_BOARD_INIT to configure the 32k crystal.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 configs/am62x_beagleplay_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
index 2f3264b7ede6..9413c859870f 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -36,6 +36,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-- 
2.43.0

