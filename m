Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94521C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C4C980548;
	Mon, 10 Feb 2025 21:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MZ0DIK+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 757DF80A55; Mon, 10 Feb 2025 21:29:51 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E20B9805E7
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51AKTjbo193214
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Feb 2025 14:29:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739219385;
 bh=2v0H7cjxbRkV6CUk+O/wTA4Vi4KEcfajXEZKpjBnw9c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=MZ0DIK+dojryz7cHGdK6SDfjHlT6HEyPkM2+PByfhzO0ofs9jPS0fi3MkAmCaExxN
 2cgJXkg8zNOyT4zwAQshFDCKC4F6WupKVAGnTjFqNGDBnRTLJWLflgvVeRLxWW4O3U
 1px7YoAdXNmQNEwKtqJNUO6hHpg9nuHK1acogIfw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51AKTjIk062579;
 Mon, 10 Feb 2025 14:29:45 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 14:29:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 14:29:44 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51AKTiDF022402;
 Mon, 10 Feb 2025 14:29:44 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, Judith
 Mendez <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 05/10] board: ti: am62px: Add remoteproc specific env
 support
Date: Mon, 10 Feb 2025 14:29:39 -0600
Message-ID: <20250210202944.1071931-6-jm@ti.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250210202944.1071931-1-jm@ti.com>
References: <20250210202944.1071931-1-jm@ti.com>
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

Add remoteproc specific env support for am62px device. If the
remoteproc CMD is defined, include the K3 remoteproc environment.
Also define rproc_fw_binaries which holds a list of remoteproc FW
binaries for u-boot loading of remote cores.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v4:
- No change
---
 board/ti/am62px/am62px.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
index 7ef54079aa8..2b2c938b2e1 100644
--- a/board/ti/am62px/am62px.env
+++ b/board/ti/am62px/am62px.env
@@ -1,6 +1,12 @@
 #include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
 
+#if CONFIG_CMD_REMOTEPROC
+#include <env/ti/k3_rproc.env>
+#endif
+
+rproc_fw_binaries= 0 /lib/firmware/am62p-mcu-r5f0_0-fw
+
 name_kern=Image
 console=ttyS2,115200n8
 args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
-- 
2.48.0

