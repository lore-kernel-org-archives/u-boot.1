Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E260CA0EF7
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0969788D86;
	Fri, 30 Aug 2024 11:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LFYnAJYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A440A88D89; Fri, 30 Aug 2024 11:10:02 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA63788D7C
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725009000; x=1727601000;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3gdT0Y9moV07skPoLwecIcLA6/zkQo4wyWyz/G/TUt8=;
 b=LFYnAJYv+VuSO/ZVER8G9MqWt4XSm42IgUtDdj6j5ip43e/wbhFvp9kc4xCwHOk2
 QNO2/KDveGRXsP4t777H6E2WpMmZbjU8xyu/Br6pz2CESploSTtXGGQqQyQTMirr
 oHwAFBVja5mM3FBg3fZ3wht7C+wYwtrQeRnv5d4Yds8=;
X-AuditID: ac14000a-03e52700000021bc-1c-66d18c683362
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 95.42.08636.86C81D66;
 Fri, 30 Aug 2024 11:10:00 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:09:59 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 03/13] include: env: phytec: Add raucinit to k3_mmc environment
Date: Fri, 30 Aug 2024 02:09:30 -0700
Message-ID: <20240830090940.2592157-4-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWyRpKBRzej52KawdWt2hafdj5mtZg6aTO7
 xdu9newW3e/UHVg8Xh1Yxe5x9s4ORo/+7hZWj+tntjMFsERx2aSk5mSWpRbp2yVwZZz8+Ji1
 YCtHxYkTb9kaGCezdzFyckgImEj8evGCqYuRi0NIYAmTxJyDO9ghnPuMEvMmH2EFqWIT0JK4
 s2UuM4gtIpAksevJMjYQm1nARWLxjQ9gNcIC/hJrp30Gs1kEVCV+3HsBZvMKWEl0dJ9mhdgm
 LzHz0newzZwC1hKbvz4As4WAao5PO8cGUS8ocXLmExaI+fISzVtnM0PYEhIHX7xghqhXkJi9
 bTIjzMxp514zQ9ihEkc2rWaawCg0C8moWUhGzUIyagEj8ypGodzM5OzUosxsvYKMypLUZL2U
 1E2MoEAXYeDawdg3x+MQIxMH4yFGCQ5mJRHeE8fPpgnxpiRWVqUW5ccXleakFh9ilOZgURLn
 Xd0RnCokkJ5YkpqdmlqQWgSTZeLglGpgLP07TU58bRk335tAkaVhnVPO6h0uYlSMrjFUeTnr
 xxzB3c+r+u9GM07k+9O94IhFoMkOnuMXUzeuSorliufNs7xeWnoxa16X4O5fHi7Gu36u3vgv
 7JrRfNGsU+enV7PNvBKd+ko/QSOJfVtlnNjx78c9syYY7zMoOMx+JTpdniNeMeqUwdMHSizF
 GYmGWsxFxYkAQpRv3GICAAA=
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

Initialize the environment for booting an RAUC image when
'doraucboot' is set to 1.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_mmc.env | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/env/phytec/k3_mmc.env b/include/env/phytec/k3_mmc.env
index 2bce4f77d2d..ad8d3a8b764 100644
--- a/include/env/phytec/k3_mmc.env
+++ b/include/env/phytec/k3_mmc.env
@@ -7,12 +7,14 @@
 /* Logic for TI K3 based SoCs to boot from a MMC device. */
 
 #include <env/phytec/overlays.env>
+#include <env/phytec/rauc.env>
 
 mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
-	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
+	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 mmcloadimage=load mmc ${mmcdev}:${mmcpart} ${kernel_addr_r} Image
 mmcloadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
-mmcboot=run mmcargs;
+mmcboot=if test ${doraucboot} = 1; then run raucinit; fi;
+	run mmcargs;
 	mmc dev ${mmcdev};
 	mmc rescan;
 	run mmcloadimage;
-- 
2.25.1

