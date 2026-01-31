Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969B5E7C6F6
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 23:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F0D83B64;
	Sun,  1 Feb 2026 00:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="epiulyV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF22A83B86; Sun,  1 Feb 2026 00:39:09 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D87E783B43
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 00:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=19be=AF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769902745; bh=F35GNwWtYvzrjSH6ivkICpobK7F3SmOaYlNPyvnxO4M=;
 b=epiulyV/YVe9Iz5HgXpdVr8/eHDBHYkRdYOnYTpSGo1lggB+8JWX42rCacbv5kGeC7t9lF3J5
 BQbK56HDZAa4sV/NDVY2h55+7xtfZ8dSR6a5V2u1V80Pkh27qLpVkPihx/yyQXzFhqZ99aWK0wu
 nEqcxuL40LOyivOBRjblTjLaRb8YN77CxPz1Egcpe2icNFE2zNkEivNj2bq0CoJ8tyYc4KFr+iP
 6Bxr9ULgSHwESgHsye97FaTZxsOl77uqoGUNr/8/KqKlTzDwDjLpAzKADup4dK0qGGFOoGJh1rW
 X9QY1PZbd6c6k3F+c756b6tw0gULPhwljl4tDGQVKlJQ==
X-Forward-Email-ID: 697e9295de426c19931e04f8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 01/12] rockchip: spl: Add common handling of USB
 bootsource_id 0x81
Date: Sat, 31 Jan 2026 23:38:12 +0000
Message-ID: <20260131233843.3419737-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131233843.3419737-1-jonas@kwiboo.se>
References: <20260131233843.3419737-1-jonas@kwiboo.se>
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

Multiple newer Rockchip SoCs report 0x81 instead of 0xa when booting
from USB, i.e. on RK3576, RK3528, RK3506 and RV1106.

Move the bootsource_id 0x81 handling currently only used for RK3528 to
the common read_brom_bootsource_id() to reduce the need to override this
function when support for newer SoCs is introduced.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 arch/arm/mach-rockchip/rk3528/rk3528.c | 15 ---------------
 arch/arm/mach-rockchip/spl.c           | 12 +++++++++++-
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3528/rk3528.c b/arch/arm/mach-rockchip/rk3528/rk3528.c
index 57ead0006f1f..f9bfc445b857 100644
--- a/arch/arm/mach-rockchip/rk3528/rk3528.c
+++ b/arch/arm/mach-rockchip/rk3528/rk3528.c
@@ -49,21 +49,6 @@ void board_debug_uart_init(void)
 {
 }
 
-u32 read_brom_bootsource_id(void)
-{
-	u32 bootsource_id = readl(BROM_BOOTSOURCE_ID_ADDR);
-
-	/* Re-map the raw value read from reg to an existing BROM_BOOTSOURCE
-	 * enum value to avoid having to create a larger boot_devices table.
-	 */
-	if (bootsource_id == 0x81)
-		return BROM_BOOTSOURCE_USB;
-	else if (bootsource_id > BROM_LAST_BOOTSOURCE)
-		log_debug("Unknown bootsource %x\n", bootsource_id);
-
-	return bootsource_id;
-}
-
 int arch_cpu_init(void)
 {
 	u32 val;
diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index a9155dceedb4..e989c148079a 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -35,7 +35,17 @@ __weak const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 
 __weak u32 read_brom_bootsource_id(void)
 {
-	return readl(BROM_BOOTSOURCE_ID_ADDR);
+	u32 bootsource_id = readl(BROM_BOOTSOURCE_ID_ADDR);
+
+	/* Re-map the raw value read from reg to an existing BROM_BOOTSOURCE
+	 * enum value to avoid having to create a larger boot_devices table.
+	 */
+	if (bootsource_id == 0x81)
+		return BROM_BOOTSOURCE_USB;
+	else if (bootsource_id > BROM_LAST_BOOTSOURCE)
+		log_debug("Unknown bootsource %x\n", bootsource_id);
+
+	return bootsource_id;
 }
 
 const char *board_spl_was_booted_from(void)
-- 
2.52.0

