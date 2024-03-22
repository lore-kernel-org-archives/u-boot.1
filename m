Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B17AC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 20:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4197987FA3;
	Fri, 22 Mar 2024 21:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ST3KInCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25FF7881A4; Fri, 22 Mar 2024 21:51:04 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37C4087D87
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 21:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b79c=K5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711140645; bh=NoDoQKlj7JBwulc6I408/l7zRXgO/lcmXSjyfKOTv60=;
 b=ST3KInCfVk3RZy0mZrkodghB8qxFnZoqRKnboI57l4eNp/YVJ6uvgI2amhQZ5HJ0B4wHguV92
 SMncClMt+Bb1B5Tm2e009+y+e2aJQmLvruCSb0BbSjDdGxfHv6JHSYmFYWrot4mv0nk+BiWyEoK
 +oZW2l2xcjLi0GS7A8dHUwldbcL0zy2pMy8s2+F3i6UUgUjvMUc2E5/BiuUueBtXrUeOYfgqp5h
 YAcqdU+T3Hmx8ZR+9rSBXElV2vrnSvLPtTn/s1NSJg0L9l/tiNv+NOcmDtxxHm9av/WiaPw7tBJ
 lZ270GhnCN0jXKRYIuJxyu3lxVYebzPK4AeU5WucxX1w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Christopher Obbard <chris.obbard@collabora.com>, Dragan Simic
 <dsimic@manjaro.org>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/3] rockchip: spl: Add SPI NOR flash to boot_devices array
Date: Fri, 22 Mar 2024 20:50:22 +0000
Message-ID: <20240322205027.3860170-4-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 65fdef241b2ab365f8308b3d
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

Add missing boot source id <-> device tree node path mapping for SPI NOR
flash on PX30, RK3288, RK3308, RK3368 and RV1126.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- New patch
---
 arch/arm/mach-rockchip/px30/px30.c     | 1 +
 arch/arm/mach-rockchip/rk3288/rk3288.c | 1 +
 arch/arm/mach-rockchip/rk3308/rk3308.c | 1 +
 arch/arm/mach-rockchip/rk3368/rk3368.c | 1 +
 arch/arm/mach-rockchip/rv1126/rv1126.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
index b4f655fa4b3e..2ec3289d75b7 100644
--- a/arch/arm/mach-rockchip/px30/px30.c
+++ b/arch/arm/mach-rockchip/px30/px30.c
@@ -19,6 +19,7 @@
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff390000",
+	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff3a0000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@ff370000",
 };
 
diff --git a/arch/arm/mach-rockchip/rk3288/rk3288.c b/arch/arm/mach-rockchip/rk3288/rk3288.c
index c77c56c1dab5..70cf50029121 100644
--- a/arch/arm/mach-rockchip/rk3288/rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/rk3288.c
@@ -28,6 +28,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff0f0000",
+	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff130000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@ff0c0000",
 };
 
diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
index 27a748327e31..b3ffabc5449a 100644
--- a/arch/arm/mach-rockchip/rk3308/rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
@@ -141,6 +141,7 @@ enum {
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff490000",
+	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff4c0000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@ff480000",
 };
 
diff --git a/arch/arm/mach-rockchip/rk3368/rk3368.c b/arch/arm/mach-rockchip/rk3368/rk3368.c
index 651ba1090206..8f5ca1dfa7c9 100644
--- a/arch/arm/mach-rockchip/rk3368/rk3368.c
+++ b/arch/arm/mach-rockchip/rk3368/rk3368.c
@@ -55,6 +55,7 @@ struct mm_region *mem_map = rk3368_mem_map;
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff0f0000",
+	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff120000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@ff0c0000",
 };
 
diff --git a/arch/arm/mach-rockchip/rv1126/rv1126.c b/arch/arm/mach-rockchip/rv1126/rv1126.c
index 8589c46f10aa..40eb9eb7b196 100644
--- a/arch/arm/mach-rockchip/rv1126/rv1126.c
+++ b/arch/arm/mach-rockchip/rv1126/rv1126.c
@@ -15,6 +15,7 @@
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@ffc50000",
+	[BROM_BOOTSOURCE_SPINOR] = "/spi@ffc90000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@ffc60000",
 };
 
-- 
2.43.2

