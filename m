Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42521C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 11:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385368197D;
	Fri, 14 Mar 2025 12:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F88Jjqp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95DA881B4B; Fri, 14 Mar 2025 12:04:23 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32EA8198F
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52EB4HBY2146502
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 06:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741950257;
 bh=4dMMzyTId5dW8avZjQntEOCPN2HOhZTJBek0kQZKKGA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=F88Jjqp7S8d6T51GOF+jPHevt4AvnLJlIUOZLNMVzWxwGNPCyz9gFNQT/mCyqphjc
 r63Q3FPI7Sv9NTyVe9ZcXQgErnNLRq/WBK54DQxoqT4TLu6gpL9nTJhg7WlnwKjegc
 Vksa1NJ4w6Top5oSaCj7ip/T8xhKe6f00l57vC2g=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52EB4H3G006952
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Mar 2025 06:04:17 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 06:04:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 06:04:17 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52EB4Bqh069672;
 Fri, 14 Mar 2025 06:04:15 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>
CC: <n-francis@ti.com>, <afd@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
 <u-kumar1@ti.com>
Subject: [PATCH 1/2] arm: dts: k3-j7200: Add ESM PMIC support for tps659413
Date: Fri, 14 Mar 2025 16:34:10 +0530
Message-ID: <20250314110411.2781732-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314110411.2781732-1-u-kumar1@ti.com>
References: <20250314110411.2781732-1-u-kumar1@ti.com>
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

From: Gowtham Tammana <g-tammana@ti.com>

On J7200 processor board MCU_SAFETY_ERROR signal is routed to PMIC for
ESM error handling. The PMIC resets the board on receipt of the signal.
Enable the support for the board by adding ESM PMIC node.

Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
---
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index ecb1dd49c64..9ac29110324 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -120,3 +120,10 @@
 	vdd-supply-2 = <&buckb1>;
 	bootph-pre-ram;
 };
+
+&tps659414 {
+	esm: esm {
+		compatible = "ti,tps659413-esm";
+		bootph-pre-ram;
+	};
+};
-- 
2.34.1

