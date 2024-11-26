Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB03D3B987
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 12:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55F6D89C75;
	Tue, 26 Nov 2024 13:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EjdQTJI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E6AA89C6C; Tue, 26 Nov 2024 13:03:55 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E2789C73
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 13:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQC3cj1825660
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 26 Nov 2024 06:03:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732622618;
 bh=NJWPY05GhYP9j2blFLatDDEeHpgVPF84kw4XaH3V04Q=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EjdQTJI4GqfzFRZXvdgThwn+OgjDRR9UShESGpPps8svpFOWdhPQr0lX07KI1pxE6
 5SuZ9ppp8IRDwxMs76JZdLt8LA9cUsAD2y3bviYNOESSdMr9DB2/CXxOZXrZTJbf5N
 leaM+JFmQD1VZ3cmdx4RK85ZJkpkt9vyPswwh/sQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQC3cm3000762;
 Tue, 26 Nov 2024 06:03:38 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 06:03:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 06:03:38 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQC3N2u051888;
 Tue, 26 Nov 2024 06:03:33 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <marex@denx.de>,
 <hnagalla@ti.com>, <mkorpershoek@baylibre.com>,
 <caleb.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <jan.kiszka@siemens.com>, <jonas@kwiboo.se>, <j-humphreys@ti.com>,
 <rogerq@kernel.org>, <nm@ti.com>, <devarsht@ti.com>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 2/2] board: ti: am62ax: env: include environment for DFU
Date: Tue, 26 Nov 2024 17:33:19 +0530
Message-ID: <20241126120322.1760862-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241126120322.1760862-1-s-vadapalli@ti.com>
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
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

Include the TI K3 DFU environment to support DFU Boot and DFU Flash.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 board/ti/am62ax/am62ax.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/am62ax/am62ax.env b/board/ti/am62ax/am62ax.env
index 97122fb57ba..96d9e1e2797 100644
--- a/board/ti/am62ax/am62ax.env
+++ b/board/ti/am62ax/am62ax.env
@@ -1,5 +1,6 @@
 #include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
+#include <env/ti/k3_dfu.env>
 #if CONFIG_CMD_REMOTEPROC
 #include <env/ti/k3_rproc.env>
 #endif
-- 
2.43.0

