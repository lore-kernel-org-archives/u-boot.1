Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CB3C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7FA987F0A;
	Mon, 11 Mar 2024 14:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="cZdxX3mn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9917B87DDD; Mon, 11 Mar 2024 14:04:23 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A630D87E50
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710162258; x=1712754258;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vHj6JV9qwDrmnurTifD54mUE1UWlncpIHi/Bq/FfMXg=;
 b=cZdxX3mnJPq5qHXyKi8afyUqiiI1G01SLMMophu3Ld+iPUkTp5/vwfdntMKoAAOs
 V7IoZlxhFZ/wRdxGkrbmD7FYCcKanhmSDeSqFPI+IlOi0kWc2EQUZ9wuqoskflqQ
 +8ST5/QR0TYe2VxcWuqddEJxVsclskquLPl0xTh4JJg=;
X-AuditID: ac14000a-fadff7000000290d-0e-65ef0152c76f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F4.93.10509.2510FE56;
 Mon, 11 Mar 2024 14:04:18 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Mar
 2024 14:04:18 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 5/5] board: phytec: phycore_imx8mp: Add RAUC boot logic to
 environment
Date: Mon, 11 Mar 2024 14:04:00 +0100
Message-ID: <20240311130400.4023780-6-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311130400.4023780-1-l.anderweit@phytec.de>
References: <20240311130400.4023780-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBRzeI8X2qwZbPyhYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgyrn99y1qw
 nbNiza31zA2M79i7GDk5JARMJL72rmHsYuTiEBJYzCTx8s4qNgjnMaPExSNrwKrYBPQlVr5c
 xAJiiwi4SPxaugfI5uBgFjCTmPA5GSQsLBAmsfXsBzYQm0VAVeLi3tmsIDavgI3Eng8ToJbJ
 S8y89B3M5hSwlZj14C8ziC0EVPNm00U2iHpBiZMzn4CtYgaqb946mxnClpA4+OIFVL2SxJ1T
 v9hgZk4795oZwg6VOLJpNdMERqFZSEbNQjJqFpJRCxiZVzEK5WYmZ6cWZWbrFWRUlqQm66Wk
 bmIEBbkIA9cOxr45HocYmTgYDzFKcDArifC+1nmbKsSbklhZlVqUH19UmpNafIhRmoNFSZx3
 dUdwqpBAemJJanZqakFqEUyWiYNTqoGRP/D746W3OmQ3v77HOZk/yNNZqeZe0Xdfo7DA3hmW
 tyQscnJTI8OCkyWU5HSZxKZdyfqifEJz1QbR+bfe/nncW33rQtUbu50e88+r1HDV38zzuumv
 +Guvveez8lu896aalLXXTz78RMsqY5ex3JdHWtIR6ceFHXM6ph96HHXR71Nn33wZEyUlluKM
 REMt5qLiRADmE79uYAIAAA==
X-Mailman-Approved-At: Mon, 11 Mar 2024 14:06:01 +0100
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

Add RAUC boot logic to the environment. This is the first board to
utilize this environment.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 73202c3b129a..d58d25476f6b 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -1,9 +1,14 @@
+#include <env/phytec/rauc.env>
+
 bootcmd=
 	if test ${dofastboot} = 1; then
 		fastboot 0;
 	fi;
 	mmc dev ${mmcdev};
 	if mmc rescan; then
+		if test ${doraucboot} = 1; then
+			run raucinit;
+		fi;
 		if run loadimage; then
 			run mmcboot;
 		else
@@ -23,7 +28,7 @@ loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
 mmcargs=
 	setenv bootargs console=${console}
-	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
+	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 mmcautodetect=yes
 mmcboot=
 	echo Booting from mmc ...;
-- 
2.25.1

