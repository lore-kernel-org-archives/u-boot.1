Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE43D2C139
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD75B891C0;
	Tue,  5 Nov 2024 16:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59873891B0; Tue,  5 Nov 2024 16:36:58 +0100 (CET)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 058378900E
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XjXWW3ZH4zY6D;
 Tue,  5 Nov 2024 16:36:55 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4XjXWV1F52zPPv; Tue,  5 Nov 2024 16:36:54 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next 0/5] rockchip: rk3399: allow to trigger sysreset in
 TPL
Date: Tue, 05 Nov 2024 16:36:31 +0100
Message-Id: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH87KmcC/x3MQQqDMBBA0avIrB1IotbGq0gXYqZ2sMQwE4oi3
 t3Q5Vv8f4KSMCkM1QlCP1beYoGtK5g/U1wIORSDM6611nQoa9N4j3qokFLGJfGGOX2xMw9n+qe
 dQ/BQ8iT05v2/HiHSnuF1XTfM4O+DcAAAAA==
X-Change-ID: 20241105-rk3399-sysreset-gpio-tpl-50620781cdd9
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Paul Kocialkowski <paulk@sys-base.io>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

A sysreset-gpio can be provided in an RK3399 platform's Device Tree and
if U-Boot detects a "warm" boot was done, it'll toggle that GPIO to
perform a reset of the PMIC, essentially forcing a cold boot to make
sure there are no non-default values in SoC registers.

For now, this was only supported in SPL, probably because when this was
implemented RK3399 (and specifically Puma) didn't have TPL support so
SPL was the earliest stage. Now that most RK3399 boards (and
specifically Puma) have TPL enabled, it makes sense to add support for
triggering this sysreset from it. It brings the following advantages:
- faster boot time as we don't need to reach SPL to be able to reset the
  system on a condition we know is already met in TPL,
- have less code to be impacted by the issue this system reset works
  around (that is, "unclean" SoC registers after a reboot),
- less confusion around the reason for restarting. Indeed when done from
  SPL, the following log can be observed:

"""
U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
Channel 0: DDR3, 666MHz
BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
Channel 1: DDR3, 666MHz
BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
256B stride
Trying to boot from BOOTROM
Returning to boot ROM...

U-Boot SPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45 +0100)
Trying to boot from MMC2

U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
"""

possibly hinting at an issue within the SPL when loading the fitImage
from MMC2 instead of the normal course of events (a system reset).

For this to be possible, the sysreset function is adapted to be able to
run in SPL and TPL by checking the appropriate symbols and a weak
callback is added in the TPL main C code so that we can hook this
sysreset function within the TPL code path.

@Cc Paul since he's trying to add support for this sysreset to the
Firefly ROC-RK3399-PC[1] and Pine64 ROCKPro64[2]. You'll want to have
gpio1 with boopth-pre-sram though so it makes it to the TPL DTB.

[1] https://lore.kernel.org/u-boot/20240926183111.1324284-1-paulk@sys-base.io/
[2] https://lore.kernel.org/u-boot/20240926183111.1324284-2-paulk@sys-base.io/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (5):
      pinctrl: rockchip: allow to build for TPL
      rockchip: rk3399: merge CRU check within rk3399_force_power_on_reset
      rockchip: tpl: allow to call board/SoC-specific code before DRAM init
      rockchip: rk3399: allow to handle sysreset-gpio in TPL
      rockchip: configs: puma-rk3399: do the system reset in TPL

 arch/arm/mach-rockchip/rk3399/rk3399.c | 58 +++++++++++++++++++---------------
 arch/arm/mach-rockchip/tpl.c           |  6 ++++
 configs/puma-rk3399_defconfig          |  3 ++
 drivers/pinctrl/Kconfig                |  8 +++++
 drivers/pinctrl/rockchip/Kconfig       |  7 ++++
 5 files changed, 56 insertions(+), 26 deletions(-)
---
base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
change-id: 20241105-rk3399-sysreset-gpio-tpl-50620781cdd9

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

