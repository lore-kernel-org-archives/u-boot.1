Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA69D5E37F
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 21:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 113E989235;
	Sat,  9 Nov 2024 22:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fc1plNpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1367389312; Sat,  9 Nov 2024 22:04:50 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A9AD88E4B
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 22:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ff=SF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1731186278;
 bh=Hd2S5AHgn7liTYOYzQSPGAs9WmUXIBYmuJ9KpzNQAXE=;
 b=fc1plNpEquHtNCkG8mpcjE9UZO1NWlZVgNxyuzN9ejIC28wZQyBWQs6XLcJtiyQoIONyRtTp7
 ex7aNUeMgVtSJWbEKrWFAQTbk7+VGxEDSXn1dY4wc0hEpYhjJvnRkPDlrbmRwgaC6STlb+OeBEy
 06rRBTebbDfGDBAmG8HcvQ//XJ4o0c++Xr/u5qKb+w2PyMuj0YQTPkygntQVyi2WFZJq0XRI1PV
 BRSKZyo4ZWfd7X+KXqb7SvlRU+wA7xt5koU7EJjL46X8IfnDKXw5Vf+TnoYq2nkQjg0HSRnDR27
 FyVfZDSV05egY/njlbksbTCF+foFSj8a2+PE9gv+4qfA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/4] rockchip: rk3288: Include files from dts/upstream
Date: Sat,  9 Nov 2024 21:04:08 +0000
Message-ID: <20241109210427.884888-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672fce65ebcd1468e2815bbc
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

This series remove common rk3288 related device tree files that instead
can be included directly from dts/upstream.

No functional change to board DTs is intended with these removals.

Changes in v2:
- Keep code for use of gmac internal clock source
- Collect r-b tags

Jonas Karlman (4):
  rockchip: rk3288: Use rk3288-power.h from dts/upstream
  rockchip: clk: rk3288: Drop use of SCLK_MAC_PLL
  rockchip: rk3288: Use rk3288-cru.h from dts/upstream
  rockchip: rk3288: Use rk3288.dtsi from dts/upstream

 arch/arm/dts/rk3288-u-boot.dtsi               |    9 -
 arch/arm/dts/rk3288.dtsi                      | 2035 -----------------
 .../clock/rockchip,rk3288-cru.txt             |   61 -
 drivers/clk/rockchip/clk_rk3288.c             |    8 +-
 include/dt-bindings/clock/rk3288-cru.h        |  381 ---
 include/dt-bindings/power/rk3288-power.h      |   32 -
 6 files changed, 4 insertions(+), 2522 deletions(-)
 delete mode 100644 arch/arm/dts/rk3288.dtsi
 delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
 delete mode 100644 include/dt-bindings/clock/rk3288-cru.h
 delete mode 100644 include/dt-bindings/power/rk3288-power.h

-- 
2.46.2

