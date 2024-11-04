Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78351D1BDF3
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 20:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D386588E50;
	Mon,  4 Nov 2024 21:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wAqVav9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5840288E96; Mon,  4 Nov 2024 21:59:24 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B0D88360
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 21:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72d1=SA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1730753954;
 bh=3DWBD54k1XumreQSoVHLdsorqNPJTQCslga0peKo/2M=;
 b=wAqVav9H1CGRACjB1bQ1s5WFyibGdeTaS9Jxx736KbDo+E52nmMr3JI6T/k91LSlNaW+Rzi5D
 UwiDzoH/9K78J7JVwcfe39XCcYHpE5yF3qT7yWnrvPP2zJ7CddAsTjc6qvKqqrTyu4dumOHGYhN
 KPQMp98lLT1sF37Rf0wtRD4y6biZ/xl7v6YM6vyNegMAeVtUYvy2nyUtDRUpuVJq0iQkTmxvHKR
 8GEiwnf0T5fGCO0/tC4hHDkRHAHFGgqH8TcSOUNK6qHqkZGoswM6k2+M2FpgnyVR1XvxcacNQ8/
 1Kl5c05TCxcWhreZ3sioMGZCtDyEaQZm5uHQ/xw1/E3A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] rockchip: rk3288: Include files from dts/upstream
Date: Mon,  4 Nov 2024 20:58:57 +0000
Message-ID: <20241104205906.986837-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672935a069a511a84def5ef7
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

Jonas Karlman (3):
  rockchip: rk3288: Use rk3288-power.h from dts/upstream
  rockchip: rk3288: Use rk3288-cru.h from dts/upstream
  rockchip: rk3288: Use rk3288.dtsi from dts/upstream

 arch/arm/dts/rk3288-u-boot.dtsi               |    9 -
 arch/arm/dts/rk3288.dtsi                      | 2035 -----------------
 .../clock/rockchip,rk3288-cru.txt             |   61 -
 drivers/clk/rockchip/clk_rk3288.c             |    2 +
 include/dt-bindings/clock/rk3288-cru.h        |  381 ---
 include/dt-bindings/power/rk3288-power.h      |   32 -
 6 files changed, 2 insertions(+), 2518 deletions(-)
 delete mode 100644 arch/arm/dts/rk3288.dtsi
 delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
 delete mode 100644 include/dt-bindings/clock/rk3288-cru.h
 delete mode 100644 include/dt-bindings/power/rk3288-power.h

-- 
2.46.2

