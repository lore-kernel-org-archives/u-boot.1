Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F83C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D4C9812BB;
	Mon, 27 Jan 2025 15:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nEzNPxXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDADF80F96; Mon, 27 Jan 2025 15:22:27 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D140F812BF
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50REMO901802115
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Jan 2025 08:22:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737987744;
 bh=C1qwXz4NaOdQPzqqemPeeqpWj7EVM9uzLvFvYZVEtJQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nEzNPxXLKCcv/wadRUGoJdmqEPiffck/klp8LQvfsq/CCKBLEWqX+h0i8DAY5xzwe
 Xz07iT1YXBHkYlCxlkvbzF7FXv3rkuuwPpixtlk/SflHU18dQM2Dkci9bA/ci5ikIM
 oB5xTdmMO0rH+CNyvfc+t8yvXksVZyPFiBZjFdbQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50REMO4K043046;
 Mon, 27 Jan 2025 08:22:24 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 08:22:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 08:22:23 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50REMHf7071075;
 Mon, 27 Jan 2025 08:22:21 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>, <w.egorov@phytec.de>, <s-k6@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 1/8] k3-ddr.c: Remove unwanted header files
Date: Mon, 27 Jan 2025 19:52:10 +0530
Message-ID: <20250127142217.1757300-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127142217.1757300-1-n-francis@ti.com>
References: <20250127142217.1757300-1-n-francis@ti.com>
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

This header file is not in use in these arch/board specific files,
remove them.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/mach-k3/k3-ddr.c | 1 -
 board/ti/common/k3-ddr.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-k3/k3-ddr.c b/arch/arm/mach-k3/k3-ddr.c
index 6e3e60cdc86..026381490da 100644
--- a/arch/arm/mach-k3/k3-ddr.c
+++ b/arch/arm/mach-k3/k3-ddr.c
@@ -5,7 +5,6 @@
 
 #include <fdt_support.h>
 #include <dm/uclass.h>
-#include <k3-ddrss.h>
 #include <spl.h>
 
 #include <asm/arch/k3-ddr.h>
diff --git a/board/ti/common/k3-ddr.c b/board/ti/common/k3-ddr.c
index a8425da8de5..926f6ea0e7d 100644
--- a/board/ti/common/k3-ddr.c
+++ b/board/ti/common/k3-ddr.c
@@ -5,7 +5,6 @@
 
 #include <fdt_support.h>
 #include <dm/uclass.h>
-#include <k3-ddrss.h>
 #include <spl.h>
 
 #include "k3-ddr.h"
-- 
2.34.1

