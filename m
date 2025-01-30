Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8504C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 22:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 593D981DCD;
	Thu, 30 Jan 2025 23:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rvUrr8Vk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A31807F1; Thu, 30 Jan 2025 23:33:01 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 464E280EBD
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 23:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50UMWvpe1600191
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 30 Jan 2025 16:32:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738276377;
 bh=H+3rugMpK5bIf054t7jOBK+pJDTM3ZJwShEqllFBy7g=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rvUrr8Vkv7e86j7lRY81llujWZecHvqqDPetJoTCzDtTSwuPgsJeRkh9bOyRX5bdW
 Vt8ivpM8Yf6jbVXMVVzavQo3DJX1L4swcuJ/siVzsi92OLE/Us7RWSvM4fPAggP0wD
 rmGBxmpJclvUg6Op8G+ed+NpY+3TB4x2rthMh69Y=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50UMWvHm112632;
 Thu, 30 Jan 2025 16:32:57 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Jan 2025 16:32:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Jan 2025 16:32:57 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50UMWuHl029547;
 Thu, 30 Jan 2025 16:32:57 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, Daniel Schultz
 <d.schultz@phytec.de>, Judith Mendez <jm@ti.com>
Subject: [PATCH v3 3/4] env: ti: am64x: set rproc_fw_binaries
Date: Thu, 30 Jan 2025 16:32:55 -0600
Message-ID: <20250130223256.1944522-4-jm@ti.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250130223256.1944522-1-jm@ti.com>
References: <20250130223256.1944522-1-jm@ti.com>
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

From: Hari Nagalla <hnagalla@ti.com>

Set remote proc FW binaries for u-boot loading of remote cores.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
Changes since v2:
- No change
---
 board/ti/am64x/am64x.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
index 8ad805a613c..43e557b8ec7 100644
--- a/board/ti/am64x/am64x.env
+++ b/board/ti/am64x/am64x.env
@@ -2,6 +2,10 @@
 #include <env/ti/mmc.env>
 #include <env/ti/k3_dfu.env>
 
+#if CONFIG_CMD_REMOTEPROC
+#include <env/ti/k3_rproc.env>
+#endif
+
 name_kern=Image
 console=ttyS2,115200n8
 args_all=setenv optargs earlycon=ns16550a,mmio32,0x02800000 ${mtdparts}
@@ -14,6 +18,8 @@ bootpart=1:2
 bootdir=/boot
 rd_spec=-
 
+rproc_fw_binaries= 0 /lib/firmware/am64-mcu-m4f0_0-fw 1 /lib/firmware/am64-main-r5f0_0-fw 2 /lib/firmware/am64-main-r5f0_1-fw 3 /lib/firmware/am64-main-r5f1_0-fw 4 /lib/firmware/am64-main-r5f1_1-fw
+
 args_usb=run finduuid;setenv bootargs console=${console}
 	${optargs}
 	root=PARTUUID=${uuid} rw
-- 
2.48.0

