Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FEFC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 08:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8042E886FC;
	Mon,  5 Aug 2024 10:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ql7p/J+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFF0F888B9; Mon,  5 Aug 2024 10:44:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B2D887E8
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 10:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=32c7=PE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722847442;
 bh=086pitYW9mv45gCpvj6GcttSfhJTfy8DWLwEyhi6VzI=;
 b=ql7p/J+qB+GHqkHkDGJK1rsN8FhCQvyXagbWaiC2Wx8Y8ugmmqosIb57x7woW5cU/kESsvsyJ
 OHkmXFHdX6Q0aRNHKPIv1GiYwmKlJWNHREfd2JIRsZkaijS9G8oNByRDyoLLU/NncMwn5BbbKPa
 VMpvHK8Wr+5YM7yfC7kZbwP6TI6xa340YzYyG8m7DlBznvfEWtXOqAinOeQ2Rf1VzDMU7A8q/fG
 O0OLDs0LIxt53mv50R4pvZFkZ2kOwf9AdZSoPLy6xtovzNCUsACJ25k748PUMeDAz+tyW+MihtA
 r6wifaMtUi6RLj2av5eIdrZ5NE1AjJQ/3POLXN8iXMkA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] rockchip: Skip serial pinctrl at pre-reloc phase
Date: Mon,  5 Aug 2024 08:43:40 +0000
Message-ID: <20240805084350.3895788-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66b090ceef96678d293a4eae
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

UART pinctrl for serial is typically applied multiple times:
- in external TPL or in TPL for DEBUG_UART in board_debug_uart_init()
- in SPL for DEBUG_UART in board_debug_uart_init()
- in SPL using pinctrl from DT
- in pre-reloc phase using pinctrl from DT
- after relocation using pinctrl from DT

This series change bootph props for the UART pinctrl to not include them
in pre-reloc phase to save some boot time:

- Radxa ROCK Pi S (RK3308): ~80 ms
- Radxa ZERO 3W (RK3566): ~120 ms
- Radxa ROCK 5B (RK3588): ~150 ms

Similar change has already been applied for RK3328 and RK3399 boards.

The change for PX30 has not been runtime tested, and only include change
for uart2, not uart0 and uart5 used on two of the supported px30 boards.

Jonas Karlman (4):
  rockchip: rk3308: Skip serial pinctrl at pre-reloc phase
  rockchip: rk356x: Skip serial pinctrl at pre-reloc phase
  rockchip: rk3588: Skip serial pinctrl at pre-reloc phase
  rockchip: px30: Skip serial pinctrl at pre-reloc phase

 arch/arm/dts/px30-u-boot.dtsi                | 3 ++-
 arch/arm/dts/rk3308-evb-u-boot.dtsi          | 3 ++-
 arch/arm/dts/rk3308-roc-cc-u-boot.dtsi       | 3 ++-
 arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi    | 3 ++-
 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi      | 3 ++-
 arch/arm/dts/rk356x-u-boot.dtsi              | 3 ++-
 arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi | 3 ++-
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 3 ++-
 arch/arm/dts/rk3588s-u-boot.dtsi             | 3 ++-
 9 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.45.2

