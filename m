Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29CDC54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 16:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5210E87CF8;
	Wed,  6 Mar 2024 17:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HLFEwa9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91E9887C92; Wed,  6 Mar 2024 17:18:44 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241B887D31
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 17:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709741917; x=1712333917;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WJ2u2dktssYUpyFpYAryRAb7XvyHl3Je3rIVqeppnqM=;
 b=HLFEwa9kguEhxOkucp6Jv4KXsFhZDEBlud5ZaoZbqd1IkjmP5aCmbys1VGiBXC4l
 dk2oEjBQmyvpmaffZAQMWSYsnuM/bsX70uJl1V3nrLK3bQB29x1tqlmxAWu9a9xI
 UMt+2fZmIJwVvEKoAm67lR9uzOJH+q5KvMXC9HWovDw=;
X-AuditID: ac14000a-fbefe7000000290d-f5-65e8975d494f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5E.E3.10509.D5798E56;
 Wed,  6 Mar 2024 17:18:37 +0100 (CET)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 6 Mar 2024
 17:18:37 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 6 Mar 2024 17:18:32 +0100
Subject: [PATCH v3 2/2] board: phycore_imx8mp: Use 2GHz RAM timings for
 PCL-070 from pcb_rev 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240306-pcl-070-patches-v3-2-cb39c3487bc3@phytec.de>
References: <20240306-pcl-070-patches-v3-0-cb39c3487bc3@phytec.de>
In-Reply-To: <20240306-pcl-070-patches-v3-0-cb39c3487bc3@phytec.de>
To: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>, Fabio
 Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709741916; l=1022;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=WJ2u2dktssYUpyFpYAryRAb7XvyHl3Je3rIVqeppnqM=;
 b=SbuMqAF55u+9y4y+FLyhPAGyaFSXAE8CLxrQ2vhRM+hDJxa5a8ImU7RjdXgQ2tNs20Yuo2Ot8
 ba7dcXvw+iGA/cZ6EkyUKfPPsS0T+Tk/gI8Bt5uVXtAnpNVtOghJjlG
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWyRpKBRzd2+otUg0u7xCweXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBl9K7eylLQ
 wFGxdM82lgbGy2xdjJwcEgImEpMunGECsYUEFjNJnN9j3cXIBWQ/YJS4N/UHWBGbgJrErjev
 WUFsFgEViU3Hl4I1CAskSOy+swqshldAUOLkzCcsXYwcHMwCmhLrd+mDhJkF5CW2v53DDFHi
 JPHi2hp2iF1OEu3bbzKC2JwCzhKHLq1kAbFFBLIlnnVuYYcYEyXxbmIQiCkhICyxaacWyGUS
 AruZJNoXLmWFiCdK7HwtBzFRVuLm+S1QX8lLTDv3mhnCDpU4smk10wRGkVlI7pyFcOcsJHcu
 YGRexSiUm5mcnVqUma1XkFFZkpqsl5K6iREUDSIMXDsY++Z4HGJk4mA8xCjBwawkwlvz60mq
 EG9KYmVValF+fFFpTmrxIUZpDhYlcd7VHcGpQgLpiSWp2ampBalFMFkmDk6pBsao2K9zNlXa
 /svSWbh4o/D9juIsm4u7RLPb1GbtOKiWspfZmU2hOev/udq/1+ZYRhw6XvX0mTp7gptiugjL
 4taJ0upHK6ZGNhU/ZD/04rLIgT38Hxo5F+8t8xGedVcyxi120Yp1n2KrK/98P7Zn+/0Te+Xf
 hvGevbElpMZ9c6xN/9PO4xdkGjqUWIozEg21mIuKEwGnfsMjdAIAAA==
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

We need to differ between PCL-070 and PCM-070. PCL-070 supports 2GHz RAM
timings from pcb rev 1 or newer. PCM-070 supports 2GHz RAM timings from
pcb rev 3 or newer.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/phycore_imx8mp/spl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index d38f6368fe36..df158024654e 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -46,8 +46,10 @@ void spl_dram_init(void)
 	if (!ret)
 		phytec_print_som_info(NULL);
 
-	ret = phytec_get_rev(NULL);
-	if (ret >= 3 && ret != PHYTEC_EEPROM_INVAL) {
+	u8 rev = phytec_get_rev(NULL);
+	u8 somtype = phytec_get_som_type(NULL);
+
+	if (rev != PHYTEC_EEPROM_INVAL && (rev >= 3 || (somtype == SOM_TYPE_PCL && rev >= 1))) {
 		dram_timing.ddrc_cfg[3].val = 0x1323;
 		dram_timing.ddrc_cfg[4].val = 0x1e84800;
 		dram_timing.ddrc_cfg[5].val = 0x7a0118;

-- 
2.34.1

