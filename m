Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB72C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 02:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CBD9884A9;
	Fri, 28 Jun 2024 04:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719542899;
	bh=BKGRDZ8Nsi7ay1F0s0scHMN3TUuAKc5a1RjsV2Ocuyc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CMP/kMlFSIMRYTxgEUA1G7GrqaVhivpn1GMa9dUiZR47LDz/NwEdzC5+B6AZcNyhU
	 4dRX2D1NCps7Nq+FiryGDCp8NzACb+ZaOIOhhsbch+zOWsMJoeC4DUS+e2Hk+4RGxY
	 DN2nGhf0A8Vme3cMkfLU+J2qYfYn9PpCAXm4gwiLgGBnwh+oTUisBNj9kezy1sC8Wj
	 UeTnj5sEx/m741hnvmxRWXdkAAW5BYnYxLD9+B/zHGc5hyadMp49TDTDgvuXYn1grz
	 0pGBbJEv1lkQ/B68ihEItRNhDTH1U2x6wgpphm20fS9UQ+b3iZYiiJTtcvGaV0exFQ
	 itB4c0zd8tqZw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EA20687D40;
 Fri, 28 Jun 2024 04:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719542897;
 bh=BKGRDZ8Nsi7ay1F0s0scHMN3TUuAKc5a1RjsV2Ocuyc=;
 h=From:To:Cc:Subject:Date:From;
 b=YbdJfRfexPEA5OHqfHd0g2L8W6cEb8zLsNbeBsG7ZNweLqw4PQu3ofQrC69YB4whh
 LtSpvljqiMXOx1Jzx2mVHA6YD3GUX1et0Ly80zmmkIn0/D0dqVKMnyqF7xqHXZzga0
 NHAUto4oiO9Tjj5N8DqjA3aNuA7W0vuLXFPlndm0tieUfIb+rVZY5njHEgrxgxFHWD
 4X/diawf3MTORNL61U2v9dw/SqWntUvsn0ESu5NM38NvVxqwzOhPTSDDMmMIrEIi1a
 ay/nIoJKz2mrEzjHVr9Z6VStjWOkEg8nlEdUcxrk046LW0Z1+CySTEAIEfR65t1k7R
 1eFU+lUS3JWfg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH v2] spl: fit: List DTOs applied by SPL in U-Boot control DT
Date: Fri, 28 Jun 2024 04:47:57 +0200
Message-ID: <20240628024804.149871-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Insert /u-boot,spl-applied-dto-<dto-name> = <index> property into the
U-Boot control DT during SPL DTO application process. This can be used
by user to inspect which DTOs got applied by the SPL and in which order
from running U-Boot.

Example:
```
u-boot=> fdt addr $fdtcontroladdr && fdt list /
Working FDT set to aee9aeb0
/ {
        u-boot,spl-applied-dto-fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100 = <0x00000005>;
        u-boot,spl-applied-dto-fdt-dto-imx8mp-dhcom-som-overlay-rev100 = <0x00000004>;
        u-boot,spl-applied-dto-fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast = <0x00000003>;
        u-boot,spl-applied-dto-fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast = <0x00000002>;
...
```

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Suniel Mahesh <sunil@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
V2: - Expand the DT by one more byte to cater for trailing NUL byte
    - Update comment related to the expansion of DT
    - Flip the !ret conditional, which was incorrect and missed
    - Expand prefix to u-boot,spl-applied-dto-
    - Document the binding
---
 common/spl/spl_fit.c                | 29 +++++++++++++++++++++++++++--
 doc/device-tree-bindings/config.txt | 11 +++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 988125be008..0a6b5ea8212 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -363,6 +363,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 {
 	struct spl_image_info image_info;
 	int node, ret = 0, index = 0;
+	char dtoname[256];
 
 	/*
 	 * Use the address following the image as target address for the
@@ -448,9 +449,13 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 			if (ret < 0)
 				break;
 
-			/* Make room in FDT for changes from the overlay */
+			/*
+			 * Make room in FDT for changes from the overlay,
+			 * the overlay name and the trailing NUL byte in
+			 * that name.
+			 */
 			ret = fdt_increase_size(spl_image->fdt_addr,
-						image_info.size);
+						image_info.size + strlen(str) + 1);
 			if (ret < 0)
 				break;
 
@@ -464,6 +469,26 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 
 			debug("%s: DT overlay %s applied\n", __func__,
 			      fit_get_name(ctx->fit, node, NULL));
+
+			/*
+			 * Insert /u-boot,<dto-name> = <index> property into
+			 * the U-Boot control DT. This can be used by user
+			 * to inspect which DTOs got applied by the SPL from
+			 * a running U-Boot.
+			 */
+			snprintf(dtoname, sizeof(dtoname), "u-boot,spl-applied-dto-%s", str);
+			ret = fdt_setprop_u32(spl_image->fdt_addr, 0, dtoname,
+					      index);
+			if (ret) {
+				/*
+				 * The DTO itself was applied, do not treat the
+				 * insertion of /u-boot,<dto-name> as an error
+				 * so the system can possibly boot somehow.
+				 */
+				debug("%s: DT overlay %s name not inserted into / node (%d)\n",
+				      __func__,
+				      fit_get_name(ctx->fit, node, NULL), ret);
+			}
 		}
 		free(tmpbuffer);
 		if (ret)
diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
index f50c68bbdc3..7aa6d9a72c6 100644
--- a/doc/device-tree-bindings/config.txt
+++ b/doc/device-tree-bindings/config.txt
@@ -95,6 +95,17 @@ rootdisk-offset (int)
 silent-console (int)
 	If present and non-zero, the console is silenced by default on boot.
 
+u-boot,spl-applied-dto-* (int)
+	Emitted by SPL into U-Boot control DT root node in case a DTO from
+	fitImage was applied on top of U-Boot control DT by the SPL fitImage
+	loader. The single integer cell indicates in which order was the DTO
+	applied by the SPL and matches the index of the DTO in the fitImage.
+	DTOs in fitImage may be skipped using board_spl_fit_append_fdt_skip(),
+	therefore the integers might not be monotonically incrementing, there
+	may be gaps. This property can be used to determine which DTOs were
+	applied by the SPL from running U-Boot by inspecting the U-Boot
+	control DT.
+
 u-boot,spl-payload-offset (int)
 	If present (and SPL is controlled by the device-tree), this allows
 	to override the CONFIG_SYS_SPI_U_BOOT_OFFS setting using a value
-- 
2.43.0

