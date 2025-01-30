Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B341FC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 22:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C9580C77;
	Thu, 30 Jan 2025 23:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PWYIrEKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 455D580C77; Thu, 30 Jan 2025 23:07:34 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D578807FB
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 23:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2de8=UX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1738274849;
 bh=jZVHQO59wv4HLrcEZ7kaux7m9KmPS3qxZdeFc2d4OmE=;
 b=PWYIrEKdzo1y6YvCCD0q9BWFb1qH3hYh3fut+oM+A+84V5A5WhfKE1BvSbGyduM10yYqzmoPX
 mK3sysfnJvEm4Pli8tdwnzkuv2nmHb3BdSxZe6B5695BNHTh4tFRlK2WwVevvBR2RiDGXHIlFC/
 25tg62NEbLCek2IzVwSp7+FqPllspVVr2FCK1+1Xw1HUdp/K2TlbGWs3o8u4Ub/ybOv+QLwEUuh
 C2W/WC00fr6JKwzHa/XJXkGH00gd0wZk9NAz8z2FzUNyl+Hm901roLjABUEDDohiCJ922EGd4XV
 UNsPuhhLqL66iVf6yA5LXtIdDc7KRpTsz30C53IBYO4g==
X-Forward-Email-ID: 679bf81c2d70e7e05883f26b
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
Subject: [PATCH v3 0/3] rockchip: sdram: Fix issues observed on RK3576
Date: Thu, 30 Jan 2025 22:07:10 +0000
Message-ID: <20250130220718.2428421-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
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

Most Rockchip AArch64 SoCs have start of DRAM at 0x0. However, the
RK3576 instead has start of DRAM at 0x40000000 and can extend continuous
beyond the 4 GiB mark.

This series fixes issues observed on a Rockchip RK3576 board testing
Heiko's RK3576 series [1].

Changes in v3:
- Fix 32-bit overflow limiting usable ram_top to max 4G

Changes in v2:
- Drop duplicate patch
- Add patch to limit gd->ram_top to max 4G
- Add patch to assign gd->ram_base in SPL
- Collect r-b tag

[1] https://patchwork.ozlabs.org/cover/2013854/

Jonas Karlman (3):
  rockchip: sdram: Allow the first bank to extend beyond 4 GiB
  rockchip: sdram: Limit usable ram_top to max 4G
  rockchip: sdram: Ensure ram_base is correct in SPL

 arch/arm/mach-rockchip/sdram.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.48.1

