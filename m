Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0397C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 05:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA88588A4D;
	Wed, 17 Jul 2024 07:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jEJg8ejY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAF7B88A38; Wed, 17 Jul 2024 07:12:08 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD49D885B6
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 07:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1721193126; x=1723785126;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f77A+6PVpdITBW+dr47PT8w4tWP9xgg3ZMqXtlmuSDk=;
 b=jEJg8ejYYZTWw652oUaOX8SCqOFGU0w20KKsMNMn4PbSoKgXDDI1mTE50cV8ktV5
 emGPpWmn32z4t6QNTDVHfhPHMpr9spnI3BljMxzLIethe6FNO5VepdjJrI1CJh3n
 bK8+6/CGd8SAa1L0ea0A8Of5zv97/sZbjCvOvZo4qiI=;
X-AuditID: ac14000a-03251700000021bc-f6-669752a6adcd
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B5.8B.08636.6A257966;
 Wed, 17 Jul 2024 07:12:06 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 17 Jul
 2024 07:12:04 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <t.remmet@phytec.de>, <d-gole@ti.com>, Daniel
 Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 7/9] include: env: phytec: k3_mmc: Apply overlays during
 boot
Date: Tue, 16 Jul 2024 22:11:32 -0700
Message-ID: <20240717051134.1538180-8-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240717051134.1538180-1-d.schultz@phytec.de>
References: <20240717051134.1538180-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWyRpKBR3dZ0PQ0g4b/WhYtaz0spk7azG7x
 dm8nu0X3O3UHFo9XB1axe5y9s4PRo7+7hdXj+I3tTAEsUVw2Kak5mWWpRfp2CVwZd75vZSxY
 yF7x+N1+9gbGbrYuRk4OCQETib0vFgDZXBxCAkuYJD49OMMC4dxnlFh0cRM7SBWbgJbEnS1z
 mUFsEQEfiaOtm4GKODiYBdIlVq1KAwkLCwRITH66igXEZhFQlVjVt4IZpIRXwEpi9h6oXfIS
 My99B5vIKWAtsfjibXaQEiGgksMPAkHCvAKCEidnPgGbwgxU3rx1NjOELSFx8MULMFtIQEFi
 9rbJjDAjp517zQxhh0ps/bKdaQKj0Cwko2YhGTULyagFjMyrGIVyM5OzU4sys/UKMipLUpP1
 UlI3MYICXISBawdj3xyPQ4xMHIyHGCU4mJVEeCcwTksT4k1JrKxKLcqPLyrNSS0+xCjNwaIk
 zru6IzhVSCA9sSQ1OzW1ILUIJsvEwSnVwGh7ySteITRXNf7jKkf9Deprz16PnXPxecvD9WJP
 J1jnfuFJuWZQciqEqbH97XbOGT9z4jZs4zKMMZ2bnrMnQffx/OMbH0ysXTVxzv2j/Uv8leXu
 7wyL+rGwu9GH417007jI+3Hifs9+Plv81eJkfs6FzS/yPC76c8rkXktuPzWbifeIyQXJN7FK
 LMUZiYZazEXFiQBqES9YXgIAAA==
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

Include the overlays.env file and run the apply routine before
booting the Kernel.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
 include/env/phytec/k3_mmc.env | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/env/phytec/k3_mmc.env b/include/env/phytec/k3_mmc.env
index e1208a6eea1..3d3595ceb7e 100644
--- a/include/env/phytec/k3_mmc.env
+++ b/include/env/phytec/k3_mmc.env
@@ -6,6 +6,8 @@
 
 /* Logic for TI K3 based SoCs to boot from a MMC device. */
 
+#include <env/phytec/overlays.env>
+
 mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
 	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
 loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} Image
@@ -15,4 +17,5 @@ mmcboot=run mmcargs;
 	mmc rescan;
 	run loadimage;
 	run loadfdt;
+	run mmc_apply_overlays;
 	booti ${loadaddr} - ${fdt_addr_r}
-- 
2.25.1

