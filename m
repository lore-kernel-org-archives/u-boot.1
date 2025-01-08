Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC34E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A457D806D5;
	Wed,  8 Jan 2025 16:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JfaMG16G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AABE5803DC; Wed,  8 Jan 2025 11:25:27 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E575D8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 11:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 508APKH12788768
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2025 04:25:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736331920;
 bh=4rPfae7bVyTF725Pp4/nLE31J6mUY1o/BRXPXwy50Hs=;
 h=From:To:CC:Subject:Date;
 b=JfaMG16GsR4Y7mHY6P4KdB+7m4r6mznvuo5lPn/JdJm2oXJMrq/HNYfqMuvSlb9nT
 J0PdPMe0jp00cvNGuHowpRD7u6N3wd4ZWl7E2OjXhyKzci2jKE/DfS7BExepDX6G+q
 ArWitZneimsJoM2JGf6ojEJqywabZuFlaeAv3WXs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 508APKuI017110
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 Jan 2025 04:25:20 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 Jan 2025 04:25:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 Jan 2025 04:25:20 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 508APGgt127878;
 Wed, 8 Jan 2025 04:25:17 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <rogerq@kernel.org>, <nm@ti.com>, <n-francis@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <afd@ti.com>, <hnagalla@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH] board: ti: j722s: j722s.env: Set remoteproc firmware names
Date: Wed, 8 Jan 2025 15:55:16 +0530
Message-ID: <20250108102516.2103132-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:49:18 +0100
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

Include k3_rproc.env to access rproc boot commands and specify rproc
firmware names for adding remoteproc support in J722S SoCs.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
This patch is independent and puts the environment in place to boot remote
processors at U-Boot stage. 

However, for successfully loading the firmwares into remote cores, rproc
DT node definitions are required. These DT changes have been merged into
Linux and available with v6.12 tag[0]. Once the DT Sync happens in U-Boot,
remote processors can be probed and booted with the help of env commands
enabled with this patch.

Sample Boot Test logs after manually adding DT nodes in U-Boot:
https://gist.github.com/3V3RYONE/0b5c7df5b5c88d2a2f273b6a04a3dd46

[0]: https://lore.kernel.org/all/20240830161742.925145-1-b-padhi@ti.com/

Thanks,
Beleswar

 board/ti/j722s/j722s.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/ti/j722s/j722s.env b/board/ti/j722s/j722s.env
index f8b6aff2c2f..10d62034e1a 100644
--- a/board/ti/j722s/j722s.env
+++ b/board/ti/j722s/j722s.env
@@ -1,6 +1,10 @@
 #include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
 
+#if CONFIG_CMD_REMOTEPROC
+#include <env/ti/k3_rproc.env>
+#endif
+
 name_kern=Image
 console=ttyS2,115200n8
 args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
@@ -13,3 +17,5 @@ mmcdev=1
 bootpart=1:2
 bootdir=/boot
 rd_spec=-
+
+rproc_fw_binaries= 0 /lib/firmware/j722s-mcu-r5f0_0-fw 2 /lib/firmware/j722s-main-r5f0_0-fw 3 /lib/firmware/j722s-c71_0-fw 4 /lib/firmware/j722s-c71_1-fw
-- 
2.34.1

