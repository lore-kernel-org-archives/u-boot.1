Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466B3C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 05:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A30688A35;
	Wed, 17 Jul 2024 07:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="oQbkWUCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4A8288A1B; Wed, 17 Jul 2024 07:12:00 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A58F888636
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 07:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1721193118; x=1723785118;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+VN4IeVfW2xED0Me22OEidK8inIIrbi0c3nCsKr0vi0=;
 b=oQbkWUCxwPNMJhOLlIz3xwdR5fbsDpzj2dJ/jbI19nkqL3DgOM+6HE6z8ScFBfn9
 hSGbN8UMjo5R0tnvglIShEpj1m+hC6rGMpEdziL9yxNl4/zUKe3Am2ynMfKBqc1A
 zr9NqGa+Qr+a+lFlrrl5GU7p29oo8J0NUl9TtRVyhYw=;
X-AuditID: ac14000a-03e52700000021bc-e9-6697529e264f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AF.7B.08636.E9257966;
 Wed, 17 Jul 2024 07:11:58 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 17 Jul
 2024 07:11:56 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <t.remmet@phytec.de>, <d-gole@ti.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 3/9] phycore_imx93: include common overlays.env
Date: Tue, 16 Jul 2024 22:11:28 -0700
Message-ID: <20240717051134.1538180-4-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240717051134.1538180-1-d.schultz@phytec.de>
References: <20240717051134.1538180-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBR3de0PQ0g3vHxC1a1npYTJ20md3i
 7d5Odovud+oOLB6vDqxi9zh7ZwejR393C6vH8RvbmQJYorhsUlJzMstSi/TtErgyzl3uYSxY
 K1Tx49NupgbGW/xdjJwcEgImEscnHGbuYuTiEBJYwiSx/ddtKOc+o8SFaU+YQarYBLQk7myZ
 C2aLCPhIHG3dzAJSxCzQySixft8CJpCEsICTxLSmZWA2i4CqxKXnq1m7GDk4eAWsJC4dCoXY
 Ji8x89J3dhCbU8BaYvHF2+wgJUJAJYcfBIKEeQUEJU7OfMICYjMDlTdvnc0MYUtIHHzxAswW
 ElCQmL1tMiPMyGnnXjND2KESW79sZ5rAKDQLyahZSEbNQjJqASPzKkah3Mzk7NSizGy9gozK
 ktRkvZTUTYygIBdh4NrB2DfH4xAjEwfjIUYJDmYlEd4JjNPShHhTEiurUovy44tKc1KLDzFK
 c7AoifOu7ghOFRJITyxJzU5NLUgtgskycXBKNTBWTbyX57U3/ZlM50nNKyoFQbPUN0QdSE3d
 3udXuX/jocQjphu1OQ5XbstT36w6J9Hy0PEJH00vTZA6Ms3Wd8r7VapCRovyLuy9uahpqejE
 mmNHON+tmrY39PvWn/+YVHYJHcw/m83hsuLFFGWRj2UuBV/r/7Y9XTyP46zVqssfLS9xTbX5
 bbc9V4mlOCPRUIu5qDgRAGdEVj9gAgAA
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

From: Benjamin Hahn <B.Hahn@phytec.de>

Include the common overlays env file for phycore_imx93.
The common overlays env file supports disabling loading overlays by
setting the no_overlays variable.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_imx93/phycore_imx93.env | 25 ++------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
index 27bfadfa140..09542f5aa7d 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 
+#include <env/phytec/overlays.env>
+
 image=Image
 console=ttyLP0
 fdt_addr=0x83000000
@@ -7,8 +9,6 @@ fdto_addr=0x830c0000
 bootenv_addr=0x83500000
 fdt_file=CONFIG_DEFAULT_FDT_FILE
 ip_dyn=yes
-bootenv=bootenv.txt
-mmc_load_bootenv=fatload mmc ${mmcdev}:${mmcpart} ${bootenv_addr} ${bootenv}
 mmcdev=CONFIG_SYS_MMC_ENV_DEV
 mmcpart=1
 mmcroot=2
@@ -17,16 +17,6 @@ mmcargs=setenv bootargs console=${console},${baudrate} earlycon
 	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
-mmc_load_overlay=fatload mmc ${mmcdev}:${mmcpart} ${fdto_addr} ${overlay}
-mmc_apply_overlays=
-	fdt address ${fdt_addr};
-	for overlay in ${overlays};
-	do;
-		if run mmc_load_overlay; then
-			fdt resize ${filesize};
-			fdt apply ${fdto_addr};
-		fi;
-	done;
 mmcboot=
 	echo Booting from mmc ...;
 	if run mmc_load_bootenv; then
@@ -42,17 +32,6 @@ mmcboot=
 nfsroot=/nfs
 netargs=setenv bootargs console=${console},${baudrate} earlycon
 	root=/dev/nfs ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
-net_load_bootenv=${get_cmd} ${bootenv_addr} ${bootenv}
-net_load_overlay=${get_cmd} ${fdto_addr} ${overlay}
-net_apply_overlays=
-	fdt address ${fdt_addr};
-	for overlay in ${overlays};
-	do;
-		if run net_load_overlay; then
-			fdt resize ${filesize};
-			fdt apply ${fdto_addr};
-		fi;
-	done;
 netboot=
 	echo Booting from net ...;
 	run netargs;
-- 
2.25.1

