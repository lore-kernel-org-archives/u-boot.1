Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30295C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C1688551;
	Mon, 10 Jun 2024 15:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="G7tWo+/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8DD88579; Mon, 10 Jun 2024 15:34:13 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B5D8853F
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718026450; x=1720618450;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FWSdOHwyDWhpYvoAI6KgGqaVjpWJuvV7++tk2zxy8yo=;
 b=G7tWo+/hCekrtalcQuFbMhoT9OchPNXih2Hpb1Dm26FszxOHlWJtOnfgmc+aV7hb
 V2WHp4onTlQJOhMpXekQQujXxE1vt874DAsMfr1JLKpVk3v2hswmahkFXCtWj/ZE
 MiaxHUzJBbExsvBWZrSaXy8TXMCVToKHEHZjZDbO1/Y=;
X-AuditID: ac14000a-03251700000021bc-e8-666700d2454c
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 86.7D.08636.2D007666;
 Mon, 10 Jun 2024 15:34:10 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:10 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 05/13] configs: phycore_am62x: Update environment location
Date: Mon, 10 Jun 2024 15:33:44 +0200
Message-ID: <20240610133352.2473414-6-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWyRpKBR/cSQ3qaQe9+QYsPjZvZLKZO2sxu
 8XZvJ7vFu779TBbd79QdWD1eHVjF7nH2zg5Gj/7uFlaPPxffsQawRHHZpKTmZJalFunbJXBl
 LN24hLXgAVfF3QVH2RoYz3B2MXJySAiYSPQ9/c/excjFISSwhEli76u3bBDOY0aJ341PmECq
 2ATUJe5s+MYKYosIBEn0XvrECGIzC3hIbP27ASwuLOAl8XbVdGYQm0VAVWLZ/4PsIDavgKXE
 /3u/mSC2yUvMvPQdLM4pYCXxY81esF4hoJpFn9awQNQLSpyc+YQFYr68RPPW2cwQtoTEwRcv
 mCHq5SVeXFrOAjNz2rnXzBB2qMTWL9uZJjAKzUIyahaSUbOQjFrAyLyKUSg3Mzk7tSgzW68g
 o7IkNVkvJXUTIyjkRRi4djD2zfE4xMjEwXiIUYKDWUmEVygjOU2INyWxsiq1KD++qDQntfgQ
 ozQHi5I47+qO4FQhgfTEktTs1NSC1CKYLBMHp1QDo1+Y33WPPxvnX2dl7GWuzEtft+p67fdF
 weeTJnXrCfzdJ+N1aA/P1Yq95+T8Ztvt0J+67LvH5cnntsUVHJh0KlKUuf+H6FT73p69naVL
 Cs1jlZrW8O5q9rv35KtHZchblUtik1avX3x/YqWbpnjDZVXNRa73fFiKBRXidhiIeW+7J5Cq
 06d8VYmlOCPRUIu5qDgRALSg+IBnAgAA
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

Update environment location to align with OSPI fixed-partition
definitions and provide a redundant environment at a 2nd location.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 468c0f373b7..7476bb4a175 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -11,7 +11,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
 CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_ENV_OFFSET=0x680000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-phyboard-lyra-rdk"
 CONFIG_SPL_TEXT_BASE=0x80080000
@@ -26,6 +26,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
+CONFIG_ENV_OFFSET_REDUND=0x6c0000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
@@ -65,6 +66,7 @@ CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
-- 
2.34.1

