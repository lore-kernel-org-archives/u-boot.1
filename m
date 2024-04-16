Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F59C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 09:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4B7C88337;
	Tue, 16 Apr 2024 11:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TX64Wr9V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4CF88832F; Tue, 16 Apr 2024 11:20:51 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937E588347
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 11:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43G9KW1i079240;
 Tue, 16 Apr 2024 04:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713259232;
 bh=2Ttwg9RgJsufGpxxNpt+p2nPduR/o+peMFNlOIpualY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TX64Wr9Vt9WN4MU81jPRhfxmZX1e6q8NjH7VTuQIt/SYZSY6g7QIzgG+9X9ALPKrz
 MqRhq5JtgJlFyEnlsY+VK1I++KkobjXjun2aNG2nifZs+jwV+tez+bGrkDcKpPcyTq
 M3Qe427uaDLWoXzJ7wH4soDOkAfxyUeSnkt2GvHo=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43G9KWDd025045
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Apr 2024 04:20:32 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 04:20:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 04:20:31 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43G9KVlB100705;
 Tue, 16 Apr 2024 04:20:31 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43G9KVx7011003;
 Tue, 16 Apr 2024 04:20:31 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Bryan Brattlof <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Nishanth Menon <nm@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Tim Harvey <tharvey@gateworks.com>, Tony Dinh
 <mibodhi@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sumit Garg <sumit.garg@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kever
 Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>, Roger
 Quadros <rogerq@kernel.org>
Subject: [PATCH v4 5/6] board: ti: am65x: Add check for k3-am654-icssg2 in
 board_fit_config_match()
Date: Tue, 16 Apr 2024 14:50:17 +0530
Message-ID: <20240416092018.3593039-6-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416092018.3593039-1-danishanwar@ti.com>
References: <20240416092018.3593039-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

When CONFIG_TI_ICSSG_PRUETH is enabled, add config name check for the
icssg2 overlay in board_fit_config_match() API.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 board/ti/am65x/evm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index 3109c9a2ac..07073a5940 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -91,10 +91,13 @@ int dram_init_banksize(void)
 #ifdef CONFIG_SPL_LOAD_FIT
 int board_fit_config_name_match(const char *name)
 {
-#ifdef CONFIG_TARGET_AM654_A53_EVM
-	if (!strcmp(name, "k3-am654-base-board"))
+	if (IS_ENABLED(CONFIG_TI_ICSSG_PRUETH) &&
+	    strcmp(name, "k3-am654-icssg2") == 0)
+		return 0;
+
+	if (IS_ENABLED(CONFIG_TARGET_AM654_A53_EVM) &&
+	    strcmp(name, "k3-am654-base-board") == 0)
 		return 0;
-#endif
 
 	return -1;
 }
-- 
2.34.1

