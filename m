Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBEDC52D7F
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECFD588BBF;
	Fri,  9 Aug 2024 11:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="l7aTOvaE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFCB388BC7; Fri,  9 Aug 2024 11:01:18 +0200 (CEST)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D27E788B89
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1723194060; bh=JErVyLTCWhwhVubkvx5OeggVbaPyV7cbUrscS23w24k=;
 h=From:To:Cc:Subject:Date;
 b=l7aTOvaExWfBkzgzIkWWv3fpLwXlLU/UPAp815mSlpXrmALHNrCaG0x7sT1g7Atx8
 wu1EYng7YuumMcUPGnYrtZo+40b7uuaK+uemZrv65jm9/gqNNE4dcJoz8tq05xv95Q
 lI7Nk+TrnqbDOxTI42a+BhvKog+cnS0NeEuStFPQ=
Received: from hyz-wsl.www.tendawifi.com ([166.111.226.87])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id EA28703C; Fri, 09 Aug 2024 16:58:34 +0800
X-QQ-mid: xmsmtpt1723193914ta5ffnfr8
Message-ID: <tencent_BD4B002FC63A5F77969D9BD1FFF125371C08@qq.com>
X-QQ-XMAILINFO: MRLc0g//fdpvJ0v/MGW+B84AEvfd4bfMQiw99sanuWvJ0wIZ+W8TGDLEf+VKuz
 GmUflhSa/qSVa6WS4hGqBW2gdYaOMz0pgHJlONczSgiM5q3wQ7DDdbaT7SbVTLgv4r6tWvBIMYk9
 AM7NOW6qkS5N8h3YLOy5H/wjDkC4SV7ls0B/fU7eWHIljbz/OWR8i4T+HvJY/hg8EZdF9oFRpQtB
 i9F5ZXCyotkBRXKhxvHs2gzL0mHbGatKackhXVQF8npAEuNhy6SN735VlnU0+nmlODNqH2U/xBlO
 erHGI9JhCcn7yn6ysxg0sOwXZQuTtBHdBzDbNREMZNpaG0fJMR/oVpGnud2gKj2PISEPuDGxtTve
 zvlcX50q3ke2nNw8bH5y+M8pNzxDBUXFtVdN9D17RPxvXAqBIYfFtaexlbJ3nz1Ro/aieJGccnQH
 IrBPHUD4tPgBTCKnZZbwNwzFVzrVQTNfps51h++WDi0dTID7dcZ9KbfjIV+t6jwQTRUHdt7m8xUl
 5Jf51fHAV4MT0hiw80ZJ+JTDURvsJ44JyrWVvMrHvU9d8h5hUmq50iUttY3zPUCaSg6oHG/yAjVI
 eKgpHPmyE8bPIEBIpyxuzci0S6nQGbGhvAVD8A2gpcvxsa/6ezrdyMvv75BnjR8yB4v69qfMsJ93
 lLRiaps/aaHL4EauLTl1mq76eSGCiGzIazLOxr5m+DIU0qgvyfaTeSXUrNAg9NO8ax4P3RcvH5VU
 CTL5KdtNYPhYMf9dUVfKJIH8q6RZqbND8cM4zGZ8C9pvtsGFxSE0r7n6UampUybDoN7jh/0YTBra
 GYbqxvzUTeMB2K0E+3D/jg67GQVjqveIBlmFbYBsUeY2BRVyaqPIKjH6ajXbnQ+wvP4EMbz2o59L
 zIx578p69RGJLtYsvUvA6zpMjwHFxrtGr+jjBXqD7vk91VeAh51T+z6AVkr7xyX4xBTZfOSfXUJY
 S9MnqpWoelVM8McFDL9Sag/ijJH173rHlm5kNKOBEJQT3DeiQgIYm42Pjc93PY
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>,
 Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
Subject: [PATCH 1/8] net: dc2114x: add support for platforms that don't have
 pci controllers
Date: Fri,  9 Aug 2024 16:56:54 +0800
X-OQ-MSGID: <20240809085701.22183-1-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
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

There're a few ethernet IP cores which have the same functions with dc2114x,
and can be connected to CPU by AXI or other buses. This commit adds support
for the platforms that do not have PCI controllers, using MMIO to communicate
with the dc2114x IP core.

Signed-off-by: Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
---
 drivers/net/Kconfig   |  8 ++++++++
 drivers/net/dc2114x.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 69ae7c0750..41b7c66105 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -740,6 +740,14 @@ config TULIP
 	help
 	  This driver supports DEC DC2114x Fast ethernet chips.
 
+config TULIP_SUPPORT_NON_PCI
+	bool "No PCI controller"
+	depends on TULIP
+	default n
+	help
+	  Say Y to this and you can run this driver on platforms that do not
+	  have PCI controllers.
+
 config XILINX_AXIEMAC
 	select PHYLIB
 	select MII
diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index ce028f451f..3704d2e655 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -72,7 +72,12 @@
 
 #define POLL_DEMAND	1
 
+#if CONFIG_IS_ENABLED(TULIP_SUPPORT_NON_PCI)
+#define phys_to_bus(dev, a)	virt_to_phys((volatile const void *)(a))
+#else
 #define phys_to_bus(dev, a)	dm_pci_phys_to_mem((dev), (a))
+#endif
+#endif
 
 #define NUM_RX_DESC PKTBUFSRX
 #define NUM_TX_DESC 1			/* Number of TX descriptors   */
@@ -461,11 +466,13 @@ static void read_hw_addr(struct dc2114x_priv *priv)
 	}
 }
 
+#if !CONFIG_IS_ENABLED(TULIP_SUPPORT_NON_PCI)
 static struct pci_device_id supported[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TULIP_FAST) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21142) },
 	{ }
 };
+#endif
 
 static int dc2114x_start(struct udevice *dev)
 {
@@ -474,8 +481,10 @@ static int dc2114x_start(struct udevice *dev)
 
 	memcpy(priv->enetaddr, plat->enetaddr, sizeof(plat->enetaddr));
 
+#if !CONFIG_IS_ENABLED(TULIP_SUPPORT_NON_PCI)
 	/* Ensure we're not sleeping. */
 	dm_pci_write_config8(dev, PCI_CFDA_PSM, WAKEUP);
+#endif
 
 	return dc21x4x_init_common(priv);
 }
@@ -485,8 +494,9 @@ static void dc2114x_stop(struct udevice *dev)
 	struct dc2114x_priv *priv = dev_get_priv(dev);
 
 	dc21x4x_halt_common(priv);
-
+#if !CONFIG_IS_ENABLED(TULIP_SUPPORT_NON_PCI)
 	dm_pci_write_config8(dev, PCI_CFDA_PSM, SLEEP);
+#endif
 }
 
 static int dc2114x_send(struct udevice *dev, void *packet, int length)
@@ -555,6 +565,8 @@ static int dc2114x_probe(struct udevice *dev)
 {
 	struct eth_pdata *plat = dev_get_plat(dev);
 	struct dc2114x_priv *priv = dev_get_priv(dev);
+
+#if !CONFIG_IS_ENABLED(TULIP_SUPPORT_NON_PCI)
 	u16 command, status;
 	u32 iobase;
 
@@ -576,9 +588,22 @@ static int dc2114x_probe(struct udevice *dev)
 	}
 
 	dm_pci_write_config8(dev, PCI_LATENCY_TIMER, 0x60);
+#endif
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(TULIP_SUPPORT_NON_PCI)
+static int dc2114x_of_to_plat(struct udevice *dev)
+{
+	struct eth_pdata *plat = dev_get_plat(dev);
+	struct dc2114x_priv *priv = dev_get_priv(dev);
+
+	plat->iobase = (phys_addr_t)map_physmem((phys_addr_t)devfdt_get_addr(dev), 0, MAP_NOCACHE);
+	priv->iobase = (void*)plat->iobase;
 
 	return 0;
 }
+#endif
 
 static const struct eth_ops dc2114x_ops = {
 	.start		= dc2114x_start,
@@ -589,9 +614,23 @@ static const struct eth_ops dc2114x_ops = {
 	.read_rom_hwaddr = dc2114x_read_rom_hwaddr,
 };
 
+#if CONFIG_IS_ENABLED(TULIP_SUPPORT_NON_PCI)
+static const struct udevice_id dc2114x_eth_ids[] = {
+	{ .compatible = "dec,dmfe" },
+	{ .compatible = "tulip,dmfe" },
+	{ .compatible = "dec,dc2114x" },
+	{ .compatible = "tulip,dc2114x" },
+	{ }
+};
+#endif
+
 U_BOOT_DRIVER(eth_dc2114x) = {
 	.name	= "eth_dc2114x",
 	.id	= UCLASS_ETH,
+#if CONFIG_IS_ENABLED(TULIP_SUPPORT_NON_PCI)
+	.of_match	= dc2114x_eth_ids,
+	.of_to_plat	= dc2114x_of_to_plat,
+#endif
 	.bind	= dc2114x_bind,
 	.probe	= dc2114x_probe,
 	.ops	= &dc2114x_ops,
@@ -599,4 +638,6 @@ U_BOOT_DRIVER(eth_dc2114x) = {
 	.plat_auto	= sizeof(struct eth_pdata),
 };
 
+#if !CONFIG_IS_ENABLED(TULIP_SUPPORT_NON_PCI)
 U_BOOT_PCI_DEVICE(eth_dc2114x, supported);
+#endif
-- 
2.39.2

