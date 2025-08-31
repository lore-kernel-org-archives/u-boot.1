Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB59DCA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 11:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4BB183937;
	Sun, 31 Aug 2025 13:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fW2Pu9bP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C77183936; Sun, 31 Aug 2025 13:21:19 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D58F683929
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 13:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0b89=3L=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756639275; bh=R3n8slMZWJxTNV4paci+DThdjKQkfD0bq2Mazoazxm0=;
 b=fW2Pu9bPRkwZQxqESUvHlqQ3GaXhlPqiRlAh/4yG5mgZrF214J1C9apDrS5LGXgeeOZJKhVaT
 O0+WOVHZ3DczYuSv5cBwbKGboB9GvjmwITkbq+w+LrmJTLq2p2Ty32XxxfVCK8XjV3dx6bD48XW
 QL8uKxYEgl8TKOnzUoHkBo0Rb47jsCWesuGLAkQC3ZSm7p0NLx9w1ELdBFcAvn/PETIHPWThAEn
 RGwo9TZtMCsdcfePG8e6F66/0R7Mh97rCYJD6D9k5IiI+5iyo7DFaenQUy/RMEjROEH1/6a6aKt
 gmxSb1wpF8w5jC1kT46iwPDkkRobiq1zYZzzG9g9mxHw==
X-Forward-Email-ID: 68b4302732f03f9a5e90865a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 03/10] rockchip: rk3528: Implement read_brom_bootsource_id()
Date: Sun, 31 Aug 2025 11:20:24 +0000
Message-ID: <20250831112046.2642363-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831112046.2642363-1-jonas@kwiboo.se>
References: <20250831112046.2642363-1-jonas@kwiboo.se>
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

