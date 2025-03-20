Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B8DC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 06:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7B9481C84;
	Thu, 20 Mar 2025 07:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PVmuh5IN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48BA08083E; Thu, 20 Mar 2025 07:30:26 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D45180F0E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52K6UCcj535597
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 01:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742452212;
 bh=kurPed+Qw7a//Jddi3OoUXCyitXrN5KJKcsx1z/Ul54=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PVmuh5INRWDmAwNGILf3LcJGDhaLbMWk5g4NudpG98EGl07DN6AcIwIP7QF+80a7c
 MjaB+A1/RQS29IOtlADinXurneps05T8epMoVvItxT45HYkNRT/deFkaHSPzTZR5jL
 4wCP37YXmtxoMOBWIwF7eQsCjQMvXcdlZ9JtJI8o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52K6UChv013882
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Mar 2025 01:30:12 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Mar 2025 01:30:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Mar 2025 01:30:11 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52K6U5Xu055186;
 Thu, 20 Mar 2025 01:30:09 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <n-francis@ti.com>, <s-vadapalli@ti.com>, <vaishnav.a@ti.com>,
 <a-limaye@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
Subject: [PATCH 1/3] mux: Kconfig: Add Kconfig options for MUX_MMIO
Date: Thu, 20 Mar 2025 12:00:02 +0530
Message-ID: <20250320063004.1069653-2-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320063004.1069653-1-a-dutta@ti.com>
References: <20250320063004.1069653-1-a-dutta@ti.com>
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

Add Kconfig options for MUX_MMIO so that it can be enabled
in SPL stage.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 drivers/mux/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index f15ee4f833f..2b95eb02177 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -10,6 +10,16 @@ config MULTIPLEXER
 
 if MULTIPLEXER
 
+config SPL_MUX_MMIO
+	bool "MMIO register bitfield-controlled Multiplexer"
+        depends on MULTIPLEXER && SYSCON
+        help
+          MMIO register bitfield-controlled Multiplexer controller.
+
+          The driver builds multiplexer controllers for bitfields in a syscon
+          register. For N bit wide bitfields, there will be 2^N possible
+          multiplexer states.
+
 config MUX_MMIO
 	bool "MMIO register bitfield-controlled Multiplexer"
 	depends on MULTIPLEXER && SYSCON
-- 
2.34.1

