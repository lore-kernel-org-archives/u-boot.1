Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84783C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 16:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12037885F1;
	Thu, 23 May 2024 18:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBC687ABC; Thu, 23 May 2024 18:59:49 +0200 (CEST)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc0d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 307BD87ABC
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 18:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VlZCk5npKz3T9;
 Thu, 23 May 2024 18:59:46 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VlZCj1jxPz9dP; Thu, 23 May 2024 18:59:45 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 0/3] rockchip: ringneck-px30: migrate to common bss and
 stack addresses
Date: Thu, 23 May 2024 18:59:33 +0200
Message-Id: <20240523-px30-2024-07-rc-v2-0-e46782d5520c@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPV1T2YC/3XNwQ6CMBAE0F8he3ZNu9QinvwPw8G0W+kFyNY0E
 NJ/t3D3+CaZmR0SS+QEj2YH4RxTnKcKujTgxvf0YYy+GkiRUTfSuKytwkOoOhSHnW5tsGS0px5
 qaxEOcT0XX0P1GNN3lu08yPpI/29ljQotadW7u/HGhKcbWWS7eoahlPIDEVfyoa4AAAA=
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: trini@konsulko.com, jonas@kwiboo.se, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>
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

The migration of other PX30-based boards will happen in next branch
instead, this one however is required for Ringneck to still reach U-Boot
CLI. Odroid-Go2 reaches the CLI without the patches in v1. Unknown
status for the other boards.

@Tom/Kever, please merge this on master.

To: Simon Glass <sjg@chromium.org>
To: Philipp Tomsich <philipp.tomsich@vrull.eu>
To: Kever Yang <kever.yang@rock-chips.com>
To: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
To: Jagan Teki <jagan@amarulasolutions.com>
To: Suniel Mahesh <sunil@amarulasolutions.com>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: trini@konsulko.com
Cc: jonas@kwiboo.se
Cc: u-boot@lists.denx.de
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Changes in v2:
- remove non-ringneck patches, they'll be for next instead
- Link to v1: https://lore.kernel.org/r/20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de

---
Quentin Schulz (3):
      rockchip: px30: default TPL_SYS_MALLOC_F_LEN to 0x600 on PX30 Kconfig level
      rockchip: Use common bss and stack addresses on PX30
      rockchip: ringneck_px30: Use common bss and stack addresses

 arch/arm/mach-rockchip/px30/Kconfig           |  8 +++++++-
 configs/evb-px30_defconfig                    |  1 -
 configs/firefly-px30_defconfig                |  1 -
 configs/odroid-go2_defconfig                  |  1 -
 configs/px30-core-ctouch2-of10-px30_defconfig |  1 -
 configs/px30-core-ctouch2-px30_defconfig      |  1 -
 configs/px30-core-edimm2.2-px30_defconfig     |  1 -
 configs/ringneck-px30_defconfig               | 19 +++----------------
 8 files changed, 10 insertions(+), 23 deletions(-)
---
base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
change-id: 20240521-px30-2024-07-rc-7136f6241d29

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

