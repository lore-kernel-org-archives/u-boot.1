Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE94C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C99387FAA;
	Tue, 12 Mar 2024 15:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RwU7DJNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0253987F4F; Tue, 12 Mar 2024 15:30:47 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D436687F69
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710253843; x=1712845843;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kraAEMssq6l117h5tPKekQWkcJ5gWJr8l7woWWoLnWs=;
 b=RwU7DJNqmi7s96MgMb3uuCajzV8uxmI9s4uKD/VjdBGrQ4bdFN8gMSf2EyVJ03YI
 wHk3h8k3l5/sirQpQ28J070rbhwCLgWDmbYju3zUv6qaBvIjC1sIlbWB0LTUfn6h
 YMVlL2nWEYxXXjUY7VDsWDY6eV3nxjFeyl7R7x1tF+U=;
X-AuditID: ac14000a-fbefe7000000290d-9d-65f0671382aa
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 4B.0A.10509.31760F56;
 Tue, 12 Mar 2024 15:30:43 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 15:30:43 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v3 5/5] board: phytec: phycore_imx8mp: Add RAUC boot logic to
 environment
Date: Tue, 12 Mar 2024 15:30:33 +0100
Message-ID: <20240312143033.3336-6-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312143033.3336-1-l.anderweit@phytec.de>
References: <20240312143033.3336-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWyRpKBR1c4/UOqwYwXehYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgyXrVMZSl4
 xlnx99FylgbGGRxdjJwcEgImEpPWtDB1MXJxCAksZpJ4ufojO4TzmFGie18TC0gVm4C+xMqX
 i8BsEQEXiV9L9wDZHBzMAmYSEz4ng5jCApESf58lgVSwCKhK/F23kxHE5hWwlFj5fiILxC55
 iZmXvrOD2JwCVhLb3u0Cs4WAamb3PoKqF5Q4OfMJWD0zUH3z1tnMELaExMEXL5gh6pUk7pz6
 xQYzc9q518wQdqjEkU2rmSYwCs1CMmoWklGzkIxawMi8ilEoNzM5O7UoM1uvIKOyJDVZLyV1
 EyMoxEUYuHYw9s3xOMTIxMF4iFGCg1lJhPe1zttUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryr
 O4JThQTSE0tSs1NTC1KLYLJMHJxSDYz5eZv3fm42mpZ0OqKPe8qE31pOgrkTBDJCPxnlBLMc
 jzj9rKBlBl/9mVylO1HWbxJZJ+rM2R1a/GLaz3TjcuUfu3Z/XtH/LXrN1Tk7YvL2pS6/whva
 5JWsMEF4GuvyjKKnJ9/sLqm/8Vyo82dHklbOgx27XywXc9+fIsvgajTPwuyoZFl65EklluKM
 REMt5qLiRACUmPJ3XwIAAA==
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
Tested-by: Teresa Remmet <t.remmet@phytec.de>
---
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index dc9ad0fe9d15..fae3e992654f 100644
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
@@ -23,7 +28,7 @@ loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 mmcargs=
 	setenv bootargs console=${console}
-	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
+	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 mmcautodetect=yes
 mmcboot=
 	echo Booting from mmc ...;
-- 
2.25.1

