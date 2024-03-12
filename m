Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AAEC54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11ECA87F39;
	Tue, 12 Mar 2024 10:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="kesVS7Go";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F85387F22; Tue, 12 Mar 2024 10:00:11 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C7E87F2D
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710234007; x=1712826007;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vHj6JV9qwDrmnurTifD54mUE1UWlncpIHi/Bq/FfMXg=;
 b=kesVS7GoYQoEeF/vUkmy5TDvH60pdGykDJCBn88+1dD8CMakyM1X+AqFw4YsDy9e
 ISdOwicnIaJOGdETyiMfmLfKkA+xELWagiw6b7DJO2QnP1zdElrSGzBCUimJB1wW
 kdSUiVbHWIIKIuB8qx8j792tJmjf8N6z37vOSs1UBV0=;
X-AuditID: ac14000a-fbefe7000000290d-fe-65f0199799ff
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 05.97.10509.79910F56;
 Tue, 12 Mar 2024 10:00:07 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 10:00:07 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v2 5/5] board: phytec: phycore_imx8mp: Add RAUC boot logic to
 environment
Date: Tue, 12 Mar 2024 09:59:57 +0100
Message-ID: <20240312085957.902398-6-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312085957.902398-1-l.anderweit@phytec.de>
References: <20240312085957.902398-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWyRpKBR3e65IdUg8+HtSweXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBlXP/6lrVg
 O2fFmlvrmRsY37F3MXJwSAiYSCyZq9XFyMUhJLCYSeJPz1ZWCOcxo8T1Tc+AHE4ONgF9iZUv
 F7GA2CICLhK/lu5hAWlmFjCTmPA5GSQsLBApsX31FiYQm0VAVWJm10t2EJtXwFri/OIljCC2
 hIC8xMxL38H2cgrYSKye6AhiCgGVHL0RBVEtKHFy5hOwRcxA1c1bZzND2BISB1+8ALOFBJQk
 7pz6xQYzcdq518wQdqjEkU2rmSYwCs1CMmoWklGzkIxawMi8ilEoNzM5O7UoM1uvIKOyJDVZ
 LyV1EyMovEUYuHYw9s3xOMTIxMF4iFGCg1lJhPe1zttUId6UxMqq1KL8+KLSnNTiQ4zSHCxK
 4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxSDYwuBivfWsRtElb0fKVWkBSrHCnZyDKl9jZrhM6U
 qUXXGk9oXFC5IRcpYnq2TXt5VKVIbKVr+KaTPzvYdDd8PX0yOpJnn7Z+svbWmn/H0i4c3dH8
 4t/k0gKDvACPt3XPNHpfOF2qzS9X3df067T9w7wLW+beP32TbyXb1xsuJwr4r6zefM219KQS
 S3FGoqEWc1FxIgAqOzWfXQIAAA==
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

