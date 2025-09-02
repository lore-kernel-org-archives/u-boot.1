Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20562CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 10:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675DE83AC7;
	Tue,  2 Sep 2025 12:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lFZJkpMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E78BE832AD; Tue,  2 Sep 2025 12:20:13 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D77E483AAF
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 12:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 582AKAwG2564784;
 Tue, 2 Sep 2025 05:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756808410;
 bh=DhLczpvHxMpxEpjCsC11q0fxpw+ToRalRpH7Kihwk/M=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lFZJkpMckupJ8L0896hjLH/kUjqs8nVSGEVZfV06Bih8cZcS8Xw2exjuhrQRx9urq
 5CJIyFkGUC7WQOV3+ozyTLdJBw1EPrp70Sf0EmPkuj7slIxhaaOAMhqx6MGdLs60I9
 AVC2cQ6YvFT8ilbbsz8jLmlbFSy+5oZK51aer4xc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 582AKAGj3414782
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 05:20:10 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 05:20:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 05:20:10 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 582AK1DC3915378;
 Tue, 2 Sep 2025 05:20:08 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>, <u-kumar1@ti.com>
CC: <a-dutta@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 3/3] arm: dts: k3-j721e-r5-common-proc-board: Enable HBMC
 in R5 SPL stage
Date: Tue, 2 Sep 2025 15:50:00 +0530
Message-ID: <20250902102000.1388848-4-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902102000.1388848-1-a-dutta@ti.com>
References: <20250902102000.1388848-1-a-dutta@ti.com>
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

Enable HBMC in the R5 SPL stage

Fixes: c9df79ee64d0 ("arm: dts: k3-j721e-r5-common: Add HBMC overrides for R5 SPL")
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 arch/arm/dts/k3-j721e-r5-common-proc-board.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
index c775432505b..e4f799dfb27 100644
--- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
@@ -52,6 +52,7 @@
 };
 
 &hbmc {
+	status = "okay";
 	reg = <0x0 0x47040000 0x0 0x100>,
 		<0x0 0x50000000 0x0 0x8000000>;
 	ranges = <0x0 0x0 0x0 0x50000000 0x4000000>,
-- 
2.34.1

