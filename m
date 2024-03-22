Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB7DC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 20:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED89881AB;
	Fri, 22 Mar 2024 21:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="SyKX0+ho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B128C881C1; Fri, 22 Mar 2024 21:50:59 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7B888198
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 21:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b79c=K5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711140641; bh=PWvzY0JqFJZc92ywfg6XSb6xGKIWwJEASsRCaaSRJ7E=;
 b=SyKX0+hoMEOx8lO6VV3GaM6pjYZKjfz42H7uN5BrC4Vrbl6jzj+DvTzZ4obbzpklCKTkQ+1LC
 kUwvoiDligQtFkC/4/uBQHHE/XQP+0aJ2XT75d1oHX7dkDx1jxDehlfTVTWvIe3pRkxlcUJOQRl
 PKDf1Tk9LwgecP1aSIDE/tOZ2/TYcrRjMinIEdOR98G19o7IeEJsvY+IA04BLsapOnuCeFCOW8b
 RcLTP5G+v/40V6kEQThpsHzCM7TlHT5xZO0BSY3LZYOFyDFl5gkJ64RXDRk2NcssiCIitXibGTv
 IQyxhID5J2YDQu++lUmVczRJ8hJrlkP4qZAf1l6dFX1A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Christopher Obbard <chris.obbard@collabora.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/3] rockchip: spl: Cache boot source id for later use
Date: Fri, 22 Mar 2024 20:50:21 +0000
Message-ID: <20240322205027.3860170-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240322205027.3860170-1-jonas@kwiboo.se>
References: <20240322205027.3860170-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65fdef201b2ab365f8308b26
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

Rockchip BROM writes a boot source id at CFG_IRAM_BASE + 0x10, this id
indicates from what storage media TPL/SPL was loaded from.

SPL uses this id to determine what device "same-as-spl" represent when
determining from where FIT should be loaded. This works as long as the
boot_devices array contain a matching id <-> node path entry.

However, SPL typically load a small part of TF-A into SRAM and on RK3399
this overwrites the CFG_IRAM_BASE + 0x10 addr used for boot source id.

For affected devices the u-boot,spl-boot-device would not be set when
booting from SPI flash and the flash@0 node was not explicitly listed
in the u-boot,spl-boot-order prop.

Here boot source id is 3 before FIT images is loaded, and 0 after:

  U-Boot SPL 2024.04-rc4 (Mar 15 2024 - 17:26:19 +0000)
  board_spl_was_booted_from: brom_bootdevice_id 3 maps to '/spi@ff1d0000/flash@0'
  Trying to boot from SPI
  ## Checking hash(es) for config config-1 ... OK
  ## Checking hash(es) for Image atf-1 ... sha256+ OK
  ## Checking hash(es) for Image u-boot ... sha256+ OK
  ## Checking hash(es) for Image fdt-1 ... sha256+ OK
  ## Checking hash(es) for Image atf-2 ... sha256+ OK
  ## Checking hash(es) for Image atf-3 ... sha256+ OK
  board_spl_was_booted_from: failed to resolve brom_bootdevice_id 0
  spl_decode_boot_device: could not find udevice for /mmc@fe330000
  spl_decode_boot_device: could not find udevice for /mmc@fe320000
  spl_perform_fixups: could not map boot_device to ofpath: -19

Use a static brom_bootsource_id_cache to save the boot source id after
an initial read from SRAM to fix this, this allow spl_perform_fixups()
to resolve correct boot source path for "same-as-spl" after SPL have
loaded TF-A related FIT images into memory.

With this the spl-boot-device prop can correctly be resolved to the
SPI flash node in the control FDT:

  => fdt addr ${fdtcontroladdr}
  Working FDT set to f1ee6710
  => fdt list /chosen
  chosen {
      u-boot,spl-boot-device = "/spi@ff1d0000/flash@0";
      stdout-path = "serial2:1500000n8";
      u-boot,spl-boot-order = "same-as-spl", "/mmc@fe330000", "/mmc@fe320000";
  };

Fixes: d57e16c7e712 ("rockchip: find U-boot proper boot device by inverting the logic that sets it")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2:
- Only cache boot source id that can be resolved to a node path
- Make use of the new BROM_BOOTSOURCE_UNKNOWN enum value
- Update commit message
- Add fixes tag
- Collect r-b tag
---
 arch/arm/mach-rockchip/spl.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index 1586a093fc37..3ce7e792b5a2 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -32,18 +32,26 @@ __weak const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 
 const char *board_spl_was_booted_from(void)
 {
-	u32  bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
+	static u32 brom_bootsource_id_cache = BROM_BOOTSOURCE_UNKNOWN;
+	u32 bootdevice_brom_id;
 	const char *bootdevice_ofpath = NULL;
 
+	if (brom_bootsource_id_cache != BROM_BOOTSOURCE_UNKNOWN)
+		bootdevice_brom_id = brom_bootsource_id_cache;
+	else
+		bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
+
 	if (bootdevice_brom_id < ARRAY_SIZE(boot_devices))
 		bootdevice_ofpath = boot_devices[bootdevice_brom_id];
 
-	if (bootdevice_ofpath)
+	if (bootdevice_ofpath) {
+		brom_bootsource_id_cache = bootdevice_brom_id;
 		debug("%s: brom_bootdevice_id %x maps to '%s'\n",
 		      __func__, bootdevice_brom_id, bootdevice_ofpath);
-	else
+	} else {
 		debug("%s: failed to resolve brom_bootdevice_id %x\n",
 		      __func__, bootdevice_brom_id);
+	}
 
 	return bootdevice_ofpath;
 }
-- 
2.43.2

