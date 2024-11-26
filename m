Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4C7D5A6E4
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 06:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C756889C21;
	Tue, 26 Nov 2024 07:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZkD8+mi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926B789C13; Tue, 26 Nov 2024 07:35:57 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76DCD89C13
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ6ZrB5016426;
 Tue, 26 Nov 2024 00:35:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732602953;
 bh=R/RFIJOKOEBhMUszm+oqkxmhVWwh7kjLpJJJWohpEJM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZkD8+mi7pn1P/bo92oQs1B0pCkzTC/NqY/aGGzyPoTeXf6TlIEBlcIAXTXXw504z3
 0ivAkNL9q5IAPOH/J/w3o9zw9Oo3cZw2JgM9lJLir2QdtSoEAaRelGRBu2jzn8iZhh
 8VTOieplnaoiGt064t6ysyfnkYspoR7tjtn9xKco=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ6ZrKr040309
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Nov 2024 00:35:53 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 00:35:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 00:35:53 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.6])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ6ZikO051095;
 Tue, 26 Nov 2024 00:35:51 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>
CC: <n-francis@ti.com>, <afd@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
 <reidt@ti.com>, <u-kumar1@ti.com>
Subject: [RFC PATCH 2/3] arm: dts: k3-j7200: Add ESM PMIC support for tps659413
Date: Tue, 26 Nov 2024 12:05:42 +0530
Message-ID: <20241126063543.2678052-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126063543.2678052-1-u-kumar1@ti.com>
References: <20241126063543.2678052-1-u-kumar1@ti.com>
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
index f096b102793..53c8d7827b9 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -108,3 +108,10 @@
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

