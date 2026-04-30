Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A55CD13D2
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4079F841D7;
	Fri,  1 May 2026 00:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="sv6TL6/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87A39803C6; Fri,  1 May 2026 00:33:42 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511A2839D5
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 00:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=y2DsxBoY9Lh4nA2+rQ/dIkM1CtHEkxCkxWpYN6t8LbY=;
 b=sv6TL6/zVPbcArv+qjUECOSOom65GmIFL/6p/b1ACnmhZwp/gEnE9i1RfxuyDy9PAbYQ4+wHK6hBewEmRcdzx6JV4QZWmsSW2d6rGA/DNzKRcI9v/ggko96gs+EHi/Ft2IiTnuuihE+BQprSj+PZN0rdgkjWAq3WyFHmgvQ9ZwU=
Received: from lukas-hpz440workstation.lan.sk100508.local
 (193-80-178-216.hdsl.highway.telekom.at [193.80.178.216])
 by mail.netcube.li with ESMTPA ; Fri, 1 May 2026 00:33:40 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/6] sunxi: move SID MAC fallback from board env setup to
 EMAC read_rom_hwaddr
Date: Fri,  1 May 2026 00:33:00 +0200
Message-ID: <20260430223319.2663939-2-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430223319.2663939-1-lukas.schmid@netcube.li>
References: <20260430223319.2663939-1-lukas.schmid@netcube.li>
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

sunxi currently seeds ethaddr/ethXaddr in setup_environment() from SID.
That happens before Ethernet probe, so even with a clean persisted
environment we can populate env with a generated MAC and later get a
mismatch warning when DM Ethernet reads a different MAC from DT/NVMEM.

Stop generating Ethernet MAC env variables in setup_environment() and
provide SID-derived fallback addresses through read_rom_hwaddr in the
sunxi EMAC and designware eth drivers instead.

Also move the SID uniqueness/MAC derivation logic into shared sunxi arch
helpers so board code and drivers use one implementation and keep legacy
algorithm compatibility across SoCs.

This keeps the generic MAC source order (DT/NVMEM first, fallback second),
avoids board-level MAC policy special-casing, and prevents same-boot
env-vs-NVMEM mismatch warnings caused by early env seeding.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 arch/arm/include/asm/arch-sunxi/sys_proto.h |  6 ++
 arch/arm/mach-sunxi/cpu_info.c              | 44 ++++++++++++++
 board/sunxi/board.c                         | 64 +--------------------
 drivers/net/designware.c                    | 20 +++++++
 drivers/net/sun8i_emac.c                    | 15 +++++
 drivers/net/sunxi_emac.c                    | 15 +++++
 6 files changed, 102 insertions(+), 62 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/sys_proto.h b/arch/arm/include/asm/arch-sunxi/sys_proto.h
index 92c7721a530..6f70753e948 100644
--- a/arch/arm/include/asm/arch-sunxi/sys_proto.h
+++ b/arch/arm/include/asm/arch-sunxi/sys_proto.h
@@ -12,6 +12,12 @@
 
 void sdelay(unsigned long);
 
+/* Read SID and apply legacy/newer-SoC normalization for uniqueness. */
+bool sunxi_get_unique_sid(unsigned int *sid);
+
+/* Build legacy-compatible SID-derived locally administered MAC address. */
+bool sunxi_get_sid_mac_addr(int index, u8 mac[6]);
+
 /* return_to_fel() - Return to BROM from SPL
  *
  * This returns back into the BROM after U-Boot SPL has performed its initial
diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c
index c3a51d9956e..d804307e280 100644
--- a/arch/arm/mach-sunxi/cpu_info.c
+++ b/arch/arm/mach-sunxi/cpu_info.c
@@ -9,8 +9,10 @@
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
 #include <axp_pmic.h>
 #include <errno.h>
+#include <u-boot/crc.h>
 
 #ifdef CONFIG_MACH_SUN6I
 int sunxi_get_ss_bonding_id(void)
@@ -175,3 +177,45 @@ int sunxi_get_sid(unsigned int *sid)
 	return -ENODEV;
 #endif
 }
+
+bool sunxi_get_unique_sid(unsigned int *sid)
+{
+	if (sunxi_get_sid(sid) != 0)
+		return false;
+
+	if (!sid[0])
+		return false;
+
+	/*
+	 * On newer SoCs use a CRC over SID words 1..3 for better uniqueness,
+	 * while keeping the long-standing algorithm on older SoCs.
+	 */
+#if !defined(CONFIG_MACH_SUN4I) && !defined(CONFIG_MACH_SUN5I) && \
+	!defined(CONFIG_MACH_SUN6I) && !defined(CONFIG_MACH_SUN7I) && \
+	!defined(CONFIG_MACH_SUN8I_A23) && !defined(CONFIG_MACH_SUN8I_A33)
+	sid[3] = crc32(0, (unsigned char *)&sid[1], 12);
+#endif
+
+	/* Ensure the NIC-specific bytes are not all 0. */
+	if ((sid[3] & 0xffffff) == 0)
+		sid[3] |= 0x800000;
+
+	return true;
+}
+
+bool sunxi_get_sid_mac_addr(int index, u8 mac[6])
+{
+	unsigned int sid[4];
+
+	if (!sunxi_get_unique_sid(sid))
+		return false;
+
+	mac[0] = ((index & 0xf) << 4) | 0x02;
+	mac[1] = (sid[0] >>  0) & 0xff;
+	mac[2] = (sid[3] >> 24) & 0xff;
+	mac[3] = (sid[3] >> 16) & 0xff;
+	mac[4] = (sid[3] >>  8) & 0xff;
+	mac[5] = (sid[3] >>  0) & 0xff;
+
+	return true;
+}
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index d7722d1858a..4a7a3f0e08d 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -41,7 +41,6 @@
 #include <asm/gpio.h>
 #include <sunxi_gpio.h>
 #include <asm/io.h>
