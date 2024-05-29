Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C31C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 13:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3118C88606;
	Wed, 29 May 2024 15:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NcuCHhS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 696338861D; Wed, 29 May 2024 15:25:07 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31963880F5
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 15:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44TDOxAg102647;
 Wed, 29 May 2024 08:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716989099;
 bh=bgfHt8r4gECitaKn7Qmewv+7pkdFR5IWFQFLHNV4lgM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=NcuCHhS07Rh7TgwJAoydU5XVmzRU0IIfBUSLqACjlcESCLRtsT0nIYFVkZOPt8L38
 SEf7xS16qRogy4IeSgDvYEfcdF/obj6FAJWSmsDVyszGQfDbrgBryb+NYZdup3C6KP
 vuk5xBcVJajMB2ckC++jDR9uc/D9xraitk2W2FDs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44TDOxnx019884
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 08:24:59 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 08:24:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 08:24:58 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.102])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44TDOv4D045052;
 Wed, 29 May 2024 08:24:58 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <sumit.garg@linaro.org>,
 <afd@ti.com>, <j-choudhary@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
Subject: [PATCH 06/14] arm: mach-k3: r5: Makefile: Fix the order for entries
Date: Wed, 29 May 2024 18:54:40 +0530
Message-ID: <20240529132448.459330-7-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529132448.459330-1-j-choudhary@ti.com>
References: <20240529132448.459330-1-j-choudhary@ti.com>
MIME-Version: 1.0
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

Add the entries in alphabetical order.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm/mach-k3/r5/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/r5/Makefile b/arch/arm/mach-k3/r5/Makefile
index 1cfc8e3ade..f1e61c8548 100644
--- a/arch/arm/mach-k3/r5/Makefile
+++ b/arch/arm/mach-k3/r5/Makefile
@@ -3,13 +3,13 @@
 # Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
 #	Andrew Davis <afd@ti.com>
 
+obj-$(CONFIG_SOC_K3_AM625) += am62x/
+obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
+obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
 obj-$(CONFIG_SOC_K3_J721E) += j721e/
 obj-$(CONFIG_SOC_K3_J721E) += j7200/
 obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
-obj-$(CONFIG_SOC_K3_AM625) += am62x/
-obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
-obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
 
 obj-y += common.o
 obj-y += lowlevel_init.o
-- 
2.25.1

