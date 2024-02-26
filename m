Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7AEC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 21:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4749987F8C;
	Mon, 26 Feb 2024 22:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G7eOiILw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA31087F73; Mon, 26 Feb 2024 22:19:43 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9476C87F5C
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 22:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJUPC058999;
 Mon, 26 Feb 2024 15:19:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708982370;
 bh=MFFVGQDsqRmbsYmQTgokJ4+nDL3XinhWApin4eo6Ihs=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=G7eOiILwjcgg8XUyXnD4trXTMtvPwH5bGhC5jiazJLRNCKHnP0IQj1FOhRryQ9UFO
 JwNBGo/bq96wtNR2p5l+PC4r9xhqtrPvIihpStV5FsVZUSk9K4/SdTfyN6W3olw3rw
 kk9+kyg4yVmZPUR8yFymwUw4SvXjSyBrVnWqLPag=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41QLJUKJ017090
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Feb 2024 15:19:30 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 15:19:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 15:19:29 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJTrN058307;
 Mon, 26 Feb 2024 15:19:29 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 26 Feb 2024 15:19:10 -0600
Subject: [PATCH v3 04/13] ram: k3-ddrss: enable the am62ax's DDR controller
 for am62px
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v3-4-04cbb42eaa6f@ti.com>
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Hari Nagalla
 <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=774; i=bb@ti.com;
 h=from:subject:message-id; bh=IVvoOtQphzM/9G4GxAQiqLzLQkOt1M62llI1mlMU3/s=;
 b=owNCWmg5MUFZJlNZ8DNk3wAAX3////f5j7//766+Gnl8d/HuNrH7/v/+u27b+376+tHF5eewA
 RswjtQBpkaBpoAaNADIAND1NDQNDIAND1Bo0GgaAAaGgABoaNDTExPUybU2oab1EQGQNGgDI0yG
 Q00GmjTTRiMmjQaDQyDQ0aAGQyHpNPSaNBpoYgeoyaNGgBpiZADQORgTJoZBkNBkNAaPSaNMJoM
 QBkABoyYJkDQYRgjQNABoAaAGmRoAZNAKFqhfgCr7kQong40YOIgd5MOfEIHQH87GDxoK+dg1ut
 2k8dhRTBKW5PIGBk0gHTS65oSK6KxzOU8Y55yeo6uN7+70X4FzMWjjy0L56FDsIkq+EO0F4xZbk
 gAivYVhhV9yjJH2wO1vswSolGy0wtZV5uiBqAfEDPZMJzj1fjiMoN2qgbYDrwCzRwgmsQsmuVyX
 BQB1ig2Q8yXYGNqjAB9LViSy+VJ3tekx5rrMv1UiAb9YabEZN2iYqxYWLCwTnUIDwqwmG08PJWl
 ViDmij4FtK1pJs2lCM4GXX+2HLH1wx4iIKOvMioji5QpZ7rcGUOA5PCRDN3zYDPHc5bB7qrO3Qt
 4n76Grh+amv5DGBEyBccLitj45hiKVAVISCPaRmAlXWCFA5eVjhoZFkccaocJAE2XCnLFIrfcOQ
 mYr1wYjZlQ3+LuSKcKEh4GbJvg=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

The am62px family of SoCs uses the same DDR controller as found on the
am62ax family. Enable this option when building for the am62px family

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/ram/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index 5b07e92030142..56391058567bb 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -65,7 +65,7 @@ choice
 	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2
 	default K3_AM64_DDRSS if SOC_K3_AM642
 	default K3_AM64_DDRSS if SOC_K3_AM625
-	default K3_AM62A_DDRSS if SOC_K3_AM62A7
+	default K3_AM62A_DDRSS if SOC_K3_AM62A7 || SOC_K3_AM62P5
 
 config K3_J721E_DDRSS
 	bool "Enable J721E DDRSS support"

-- 
2.43.2

