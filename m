Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEF1C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5482988548;
	Mon, 10 Jun 2024 15:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rD4bGqhr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7612C88520; Mon, 10 Jun 2024 15:34:13 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8458388543
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
 bh=CS12a5WoAFXPEHsv2SOWaYd1E5gnSJVICRW3W6+vmxQ=;
 b=rD4bGqhrSC+iH/eh0rq1JeRpTvPgy1VUoMuEqXUiEbB9FPDWJa5qk5aSu3vR2FQt
 UpLeSAoEwU+QoBMF8XIrpnJf+4BTbrcjh3cAlxTznRBHJYG9765ItsfXeQf/Pd7U
 b36ITwcRCe4RzGX2+mEoKNrOmCbJrA/Dhg5Kiy3yI8E=;
X-AuditID: ac14000a-03e52700000021bc-e9-666700d25385
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E6.7D.08636.2D007666;
 Mon, 10 Jun 2024 15:34:10 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:10 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 06/13] configs: phycore_am64x: Update environment location
Date: Mon, 10 Jun 2024 15:33:45 +0200
Message-ID: <20240610133352.2473414-7-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWyRpKBR/cSQ3qaQdtsSYsPjZvZLKZO2sxu
 8XZvJ7vFu779TBbd79QdWD1eHVjF7nH2zg5Gj/7uFlaPPxffsQawRHHZpKTmZJalFunbJXBl
 7Hh1iLXgOlfFuR2XWBsYD3N2MXJySAiYSHydvpq9i5GLQ0hgCZPEwu23GSGcx4wSvxufMIFU
 sQmoS9zZ8I0VxBYRCJLovfSJEcRmFvCQ2Pp3A1hcWMBLYsHdV8wgNouAqsSSle/ZQGxeAUuJ
 P2dvMEJsk5eYeek7O4jNKWAl8WPNXrBeIaCaRZ/WsEDUC0qcnPmEBWK+vETz1tnMELaExMEX
 L5gh6uUlXlxazgIzc9q518wQdqjE1i/bmSYwCs1CMmoWklGzkIxawMi8ilEoNzM5O7UoM1uv
 IKOyJDVZLyV1EyMo5EUYuHYw9s3xOMTIxMF4iFGCg1lJhFcoIzlNiDclsbIqtSg/vqg0J7X4
 EKM0B4uSOO/qjuBUIYH0xJLU7NTUgtQimCwTB6dUA+N6jeqP5d7La1SmvvZ6Vn318Lr0Rr3Q
 WjmblU2NLywVTuf+vsHALnj+XPzRphfHNnTP6zjc1CcWai7JUP8p8dekWpOnhVsCxCY7zNtb
 NfHkeccXr3z27jRMmfJrz2Ffu6Wnj7Tm3Ir/W52hvz20lM1WwfLfs22nmhZNjs4WqJzy1Ivd
 j3ub3G8lluKMREMt5qLiRADLZRZCZwIAAA==
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
 configs/phycore_am64x_a53_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 76bb0e53e51..e94d829fd8f 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -13,7 +13,7 @@ CONFIG_TARGET_PHYCORE_AM64X_A53=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
 CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_ENV_OFFSET=0x680000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am642-phyboard-electra-rdk"
@@ -28,6 +28,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
+CONFIG_ENV_OFFSET_REDUND=0x6c0000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
@@ -76,6 +77,7 @@ CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
-- 
2.34.1

