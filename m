Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B82AC54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 14:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA1787FDA;
	Thu, 14 Mar 2024 15:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XudFK8PI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC3B87FAD; Thu, 14 Mar 2024 15:44:11 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3105387F74
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 15:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710427448;
 bh=q/NrnUtf1yRXS+VnksdLBjk77JKF4zUyC+y9mpg1Tl4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XudFK8PIE9auD0B9dwSM632ZSgzHveVXk+euY95bwnSBXfllVlbUFFctfRzlILr/v
 kRzUu8BIfeKgnAhiam22UGked91TQjr0RX5kq0b9uTt2Ag2npgaPvc6XZfWp3+pkcx
 37CmsPk35O08Wnd+31hDaSo2dg6ZQ8QoFaMQ6fFk+pKZwLPe/A9CNGMYgippdvfRFc
 0EDPDljcQNZDGCkE6K48H0jbUL/BO63+H9uiXeaAK02l/e+Kz32eT48kj0hWnHuw5z
 Gh8Kr4g8fvlQ5GA92jbNH4MgD7RcRyiNmfIxIItiJjV2bcYOiu7hid1bzOOCIcz9Jo
 N3gzZRTYNJZQw==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1F5A837820F7;
 Thu, 14 Mar 2024 14:44:06 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@denx.de>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 2/3] rockchip: Add a board_gen_ethaddr() function
Date: Thu, 14 Mar 2024 10:43:47 -0400
Message-ID: <20240314144403.491850-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240314144403.491850-1-detlev.casanova@collabora.com>
References: <20240314144403.491850-1-detlev.casanova@collabora.com>
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

Set the MAC address based on the CPU ID only if the ethernet device has
no ROM or DT address set.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm/Kconfig                          |  1 +
 arch/arm/include/asm/arch-rockchip/misc.h |  1 +
 arch/arm/mach-rockchip/board.c            | 30 ++++++++++++++++++-----
 arch/arm/mach-rockchip/misc.c             | 22 ++++++++++++-----
 4 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 01d6556c42b..21b41675ef6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2003,6 +2003,7 @@ config ARCH_ROCKCHIP
 	select DM_SPI_FLASH
 	select DM_USB_GADGET if USB_DWC3_GADGET
 	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select NET_BOARD_ETHADDR
 	select OF_CONTROL
 	select MTD
 	select SPI
diff --git a/arch/arm/include/asm/arch-rockchip/misc.h b/arch/arm/include/asm/arch-rockchip/misc.h
index 4155af8c3b0..6e972de6279 100644
--- a/arch/arm/include/asm/arch-rockchip/misc.h
+++ b/arch/arm/include/asm/arch-rockchip/misc.h
@@ -10,5 +10,6 @@ int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
 			      const u32 cpuid_length,
 			      u8 *cpuid);
 int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length);
+int rockchip_gen_macaddr(int dev_num, u8 *mac_addr);
 int rockchip_setup_macaddr(void);
 void rockchip_capsule_update_board_setup(void);
diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 2620530e03f..283d3b9ed3a 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -296,8 +296,8 @@ int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 }
 #endif
 
-#ifdef CONFIG_MISC_INIT_R
-__weak int misc_init_r(void)
+#if IS_ENABLED(CONFIG_MISC_INIT_R) || IS_ENABLED(CONFIG_NET_BOARD_ETHADDR)
+static int set_cpuid(void)
 {
 	const u32 cpuid_offset = CFG_CPUID_OFFSET;
 	const u32 cpuid_length = 0x10;
@@ -309,10 +309,6 @@ __weak int misc_init_r(void)
 		return ret;
 
 	ret = rockchip_cpuid_set(cpuid, cpuid_length);
-	if (ret)
-		return ret;
-
-	ret = rockchip_setup_macaddr();
 
 	return ret;
 }
@@ -349,3 +345,25 @@ __weak int board_rng_seed(struct abuf *buf)
 	return 0;
 }
 #endif
+
+#if IS_ENABLED(CONFIG_MISC_INIT_R)
+__weak int misc_init_r(void)
+{
+	return set_cpuid();
+}
+#endif
+
+int board_gen_ethaddr(int dev_num, u8 *mac_addr)
+{
+	if (!IS_ENABLED(CONFIG_NET_BOARD_ETHADDR))
+		return 0;
+
+	if (!env_get("cpuid#")) {
+		int err = set_cpuid();
+
+		if (err)
+			return err;
+	}
+
+	return rockchip_gen_macaddr(dev_num, mac_addr);
+}
diff --git a/arch/arm/mach-rockchip/misc.c b/arch/arm/mach-rockchip/misc.c
index 7d03f0c2b67..9c7b04ee5a8 100644
--- a/arch/arm/mach-rockchip/misc.c
+++ b/arch/arm/mach-rockchip/misc.c
@@ -21,14 +21,13 @@
 
 #include <asm/arch-rockchip/misc.h>
 
-int rockchip_setup_macaddr(void)
+int rockchip_gen_macaddr(int dev_num, u8 *mac_addr)
 {
 #if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
 	int ret;
 	const char *cpuid = env_get("cpuid#");
 	u8 hash[SHA256_SUM_LEN];
 	int size = sizeof(hash);
-	u8 mac_addr[6];
 
 	/* Only generate a MAC address, if none is set in the environment */
 	if (env_get("ethaddr"))
@@ -51,15 +50,26 @@ int rockchip_setup_macaddr(void)
 	/* Make this a valid MAC address and set it */
 	mac_addr[0] &= 0xfe;  /* clear multicast bit */
 	mac_addr[0] |= 0x02;  /* set local assignment bit (IEEE802) */
-	eth_env_set_enetaddr("ethaddr", mac_addr);
 
-	/* Make a valid MAC address for ethernet1 */
-	mac_addr[5] ^= 0x01;
-	eth_env_set_enetaddr("eth1addr", mac_addr);
+	/* Make a valid MAC address for the given device number */
+	mac_addr[5] ^= dev_num;
 #endif
 	return 0;
 }
 
+int rockchip_setup_macaddr(void)
+{
+	u8 mac_addr[6];
+
+	if (rockchip_gen_macaddr(0, mac_addr) == 0)
+		eth_env_set_enetaddr("ethaddr", mac_addr);
+
+	if (rockchip_gen_macaddr(1, mac_addr) == 0)
+		eth_env_set_enetaddr("eth1addr", mac_addr);
+
+	return 0;
+}
+
 int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
 			      const u32 cpuid_length,
 			      u8 *cpuid)
-- 
2.43.2

