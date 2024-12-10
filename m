Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F16EE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 13:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F0C894BE;
	Tue, 10 Dec 2024 14:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qybWbwpX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A018948F; Tue, 10 Dec 2024 14:58:05 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28A78949E
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 14:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BADw0DA2632373
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 07:58:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733839080;
 bh=l+wNP1zQ5UlpZf0IacOpxjHrCI+QyQuRdC/k412wrss=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qybWbwpXqY2WU0lzZODhRu9eVE8IDTiTio0Lb1SF6lbU8an4waYTTqtLGCcOwzmpl
 PQZezF2KdWGPbNHP+8Vg8qWLKwEN203lklXpuRcG7b45ybKimuFXr/PQPl5xSMo27S
 qgcVMmq1Y4dy8vx5jG0fpzWpOn7IhCw2javMSyyQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BADw0NP050214
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Dec 2024 07:58:00 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 07:58:00 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 07:58:00 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BADvkpG062352;
 Tue, 10 Dec 2024 07:57:57 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH 3/4] arm: mach-k3: j722_spl: Add FAST XSPI boot mode
Date: Tue, 10 Dec 2024 19:27:30 +0530
Message-ID: <20241210135731.1043269-4-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210135731.1043269-1-p-mantena@ti.com>
References: <20241210135731.1043269-1-p-mantena@ti.com>
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

From: Vaishnav Achath <vaishnav.a@ti.com>

Fast XSPI boot mode is supported by J722S ROM, add that.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/include/mach/j722s_spl.h | 1 +
 arch/arm/mach-k3/j722s/j722s_init.c       | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/j722s_spl.h b/arch/arm/mach-k3/include/mach/j722s_spl.h
index eab8c511b7c..a91cc82448f 100644
--- a/arch/arm/mach-k3/include/mach/j722s_spl.h
+++ b/arch/arm/mach-k3/include/mach/j722s_spl.h
@@ -24,6 +24,7 @@
 #define BOOT_DEVICE_DFU			0x0A
 #define BOOT_DEVICE_GPMC_NAND		0x0B
 #define BOOT_DEVICE_GPMC_NOR		0x0C
+#define BOOT_DEVICE_FAST_XSPI		0x0D
 #define BOOT_DEVICE_XSPI		0x0E
 #define BOOT_DEVICE_NOBOOT		0x0F
 
diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index 01b00681f68..c4d99142e48 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -219,6 +219,8 @@ static u32 __get_primary_bootmedia(u32 devstat)
 		fallthrough;
 	case BOOT_DEVICE_XSPI:
 		fallthrough;
+	case BOOT_DEVICE_FAST_XSPI:
+		fallthrough;
 	case BOOT_DEVICE_SPI:
 		return BOOT_DEVICE_SPI;
 
-- 
2.34.1

