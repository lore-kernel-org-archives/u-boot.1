Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7417CE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5564080295;
	Wed, 18 Dec 2024 14:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n+mc/Mlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D2880295; Wed, 18 Dec 2024 14:14:04 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B20D8022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIDDvvO163280
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 18 Dec 2024 07:13:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734527637;
 bh=BdZcDde9WkwKF2TXyOg/c4QXye8exFYxCWzB3YVNpBA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=n+mc/Mlftdjxfk8BqIXQqFrVc4EoQHdbzeuaXsoKqTlC4wCNBg6oKGs43z7Gjjhy0
 0n1lONQq4mZku6+G7lOqTZjj3pz29f7phV5R7yPiUqXHDaTXVZUN0zqSxKhf6LWT4t
 gxei99CkuczrNuxNzja3A3ZnIrVqD5ebE+jctB+s=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIDDvnv059475;
 Wed, 18 Dec 2024 07:13:57 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 07:13:57 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 07:13:57 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIDDjRa035276;
 Wed, 18 Dec 2024 07:13:55 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 2/4] arm: dts: k3-j722s-r5-evm: Fix DM2TIFS secproxy thread
 ID
Date: Wed, 18 Dec 2024 18:43:39 +0530
Message-ID: <20241218131341.2073823-3-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218131341.2073823-1-p-mantena@ti.com>
References: <20241218131341.2073823-1-p-mantena@ti.com>
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

Fix the DM2TIFS secureproxy thread ID as per the latest TISCI
documentation for J722S.
https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j722s/sec_proxy.html

Fixes: fc2da3a3d0d3 ("arm: dts: Introduce J722S U-Boot dts files")
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/dts/k3-j722s-r5-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
index 5e5c2e3111e..1bec997c93c 100644
--- a/arch/arm/dts/k3-j722s-r5-evm.dts
+++ b/arch/arm/dts/k3-j722s-r5-evm.dts
@@ -41,8 +41,8 @@
 		ti,host-id = <36>;
 		ti,secure-host;
 		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
+		mboxes= <&secure_proxy_main 28>,
+			<&secure_proxy_main 29>;
 		bootph-all;
 	};
 };
-- 
2.34.1

