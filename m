Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204F9C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 12:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CEAF80586;
	Wed, 22 Jan 2025 13:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tgqCXqUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4277A80805; Wed, 22 Jan 2025 13:13:49 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E215803B5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 13:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50MCDiw11008573
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 06:13:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737548024;
 bh=kbfwmfVGkPxLOLCxwWnQQRDZMV5h0IkZP+uEfEJhMAM=;
 h=From:To:CC:Subject:Date;
 b=tgqCXqUoKp1f8DbfSXVcuEEcfh9Z7SUZHAXis0YfLobqoTA+3B9zsLAcno0oogiPD
 +tAEE1dfBqcma+7n06NedpA6RrtILFtPg2qZH4fvyT+mdgxX0OJlFXLl6kvyZncLke
 AwvePsnlsr7f1R2UZLV1lypeShldYWx0buxJ7xCk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50MCDijc006493
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Jan 2025 06:13:44 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Jan 2025 06:13:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Jan 2025 06:13:43 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.104])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50MCDdG7109898; 
 Wed, 22 Jan 2025 06:13:40 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <jm@ti.com>,
 <nm@ti.com>, <n-francis@ti.com>, <sjg@chromium.org>, <hnagalla@ti.com>,
 <afd@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] configs: am62ax_evm_a53_defconfig: enable USB DFU support
Date: Wed, 22 Jan 2025 17:43:36 +0530
Message-ID: <20250122121338.1055249-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
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

The config fragment "am62x_a53_usbdfu.config" which adds USB DFU support
for AM62x SoC is applicable to the AM62Ax SoC as well. Hence, include it
in "am62ax_evm_a53_defconfig" in order to enable support for USB DFU flash
and boot.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
82d262ae162 Merge patch series "MediaTek MT7629 OF_UPSTREAM migration (v2)"
of the master branch of Mainline U-Boot.

Patch has been tested for SD Boot on AM62A7-SK to ensure that the
change to am62ax_evm_a53_defconfig in this patch doesn't introduce a
regression. Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/c8879ebb33417458cc39e262c98ff959

Regards,
Siddharth.

 configs/am62ax_evm_a53_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index bf6e9639901..a2f6d904df4 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -107,3 +107,5 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+
+#include <configs/am62x_a53_usbdfu.config>
-- 
2.43.0

