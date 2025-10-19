Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E60BCCD183
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 15:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA0DD800B6;
	Sun, 19 Oct 2025 17:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tE0F2AO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27601838C5; Sun, 19 Oct 2025 17:48:03 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6295D83211
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 17:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1760888879; bh=TLQ4zBFJMtMSleTGLZRhhA6dnBUiSXJfl1NoARqi45U=;
 b=tE0F2AO4SGlj3fxov9ic6sbnW/uoMZRAsCWn8HaZ7BqBtRO7zmm6z+6eXO+9ntkjVkt2kCFkW
 1SVQu3MxdKeJ6Gp7lDFdG+Vw8Yfs8T9v/Au2C1ZehTE6/MTcWq6K3ARUvxO5PALNPAC6QtFywpY
 2zFSgM3OpKJl1ctNskv7KQ0WbfGS1DI7kxXLvj8pXSZp2G3b1f4uiJSnjjb7F+Nijo/7OSptYP6
 mnuR2P5XzODZrYwMsuCGoXm6AG+CMVpYqyvuiQXftZlDNTPqCRc8ajEjr7tjSNAG780I37nGN4L
 fO78VDOt9XPbWIxqk5D4v3Bl390s6l8z75qMmP/BJBmQ==
X-Forward-Email-ID: 68f5082d5ea0c6742724318a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 2/5] rockchip: spl: Add a read_brom_bootsource_id() helper
Date: Sun, 19 Oct 2025 15:47:16 +0000
Message-ID: <20251019154728.846096-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019154728.846096-1-jonas@kwiboo.se>
References: <20251019154728.846096-1-jonas@kwiboo.se>
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

The bootsource ids reported by BootROM of RK3528 and RK3576 for e.g.
SPI NOR and USB differs slightly compared to prior SoCs:

- Booting from sfc0 (ROCK 4D) report the normal bootsource id 0x3.
- Booting from sfc1 M1 (NanoPi M5) report a new bootsource id 0x23.
- Booting from sfc1 M0 has not been tested (no board using this config).
- Booting from USB report a new bootsource id 0x81 on RK3528 and RK3576.

Add a helper function to read the bootsource id. This helper function
will be used to translate the new values to the common BROM_BOOTSOURCE
enum values on RK3528 and RK3576.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v4: No change
v3: Mention RK3528 in commit message
v2: No change
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
2.51.0

