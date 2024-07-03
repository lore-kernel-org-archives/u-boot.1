Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9CDC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F3AC88851;
	Wed,  3 Jul 2024 15:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KAqnHbQR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F33788784; Wed,  3 Jul 2024 07:42:40 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8955F887C6
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 07:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719985358; x=1722577358;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qMM9g2ZmwbdyWxdPzVPE2xrJrHHseKgFYpkpA7EUD0E=;
 b=KAqnHbQRfhX8N8NZEd3K8K/Yrc2uDydsxm2FqIft9Eyt7w+T0YidBMRwoSPAdm7H
 a3LN5AaRso6EUY/j1hIyvvjXEMc4zqc0h9H+9/c1Aft5UklsdOf8gNx3c9H6TXh1
 t7rIkDbcp67jseJpfya4pc9yM2dnrrf2v0ZDW2f/ajI=;
X-AuditID: ac14000a-03251700000021bc-73-6684e4cef92f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 14.7D.08636.EC4E4866;
 Wed,  3 Jul 2024 07:42:38 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 07:42:35 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <m.othacehe@gmail.com>, <joe.hershberger@ni.com>, <w.egorov@phytec.de>,
 <t.remmet@phytec.de>
CC: <d-gole@ti.com>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 4/9] board: phytec: renaming of variables according to bootstd
 doc
Date: Tue, 2 Jul 2024 22:41:57 -0700
Message-ID: <20240703054202.2812540-5-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703054202.2812540-1-d.schultz@phytec.de>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWyRpKBR/fck5Y0g0+PpS1a1npYPLzqb/Fp
 52NWixk3p7FZvDg2l93i25ZtjBZTJ21mt3i7t5PdovudugOnx/sbrewesxsusnjsnHWX3ePV
 gVXsHmfv7GD06O9uYfW4fmY7k8fxG9uZAjiiuGxSUnMyy1KL9O0SuDL2TvnLVPBBoeLE8rMs
 DYynpbsYOTkkBEwknneuYwWxhQSWMEns2y3ZxcgFZN9jlFhzaTsjSIJNQEvizpa5zCAJEYF1
 jBJzr2xiAnGYBZYxSpybcYANpEpYIEhizsdTLCA2i4CKxLZjq5lBbF4BK4kzuzazQayTl5h5
 6Ts7iM0pYC0x+fdzoBoOoHVWEgv/mEOUC0qcnPkEbAwzUHnz1tnMELaExMEXL5ghLlWQmL1t
 MiPMyGnnXjND2KESW79sZ5rAKDQLyahZSEbNQjJqASPzKkah3Mzk7NSizGy9gozKktRkvZTU
 TYyg+BFh4NrB2DfH4xAjEwfjIUYJDmYlEV6p981pQrwpiZVVqUX58UWlOanFhxilOViUxHlX
 dwSnCgmkJ5akZqemFqQWwWSZODilGhh3zPo+92HIjMo3Ffzys7yCJi1nYTl6T7v/rOJSrS/6
 fkLf1s70eLY512bKQ6vKgh3yf1h6UrsML0j6BL4J+7xMckH3sfnWB2UnzP2waZ6Wt8rJ+K5+
 7wlb5XIOKv7gVFIo+TtZbOrhLbYnLVIWbX7zSyXsjI7p3ECDjbtkXbhem0S/r+WqiS1XYinO
 SDTUYi4qTgQAF6c09o0CAAA=
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

Rename existing environment variables according to the bootstd doc.
Renamed variables are fdto_addr, bootenv_addr, fdt_addr and
fdt_file.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 .../phytec/phycore_imx8mp/phycore_imx8mp.env  | 20 +++++++++----------
 board/phytec/phycore_imx93/phycore_imx93.env  | 20 +++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 4ed5dc7e272..f8f878e8f3a 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -17,17 +17,17 @@ bootcmd=
 		fi;
 	fi;
 console=ttymxc0,115200
-bootenv_addr=0x49100000
-fdto_addr=0x49000000
+bootenv_addr_r=0x49100000
+fdtoverlay_addr_r=0x49000000
 dofastboot=0
 emmc_dev=2
 fastboot_raw_partition_all=0 4194304
 fastboot_raw_partition_bootloader=64 8128
-fdt_addr=0x48000000
-fdt_file=CONFIG_DEFAULT_FDT_FILE
+fdt_addr_r=0x48000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
 ip_dyn=yes
-loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 mmcargs=
 	setenv bootargs console=${console}
@@ -37,13 +37,13 @@ mmcboot=
 	echo Booting from mmc ...;
 	if test ${no_bootenv} = 0; then
 		if run mmc_load_bootenv; then
-			env import -t ${bootenv_addr} ${filesize};
+			env import -t ${bootenv_addr_r} ${filesize};
 		fi;
 	fi;
 	run mmcargs;
 	if run loadfdt; then
 		run mmc_apply_overlays;
-		booti ${loadaddr} - ${fdt_addr};
+		booti ${loadaddr} - ${fdt_addr_r};
 	else
 		echo WARN: Cannot load the DT;
 	fi;
@@ -62,14 +62,14 @@ netboot=
 	fi;
 	if test ${no_bootenv} = 0; then
 		if run net_load_bootenv; then
-			env import -t ${bootenv_addr} ${filesize};
+			env import -t ${bootenv_addr_r} ${filesize};
 		fi;
 	fi;
 	${get_cmd} ${loadaddr} ${image};
 	run netargs;
-	if ${get_cmd} ${fdt_addr} ${fdt_file}; then
+	if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
 		run net_apply_overlays;
-		booti ${loadaddr} - ${fdt_addr};
+		booti ${loadaddr} - ${fdt_addr_r};
 	else
 		echo WARN: Cannot load the DT;
 	fi;
diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
index 09542f5aa7d..ab65cfce5fd 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -4,10 +4,10 @@
 
 image=Image
 console=ttyLP0
-fdt_addr=0x83000000
-fdto_addr=0x830c0000
-bootenv_addr=0x83500000
-fdt_file=CONFIG_DEFAULT_FDT_FILE
+fdt_addr_r=0x83000000
+fdtoverlay_addr_r=0x830c0000
+bootenv_addr_r=0x83500000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
 ip_dyn=yes
 mmcdev=CONFIG_SYS_MMC_ENV_DEV
 mmcpart=1
@@ -16,16 +16,16 @@ mmcautodetect=yes
 mmcargs=setenv bootargs console=${console},${baudrate} earlycon
 	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
-loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 mmcboot=
 	echo Booting from mmc ...;
 	if run mmc_load_bootenv; then
-		env import -t ${bootenv_addr} ${filesize};
+		env import -t ${bootenv_addr_r} ${filesize};
 	fi;
 	run mmcargs;
 	if run loadfdt; then
 		run mmc_apply_overlays;
-		booti ${loadaddr} - ${fdt_addr};
+		booti ${loadaddr} - ${fdt_addr_r};
 	else
 		echo WARN: Cannot load the DT;
 	fi;
@@ -41,12 +41,12 @@ netboot=
 		setenv get_cmd tftp;
 	fi;
 	if run net_load_bootenv; then
-		env import -t ${bootenv_addr} ${filesize};
+		env import -t ${bootenv_addr_r} ${filesize};
 	fi;
 	${get_cmd} ${loadaddr} ${image};
-	if ${get_cmd} ${fdt_addr} ${fdt_file}; then
+	if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
 		run net_apply_overlays;
-		booti ${loadaddr} - ${fdt_addr};
+		booti ${loadaddr} - ${fdt_addr_r};
 	else
 		echo WARN: Cannot load the DT;
 	fi;
-- 
2.25.1

