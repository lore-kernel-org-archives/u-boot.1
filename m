Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33890C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 21:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D90810F4;
	Tue, 22 Apr 2025 23:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="V4CpVwRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1673D810EB; Tue, 22 Apr 2025 23:12:31 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D0E80FF7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 23:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e320=XJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1745356347;
 bh=gI/ogYWKOCO/rSlztTaiduxtUXRvqPJzfepHyBI1PvM=;
 b=V4CpVwRfKlxsGIiAeoAnJk5Ix9j/zudp4tvdDqhk+hu+RpgrNSpfYy+WBVYmzH4PhPFDN2AEm
 9g1HaqTLPMp/f04xP8J0i9sJbYivKDBJ7fyLssXkPp2e01GFBS3imJBZDvq99UW3HoEyeMw4BRN
 bV+IFdRJJvoKX2eXipIr5Q0IQtdkCM0928p38f0SuPm2Cn7vI78vyDt59ptOB1VfLZRfH8C220i
 NZitcsrJE6cYKwHFMulgsVoho0QZnjF2ubNHCIZ/21JcpRLgzdlj0N2yxhQKa7gq9aPs3nWE8e2
 auG52HeL48NWM88tuKaKWu+aegyNjghPxeIvqY4hiMEg==
X-Forward-Email-ID: 68080637305f69a6701c5980
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] rockchip: rk3576: Add rng, checkboard() and ArmSoM Sige5
Date: Tue, 22 Apr 2025 21:12:05 +0000
Message-ID: <20250422211216.3727559-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
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

This is a follow-up series on top of the "Support for the RK3576" series.
It add support for rng, printing SoC variant and adds a generic and the
ArmSoM Sige5 board.

This series depends on the "rng: rockchip: Add support for rkrng
variant" [1] patch from the RK3528 series for functional rng use.

[1] https://patchwork.ozlabs.org/patch/2069696/

Jonas Karlman (4):
  rockchip: rk3576: Add rng node to u-boot.dtsi
  rockchip: rk3576: Implement checkboard() to print SoC variant
  board: rockchip: Add minimal generic RK3576 board
  board: rockchip: Add ArmSoM Sige5

 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi | 18 ++++++++
 arch/arm/dts/rk3576-generic-u-boot.dtsi      |  3 ++
 arch/arm/dts/rk3576-generic.dts              | 45 ++++++++++++++++++
 arch/arm/dts/rk3576-u-boot.dtsi              | 11 +++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS    | 11 +++++
 arch/arm/mach-rockchip/rk3576/rk3576.c       | 48 ++++++++++++++++++++
 configs/generic-rk3576_defconfig             | 41 +++++++++++++++++
 configs/sige5-rk3576_defconfig               | 48 ++++++++++++++++++++
 doc/board/rockchip/rockchip.rst              |  2 +
 9 files changed, 227 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-generic.dts
 create mode 100644 arch/arm/mach-rockchip/rk3576/MAINTAINERS
 create mode 100644 configs/generic-rk3576_defconfig
 create mode 100644 configs/sige5-rk3576_defconfig

-- 
2.49.0

