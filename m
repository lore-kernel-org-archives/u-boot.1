Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A94CEFC53
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 20:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AFEA88EA7;
	Tue,  8 Oct 2024 22:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pR4GAipD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1EDB88EA7; Tue,  8 Oct 2024 22:06:56 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B6488EA7
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 22:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ecb7=RF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1728418008;
 bh=9yAM26XRVHcxgKKnAHfGR6+8ZGm5RzBcSn1deVKWVZg=;
 b=pR4GAipDHFi/HLx9qEx/Ve9ExFcvYcHCqyyEabRmtSMLQAlv/19Ufb3frARdToSGMLyI0Im6A
 /RkRMmDB5Q3An52O+55nCtknIPJQWM0DH0w5lXg1p3BLqBrcSGLbC82NjY8BfHCerXQgJH4CN4P
 uo6GctBNk/ycEn73d+IaRklC+xGiJ8jee6fiE6UqHgxn5Gvsm09R15FBdSFZCu6RonX5Tso1xPf
 Bb7E8UZn8baxdwKhj5U9IjVLM+lvCZvZrgKiUFHtXwxUgSgf168xZoc2bIP/XK8JB38Zb6s0ARG
 mRxegaDwXscZTzSA63DnRhMkrPpwHb5uHF9SMv/o5DVA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] board: rockchip: Add Hardkernel ODROID-M1S
Date: Tue,  8 Oct 2024 20:06:32 +0000
Message-ID: <20241008200641.2203023-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 670590d57d6a06543222dbe5
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

This series add support for the RK3566 based Hardkernel ODROID-M1S and
also correct the board compatible used for Hardkernel ODROID-M1.

Features tested on a ODROID-M1S 8GB rev1.0 20230906:
- SD-card boot
- eMMC boot
- Ethernet
- PCIe/NVMe
- USB gadget
- USB host

Changes in v2:
- Fix clean apply on master branch

Jonas Karlman (3):
  arm64: dts: rockchip: Correct vendor prefix for Hardkernel ODROID-M1
  arm64: dts: rockchip: Add Hardkernel ODROID-M1S
  board: rockchip: Add Hardkernel ODROID-M1S

 arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi    |   3 +
 arch/arm/mach-rockchip/rk3568/Kconfig         |   6 +
 board/hardkernel/odroid_m1s/Kconfig           |  12 +
 board/hardkernel/odroid_m1s/MAINTAINERS       |   6 +
 configs/odroid-m1s-rk3566_defconfig           |  93 +++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../src/arm64/rockchip/rk3566-odroid-m1s.dts  | 663 ++++++++++++++++++
 .../src/arm64/rockchip/rk3568-odroid-m1.dts   |   2 +-
 8 files changed, 785 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
 create mode 100644 board/hardkernel/odroid_m1s/Kconfig
 create mode 100644 board/hardkernel/odroid_m1s/MAINTAINERS
 create mode 100644 configs/odroid-m1s-rk3566_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-odroid-m1s.dts

-- 
2.46.2

