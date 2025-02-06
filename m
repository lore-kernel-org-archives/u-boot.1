Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA3BC02192
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 01:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF7C6807D7;
	Thu,  6 Feb 2025 02:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dv5MMBxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A84800CF; Thu,  6 Feb 2025 02:54:19 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A6C807B3
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 02:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5161s7DE2643084
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Feb 2025 19:54:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738806847;
 bh=asinHDlO1kPPK3ZWYWWJ6c1tuKC1mHoUE75RqEGQrdk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=dv5MMBxfcDmw9rH8i2exMsdaJcalpJw3yOjKQpup7bl4eekuoLY7qo+IqaKNWNqdl
 wXEQuTqDwRMkWIVoai7SUAuEI5CqDYNztHWrXZIYZNvI3vIHqF9u09h3V1YHVSmPId
 B45O4eLsP1CuNdKGU7NFQrS7a3GpTFDKerWaWvzg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5161s7m8013072
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Feb 2025 19:54:07 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 19:54:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 19:54:06 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5161s680036392;
 Wed, 5 Feb 2025 19:54:06 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Judith
 Mendez <jm@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 4/6] board: ti: am62x: Add remoteproc specific env support
Date: Wed, 5 Feb 2025 19:54:04 -0600
Message-ID: <20250206015406.2702944-5-jm@ti.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250206015406.2702944-1-jm@ti.com>
References: <20250206015406.2702944-1-jm@ti.com>
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

Add remoteproc specific env support for am62x device. If the
remoteproc CMD is defined, include the K3 remote procenvironment.
Also define rproc_fw_binaries which holds a list of remoteproc FW
binaries for u-boot loading of remote cores.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v3:
- add patch
---
 board/ti/am62x/am62x.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
index 078cc4b5ac9..60b5fd5e6ca 100644
--- a/board/ti/am62x/am62x.env
+++ b/board/ti/am62x/am62x.env
@@ -2,6 +2,12 @@
 #include <env/ti/mmc.env>
 #include <env/ti/k3_dfu.env>
 
+#if CONFIG_CMD_REMOTEPROC
+#include <env/ti/k3_rproc.env>
+#endif
+
+rproc_fw_binaries= 0 /lib/firmware/am62-mcu-m4f0_0-fw
+
 name_kern=Image
 console=ttyS2,115200n8
 args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
-- 
2.48.0

