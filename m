Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78748CA0EF6
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A8388D7E;
	Fri, 30 Aug 2024 11:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Ea1YqMeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F5488D76; Fri, 30 Aug 2024 11:09:59 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4596988D6D
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725008997; x=1727600997;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EzFp65VNP+v+QXRTQcEE6GjUY+HVDhUpJ+JWo+lUfEM=;
 b=Ea1YqMeTaQT3xr5X2YjVkypVSxCjYnB93GY/bcPVvvqirWP6/lrJ2Jlunq1xg6Tb
 tlomWawmjhWdwVMAjHc6uHokWqwjy4YH+MHumkxmsORWebjiib9CXBKHqhyP5zEJ
 NAH/Qvz3oWCdSLIXBrKVWe3Dz6aqwmaYX/IEeJSRD48=;
X-AuditID: ac14000a-03e52700000021bc-12-66d18c654bed
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 31.42.08636.56C81D66;
 Fri, 30 Aug 2024 11:09:57 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:09:55 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 01/13] configs: phycore_am64x_a53_defconfig: Enable
 CONFIG_OF_BOARD_SETUP
Date: Fri, 30 Aug 2024 02:09:28 -0700
Message-ID: <20240830090940.2592157-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWyRpKBRze152Kawc45nBafdj5mtZg6aTO7
 xdu9newW3e/UHVg8Xh1Yxe5x9s4ORo/+7hZWj+tntjMFsERx2aSk5mSWpRbp2yVwZZz6MJ2l
 YDlbxZdNf1gaGA+zdjFyckgImEj07ehn7GLk4hASWMIkMW3iXFYI5z6jxMnZVxlBqtgEtCTu
 bJnLDGKLCCRJ7HqyjA3EZhZwkVh84wPYJGGBSIkFN54zgdgsAqoSJ/fuBLN5BawkVkxtZ4HY
 Ji8x89J3dhCbU8BaYvPXB2C2EFDN8Wnn2CDqBSVOznzCAjFfXqJ562xmCFtC4uCLF8wQ9QoS
 s7dNZoSZOe3ca2YIO1TiyKbVTBMYhWYhGTULyahZSEYtYGRexSiUm5mcnVqUma1XkFFZkpqs
 l5K6iREU6CIMXDsY++Z4HGJk4mA8xCjBwawkwnvi+Nk0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK
 4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxSDYwsG5W2SjfKP5VxP5i8r+Jm6o+v7qdeTrl4YINM
 T1Q109V9ZXuT3Zi63p57EZrivGU/I5/69+wTGde5Vgkn7ekVjPp+2PG29rUfHRPNyhI23g8O
 5jpzbM3dXrOgHxkigYLCJyOiZ8bphtyzKZ7c6pL0N3Pb5mW34hc9z3l6a/aZsLCmw52if/uU
 WIozEg21mIuKEwEk5D/5YgIAAA==
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

From: Wadim Egorov <w.egorov@phytec.de>

Enable CONFIG_OF_BOARD_SETUP to fixup kernel device tree with mtd
partitions.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 1af72e8bb32..5651a25c5dd 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -37,6 +37,7 @@ CONFIG_SPL_SPI=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run mmcboot; bootflow scan -lb"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_BOARD_LATE_INIT=y
-- 
2.25.1

