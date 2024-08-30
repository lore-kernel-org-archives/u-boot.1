Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB07CA0EF7
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A55D688DB1;
	Fri, 30 Aug 2024 11:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Bm1omKhE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F189888DA4; Fri, 30 Aug 2024 11:10:14 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2334A88D9A
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725009013; x=1727601013;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lzeI0G+0D7x01TqnZttSfCO/dj3hy88e6sapJh0YO1k=;
 b=Bm1omKhEvbeEGzNJuiLTWiwgT1x4RSYbAfSXr8v8IfoQTq9eGiQ5cvDgp+QEiFkY
 1V9po3Nb4SjkOxmDrG7Lc4fNmdMjvILcCHgdfy6fEpzbIXjkzG4zUkryHxpXpVzN
 hvgkBqsXuTXyjk95gfXTBRQDfsib60GKlhZ+EiBdG8M=;
X-AuditID: ac14000a-03e52700000021bc-38-66d18c75a1ff
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A1.52.08636.57C81D66;
 Fri, 30 Aug 2024 11:10:13 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:10:11 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 10/13] configs: phycore_am62x_a53_defconfig: Merge
 am62x_a53_usbdfu.config
Date: Fri, 30 Aug 2024 02:09:37 -0700
Message-ID: <20240830090940.2592157-11-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWyRpKBR7e052KawbeHLBafdj5mtZg6aTO7
 xdu9newW3e/UHVg8Xh1Yxe5x9s4ORo/+7hZWj+tntjMFsERx2aSk5mSWpRbp2yVwZdy50cdS
 8J29ovt4F2MD4xu2LkZODgkBE4n9y+axdzFycQgJLGGS6L/8lwnCuc8osezlN0aQKjYBLYk7
 W+Yyg9giAkkSu54sA+tmFnCRWHzjAyuILSwQJXH1zguwehYBVYkz/YfA6nkFrCUOHvzECLFN
 XmLmpe/sIDYnUHzz1wdgtpCAlcTxaefYIOoFJU7OfMICMV9eonnrbGYIW0Li4IsXzBD1ChKz
 t02Gmznt3GtmCDtU4sim1UwTGIVmIRk1C8moWUhGLWBkXsUolJuZnJ1alJmtV5BRWZKarJeS
 uokRFOgiDFw7GPvmeBxiZOJgPMQowcGsJMJ74vjZNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
 qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2M4Yv8F+uIL9k4J1vgAWNf4OYbPs92XlGetUj+yRtX
 Bf+D6VETGA+ZKaUK6RlsU+41132jfa984pclmmK7j8X3zTofEHqaUXVRVfzO865TBOUjJirc
 +Mr6aYrAYgsLkYavi5ZdtJ9YGF3w3IBx/irPdZYmd7i4o565TJ4t9Ss3VXVtjGrOpfp/SizF
 GYmGWsxFxYkAQRkiemICAAA=
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

Merge the am62x_a53_usbdfu.config into the phyCORE-AM62x A53 defconfig to
properly support USB DFU boot.

This config was made with the following command:

    make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- \
        phycore_am62x_a53_defconfig am62x_a53_usbdfu.config

However, CONFIG_USB_GADGET_MANUFACTURER was not merged to keep Phytec
as manufacturer.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 7bbd8011fa8..07a1fff1f3d 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -92,7 +92,7 @@ CONFIG_SPL_CLK=y
 CONFIG_CLK_TI_SCI=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
-CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
 CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
-- 
2.25.1

