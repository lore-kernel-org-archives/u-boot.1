Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A36AC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 22:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D447480F0B;
	Thu, 30 Jan 2025 23:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BdXtJ7f0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED80E80EFB; Thu, 30 Jan 2025 23:07:45 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9648680F0B
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 23:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2de8=UX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1738274861; bh=mKKRNBMCvxcIEB7f3CvRqPLZ24spGNvpDDW/wParJ1o=;
 b=BdXtJ7f0FVNFwEseAIEaZ/cIGcn1DBdYf+WHTohHlqGdqHdY9B6KxE4sZVxljYHoiNrJjY4ic
 ufHkHnC9EMXCz2a7mHuqrue1wAWPmeyp5U1rIjfv6/9D0j3Mtu2ab8A+kK45OUgWsNDrWqstXqR
 /2dCzdA+qP9yNj7QHgSkoOjlw5W23wcdBWh0kFktpoBdpSHXhFOkrzg5UoNYkDbCNQCqRJErf7J
 YNXjhE6pU/zoEHt+H6U5jKK2aB+OVzDmPvse9e3yT7dp+snNs783lrJq6TlJ/sfblLOGMFrm3+x
 Fn4Sf5ecBvKzb22ZLfPl02SgF3dyOLF3JUvvFggpEGCg==
X-Forward-Email-ID: 679bf8292d70e7e05883f2aa
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
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
Subject: [PATCH v3 3/3] rockchip: sdram: Ensure ram_base is correct in SPL
Date: Thu, 30 Jan 2025 22:07:13 +0000
Message-ID: <20250130220718.2428421-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130220718.2428421-1-jonas@kwiboo.se>
References: <20250130220718.2428421-1-jonas@kwiboo.se>
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
v3: No change
v2: New patch
---
 arch/arm/mach-rockchip/sdram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 4b8b6b9da7c5..f7d32829295c 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -478,6 +478,7 @@ int dram_init(void)
 		debug("Cannot get DRAM size: %d\n", ret);
 		return ret;
 	}
+	gd->ram_base = ram.base;
 	gd->ram_size = ram.size;
 	debug("SDRAM base=%lx, size=%lx\n",
 	      (unsigned long)ram.base, (unsigned long)ram.size);
-- 
2.48.1

