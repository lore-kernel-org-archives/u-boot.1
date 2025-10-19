Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4782CCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 15:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 971AF838C5;
	Sun, 19 Oct 2025 17:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="chlHll3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EBD5838D5; Sun, 19 Oct 2025 17:48:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A997E838AE
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 17:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1760888884; bh=PR20KvarefrHwg2p/5W5m7uzhoXnZallFWzu4di1W7E=;
 b=chlHll3bpUt0vKBmPdMoggpQqUBC63y/XHPlziLJoRmnBc3/Mr1t6g0c71b0V1H1Ob0KWArGZ
 ZYwgB4V80r4fEWrFXSpEfKdPdpHT/dKtz5WW+dEf8UlXmnrNfuZ5hYOFetO6U4JTB0o4wv4vVxu
 S5VgulgHcBi5H2p9VIrstg/t4bbOdSb8d3/S0R3C8yKReTIJNtxBQqy6BsNRs7L35H5HUeiHA36
 /xACqht17roR67/BytPy0ou9uWEaFnYpizBeNXuCfT4oovP3bOFFqDc2c7ALCacSW0We+Ajje5g
 b14eXmf8iW8F7ST+TxfPWEAQVqvsrJlcDn7MtIpUPyIg==
X-Forward-Email-ID: 68f508305ea0c674272431c5
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
Subject: [PATCH v4 3/5] rockchip: rk3528: Implement read_brom_bootsource_id()
Date: Sun, 19 Oct 2025 15:47:17 +0000
Message-ID: <20251019154728.846096-4-jonas@kwiboo.se>
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

The bootsource ids reported by BootROM of RK3528 for e.g. USB differs
compared to prior SoCs:

- Booting from USB report a new bootsource id 0x81.

Add a RK3528 specific read_brom_bootsource_id() function to help decode
this new bootsource id value to help support booting from USB on RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v4: No change
v3: New patch to map USB bootsource id on RK3528
---
 arch/arm/mach-rockchip/rk3528/rk3528.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3528/rk3528.c b/arch/arm/mach-rockchip/rk3528/rk3528.c
index f9bfc445b857..57ead0006f1f 100644
--- a/arch/arm/mach-rockchip/rk3528/rk3528.c
+++ b/arch/arm/mach-rockchip/rk3528/rk3528.c
@@ -49,6 +49,21 @@ void board_debug_uart_init(void)
 {
 }
 
+u32 read_brom_bootsource_id(void)
+{
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
+}
+
 int arch_cpu_init(void)
 {
 	u32 val;
-- 
2.51.0

