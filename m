Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80F2CA0EF6
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8704088D84;
	Fri, 30 Aug 2024 11:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UFmWr3dt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C5188D7E; Fri, 30 Aug 2024 11:10:00 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1516388D74
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725008999; x=1727600999;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bSR1d+/snlC/Z9NCwcYll2hQdiPXaueRSapXRoXnb2w=;
 b=UFmWr3dtdCdAy1wvPVX0+L2r31ji7w7fqGcf8qEYql74/OjSXaoT/yHLLeJMq9hC
 LCrdjgPenbtUBxwaXNV/HiS5OrxgkURj674V0VYT5uWewumfBUEO6udoANd/9BEQ
 GrV5A3RqL9Gv5j7tiJvbfC5oQc23eIwvvGZkoiD5RAM=;
X-AuditID: ac14000a-03e52700000021bc-16-66d18c666bb3
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 73.42.08636.66C81D66;
 Fri, 30 Aug 2024 11:09:58 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:09:57 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 02/13] include: env: phytec: k3_mmc: Rename variables
Date: Fri, 30 Aug 2024 02:09:29 -0700
Message-ID: <20240830090940.2592157-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWyRpKBRzet52KawbGpFhafdj5mtZg6aTO7
 xdu9newW3e/UHVg8Xh1Yxe5x9s4ORo/+7hZWj+tntjMFsERx2aSk5mSWpRbp2yVwZVx7NIG1
 4Apnxdbmn8wNjPM5uhg5OSQETCQuPGlkBrGFBJYwSfz9ltXFyAVk32eU2DxrNTtIgk1AS+LO
 lrlgRSICSRK7nixjA7GZBVwkFt/4wApiCwu4Suy+cIwJxGYRUJV4vuQyWD2vgJVEQ89KJohl
 8hIzL30Hm8kpYC2x+esDdojFVhLHp51jg6gXlDg58wkLxHx5ieats5khbAmJgy9eQB2qIDF7
 22RGmJnTzr1mhrBDJY5sWs00gVFoFpJRs5CMmoVk1AJG5lWMQrmZydmpRZnZegUZlSWpyXop
 qZsYQWEuwsC1g7FvjschRiYOxkOMEhzMSiK8J46fTRPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
 u7ojOFVIID2xJDU7NbUgtQgmy8TBKdXA6O9VEKnbVbp/6p/4DbEvNFujzimrieacCd7Pu9V4
 u/qUMPszEfnLuj0rjp6fkWNy9rpwiWnlyludCYxrpllMsUv6kvly/u+dV94Ym0WLFMV82Hxl
 enHn3CkZO3qXeM5afld5bUDUbOFt7huYr+W958o/tPP9Wl7/NPtkszks3auadswL4GxJUWIp
 zkg01GIuKk4EAOLn/IthAgAA
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

Add a mmc prefix to 'loadimage' and 'loadfdt' because we need
similar variables for other boot sources. This will prevent
name clashes and allows to implement similar boot logic.

Also switch from loadaddr to kernel_addr_r.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_mmc.env | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/env/phytec/k3_mmc.env b/include/env/phytec/k3_mmc.env
index 3d3595ceb7e..2bce4f77d2d 100644
--- a/include/env/phytec/k3_mmc.env
+++ b/include/env/phytec/k3_mmc.env
@@ -10,12 +10,12 @@
 
 mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
 	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
-loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} Image
-loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcloadimage=load mmc ${mmcdev}:${mmcpart} ${kernel_addr_r} Image
+mmcloadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 mmcboot=run mmcargs;
 	mmc dev ${mmcdev};
 	mmc rescan;
-	run loadimage;
-	run loadfdt;
+	run mmcloadimage;
+	run mmcloadfdt;
 	run mmc_apply_overlays;
-	booti ${loadaddr} - ${fdt_addr_r}
+	booti ${kernel_addr_r} - ${fdt_addr_r}
-- 
2.25.1

