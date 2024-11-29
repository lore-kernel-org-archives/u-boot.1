Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B5DD6EC05
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 12:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7C389421;
	Fri, 29 Nov 2024 13:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OzO9/5xn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF80893C9; Fri, 29 Nov 2024 12:32:17 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFCE98921B
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 12:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBW37l083537;
 Fri, 29 Nov 2024 05:32:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732879923;
 bh=QUIyUsc7tNhlUNyVhnRhCansErNoTUv66pdzBGJvEVY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OzO9/5xnJyKmDb1g8bLigKVIftUEp5sivkzCRILfB2nhsP0hVGZGVQ0rGR1IBFk7S
 zaWKfFiY+5T1zapFZAMjLhaZ2SPTvmE2MfdZtWHLYLfdr2q5PiEGdSMDJ93wl0nLf2
 bHEXzxUlT+94Fm/w8za7UOh/peoK+z3z1SvqTRCA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ATBW3Q2029695
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Nov 2024 05:32:03 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Nov 2024 05:32:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Nov 2024 05:32:02 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBVabR106135;
 Fri, 29 Nov 2024 05:31:57 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <a-dutta@ti.com>, <sjg@chromium.org>,
 <marex@denx.de>, <jonas@kwiboo.se>, <kever.yang@rock-chips.com>,
 <william.zhang@broadcom.com>, <a-limaye@ti.com>, <u-kumar1@ti.com>,
 <vaishnav.a@ti.com>, <sumit.garg@linaro.org>,
 <quentin.schulz@cherry.de>, <p-mantena@ti.com>,
 <ilias.apalodimas@linaro.org>, <afd@ti.com>, <nm@ti.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 4/8] arm: dts: k3-j721e-r5-common: Add HBMC overrides for R5
 SPL
Date: Fri, 29 Nov 2024 17:01:32 +0530
Message-ID: <20241129113136.383277-5-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129113136.383277-1-a-dutta@ti.com>
References: <20241129113136.383277-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 29 Nov 2024 13:45:54 +0100
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

Add 32-bit address overrides for Hyper Bus Memory Controller
for Hyperflash to be functional in R5 SPL.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 arch/arm/dts/k3-j721e-r5-common-proc-board.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
index ce55ea6bae..c775432505 100644
--- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
@@ -51,6 +51,13 @@
 	bootph-pre-ram;
 };
 
+&hbmc {
+	reg = <0x0 0x47040000 0x0 0x100>,
+		<0x0 0x50000000 0x0 0x8000000>;
+	ranges = <0x0 0x0 0x0 0x50000000 0x4000000>,
+		 <0x1 0x0 0x0 0x54000000 0x800000>;
+};
+
 &ospi0 {
 	/* Address change for data region (32-bit) */
 	reg = <0x0 0x47040000 0x0 0x100>,
-- 
2.34.1

