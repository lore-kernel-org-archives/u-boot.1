Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8ECD39432
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 14:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4938C83CF5;
	Thu,  2 Apr 2026 16:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="rJ6PE71e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB5983D8A; Thu,  2 Apr 2026 16:39:32 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 by phobos.denx.de (Postfix) with ESMTP id 9014B839DF
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 16:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1775140762;
 bh=rMcf3Wptn2ecwhk96mr/GjI3Zc8NvFJ6//paLdTMVQg=;
 h=From:To:CC:Subject:Date:From;
 b=rJ6PE71eLXb/I940eC/L4kSD8v+exg9XdCE/ZGNfBXkBzDfcI9XESwhGxs3C33zxg
 DrCm6NmiKU/reKm5PGZPREdIlNH1DyteX+pJXQvHG9ntMBibw+2478YSRvDODcFhZf
 XaJWYRIUV0cbGlMmwzxtVsMOEvKZ8FIq6EGUQZEFTFK55iJP2+MwVGw0H+CJEHj0ms
 zZ/GOaXQbomvehYAXBmsqz0evxD/A5hYItOUd/GsOwmBfESIsu0g5cWkd/e20xoXOm
 dJuYuwINH4Q6pdHxIAFJb7N+Fmsa3WsDYHLbvLAnSL7s6iFpBkzG9NsjOfut2ceIjd
 575h6Zl/YE+lA==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Peng Fan
 <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V2] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
Date: Thu, 2 Apr 2026 16:37:53 +0200
Message-ID: <20260402143753.40142-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Currently, the board specific code evaluates only the first Ethernet
MAC address fuse, regardless of whether the first or second MAC
address is requested. When the function for determine the second
Ethernet MAC address is looking for the fused MAC address, it only
reads the first MAC address fuse and increment it by one to set
the second Ethernet MAC address. That is not the expected behavior
when two MAC addresses are fused, because this causes the second
fused MAC address to be ignored. Change this so that the second
fused MAC address will be used.

In addition, the handling of the MAC address for early prototypes
will be removed, as such SoMs were not used by customers.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Cc: Marek Vasut <marex@nabladev.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
V2: - Change the commit message to be more precise
    - Move index to the end of parameters to be consistent to the STM32MP plattform
    - Remove fallback where the first MAC address fuse incremented by one is used
    - Remove MAC Adress treatmeant for early prototypes
---
 board/dhelectronics/common/dh_imx.c             |  4 ++--
 board/dhelectronics/common/dh_imx.h             |  3 ++-
 board/dhelectronics/dh_imx6/dh_imx6.c           |  2 +-
 .../dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c | 17 +++--------------
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/board/dhelectronics/common/dh_imx.c b/board/dhelectronics/common/dh_imx.c
index 3d6487dd0d8..50404a66f9d 100644
--- a/board/dhelectronics/common/dh_imx.c
+++ b/board/dhelectronics/common/dh_imx.c
@@ -10,13 +10,13 @@
 #include <net.h>
 #include "dh_imx.h"
 
-int dh_imx_get_mac_from_fuse(unsigned char *enetaddr)
+int dh_imx_get_mac_from_fuse(unsigned char *enetaddr, int index)
 {
 	/*
 	 * If IIM fuses contain valid MAC address, use it.
 	 * The IIM MAC address fuses are NOT programmed by default.
 	 */
-	imx_get_mac_from_fuse(0, enetaddr);
+	imx_get_mac_from_fuse(index, enetaddr);
 	if (!is_valid_ethaddr(enetaddr))
 		return -EINVAL;
 
diff --git a/board/dhelectronics/common/dh_imx.h b/board/dhelectronics/common/dh_imx.h
index 284f8637fb8..be2ff5e076c 100644
--- a/board/dhelectronics/common/dh_imx.h
+++ b/board/dhelectronics/common/dh_imx.h
@@ -7,6 +7,7 @@
  * dh_imx_get_mac_from_fuse - Get MAC address from fuse and write it to env
  *
  * @enetaddr: buffer where address is to be stored
+ * @index: index of MAC address in fuse (starts with 0)
  * Return: 0 if OK, other value on error
  */
-int dh_imx_get_mac_from_fuse(unsigned char *enetaddr);
+int dh_imx_get_mac_from_fuse(unsigned char *enetaddr, int index);
diff --git a/board/dhelectronics/dh_imx6/dh_imx6.c b/board/dhelectronics/dh_imx6/dh_imx6.c
index 234824b38c2..c9e8107685a 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6.c
@@ -94,7 +94,7 @@ int dh_setup_mac_address(struct eeprom_id_page *eip)
 	if (dh_get_mac_is_enabled("ethernet0"))
 		return 0;
 
-	if (!dh_imx_get_mac_from_fuse(enetaddr))
+	if (!dh_imx_get_mac_from_fuse(enetaddr, 0))
 		goto out;
 
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 5c35a5bf447..a9153418314 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -50,7 +50,7 @@ static int dh_imx8_setup_ethaddr(struct eeprom_id_page *eip)
 	if (dh_get_mac_is_enabled("ethernet0"))
 		return 0;
 
-	if (!dh_imx_get_mac_from_fuse(enetaddr))
+	if (!dh_imx_get_mac_from_fuse(enetaddr, 0))
 		goto out;
 
 	if (!dh_get_value_from_eeprom_buffer(DH_MAC0, enetaddr, sizeof(enetaddr), eip))
@@ -75,8 +75,8 @@ static int dh_imx8_setup_eth1addr(struct eeprom_id_page *eip)
 	if (dh_get_mac_is_enabled("ethernet1"))
 		return 0;
 
-	if (!dh_imx_get_mac_from_fuse(enetaddr))
-		goto increment_out;
+	if (!dh_imx_get_mac_from_fuse(enetaddr, 1))
+		goto out;
 
 	if (!dh_get_value_from_eeprom_buffer(DH_MAC1, enetaddr, sizeof(enetaddr), eip))
 		goto out;
@@ -84,19 +84,8 @@ static int dh_imx8_setup_eth1addr(struct eeprom_id_page *eip)
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom1"))
 		goto out;
 
-	/*
-	 * Populate second ethernet MAC from first ethernet EEPROM with MAC
-	 * address LSByte incremented by 1. This is only used on SoMs without
-	 * second ethernet EEPROM, i.e. early prototypes.
-	 */
-	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
-		goto increment_out;
-
 	return -ENXIO;
 
-increment_out:
-	enetaddr[5]++;
-
 out:
 	return eth_env_set_enetaddr("eth1addr", enetaddr);
 }
-- 
2.30.2

