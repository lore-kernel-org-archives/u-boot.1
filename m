Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F10C108B8E9
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 10:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4046D83FA4;
	Fri, 20 Mar 2026 11:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="cLVXIroL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C9083FC5; Fri, 20 Mar 2026 11:32:00 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 by phobos.denx.de (Postfix) with ESMTP id B209883E36
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 11:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1774002711;
 bh=tB3ZLuSjmO72sLrWlQPA1EuUGiKdsOg2ApFMNdS28/s=;
 h=From:To:CC:Subject:Date:From;
 b=cLVXIroLEdTLXFY1J5Mbk8tsXyCX/mk1DBY4Tdnp/6lxEe9anSDF4UYxdjDXwsBId
 JHTEwWn4KCHDdkauccukK9JNjmNZfAnzsIuEaFgtRS8xDqcg2NYmlDZWdtVZ7/s/pH
 y7J9bzhvrFnmRxl7E1cn4URDVBKdGIO4aIfS0dmVLWDx3kGzbvYb8tZzKFa/ms73Jw
 2dQftupbiBNajgepPsZm7QcvSIj3RI98rVcN+OV6GhfRr0PFtUM9gOgU0ra0hlRv2z
 J/eRI9SANCX4G3Zszdw+soxiXDzDaQq45d/3V5rsAc+XSauq0crUW0IWxSRMkX/69j
 575oEt68u1lzw==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Marek Vasut
 <marex@nabladev.com>, Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also from
 fuse
Date: Fri, 20 Mar 2026 11:29:18 +0100
Message-ID: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
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

When two Ethernet MAC addresses are fused, the first MAC address
is incremented by one and used for the second MAC address. This
causes the second fused MAC address to be ignored. Change this
so that the second fused MAC address will be used.
Keep the old behavior if there isn't any second Ethernet MAC
defined and only the first MAC address is fused but not the
second. In this case use the fused MAC address incremented by
one, for the second MAC address.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Marek Vasut <marex@nabladev.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
 board/dhelectronics/common/dh_imx.c               |  4 ++--
 board/dhelectronics/common/dh_imx.h               |  3 ++-
 board/dhelectronics/dh_imx6/dh_imx6.c             |  2 +-
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c | 13 ++++++++++---
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/board/dhelectronics/common/dh_imx.c b/board/dhelectronics/common/dh_imx.c
index 3d6487dd0d8..308cdb5b002 100644
--- a/board/dhelectronics/common/dh_imx.c
+++ b/board/dhelectronics/common/dh_imx.c
@@ -10,13 +10,13 @@
 #include <net.h>
 #include "dh_imx.h"
 
-int dh_imx_get_mac_from_fuse(unsigned char *enetaddr)
+int dh_imx_get_mac_from_fuse(int dev_id, unsigned char *enetaddr)
 {
 	/*
 	 * If IIM fuses contain valid MAC address, use it.
 	 * The IIM MAC address fuses are NOT programmed by default.
 	 */
-	imx_get_mac_from_fuse(0, enetaddr);
+	imx_get_mac_from_fuse(dev_id, enetaddr);
 	if (!is_valid_ethaddr(enetaddr))
 		return -EINVAL;
 
diff --git a/board/dhelectronics/common/dh_imx.h b/board/dhelectronics/common/dh_imx.h
index 284f8637fb8..cb51a2f6eb2 100644
--- a/board/dhelectronics/common/dh_imx.h
+++ b/board/dhelectronics/common/dh_imx.h
@@ -6,7 +6,8 @@
 /*
  * dh_imx_get_mac_from_fuse - Get MAC address from fuse and write it to env
  *
+ * @dev_id: index of MAC address in fuse (starts with 0)
  * @enetaddr: buffer where address is to be stored
  * Return: 0 if OK, other value on error
  */
-int dh_imx_get_mac_from_fuse(unsigned char *enetaddr);
+int dh_imx_get_mac_from_fuse(int dev_id, unsigned char *enetaddr);
diff --git a/board/dhelectronics/dh_imx6/dh_imx6.c b/board/dhelectronics/dh_imx6/dh_imx6.c
index 234824b38c2..5806a03ed17 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6.c
@@ -94,7 +94,7 @@ int dh_setup_mac_address(struct eeprom_id_page *eip)
 	if (dh_get_mac_is_enabled("ethernet0"))
 		return 0;
 
-	if (!dh_imx_get_mac_from_fuse(enetaddr))
+	if (!dh_imx_get_mac_from_fuse(0, enetaddr))
 		goto out;
 
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 5c35a5bf447..60d1e05b77f 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -50,7 +50,7 @@ static int dh_imx8_setup_ethaddr(struct eeprom_id_page *eip)
 	if (dh_get_mac_is_enabled("ethernet0"))
 		return 0;
 
-	if (!dh_imx_get_mac_from_fuse(enetaddr))
+	if (!dh_imx_get_mac_from_fuse(0, enetaddr))
 		goto out;
 
 	if (!dh_get_value_from_eeprom_buffer(DH_MAC0, enetaddr, sizeof(enetaddr), eip))
@@ -75,8 +75,8 @@ static int dh_imx8_setup_eth1addr(struct eeprom_id_page *eip)
 	if (dh_get_mac_is_enabled("ethernet1"))
 		return 0;
 
-	if (!dh_imx_get_mac_from_fuse(enetaddr))
-		goto increment_out;
+	if (!dh_imx_get_mac_from_fuse(1, enetaddr))
+		goto out;
 
 	if (!dh_get_value_from_eeprom_buffer(DH_MAC1, enetaddr, sizeof(enetaddr), eip))
 		goto out;
@@ -92,6 +92,13 @@ static int dh_imx8_setup_eth1addr(struct eeprom_id_page *eip)
 	if (!dh_get_mac_from_eeprom(enetaddr, "eeprom0"))
 		goto increment_out;
 
+	/*
+	 * If only the first MAC address is fused but not the second, use the
+	 * fused MAC address incremented by one, for the second MAC address.
+	 */
+	if (!dh_imx_get_mac_from_fuse(0, enetaddr))
+		goto increment_out;
+
 	return -ENXIO;
 
 increment_out:
-- 
2.30.2

