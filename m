Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F46C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 22:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F4218277D;
	Sat, 12 Jul 2025 00:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="q5HzSqys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF7A4828A2; Sat, 12 Jul 2025 00:21:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8526B81FEE
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 00:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1752272499;
 bh=D1gAUJfFyGEgIS8ovE1VDzlHQW3o/tSzs60I1zOa+a0=;
 b=q5HzSqysztxm1V5nW6XHiom3KpiK8LWsVxuBg8FuQEGGxYdghjYBxiY389TWOQpMIsL3103/A
 CXXAzuWc3XpWMatTyaimSR+vGPDIRauoS0710z7C05aHj2V4QcLOFB0m6zKTtRE30cUOqCFnZK0
 +gJMDFMXRpQeApbehUgiZWMUfSJEZThxsBEt9MLP5pm8X7ccsWNePRh4kq1zOZKaIh3TftY2eNu
 TpZ/b+lMYJXIJMntK5bQ49iUdZFmKf3wcN4L05vOxgD7kFR4KRal4BD389phHaXejqjpCbMFDfq
 fKbuIcQDYo0zb04o2dlQ6woJuye12ob1KV9ZyztAkLjg==
X-Forward-Email-ID: 68718e7126dc7c4d2555fcc1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/6] rockchip: rk3576: Add rng,
 checkboard() and generic board
Date: Fri, 11 Jul 2025 22:21:15 +0000
Message-ID: <20250711222132.204344-1-jonas@kwiboo.se>
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
It adds support for RNG, USB PID, a generic board and printing of the
running SoC variant.

Changes in v2:
- Add RNG node by picking a commit from devicetree-rebasing
- Add compatible for RK3576 to RNG driver
- Add default USB_GADGET_PRODUCT_NUM for RK3576
- Add USB OTG nodes to the minimal generic RK3576 board
- Split the checkboard() patch in two
- Split out the ArmSoM Sige5 patch into a separate series

Jonas Karlman (5):
  rng: rockchip_rng: Add compatible for RK3576
  rockchip: Add default USB_GADGET_PRODUCT_NUM for RK3576
  board: rockchip: Add minimal generic RK3576 board
  rockchip: rk3576: Implement checkboard() to print SoC variant
  arm: dts: rockchip: Include OTP in U-Boot pre-reloc phase for RK3576

Nicolas Frattaroli (1):
  arm64: dts: rockchip: add RK3576 RNG node

 arch/arm/dts/rk3576-generic-u-boot.dtsi     |  3 +
 arch/arm/dts/rk3576-generic.dts             | 65 +++++++++++++++++++++
 arch/arm/dts/rk3576-u-boot.dtsi             |  4 ++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS   |  5 ++
 arch/arm/mach-rockchip/rk3576/rk3576.c      | 48 +++++++++++++++
 configs/generic-rk3576_defconfig            | 51 ++++++++++++++++
 doc/board/rockchip/rockchip.rst             |  1 +
 drivers/rng/rockchip_rng.c                  |  4 ++
 drivers/usb/gadget/Kconfig                  |  1 +
 dts/upstream/src/arm64/rockchip/rk3576.dtsi |  8 +++
 10 files changed, 190 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-generic.dts
 create mode 100644 arch/arm/mach-rockchip/rk3576/MAINTAINERS
 create mode 100644 configs/generic-rk3576_defconfig

-- 
2.49.0

