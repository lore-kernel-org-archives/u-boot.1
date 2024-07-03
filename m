Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C4BC30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A5EF8884A;
	Wed,  3 Jul 2024 15:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZW+9bMzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87069887C6; Wed,  3 Jul 2024 07:42:37 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B4388784
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 07:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719985355; x=1722577355;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E2MeBmCR+979WKZye+Yzz2E0BVEH48+lzoVvqU9s8fQ=;
 b=ZW+9bMzK6xEw9Cs4MeVZ74ebfXMTPYmSZy4/keAihiyVvvBoJhh9wrY/9iuAxRFv
 BiXxZW9ST1Q1XudgijVKiWZ5rEBKRppRykYsn07wJVACTqtiIWE45rm2ojkHJGBx
 RNpiAY5MxnAy8JGEAH1FzLdmOw8eGWemsRI00FnBCXU=;
X-AuditID: ac14000a-03251700000021bc-6e-6684e4cbff34
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 42.7D.08636.BC4E4866;
 Wed,  3 Jul 2024 07:42:35 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 07:42:32 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <m.othacehe@gmail.com>, <joe.hershberger@ni.com>, <w.egorov@phytec.de>,
 <t.remmet@phytec.de>
CC: <d-gole@ti.com>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 3/9] phycore_imx93: include common overlays.env
Date: Tue, 2 Jul 2024 22:41:56 -0700
Message-ID: <20240703054202.2812540-4-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703054202.2812540-1-d.schultz@phytec.de>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWyRpKBR/f0k5Y0g22TZSxa1npYPLzqb/Fp
 52NWixk3p7FZvDg2l93i25ZtjBZTJ21mt3i7t5PdovudugOnx/sbrewesxsusnjsnHWX3ePV
 gVXsHmfv7GD06O9uYfW4fmY7k8fxG9uZAjiiuGxSUnMyy1KL9O0SuDLufn/EVvBXsOLk3nuM
 DYzr+bsYOTkkBEwk9h1/zdjFyMUhJLCESeLA1iNMEM49Rok3788xgVSxCWhJ3NkylxkkISKw
 jlFi7pVNYFXMAssYJc7NOMAGUiUsYC/x+MZrVhCbRUBF4t38mSwgNq+AlcSVg8cYIfbJS8y8
 9J0dxOYUsJaY/Ps50FQOoHVWEgv/mEOUC0qcnPkErJUZqLx562xmCFtC4uCLF2C2kICCxOxt
 k+FGTjv3mhnCDpXY+mU70wRGoVlIRs1CMmoWklELGJlXMQrlZiZnpxZlZusVZFSWpCbrpaRu
 YgRFkAgD1w7GvjkehxiZOBgPMUpwMCuJ8Eq9b04T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzru6
 IzhVSCA9sSQ1OzW1ILUIJsvEwSnVwLiM46uD0oMS8ac/8zLu3FQvuS+3VdYsarto8reQZVaG
 MdtZfdh0NDjtLr12Pv0nVUY6M3eRWGdDRdmNDckc3E6udczvGBxeTMzf+/ref6t9lht6f224
 8MIy5FGm1uSPh31CZ9rM+7mww0P3jmjk/DLvJzurnx9k2LtCqum1ANemiYIZJ54sW6zEUpyR
 aKjFXFScCADeNf+/jgIAAA==
X-Mailman-Approved-At: Wed, 03 Jul 2024 15:46:48 +0200
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

