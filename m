Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1B1C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D30F887EE7;
	Mon, 11 Mar 2024 14:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="EwzWqhky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A7687D50; Mon, 11 Mar 2024 14:04:23 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7979F87E0D
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
 bh=60KNEfVbJ3wM0OC//eNfdGtlcC0QMJQaUhmdtSnKIFY=;
 b=EwzWqhkydafPB9WVacwGWhkMlRaUq1EAqweByRcZDN9Ln3REZrY5nj4oloyJvjgb
 Fz7KHMBZC4/j9ynJ6DD4x61jiTnrjn598160K+hky0ce5OkqMAMbOt9KxiHSpqsC
 YLLy1kRUMnP+6DhNH2G2r4gaXK2BDHSHkI9DWLiHVdY=;
X-AuditID: ac14000a-fbefe7000000290d-0b-65ef0152f7ec
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 04.93.10509.2510FE56;
 Mon, 11 Mar 2024 14:04:18 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Mar
 2024 14:04:17 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 2/5] phycore_imx8mp: Move default bootcmd to board env
Date: Mon, 11 Mar 2024 14:03:57 +0100
Message-ID: <20240311130400.4023780-3-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311130400.4023780-1-l.anderweit@phytec.de>
References: <20240311130400.4023780-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWyRpKBRzeI8X2qwfbt7BYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgybt54zlpw
 nbvi6bHvjA2Mnzm7GDk4JARMJCZtCu1i5OIQEljMJLHz2z5WCOcxo8Sznz+BHE4ONgF9iZUv
 F7GA2CICLhK/lu5hAWlmFjCTmPA5GSQsLOAm8W3lS7ASFgFViQmN19hAbF4BG4mN8/8ygtgS
 AvISMy99ZwexOQVsJWY9+MsMYgsB1bzZdBGqXlDi5MwnYHOYgeqbt85mhrAlJA6+eAFVryRx
 59QvNpiZ0869ZoawQyWObFrNNIFRaBaSUbOQjJqFZNQCRuZVjEK5mcnZqUWZ2XoFGZUlqcl6
 KambGEEhLsLAtYOxb47HIUYmDsZDjBIczEoivK913qYK8aYkVlalFuXHF5XmpBYfYpTmYFES
 513dEZwqJJCeWJKanZpakFoEk2Xi4JRqYMxpv7Zx9qNA3SMuB3iSii5qrjjYtHSGa0XIpQ13
 7gczPeLI+u39TPOgxEr9nQdnLswyYjjaEVeTZ6uq+Okij05zrUNMj+u7LZWzFQo223w/k9Wz
 5FN79qqunXdVGfVT5vNcm2Q5UeSUb0/ZrBVcJ7XZvohsd7b3qL1Zvnptvte03yUcm3XN1yix
 FGckGmoxFxUnAgDtYU/zXwIAAA==
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

Move the default bootcmd from the defconfig to the board environment.
No change in functionality.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 12 ++++++++++++
 configs/phycore-imx8mp_defconfig               |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 6d15b7f3dc9f..73202c3b129a 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -1,3 +1,15 @@
+bootcmd=
+	if test ${dofastboot} = 1; then
+		fastboot 0;
+	fi;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
 console=ttymxc0,115200
 dofastboot=0
 emmc_dev=2
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index b3a7bbd79bb6..fd492eba3c10 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -25,8 +25,6 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="if test ${dofastboot} = 1; then fastboot 0; fi; mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
-- 
2.25.1

