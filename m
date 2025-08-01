Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEEBC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 17:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5258883AD5;
	Fri,  1 Aug 2025 19:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pcJjiccF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A2B83AAD; Fri,  1 Aug 2025 19:09:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8095D83ACA
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 19:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754068186; bh=+dzRedqHHgcAOc9qW2j1rh3kJ5IFysiflLLscFIYPf8=;
 b=pcJjiccF3p8molh69u2PWy0WbQ/RRUaZKvgzjlC2DsPDeicrkLRE14GYetQNBlxIxbbJA/skQ
 aMVUZiXXBnuxkx02DYOwrgBBFnub93+v17EuhZdLvyPTFuzosoXGuek/Rbjtp7LuB6Sclbj6EdU
 vmjRZe9PndxNjejlJHpSdWvGzb/vD1F9CyNz+d9dL5V9FACF9C+Q4cAeelgKps8m4AolVvPzx+x
 FkEftYBT3lMOZ3SktUgNJgmbYXcANUJA0Ybg0AfR7RQY+RFALN1flBrJ4nYruF2uERJCNrTUXH6
 jBsSilhioyFGJyWLrdgDXn24CtboIT2hTzxkgTlyJdqw==
X-Forward-Email-ID: 688cf4d6ba56726f0787e06b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/2] rockchip: sdram: Add rockchip_sdram_type() helper
Date: Fri,  1 Aug 2025 17:09:27 +0000
Message-ID: <20250801170933.2530191-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801170933.2530191-1-jonas@kwiboo.se>
References: <20250801170933.2530191-1-jonas@kwiboo.se>
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

Add a helper function based on rockchip_sdram_size() that return what
DRAM type is used on current running board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 arch/arm/include/asm/arch-rockchip/sdram.h |  3 +++
 arch/arm/mach-rockchip/sdram.c             | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/include/asm/arch-rockchip/sdram.h b/arch/arm/include/asm/arch-rockchip/sdram.h
index 4fb45ac5c76e..476fc1c4ee33 100644
--- a/arch/arm/include/asm/arch-rockchip/sdram.h
+++ b/arch/arm/include/asm/arch-rockchip/sdram.h
@@ -87,6 +87,9 @@ enum {
 #define SYS_REG_CS1_COL_SHIFT(ch)		(0 + (ch) * 2)
 #define SYS_REG_CS1_COL_MASK			3
 
+/* Get sdram type decode from reg */
+u8 rockchip_sdram_type(phys_addr_t reg);
+
 /* Get sdram size decode from reg */
 size_t rockchip_sdram_size(phys_addr_t reg);
 
diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 3bc482331c7e..d560f90e873d 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -345,6 +345,21 @@ int dram_init_banksize(void)
 	return 0;
 }
 
+u8 rockchip_sdram_type(phys_addr_t reg)
+{
+	u32 dram_type, version;
+	u32 sys_reg2 = readl(reg);
+	u32 sys_reg3 = readl(reg + 4);
+
+	dram_type = (sys_reg2 >> SYS_REG_DDRTYPE_SHIFT) & SYS_REG_DDRTYPE_MASK;
+	version = (sys_reg3 >> SYS_REG_VERSION_SHIFT) & SYS_REG_VERSION_MASK;
+	if (version >= 3)
+		dram_type |= ((sys_reg3 >> SYS_REG_EXTEND_DDRTYPE_SHIFT) &
+			      SYS_REG_EXTEND_DDRTYPE_MASK) << 3;
+
+	return dram_type;
+}
+
 size_t rockchip_sdram_size(phys_addr_t reg)
 {
 	u32 rank, cs0_col, bk, cs0_row, cs1_row, bw, row_3_4;
-- 
2.50.1

