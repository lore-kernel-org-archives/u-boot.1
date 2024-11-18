Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB69D4920C
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57CEA88EAE;
	Mon, 18 Nov 2024 11:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tSOEBGgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7AE787F19; Mon, 18 Nov 2024 11:57:23 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB6CD88CEA
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AIAvK9J3261094
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2024 04:57:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731927440;
 bh=6iIECzK8FlvIf4DUB3qiZXCrk36Tg5jewIzttxlxMwM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=tSOEBGgZg2BBLJHs5W5EAFtIFqifSmB8X7YnWo2+UBValCpZYDXaHokje0vJP2YG2
 4Ce7OncUJu6cHy7ErcbQftRPOKO8dfTSks6DjPhx6f9YndhZkbcXvSHmq+F1I/QvMO
 A9V1zuIUJahqPfL62Mup0RTU5BTw6xjMfJPzH7gA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AIAvKwj012897
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 04:57:20 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 04:57:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 04:57:19 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AIAvETS051199;
 Mon, 18 Nov 2024 04:57:17 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <b-padhi@ti.com>
CC: <sabiya.d@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 1/5] arm: dts: k3-j784s4-r5: Add VTM node to R5 stage
Date: Mon, 18 Nov 2024 16:27:10 +0530
Message-ID: <20241118105714.1973573-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118105714.1973573-1-n-francis@ti.com>
References: <20241118105714.1973573-1-n-francis@ti.com>
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

Add VTM node to R5 boot stage so that AVS gets correctly configured for
J784S4 EVM and AM69 SK.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-j784s4-r5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/k3-j784s4-r5.dtsi b/arch/arm/dts/k3-j784s4-r5.dtsi
index 0cd0ccc2dea..8bd863e8fcb 100644
--- a/arch/arm/dts/k3-j784s4-r5.dtsi
+++ b/arch/arm/dts/k3-j784s4-r5.dtsi
@@ -104,3 +104,9 @@
 &mcu_udmap {
 	ti,sci = <&dm_tifs>;
 };
+
+&wkup_vtm0 {
+	bootph-pre-ram;
+	vdd-supply-2 = <&tps62873a>;
+};
+
-- 
2.34.1

