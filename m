Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EABCF34B9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 19:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B54488F08;
	Thu,  3 Oct 2024 21:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vWSfrlb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6976088F08; Thu,  3 Oct 2024 21:41:22 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D996288EAB
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 21:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a5dc=RA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1727984472;
 bh=Wh9ZvxdBZytjuLOXvduhswN4zdItzXLDhwWY12BcRt8=;
 b=vWSfrlb9nlJWShzdz8PLiB1dTjvy0RxSUhTeondD98apra3sHQHBmGseyrvEZ6zRx6Fj30QbA
 BUgZF2Qes/I6qC19c+TnqBoBDaR32oS/bFN4RIXlEWpXaAF0P1FPo6/zeCYl8ZlgyPkYjKubXIq
 V0FTa5mi6Mq2p8hkxznoPiZQszXzG15zKGiz1w38CdJv3EsfqaBwxbtNfwC4YtpZGJADoeAPFqe
 WueQgIRGiWYA6zWu2VckFJjZ7L1bvaw8YiUxVVhfxAdE3eLpuTHZByoXpbR8t02vJidW0PqgYRz
 XLLzcBj1BXR8PsVdqGQBoQV1Vc2SXLtO0VDbTacBju+g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] board: rockchip: Add Hardkernel ODROID-M1S
Date: Thu,  3 Oct 2024 19:40:50 +0000
Message-ID: <20241003194101.328231-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66fef3535caab3e1f31090aa
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

