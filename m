Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8A2C0218F
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 22:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BCD880F96;
	Sun, 26 Jan 2025 23:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="heegGJsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A4D80F10; Sun, 26 Jan 2025 23:50:11 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACB2180FBC
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 23:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ca7d=UT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737931805; bh=D18+bwsZh6gW2nQSJ2+vV45ZuZRUoTPl7C5ysYjvTgo=;
 b=heegGJsUt0zrHxnG2NZhRgQUDNqeSl7spXiEhbU7U+VCllXCEiHlb0s9IcGn8ifeJ1VnDRWKP
 c5sPd7Sh+96YsW58Bj3wEAa2NLPpTJjooPUvCLse733kELGZUOcEA2HG+AcA/UUg2LSG/OVK+94
 bT4Xm0iUukZdt34FXWaM4bwGmaz7Lh2nvmWMJRTLRY/6fujbwxADbe+00pRNGoIa1od3pPMq45n
 U8I8pGpCOpyMVXqtLTkLXGOYV+M9/fFYjaIgbmmUoda1FakkX7gT3YZ9cKtvt5NtBgzqOhhvx0u
 Px0RdWP5Gc1Pj6IlPNOY/A7E5pvhe5lxzyEX5Kv+ZJ0A==
X-Forward-Email-ID: 6796bc1a4079df9fc6c0d031
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/3] rockchip: sdram: Ensure ram_base is correct in SPL
Date: Sun, 26 Jan 2025 22:49:42 +0000
Message-ID: <20250126224948.544633-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250126224948.544633-1-jonas@kwiboo.se>
References: <20250126224948.544633-1-jonas@kwiboo.se>
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

Most Rockchip SoCs use 0x0 as DRAM base address, however some SoCs use
0x60000000 and RK3576 use 0x40000000 as DRAM base address.

CFG_SYS_SDRAM_BASE is defined with correct address for each SoC and
U-Boot proper use this to set correct gd->ram_base in setup_dest_addr().

SPL never assign any value to gd->ram_base and instead use the default,
0x0. Set correct gd->ram_base in dram_init() to ensure its correctness
in SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 arch/arm/mach-rockchip/sdram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 08deebb765f0..2092821002a8 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -479,6 +479,7 @@ int dram_init(void)
 		debug("Cannot get DRAM size: %d\n", ret);
 		return ret;
 	}
+	gd->ram_base = ram.base;
 	gd->ram_size = ram.size;
 	debug("SDRAM base=%lx, size=%lx\n",
 	      (unsigned long)ram.base, (unsigned long)ram.size);
-- 
2.48.1

