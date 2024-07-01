Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3A1C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 05:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A01F8866B;
	Mon,  1 Jul 2024 07:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ulidpDLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2185D88669; Mon,  1 Jul 2024 07:19:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 091198865F
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 07:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4615IxLw120138;
 Mon, 1 Jul 2024 00:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719811139;
 bh=Q5cBqyCUZxXLZIMxmcG4Uy35uvTURlU2gMCE75GxKPs=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=ulidpDLUuUZNdGdzOH52gbx7WD/Qg1QM8ZGWDtSvQ2xL5ceK71ZvBqnbo+EAEDBGS
 Dm8OowX2Iv6GKPiMLiA70JY5PJsUTSC9OQRv9gr4ZHoyhf3ckQc/VywcxA5gr0O3lC
 jROCOLy3Hco1zpenK5jMFT+pR44pbTzUMok/P+Aw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4615IxE0085708
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Jul 2024 00:18:59 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 00:18:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 00:18:59 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4615IpvW059517;
 Mon, 1 Jul 2024 00:18:55 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 1 Jul 2024 10:48:49 +0530
Subject: [PATCH v2 1/4] include: env: ti: mmc: Change name_fdt usage to fdtfile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240701-b4-upstream-streamline-platform-v2-1-7539ff066b58@ti.com>
References: <20240701-b4-upstream-streamline-platform-v2-0-7539ff066b58@ti.com>
In-Reply-To: <20240701-b4-upstream-streamline-platform-v2-0-7539ff066b58@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719811131; l=1146;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=jESB+8d0NLaiGx+wBhysB9lqWBU3x6gWYsDzw7HbM8s=;
 b=2URkuJ9S0H00nEOJwOBwxV7I+dYdIGQ+pIW/d2xAk1ZheRBwkjKvCAbh30kzw+g3DKo0pgMFd
 M6D41vglqinCvqSqw1sOmB/9xX7lmIISa4eH+UxTzvBzUt7R3EVTm0J
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

name_fdt is kept for backward compatibility but it depends on EEPROM
detection logic and some of the platforms like J7AHP/AM69 don't have
that anymore which causes boot failure.

Replacing name_fdt usage to fdtfile as fdtfile is populated based on
CONFIG_DEFAULT_DEVICE_TREE.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 include/env/ti/mmc.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
index 0256a2d2aaca..037a09010ce4 100644
--- a/include/env/ti/mmc.env
+++ b/include/env/ti/mmc.env
@@ -16,7 +16,7 @@ importbootenv=echo Importing environment from mmc${mmcdev} ...;
 loadbootenv=fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
 loadimage=load ${devtype} ${bootpart} ${loadaddr} ${bootdir}/${bootfile}
 loadfdt=load ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfile}
-get_fdt_mmc=load mmc ${bootpart} ${fdtaddr} ${bootdir}/dtb/${name_fdt}
+get_fdt_mmc=load mmc ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfile}
 envboot=if mmc dev ${mmcdev}; then
 	if mmc rescan; then
 		echo SD/MMC found on device ${mmcdev};

-- 
2.45.1

