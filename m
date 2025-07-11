Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4EFC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 23:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F21982F6A;
	Sat, 12 Jul 2025 01:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kOWZUJN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 559FA8277D; Sat, 12 Jul 2025 01:06:31 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E106E80FA8
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 01:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752275187; bh=z+F5vcX3o6ELBuy+dp5n8yN98EBgAQsrN4y5oHxi0fQ=;
 b=kOWZUJN3AfFX+TJUw0nH+XNkfeR0GCZgGRlq+p6ZFu/b+VCSqPys2HPzuGc6dVLb4qPiRYJcN
 dHx2J1fw/UKdZo3xlPQM2dUOcEdzJ9lm7u2OelzLSb1oXirVPhm/kvFDbBHoN2h6vH2W+G5uxdo
 Xem28JuFiCl05yHGFuXxa44Ht5EDwVTSKbH6UL1GPJLHaSjYstKuPbZ9rhG8yhvTRc5RDFU46cS
 cXg+0SNaqboeSHcdvjnTW6q1lH/7nIAt0YUVeNvKnlaO/YBZrXX/th3Ys55y9Bl6p1rH1U9obJG
 jTXLqnrS9ffEKr2f7bXtCoAjU4rBm7ATUdUup6QuAKAw==
X-Forward-Email-ID: 687198f126dc7c4d255622d2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/4] rockchip: spl: Add a read_brom_bootsource_id() helper
Date: Fri, 11 Jul 2025 23:06:04 +0000
Message-ID: <20250711230613.217996-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711230613.217996-1-jonas@kwiboo.se>
References: <20250711230613.217996-1-jonas@kwiboo.se>
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

The bootsource ids reported by BootROM of RK3576 for e.g. SPI NOR and
USB differs slightly compared to prior SoCs:

- Booting from sfc0 (ROCK 4D) report the normal bootsource id 0x3.
- Booting from sfc1 M1 (NanoPi M5) report a new bootsource id 0x23.
- Booting from sfc1 M0 has not been tested (no board using this config).
- Booting from USB report a new bootsource id 0x81.

Add a helper function to read the bootsource id. This helper function
will be used to translate the new values to the common BROM_BOOTSOURCE
enum values on RK3576.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/bootrom.h | 2 ++
 arch/arm/mach-rockchip/spl.c                 | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
index e736772fda75..b15938c021d6 100644
--- a/arch/arm/include/asm/arch-rockchip/bootrom.h
+++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
@@ -64,4 +64,6 @@ extern const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1];
  */
 #define BROM_BOOTSOURCE_ID_ADDR   (CFG_IRAM_BASE + 0x10)
 
+u32 read_brom_bootsource_id(void);
+
 #endif
diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index f4d29bbdd17e..1ce3a3b05547 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -31,6 +31,11 @@ int board_return_to_bootrom(struct spl_image_info *spl_image,
 __weak const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 };
 
+__weak u32 read_brom_bootsource_id(void)
+{
+	return readl(BROM_BOOTSOURCE_ID_ADDR);
+}
+
 const char *board_spl_was_booted_from(void)
 {
 	static u32 brom_bootsource_id_cache = BROM_BOOTSOURCE_UNKNOWN;
@@ -40,7 +45,7 @@ const char *board_spl_was_booted_from(void)
 	if (brom_bootsource_id_cache != BROM_BOOTSOURCE_UNKNOWN)
 		bootdevice_brom_id = brom_bootsource_id_cache;
 	else
-		bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
+		bootdevice_brom_id = read_brom_bootsource_id();
 
 	if (bootdevice_brom_id < ARRAY_SIZE(boot_devices))
 		bootdevice_ofpath = boot_devices[bootdevice_brom_id];
-- 
2.49.0

