Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61227D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB3E84172;
	Thu,  8 Jan 2026 14:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GynV4GxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B6C841C2; Thu,  8 Jan 2026 14:36:26 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C11384189
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 14:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d19=7O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1767879378; bh=flwFhOrVeYXJUAATrmpELQp51/b7VjbATi4rW3jgcDM=;
 b=GynV4GxBLxKLcRCtzeEF8JVdxZmbnMcEoA1feUb0UWnYOZOu4SYxZuyGSaTVW6qQPX45puq7T
 /Hv4xlSnsOfRPXWajU+OcKpWbsaRCqKVPzECv06DKonsqLccj63LpWEiBUqCQW/pXKjQrQMHVX2
 gETZfJajB5nGSH0qWHKeN39oirokImnKp2aeeNlby6WIw4sjLP5KyHerX08sbP1M1ZU9/4EVQS/
 kdn1WASy5tkh1jX7sWtzrvm3v1HsAxeNmEWosFqBBNw9phAK9wXSouHKPfl5Q1mkzNUewKDjHOY
 AM9S15k9dioUP854gb7AK01rYVgIDtOobSzwSfCDQEJA==
X-Forward-Email-ID: 695fb2d02b5f20405ba817cb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.2.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] rockchip: rk3576: Allow pmu sram access for non-secure
 masters
Date: Thu,  8 Jan 2026 13:32:29 +0000
Message-ID: <20260108133234.4001390-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108133234.4001390-1-jonas@kwiboo.se>
References: <20260108133234.4001390-1-jonas@kwiboo.se>
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

The firewall block access to pmu sram for non-secure masters by default
after reset (0xffffbfff).

Change the pmu lookup configuration to match the default lookup config
for ddr and system sram (0xffff3fff) to allow loading TF-A using DMA.

Mainline TF-A will re-configure the firewall to use an even less
restrictive lookup (0xbffe3ff0), so this change is not expected to have
any real security implication.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3576/rk3576.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index a1e8a7572fa4..c17ba418ced5 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -26,6 +26,9 @@
 #define SYS_SGRF_SOC_CON15	0x005C
 #define SYS_SGRF_SOC_CON20	0x0070
 
+#define FW_PMU1SGRF_BASE	0x26003000
+#define PMU1SGRF_SLV_LOOKUP0	0x80
+
 #define FW_SYS_SGRF_BASE	0x26005000
 #define SGRF_DOMAIN_CON1	0x4
 #define SGRF_DOMAIN_CON2	0x8
@@ -140,6 +143,9 @@ int arch_cpu_init(void)
 	if (!IS_ENABLED(CONFIG_SPL_BUILD))
 		return 0;
 
+	/* Allow pmu sram access for non-secure masters */
+	writel(0xffff3fff, FW_PMU1SGRF_BASE + PMU1SGRF_SLV_LOOKUP0);
+
 	/* Set the emmc to access ddr memory */
 	val = readl(FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON2);
 	writel(val | 0x7, FW_SYS_SGRF_BASE + SGRF_DOMAIN_CON2);
-- 
2.52.0

