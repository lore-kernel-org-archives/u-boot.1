Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBAACA0EF9
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2800E88D83;
	Fri, 30 Aug 2024 11:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="WcqTo+BY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20FE888D9A; Fri, 30 Aug 2024 11:10:08 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1225A88D93
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725009006; x=1727601006;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u1ofcnfoOnvCaH4SYFPq0fvKvSPVJiQUSpfeODo686o=;
 b=WcqTo+BY7/HvARAOIEHfdBl3Sq9rCdEWF/QbGKJ9kwPR19fYaWi8jou0WPxoL6jX
 vG+sNeDh9dqdIWJtyv5Iingf3KjXMbz+0q7ENB0fjQ1CJ0pJLwgvAOPgRKBjG1Ae
 AzMFzIh//BOXGQdHxZNLOSHFCnPUUfnRRWWd8BRIMD0=;
X-AuditID: ac14000a-03251700000021bc-27-66d18c6d5199
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 8A.42.08636.D6C81D66;
 Fri, 30 Aug 2024 11:10:06 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:10:04 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 06/13] board: phytec: phycore_am62x: Add Network/SPI Boot
Date: Fri, 30 Aug 2024 02:09:33 -0700
Message-ID: <20240830090940.2592157-7-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBRzev52KaQVOSxaedj1ktpk7azG7x
 dm8nu0X3O3UHFo9XB1axe5y9s4PRo7+7hdXj+pntTAEsUVw2Kak5mWWpRfp2CVwZn0+vYym4
 xF7RsWsWawPjBbYuRk4OCQETieu79zF2MXJxCAksYZJ4v+cWG4Rzn1Fi8eb9zCBVbAJaEne2
 zAWzRQSSJHY9WQbWzSzgIrH4xgdWEFtYwBPI/sIIYrMIqEosnbyeqYuRg4NXwEriQLsdxDJ5
 iZmXvrOD2JwC1hKbvz4As4WASo5POwc2kldAUOLkzCcsEOPlJZq3zmaGsCUkDr54wQxRryAx
 e9tkRpiZ0869ZoawQyWObFrNNIFRaBaSUbOQjJqFZNQCRuZVjEK5mcnZqUWZ2XoFGZUlqcl6
 KambGEFBLsLAtYOxb47HIUYmDsZDjBIczEoivCeOn00T4k1JrKxKLcqPLyrNSS0+xCjNwaIk
 zru6IzhVSCA9sSQ1OzW1ILUIJsvEwSnVwChzwOb8ueaczPx/7Q5qEoH87O7ucpNyjdQCndMu
 6QjPiUo6OP1J4U7ZWUVB01iXmq4+PiFIZG+Jx5172zbvm3Mmc9aZ8lkFtpIb17/b/UWG82pg
 u1XGMmE9kQqvXz2FB0xWn5q0STFl6tPLTYV/Dj1mz7q9N2xKhsv1WU1yiQUzeTTdOv7sOaTE
 UpyRaKjFXFScCACgPSJSYAIAAA==
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

Include the boot logic to boot via Network or from a OSPI/QSPI
NOR flash. Moreover, set all required variables to both boot
methods to the environment.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am62x/phycore_am62x.env | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 046bbd22f25..711ca3040c4 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -1,5 +1,7 @@
 #include <env/ti/k3_dfu.env>
 #include <env/phytec/k3_mmc.env>
+#include <env/phytec/k3_net.env>
+#include <env/phytec/k3_spi.env>
 
 fdtaddr=0x88000000
 loadaddr=0x82000000
@@ -15,3 +17,9 @@ mmcroot=2
 mmcpart=1
 console=ttyS2,115200n8
 earlycon=ns16550a,mmio32,0x02800000
+
+get_cmd=tftp
+
+spi_fdt_addr=0x700000
+spi_image_addr=0x800000
+spi_ramdisk_addr=0x1e00000
-- 
2.25.1

