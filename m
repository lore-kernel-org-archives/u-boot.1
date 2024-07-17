Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D310FC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 05:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CF688A42;
	Wed, 17 Jul 2024 07:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="cYUng1XH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B27D88A33; Wed, 17 Jul 2024 07:12:13 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF4EE88A49
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 07:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1721193130; x=1723785130;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NsU76seaq0f1b3Qou3CrLvicujcEgQZ2Du1O4TkD8Es=;
 b=cYUng1XH7uV7SRZA7R6aBvIHi35KFd2kn5NwU08LaWjwGoeaW+p86tF26G+gBktJ
 F6XcSPQpCdTtRMkfl4pqZIGobaeZBvsiHYFa03p3sj6jsbUDuKOvXFi9B7k+2O9N
 6Bi9sYN8M0NH2Q51UishcC3NmDqc/LeciWaWPheH5kM=;
X-AuditID: ac14000a-03e52700000021bc-fd-669752aa4594
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 98.8B.08636.AA257966;
 Wed, 17 Jul 2024 07:12:10 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 17 Jul
 2024 07:12:08 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <t.remmet@phytec.de>, <d-gole@ti.com>, Daniel
 Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 9/9] board: phytec: phycore_am64x: Use k3_mmc.env logic
Date: Tue, 16 Jul 2024 22:11:34 -0700
Message-ID: <20240717051134.1538180-10-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240717051134.1538180-1-d.schultz@phytec.de>
References: <20240717051134.1538180-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWyRpKBR3dV0PQ0g+kdWhYtaz0spk7azG7x
 dm8nu0X3O3UHFo9XB1axe5y9s4PRo7+7hdXj+I3tTAEsUVw2Kak5mWWpRfp2CVwZ99f9YS/4
 ylFx5ONGxgbGJ+xdjJwcEgImEpPPTWLpYuTiEBJYwiTx4dp/NgjnPqPEzWeHGUGq2AS0JO5s
 mcsMYosI+Egcbd0M1MHBwSyQLrFqVRpIWFjAS2L3v91gQ1kEVCV+39wKZvMKWEvc/LMYapm8
 xMxL38FsTqD44ou32UHGCAlYSRx+EAhRLihxcuYTFhCbGai8eetsZghbQuLgixdgtpCAgsTs
 bZMZYUZOO/eaGcIOldj6ZTvTBEahWUhGzUIyahaSUQsYmVcxCuVmJmenFmVm6xVkVJakJuul
 pG5iBIW4CAPXDsa+OR6HGJk4GA8xSnAwK4nwTmCclibEm5JYWZValB9fVJqTWnyIUZqDRUmc
 d3VHcKqQQHpiSWp2ampBahFMlomDU6qBcf3iA4WzMiv3nCyX/ivFsj/G/uun1m27XY9NX3Mi
 nkta+pWY95WJvL6iL3YcstC4YXJa2OX9zW5Vrr6E8+0s+59HWOyyk/04Zf6WTbryMd3ZO1dO
 XjUrfVnJLKaZkzM7Zz4Vmubotc1W7D/L9sMNWpMWPUjhfaP6/z7/ieOPW8/MNo44KZYcmKXE
 UpyRaKjFXFScCAAIhgXWXwIAAA==
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

Use our common environment file to implement MMC boot.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am64x/phycore_am64x.env | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index e24a958f51d..18f0fa5b4c3 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -1,3 +1,5 @@
+#include <env/phytec/k3_mmc.env>
+
 fdtaddr=0x88000000
 loadaddr=0x82000000
 scriptaddr=0x80000000
@@ -12,13 +14,3 @@ mmcroot=2
 mmcpart=1
 console=ttyS2,115200n8
 earlycon=ns16550a,mmio32,0x02800000
-mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
-	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
-loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} Image
-loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdtaddr} ${fdtfile}
-mmcboot=run mmcargs;
-	mmc dev ${mmcdev};
-	mmc rescan;
-	run loadimage;
-	run loadfdt;
-	booti ${loadaddr} - ${fdtaddr}
-- 
2.25.1

