Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61816C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 17:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD9B8801D;
	Fri, 15 Mar 2024 18:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xXthcJ77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C65688023; Fri, 15 Mar 2024 18:35:31 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D5788018
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 18:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4765=KW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1710524105;
 bh=yvoIXGg6BH9vQlnowd29mn7pw82dBgC49JJwrLRFB1g=;
 b=xXthcJ77VGyWIbUnU2I4ozJKPurbDJ6CT3oSSiLB586euaSQtZas2Ahod3iRlPUEcukggHuFM
 8S42L+IEOXFUi7ioZg3WXHz9KOl+XDfgzF98s3shEwFuwzJVIIX4QBjils+cOF++gbwtMrmU5ko
 hwr7L1XoV7QysiQCDOGLF/kIpf40KRcNr5BiP1aNkDydS4NyKTN/sNEnaRgZ+zrqJlpBc533g9E
 Rj1sSlUXKi99/ABt4b4NtFt/bC8ATlG+X542gx08Jf2AEyNENVuEVi+WEbkRclILOUY30gAwxMT
 XK1rwKJowZdx/jYsCJsvWnk0qPWxrrPBOFGYS6onb4bw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Christopher Obbard <chris.obbard@collabora.com>, Jonas Karlman
 <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] rockchip: spl: Cache boot source id for later use
Date: Fri, 15 Mar 2024 17:34:52 +0000
Message-ID: <20240315173454.2672509-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65f486c91148fd6640fdcecb
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

Rockchip BROM write a boot source id at CFG_IRAM_BASE + 0x10, the id
indicate from what storage media TPL/SPL was loaded from.

SPL use this value to determine what device "same-as-spl" represent when
determining from where FIT should be loaded. This works as long as the
boot_devices array contain a matching id <-> node path entry.

However, SPL typically load a small part of TF-A into SRAM and on RK3399
this overwrites the CFG_IRAM_BASE + 0x10 addr used for boot source id.

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

Use a static bootdevice_brom_id to cache the boot source id after an
initial read from SRAM to fix this, this allow spl_perform_fixups() to
resolve correct boot source path for "same-as-spl" after SPL have loaded
TF-A related FIT images into memory.

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

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/spl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index 1586a093fc37..27e996b504e7 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -32,9 +32,17 @@ __weak const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 
 const char *board_spl_was_booted_from(void)
 {
-	u32  bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
+	static u32 bootdevice_brom_id;
 	const char *bootdevice_ofpath = NULL;
 
+	if (!bootdevice_brom_id)
+		bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
+	if (!bootdevice_brom_id) {
+		debug("%s: unknown brom_bootdevice_id %x\n",
+		      __func__, bootdevice_brom_id);
+		return NULL;
+	}
+
 	if (bootdevice_brom_id < ARRAY_SIZE(boot_devices))
 		bootdevice_ofpath = boot_devices[bootdevice_brom_id];
 
-- 
2.43.2

