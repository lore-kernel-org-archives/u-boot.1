Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8867C04FFE
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 11:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02D0B87FF2;
	Sat, 11 May 2024 13:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="NJHBJHuE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 638808828E; Sat, 11 May 2024 13:28:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 585DA87FA7
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 13:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6c02=MO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1715426909;
 bh=clrxCJmmRvRNTYIb5pxtDPuDK602vE6est+FATjZ9RM=;
 b=NJHBJHuEWuge9xrG5rMXQ3yg+6UlPyW4GuMaOug0ngm+84tAI15JxggIsqpC2CTZGoEIF/oG+
 uQXR7GUpy/31w+UQ8RgEeYUSUGe8u8tsjH8BbMzoZtzkSB6pfKCcobaVD+iStM/YYyF2+DujsNs
 X2cb0S8e5ow+o1cMpC+VA774MUFLpuHqCg+0lCEyfTpl0R1H9+XOboTVy0MYPtYFhWKeI9Cu4ks
 yoezAo0Evzg9wdcj/M2flAlj5TN9eaY2nL7kk57u8KW2fyRKUIJaRsO1483c+7eSMmkFiz/jWmO
 +bI6Hdq3e+4unujHGqIHHwvZO73EL3luHFBtaH9tdXRQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 0/4] rockchip: Add gpio request() ops and drop PCIe
 reset-gpios workaround
Date: Sat, 11 May 2024 11:28:11 +0000
Message-ID: <20240511112821.1156519-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663f565aacd5e90e057dfc2e
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

This series add gpio request() and pinctrl gpio_request_enable() ops so
that a gpio requested pin automatically use gpio pinmux and U-Boot
behaves more similar to Linux kernel.

With the gpio and pinctrl ops implemented this series also remove a PCIe
reset-gpios related device lock-up workaround from board u-boot.dtsi.

PX30, RK3066, RK3188, RK356x and RK3588 are the only SoCs that currently
define gpio-ranges props and is affected by this series.

A follow up series adding support for the pinmux status cmd will also
add gpio-ranges props for remaining RK SoCs.

Jonas Karlman (4):
  pinctrl: rockchip: Add gpio_request_enable() ops
  gpio: rockchip: Add request() ops
  rockchip: rk3568-rock-3a: Drop PCIe reset-gpios workaround
  rockchip: rk3568-radxa-e25: Drop PCIe reset-gpios workaround

 arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 12 -------
 arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       | 12 -------
 drivers/gpio/rk_gpio.c                        | 10 ++++++
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 +++++++++++++++++++
 4 files changed, 41 insertions(+), 24 deletions(-)

-- 
2.43.2

