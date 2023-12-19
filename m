Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E37C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A70F877D4;
	Tue, 19 Dec 2023 12:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X/h9Ys2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A3B86F1E; Tue, 19 Dec 2023 11:13:33 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF46B871AA
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJADN7Z051486;
 Tue, 19 Dec 2023 04:13:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702980803;
 bh=pOo7rifUtDqO0AwhQ0nKUnSC6cNG9pMJyJiayrXPZwc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=X/h9Ys2+54Nhr3btBebTaqNe4U1fp0kDpYtftTtusclIz0PwseXxO/PJztkiQasA2
 H2Qi57Z/IXu974LeeXMbtNVcoCCfBTVD618OUCVPT1NobAx6m5SN+B1KCz1Pzn4Jk2
 y0Sg8UeBlKiLOONSCeCyBZnlnKzivcBZL1x7woGE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJADNZQ113618
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 04:13:23 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 04:13:23 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 04:13:23 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJADNrW089673;
 Tue, 19 Dec 2023 04:13:23 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BJADM22018970;
 Tue, 19 Dec 2023 04:13:22 -0600
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
Subject: [RFC PATCH 14/16] configs: am65x_evm_a53_defconfig: add
 SPL_LOAD_FIT_APPLY_OVERLAY
Date: Tue, 19 Dec 2023 15:42:20 +0530
Message-ID: <20231219101225.3443978-28-danishanwar@ti.com>
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

