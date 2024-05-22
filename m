Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0854C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C631688846;
	Wed, 22 May 2024 16:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iCsOW0DG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9479C882C5; Wed, 22 May 2024 06:53:56 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 855888828E
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 06:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44M4rkC7106819;
 Tue, 21 May 2024 23:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716353626;
 bh=zYhxIq0mzLUGZ9m024/OGPAouk35EH1w9o11eGOxR5I=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iCsOW0DGMbAK3FDpH+S0KKwDKcVLQdLhfKSQ5gz0t8zBY54xFWBpGY3d81VLEbrl4
 pZR9FU0VtwVRsn9hHK3f6EmtGs+BI2rCrfwFYWGajx544MBZFyBUxNJMlPEx5hMsQe
 f6puK3j1kWEqmKRWgv3a/KcWlpTMrUHfQSfFvOpM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44M4rkW7030798
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 21 May 2024 23:53:46 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 23:53:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 23:53:46 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44M4rWBP067123;
 Tue, 21 May 2024 23:53:42 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>
CC: <m-chawdhry@ti.com>, <n-jain1@ti.com>, <mkorpershoek@baylibre.com>,
 <rogerq@kernel.org>, <afd@ti.com>, <b-padhi@ti.com>, <vigneshr@ti.com>,
 <kamlesh@ti.com>, <clamor95@gmail.com>, <marcel.ziswiler@toradex.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH 2/2] board: ti: j784s4: j784s4.env: Set remoteproc firmware
 names
Date: Wed, 22 May 2024 10:23:31 +0530
Message-ID: <20240522045331.503472-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522045331.503472-1-b-padhi@ti.com>
References: <20240522045331.503472-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 22 May 2024 16:50:33 +0200
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

Include k3_rproc.env to access rproc boot commands and specify
rproc firmware names for adding remoteproc support in J784S4 SoCs.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 board/ti/j784s4/j784s4.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
index 7e54ca042ef..f5b72c7505e 100644
--- a/board/ti/j784s4/j784s4.env
+++ b/board/ti/j784s4/j784s4.env
@@ -3,6 +3,10 @@
 #include <env/ti/ufs.env>
 #include <env/ti/k3_dfu.env>
 
+#if CONFIG_CMD_REMOTEPROC
+#include <env/ti/k3_rproc.env>
+#endif
+
 name_kern=Image
 console=ttyS2,115200n8
 args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02880000
@@ -15,3 +19,5 @@ mmcdev=1
 bootpart=1:2
 bootdir=/boot
 rd_spec=-
+
+rproc_fw_binaries= 2 /lib/firmware/j784s4-main-r5f0_0-fw 3 /lib/firmware/j784s4-main-r5f0_1-fw 4 /lib/firmware/j784s4-main-r5f1_0-fw 5 /lib/firmware/j784s4-main-r5f1_1-fw 6 /lib/firmware/j784s4-main-r5f2_0-fw 7 /lib/firmware/j784s4-main-r5f2_1-fw 8 /lib/firmware/j784s4-c71_0-fw 9 /lib/firmware/j784s4-c71_1-fw 10 /lib/firmware/j784s4-c71_2-fw 11 /lib/firmware/j784s4-c71_3-fw
-- 
2.34.1

