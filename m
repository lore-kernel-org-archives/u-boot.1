Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9594FC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 05:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 449D788A31;
	Wed, 17 Jul 2024 07:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rTg//byR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CA5588A52; Wed, 17 Jul 2024 07:12:12 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D755D885B6
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 07:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1721193128; x=1723785128;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dSBO97yX/i6DsUlmulpFE9L9cg/nLsUjvM8pm26g1ac=;
 b=rTg//byRHCy/KLT933xnG+5PPIar+q2XoAmGuecRmkO7AKPD8Zkd2S889hgHRd1G
 f3wPIunFUgVSTuyOu/n7IT7kGZM153yrtLWhdb7uL+MSKVvCgPxX3mO7eYKbRvxD
 nhG9sY7m1S9UyEiSnN+1Hyg2QUY6n9cjVB0F+8hfr/g=;
X-AuditID: ac14000a-03e52700000021bc-f9-669752a8461a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 27.8B.08636.8A257966;
 Wed, 17 Jul 2024 07:12:08 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 17 Jul
 2024 07:12:06 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <t.remmet@phytec.de>, <d-gole@ti.com>, Daniel
 Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 8/9] board: phytec: phycore_am62x: Use k3_mmc.env logic
Date: Tue, 16 Jul 2024 22:11:33 -0700
Message-ID: <20240717051134.1538180-9-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240717051134.1538180-1-d.schultz@phytec.de>
References: <20240717051134.1538180-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWyRpKBR3dF0PQ0g08rNC1a1npYTJ20md3i
 7d5Odovud+oOLB6vDqxi9zh7ZwejR393C6vH8RvbmQJYorhsUlJzMstSi/TtErgy9q95wViw
 hLPi06WVbA2MPRxdjJwcEgImEkdu3GXpYuTiEBJYwiRx4/hnJgjnPqPEopaDjCBVbAJaEne2
 zGUGsUUEfCSOtm4G6uDgYBZIl1i1Kg0kLCzgJXHvzwNWEJtFQFXic/tksFZeASuJS4uPsEIs
 k5eYeek7O4jNKWAtsfjibXaQMUJANYcfBEKUC0qcnPmEBcRmBipv3jqbGcKWkDj44gWYLSSg
 IDF7G8R4kJHTzr1mhrBDJbZ+2c40gVFoFpJRs5CMmoVk1AJG5lWMQrmZydmpRZnZegUZlSWp
 yXopqZsYQSEuwsC1g7FvjschRiYOxkOMEhzMSiK8ExinpQnxpiRWVqUW5ccXleakFh9ilOZg
 URLnXd0RnCokkJ5YkpqdmlqQWgSTZeLglGpgnNqQ+Dzk2V/PFt19tevKvySsjXl5rPG9pWZw
 SFuw/JrmjatcOXky1lxjbzbfxcOi39jlOHWBQL7b2uPyRgI2+49sORHQ4B3yOGTfdg+75IM+
 v8KsJZNDH/ZrRk71W2l2SsMk0ejjs9O9CyY5+AtHsnfl66r/sPh6ycxA3MZl84K+fN6PckeU
 WIozEg21mIuKEwGt0o59XwIAAA==
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
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/phycore_am62x.env | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 2d6475d408f..046bbd22f25 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -1,4 +1,5 @@
 #include <env/ti/k3_dfu.env>
+#include <env/phytec/k3_mmc.env>
 
 fdtaddr=0x88000000
 loadaddr=0x82000000
@@ -14,13 +15,3 @@ mmcroot=2
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

