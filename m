Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A21C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A88877A1;
	Tue, 19 Dec 2023 12:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mDu6pSHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4146486F1E; Tue, 19 Dec 2023 11:13:29 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E915871B1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJADKkJ001456;
 Tue, 19 Dec 2023 04:13:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702980800;
 bh=pOo7rifUtDqO0AwhQ0nKUnSC6cNG9pMJyJiayrXPZwc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=mDu6pSHeyfyYin78Blf4Xk02ZUJ+ZzGYcrogZlJl9hUKNeVL3pgjRjOLG2fRSAUly
 Kx7HRyn+0yyxzLNaqdAlWfpPrvEmIwuGhawL2MOcq+McCg/UiQuGZBnprk6J4Awarp
 kWYdKJwfbF79ifPx7YLf6mJFsGbPVvk6mXkh5YD8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJADJjg031744
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 04:13:19 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 04:13:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 04:13:19 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJADJjB116160;
 Tue, 19 Dec 2023 04:13:19 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BJADI07018960;
 Tue, 19 Dec 2023 04:13:19 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 13/16] configs: am65x_evm_a53_defconfig: add
 SPL_LOAD_FIT_APPLY_OVERLAY
Date: Tue, 19 Dec 2023 15:42:18 +0530
Message-ID: <20231219101225.3443978-26-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219101225.3443978-1-danishanwar@ti.com>
References: <20231219101225.3443978-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 19 Dec 2023 12:33:18 +0100
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

We want SPL to apply DTB overlays (e.g. NAND card overlay) so
enable SPL_LOAD_FIT_APPLY_OVERLAY.
Increase SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ and
SPL_STACK_R_MALLOC_SIMPLE_LEN. Without this SPL hangs.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 configs/am65x_evm_a53_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index e79a961317..2755d7082f 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -70,6 +70,9 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_REMOTEPROC=y
+CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
+CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ=0x100000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x1000000
 CONFIG_CMD_USB=y
 CONFIG_CMD_TIME=y
 CONFIG_MTDIDS_DEFAULT="nor0=47040000.spi.0"
-- 
2.34.1

