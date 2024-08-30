Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D19CA0EF9
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4526988D9E;
	Fri, 30 Aug 2024 11:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="sjrAPowp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F36588D9C; Fri, 30 Aug 2024 11:10:13 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B16288D90
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725009011; x=1727601011;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nuerjAa2PcNGeISKbKGRatp3aBY1IxUvzbz6VcFL6oA=;
 b=sjrAPowpYL4spvEd94DhVnf5vaJseFRV7SFfyAg8g6LKQwmTOMHaGNsruMdGpoTC
 LEnBG7io7FjK419RDWYYRO5mbC++eedwkazw3kKUsX0c2YUxTWg7ClTubQp3aX7y
 NeGOlya4uH6IZ3s5Jk81X10DrGW7hOOrz7BUPFCInF8=;
X-AuditID: ac14000a-03e52700000021bc-34-66d18c7314bb
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 10.52.08636.37C81D66;
 Fri, 30 Aug 2024 11:10:11 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:10:09 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 09/13] configs: phycore_am64x_a53_defconfig: Make BOOTCMD
 generic
Date: Fri, 30 Aug 2024 02:09:36 -0700
Message-ID: <20240830090940.2592157-10-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWyRpKBR7e452KaQf9cYYtPOx+zWkydtJnd
 4u3eTnaL7nfqDiwerw6sYvc4e2cHo0d/dwurx/Uz25kCWKK4bFJSczLLUov07RK4MqZfWsxS
 MJW94vCKjUwNjPPZuhg5OSQETCSWT/3B3sXIxSEksIRJYtK3pcwQzn1Gia0fW1hBqtgEtCTu
 bJnLDGKLCCRJ7HqyDKybWcBFYvGND2A1wgKBEtOeTwGrYRFQlVj/4ypLFyMHB6+AtcS2WU4Q
 y+QlZl76zg5icwKFN399AGYLCVhJHJ92Dmwkr4CgxMmZT1ggxstLNG+dzQxhS0gcfPGCGaJe
 QWL2tsmMMDOnnXvNDGGHShzZtJppAqPQLCSjZiEZNQvJqAWMzKsYhXIzk7NTizKz9QoyKktS
 k/VSUjcxgsJchIFrB2PfHI9DjEwcjIcYJTiYlUR4Txw/mybEm5JYWZValB9fVJqTWnyIUZqD
 RUmcd3VHcKqQQHpiSWp2ampBahFMlomDU6qBkf2aR3mEymN/hserWTLXZoQ39Da+sVRLKgn2
 smDbeHf2lC3bZ9/f/iZWa55kkUDznuTAJIYTEjsu13i6rdoo/zBxX71T5bow5lzG+r8y2+o/
 Ndqa+GvP2fJx2nav8oN5Z/cwb1436y/Pze9zp13iZbJ8/kEiVenrk3DjkKC9Qr/DJjpYlN61
 V2Ipzkg01GIuKk4EALGVRehhAgAA
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

The phyCORE-AM64x board code sets an environment variable 'boot'
with the device U-Boot booted from. Use this variable in
CONFIG_BOOTCOMMAND to boot Linux from the same boot device by
default.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 5651a25c5dd..e1699ad4420 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -38,7 +38,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run mmcboot; bootflow scan -lb"
+CONFIG_BOOTCOMMAND="run ${boot}boot; bootflow scan -lb"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x180000
-- 
2.25.1