-#include <u-boot/crc.h>
 #include <env_internal.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
@@ -748,38 +747,6 @@ static void parse_spl_header(const uint32_t spl_addr)
 	env_set_hex("fel_scriptaddr", spl->fel_script_address);
 }
 
-static bool get_unique_sid(unsigned int *sid)
-{
-	if (sunxi_get_sid(sid) != 0)
-		return false;
-
-	if (!sid[0])
-		return false;
-
-	/*
-	 * The single words 1 - 3 of the SID have quite a few bits
-	 * which are the same on many models, so we take a crc32
-	 * of all 3 words, to get a more unique value.
-	 *
-	 * Note we only do this on newer SoCs as we cannot change
-	 * the algorithm on older SoCs since those have been using
-	 * fixed mac-addresses based on only using word 3 for a
-	 * long time and changing a fixed mac-address with an
-	 * u-boot update is not good.
-	 */
-#if !defined(CONFIG_MACH_SUN4I) && !defined(CONFIG_MACH_SUN5I) && \
-    !defined(CONFIG_MACH_SUN6I) && !defined(CONFIG_MACH_SUN7I) && \
-    !defined(CONFIG_MACH_SUN8I_A23) && !defined(CONFIG_MACH_SUN8I_A33)
-	sid[3] = crc32(0, (unsigned char *)&sid[1], 12);
-#endif
-
-	/* Ensure the NIC specific bytes of the mac are not all 0 */
-	if ((sid[3] & 0xffffff) == 0)
-		sid[3] |= 0x800000;
-
-	return true;
-}
-
 /*
  * Note this function gets called multiple times.
  * It must not make any changes to env variables which already exist.
@@ -788,37 +755,10 @@ static void setup_environment(const void *fdt)
 {
 	char serial_string[17] = { 0 };
 	unsigned int sid[4];
-	uint8_t mac_addr[6];
-	char ethaddr[16];
-	int i;
 
-	if (!get_unique_sid(sid))
+	if (!sunxi_get_unique_sid(sid))
 		return;
 
-	for (i = 0; i < 4; i++) {
-		sprintf(ethaddr, "ethernet%d", i);
-		if (!fdt_get_alias(fdt, ethaddr))
-			continue;
-
-		if (i == 0)
-			strcpy(ethaddr, "ethaddr");
-		else
-			sprintf(ethaddr, "eth%daddr", i);
-
-		if (env_get(ethaddr))
-			continue;
-
-		/* Non OUI / registered MAC address */
-		mac_addr[0] = (i << 4) | 0x02;
-		mac_addr[1] = (sid[0] >>  0) & 0xff;
-		mac_addr[2] = (sid[3] >> 24) & 0xff;
-		mac_addr[3] = (sid[3] >> 16) & 0xff;
-		mac_addr[4] = (sid[3] >>  8) & 0xff;
-		mac_addr[5] = (sid[3] >>  0) & 0xff;
-
-		eth_env_set_enetaddr(ethaddr, mac_addr);
-	}
-
 	if (!env_get("serial#")) {
 		snprintf(serial_string, sizeof(serial_string),
 			"%08x%08x", sid[0], sid[3]);
@@ -892,7 +832,7 @@ static void bluetooth_dt_fixup(void *blob)
 		for (i = 0; i < ETH_ALEN; ++i)
 			bdaddr[i] = tmp[ETH_ALEN - i - 1];
 	} else {
-		if (!get_unique_sid(sid))
+		if (!sunxi_get_unique_sid(sid))
 			return;
 
 		bdaddr[0] = ((sid[3] >>  0) & 0xff) ^ 1;
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 6ed9c6d538a..3d8e13031af 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -37,6 +37,8 @@
 #include <asm/arch/gmac.h>
 #endif
 
+bool sunxi_get_sid_mac_addr(int index, u8 mac[6]);
+
 static int dw_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
 {
 	struct dw_eth_dev *priv = dev_get_priv((struct udevice *)bus->priv);
@@ -842,6 +844,23 @@ int designware_eth_write_hwaddr(struct udevice *dev)
 	return _dw_write_hwaddr(priv, pdata->enetaddr);
 }
 
+static int designware_eth_read_rom_hwaddr(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	u8 mac[ARP_HLEN];
+
+	if (IS_ENABLED(CONFIG_ARCH_SUNXI)) {
+		if (!sunxi_get_sid_mac_addr(dev_seq(dev), mac))
+			return -ENODEV;
+
+		memcpy(pdata->enetaddr, mac, ARP_HLEN);
+
+		return 0;
+	}
+
+	return -ENOSYS;
+}
+
 static int designware_eth_bind(struct udevice *dev)
 {
 	if (IS_ENABLED(CONFIG_PCI)) {
@@ -1018,6 +1037,7 @@ const struct eth_ops designware_eth_ops = {
 	.free_pkt		= designware_eth_free_pkt,
 	.stop			= designware_eth_stop,
 	.write_hwaddr		= designware_eth_write_hwaddr,
+	.read_rom_hwaddr	= designware_eth_read_rom_hwaddr,
 };
 
 int designware_eth_of_to_plat(struct udevice *dev)
diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 41c52f56d7a..a267b6cd7f5 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -13,6 +13,7 @@
 #include <cpu_func.h>
 #include <log.h>
 #include <asm/cache.h>
+#include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
@@ -259,6 +260,19 @@ static int sun8i_eth_write_hwaddr(struct udevice *dev)
 	return 0;
 }
 
+static int sun8i_eth_read_rom_hwaddr(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	u8 mac[ARP_HLEN];
+
+	if (!sunxi_get_sid_mac_addr(dev_seq(dev), mac))
+		return -ENODEV;
+
+	memcpy(pdata->enetaddr, mac, ARP_HLEN);
+
+	return 0;
+}
+
 static void sun8i_adjust_link(struct emac_eth_dev *priv,
 			      struct phy_device *phydev)
 {
@@ -715,6 +729,7 @@ static int sun8i_emac_eth_probe(struct udevice *dev)
 
 static const struct eth_ops sun8i_emac_eth_ops = {
 	.start                  = sun8i_emac_eth_start,
+	.read_rom_hwaddr	= sun8i_eth_read_rom_hwaddr,
 	.write_hwaddr           = sun8i_eth_write_hwaddr,
 	.send                   = sun8i_emac_eth_send,
 	.recv                   = sun8i_emac_eth_recv,
diff --git a/drivers/net/sunxi_emac.c b/drivers/net/sunxi_emac.c
index 3dee849c97e..f45a0790a40 100644
--- a/drivers/net/sunxi_emac.c
+++ b/drivers/net/sunxi_emac.c
@@ -15,6 +15,7 @@
 #include <miiphy.h>
 #include <net.h>
 #include <asm/io.h>
+#include <asm/arch/sys_proto.h>
 #include <asm/arch/clock.h>
 #include <power/regulator.h>
 
@@ -539,6 +540,19 @@ static int sunxi_emac_eth_send(struct udevice *dev, void *packet, int length)
 	return _sunxi_emac_eth_send(priv, packet, length);
 }
 
+static int sunxi_emac_read_rom_hwaddr(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	u8 mac[ARP_HLEN];
+
+	if (!sunxi_get_sid_mac_addr(dev_seq(dev), mac))
+		return -ENODEV;
+
+	memcpy(pdata->enetaddr, mac, ARP_HLEN);
+
+	return 0;
+}
+
 static int sunxi_emac_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 {
 	struct emac_eth_dev *priv = dev_get_priv(dev);
@@ -581,6 +595,7 @@ static int sunxi_emac_eth_probe(struct udevice *dev)
 
 static const struct eth_ops sunxi_emac_eth_ops = {
 	.start			= sunxi_emac_eth_start,
+	.read_rom_hwaddr	= sunxi_emac_read_rom_hwaddr,
 	.send			= sunxi_emac_eth_send,
 	.recv			= sunxi_emac_eth_recv,
 	.stop			= sunxi_emac_eth_stop,
-- 
2.47.3


