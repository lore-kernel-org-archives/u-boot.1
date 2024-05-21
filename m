Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C838C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 17:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BB4883AA;
	Tue, 21 May 2024 19:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F96A88313; Tue, 21 May 2024 19:40:11 +0200 (CEST)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc08])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C5088313
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 19:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VkMCD4xl1zx6q;
 Tue, 21 May 2024 19:40:08 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VkMCC3dH7z6tw; Tue, 21 May 2024 19:40:07 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 00/10] rockchip: px30: migrate to common bss and stack
 addresses + UART fixes for evb-px30
Date: Tue, 21 May 2024 19:39:53 +0200
Message-Id: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGncTGYC/x3MQQqAIBBA0avErBvQ0ZS6SrSImmo2JgoRSHfPW
 r7F/wUyJ+EMQ1Mg8SVZzlCh2waWYw47o6zVQIqs6khjvI3CT6g8pgW9Nm5zZPVKPdQqJt7k/o/
 j9DwvdwuBUGEAAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: jonas@kwiboo.se, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

PX30 Ringneck ran out of memory in the allocation pool of U-Boot proper
pre-reloc. Something needed to be done. Jonas did migrate a few SoCs
already to this common bss+stack addresses so it made sense to follow
the same route for one additional SoC: PX30.

While at it, also fix a few issues related to UART on the PX30 Mini EVB
I could test.

Boot (to U-Boot CLI) tested on PX30 Ringneck and PX30 Mini-EVB.

Thanks to Jonas for hinting where to look at.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (10):
      rockchip: px30: default TPL_SYS_MALLOC_F_LEN to 0x600 on PX30 Kconfig level
      rockchip: Use common bss and stack addresses on PX30
      rockchip: ringneck_px30: Use common bss and stack addresses
      rockchip: evb-px30: Use common bss and stack addresses
      rockchip: firefly-px30: Use common bss and stack addresses
      rockchip: odroid-go2: Use common bss and stack addresses
      rockchip: px30-core-*: Use common bss and stack addresses
      rockchip: px30: make UART pinmux accessible to TPL/SPL DTB
      rockchip: evb-px30: do not remove pinctrl nodes from SPL DTB
      rockchip: evb-px30: make UART5 the debug UART

 arch/arm/dts/px30-u-boot.dtsi                 | 16 ++++++++++++++++
 arch/arm/mach-rockchip/px30/Kconfig           |  8 +++++++-
 configs/evb-px30_defconfig                    | 23 +++++------------------
 configs/firefly-px30_defconfig                | 19 +++----------------
 configs/odroid-go2_defconfig                  | 19 +++----------------
 configs/px30-core-ctouch2-of10-px30_defconfig | 19 +++----------------
 configs/px30-core-ctouch2-px30_defconfig      | 19 +++----------------
 configs/px30-core-edimm2.2-px30_defconfig     | 19 +++----------------
 configs/ringneck-px30_defconfig               | 19 +++----------------
 9 files changed, 46 insertions(+), 115 deletions(-)
---
base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
change-id: 20240521-px30-2024-07-rc-7136f6241d29

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

