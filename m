Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF60C531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 13:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C377D88618;
	Fri, 16 Aug 2024 15:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="p1OeEIP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 722B488618; Fri, 16 Aug 2024 15:23:50 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76330885C5
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 15:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1723814617; x=1726406617;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4svUhisFSzJTbP0gbz72XexzuQiQlUirO2coe2Q312k=;
 b=p1OeEIP9eWBPpUurFUfvlORWP8Jp/C+3W6UbKm1WDpc/BdL31na8A1Btdb/sP4Xe
 6SWAKZjn4NkRlu5k6OmHPR85l/GfZ89+1E1w9zMYp2alr6ax38/thZlhfYY7kr+V
 pPDQnrxlD2pU0X5UQojS8AB/ljchNbWI2M0c6p9CBew=;
X-AuditID: ac14000a-03e52700000021bc-af-66bf52d92831
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C9.61.08636.9D25FB66;
 Fri, 16 Aug 2024 15:23:37 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 16 Aug
 2024 15:23:36 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH] configs: am64x*_r5_defconfig: Drop BOOTCOMMAND
Date: Fri, 16 Aug 2024 15:23:28 +0200
Message-ID: <20240816132328.928651-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWyRpKBR/dm0P40g663nBZTJ21mt3i7t5Pd
 ovudusX/sx/YHVg8Xh1Yxe5x9s4ORo/+7hZWj+M3tjMFsERx2aSk5mSWpRbp2yVwZfzpXM1S
 cJ+r4nj3E/YGxt2cXYycHBICJhJTt51h7GLk4hASWMIk8bcFxnnMKHFt1RMmkCo2AXWJOxu+
 sYLYIgJSEi87NzJ3MXJwMAu4S9y9FAcSFhawl7gz6ydYCYuAqsTXxo9grbwCFhK7zt9mh1gm
 LzHz0nd2iLigxMmZT1hAbGagePPW2cwQtoTEwRcvwGwhoPiLS8tZYHqnnXvNDGGHShzZtJpp
 AqPALCSjZiEZNQvJqAWMzKsYhXIzk7NTizKz9QoyKktSk/VSUjcxgsJWhIFrB2PfHI9DjEwc
 jIcYJTiYlUR4n37ZmybEm5JYWZValB9fVJqTWnyIUZqDRUmcd3VHcKqQQHpiSWp2ampBahFM
 lomDU6qB0WqF6O7VZ5bu52HxNt1V/C/7bHlj8Wm946cLZuQyG568FScaocJ45KTDxynh15cY
 xsuefXdTNei+ouvC2IdHH0/beTi9K6Q56u2TcpWOF0YV06S1I+4arn/8++Kz58Wf07eymO9a
 +j4jZYaT87wf8t8PSLYHi4fPjnk2W+QWs6qBVYyeKeNMeyWW4oxEQy3mouJEAIzQfXhJAgAA
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

There is no need to define a default for bootcmd in R5 u-boot because
the R5 is directly booting into the next stage A53 bootloader.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/am64x_evm_r5_defconfig     | 2 --
 configs/phycore_am64x_r5_defconfig | 2 --
 2 files changed, 4 deletions(-)

diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index 96475d4c1b8..08c9cf2c316 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -35,8 +35,6 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run distro_bootcmd"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
index a0d78241928..24361bb9c1d 100644
--- a/configs/phycore_am64x_r5_defconfig
+++ b/configs/phycore_am64x_r5_defconfig
@@ -34,8 +34,6 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run distro_bootcmd"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
-- 
2.34.1

