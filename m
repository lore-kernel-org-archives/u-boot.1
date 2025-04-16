Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABC0C369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 12:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72B2782F00;
	Wed, 16 Apr 2025 14:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ra/TFpJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6234182E9A; Wed, 16 Apr 2025 14:08:50 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E22C82E9A
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 14:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53GC8gqk307357
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 07:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744805322;
 bh=nCzpz3HoYWN8sPzXOwRqRP6FTYCD2K12KfZ6+Sl7IoA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ra/TFpJvAnOiA7RyvtjGc6Fawa0aDGad9IOcWWWOSe4rYoG0f2cxRH7cDW+HrYWy4
 QebBcsLtKB78a6vaKI3NFp0gr0zkY3ioqgToKF7Uyyyn66Qt8fojjLZVlajcxFriL0
 N3CpKnbT9cYKgVpc46YiZ1p11WtT0Cs/+B/LY77w=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53GC8gqX057263
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 07:08:42 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 07:08:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 07:08:42 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53GC8Uiw127831;
 Wed, 16 Apr 2025 07:08:38 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <j-humphreys@ti.com>, <jm@ti.com>,
 <sjg@chromium.org>, <s-k6@ti.com>, <n-francis@ti.com>,
 <rogerq@kernel.org>, <danishanwar@ti.com>, <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <srk@ti.com>
Subject: [PATCH 2/3] pci: pcie_cdns_ti: Enable PCIe root-complex mode in AM64
 SoC
Date: Wed, 16 Apr 2025 17:38:29 +0530
Message-ID: <20250416120830.138965-3-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416120830.138965-1-h-salunke@ti.com>
References: <20250416120830.138965-1-h-salunke@ti.com>
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

TI's AM64 SoC has single instance of PCIe Controller namely PCIe0 which
is Cadence PCIe Controller. Add support to configure PCIe0 in Root-
Complex mode of operation.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/pci/pcie_cdns_ti.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pcie_cdns_ti.c b/drivers/pci/pcie_cdns_ti.c
index e5bcc6eb53e..9d1d123a18c 100644
--- a/drivers/pci/pcie_cdns_ti.c
+++ b/drivers/pci/pcie_cdns_ti.c
@@ -835,11 +835,21 @@ static const struct pcie_cdns_ti_data j7200_pcie_rc_data = {
 	.max_lanes = 2,
 };
 
+static const struct pcie_cdns_ti_data am64_pcie_rc_data = {
+	.mode = PCIE_MODE_RC,
+	.quirk_detect_quiet_flag = true,
+	.max_lanes = 1,
+};
+
 static const struct udevice_id pcie_cdns_ti_ids[] = {
 	{
 		.compatible = "ti,j7200-pcie-host",
 		.data = (ulong)&j7200_pcie_rc_data,
 	},
+	{
+		.compatible = "ti,am64-pcie-host",
+		.data = (ulong)&am64_pcie_rc_data,
+	},
 	{},
 };
 
-- 
2.34.1

