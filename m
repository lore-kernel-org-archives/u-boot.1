Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDF5C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 20:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E1687FAD;
	Tue, 12 Mar 2024 21:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q4+Rjf6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 791B787F78; Tue, 12 Mar 2024 21:20:48 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0887C87DFF
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 21:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKTn5000710;
 Tue, 12 Mar 2024 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710274829;
 bh=yaYH5nDSBK4eIrRwqbg6NCjpdUWeTAvI3EvRBoexS5c=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=Q4+Rjf6VNMiWgLY+ShY+dHTTsJOpt6ya0cvnV2GAo2InGH4Tk8n1qZWUGG5f9c2Jf
 EhVTdecxx3kdl+woepOzU8Z0l4wwzUMV/ivh5z27+Y+hbVg1hxkzTRDfQ9ON8rHZkx
 OZ1QAlUd0Qyeo7AXSdkOyIy8o1dC02gOree7Rpgo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CKKT2J086644
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 15:20:29 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 15:20:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 15:20:29 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKTiG091692;
 Tue, 12 Mar 2024 15:20:29 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 12 Mar 2024 15:20:31 -0500
Subject: [PATCH v4 13/13] arm: mach-k3: fixup whitespace in SPDX License
 IDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v4-13-fa772bfa623b@ti.com>
References: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2959; i=bb@ti.com;
 h=from:subject:message-id; bh=OWXzHuYFa10MP22R+ggKX3y1SQ24SNbJvdw+fUaV6yg=;
 b=owNCWmg5MUFZJlNZk+pEUAAAan///v/ZK//2+v7p/xzN/2vKn7Z//vy9v/93f50q397e3tWwA
 RsZRyaGhpiADQ0AAA0NDQ00DR6gAAAGIGJiAyaaANA0AAAPUGjQZGT1GnpqfqmOQDQABoANDQZG
 jRoBoaaaPUAAaBkaABoDTaQ0NADamQeoYQNNNDQaZGmjI2UHRpo00aMmjTTTTQBk0aMmRpo0A0A
 DAQyDEGgGmRkMgDTQZBoNBoDQwhoNBo0ABAoOCLaVcFVBEwOBWQpaHJyEBzR3DbYQWJDAHR9l0g
 HAECqThp3Wkaa+9HT4JstAM7Vi3I/6NATrmKVKplSLsXIERLXVNTrdPdgkCcmCPB5wn+aj8/yNX
 yxdDvx2gPZtrMEkobJWOOPLJOHcXmRlab47WizYI3svLGIU20mwfRgzPrVj6tabQBQyxQMyyNhx
 UtaY3AhyIDAd+RikLUS9XB++IhC3lCnpDXdDruo1FdE8xM2hIAfxmIczq53UsPOw3F8GKKrExOd
 l+XfZ0azKipm/qW/HXmkjqDKTWaIOQWgHglS4f738JNH/GJMnrv4gwntQ7Q7tZomCFohidRXpeS
 4Jn9h1EeGSGaC/S8ICTjL8ow10SjTWLjOLX8jArZwFGNjiZSN/dKRbJCmy1I0YngJCCn0bdKQPj
 F55AIXE1gJh4WBeg/8FqLuSKcKEhJ9SIoA=
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

The SPDX ID format usese a single space used after the
'SPDX-License-Identifier:'. Fix all files that use any other white-space
character other than a single space.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/r5/am62ax/Makefile | 2 +-
 arch/arm/mach-k3/r5/am62px/Makefile | 2 +-
 arch/arm/mach-k3/r5/am62x/Makefile  | 2 +-
 arch/arm/mach-k3/r5/j7200/Makefile  | 2 +-
 arch/arm/mach-k3/r5/j721e/Makefile  | 2 +-
 arch/arm/mach-k3/r5/j721s2/Makefile | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-k3/r5/am62ax/Makefile b/arch/arm/mach-k3/r5/am62ax/Makefile
index e4e55ce5c7dd2..313ce5a05fdc0 100644
--- a/arch/arm/mach-k3/r5/am62ax/Makefile
+++ b/arch/arm/mach-k3/r5/am62ax/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier:	GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
 
diff --git a/arch/arm/mach-k3/r5/am62px/Makefile b/arch/arm/mach-k3/r5/am62px/Makefile
index 50b0df20a3d1a..091d4fa5b4512 100644
--- a/arch/arm/mach-k3/r5/am62px/Makefile
+++ b/arch/arm/mach-k3/r5/am62px/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier:	GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
 
diff --git a/arch/arm/mach-k3/r5/am62x/Makefile b/arch/arm/mach-k3/r5/am62x/Makefile
index d6c876df66dde..9ab0100ee174a 100644
--- a/arch/arm/mach-k3/r5/am62x/Makefile
+++ b/arch/arm/mach-k3/r5/am62x/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier:	GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
 
diff --git a/arch/arm/mach-k3/r5/j7200/Makefile b/arch/arm/mach-k3/r5/j7200/Makefile
index 0f91cf4daea41..78325db402c56 100644
--- a/arch/arm/mach-k3/r5/j7200/Makefile
+++ b/arch/arm/mach-k3/r5/j7200/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier:	GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
 obj-y += clk-data.o
diff --git a/arch/arm/mach-k3/r5/j721e/Makefile b/arch/arm/mach-k3/r5/j721e/Makefile
index 0f91cf4daea41..78325db402c56 100644
--- a/arch/arm/mach-k3/r5/j721e/Makefile
+++ b/arch/arm/mach-k3/r5/j721e/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier:	GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
 obj-y += clk-data.o
diff --git a/arch/arm/mach-k3/r5/j721s2/Makefile b/arch/arm/mach-k3/r5/j721s2/Makefile
index e794bffb3afa9..8588c5e4c39c6 100644
--- a/arch/arm/mach-k3/r5/j721s2/Makefile
+++ b/arch/arm/mach-k3/r5/j721s2/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier:	GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0+
 #
 # Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
 obj-y += clk-data.o

-- 
2.43.2

