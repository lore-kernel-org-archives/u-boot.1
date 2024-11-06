Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0410D44D50
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 11:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F94D88E89;
	Wed,  6 Nov 2024 12:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1AD8891CD; Wed,  6 Nov 2024 12:29:52 +0100 (CET)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55DB188D54
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 12:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xk2zx6cgZzC4j;
 Wed,  6 Nov 2024 12:29:49 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Xk2zw0lnyzLCQ; Wed,  6 Nov 2024 12:29:47 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next v2 0/4] rockchip: rk3399: trigger sysreset in TPL
Date: Wed, 06 Nov 2024 12:29:40 +0100
Message-Id: <20241106-rk3399-sysreset-gpio-tpl-v2-0-22aa82189eb6@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACRTK2cC/4WNQQqDMBBFryKz7pQkaq2ueo/iQpJRhxaVmSCKe
 PcGL9Dl+5///gFKwqTQZAcIraw8TwncLQM/dtNAyCExOOMKa02J8snzukbdVUgp4rDwjHH5Ymk
 ezlRP60OoIc0XoZ63S/2GibYIbUpH1jjLfv2t9ur+q1eLBq3zXd+bqiuoePmRRPZ7IGjP8/wBg
 dITlMYAAAA=
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
specifically Puma) have TPL enabled, it makes sense to move this logic
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

For this to be possible, a weak callback is added in the TPL main C code
so that we can hook this sysreset function within the TPL code path.

@Cc Paul since he's trying to add support for this sysreset to the
Firefly ROC-RK3399-PC[1] and Pine64 ROCKPro64[2]. You'll want to have
gpio1 with boopth-pre-sram though so it makes it to the TPL DTB.

[1] https://lore.kernel.org/u-boot/20240926183111.1324284-1-paulk@sys-base.io/
[2] https://lore.kernel.org/u-boot/20240926183111.1324284-2-paulk@sys-base.io/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- added Paul's Rb tags
- fixed "an TPL" typos
- removed SPL support (merging patches 4 and 5 from v1 for
  bisectability)
- removed indentation in # if defined and their trailing comments

- Link to v1: https://lore.kernel.org/r/20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de

---
Quentin Schulz (4):
      pinctrl: rockchip: allow to build for TPL
      rockchip: rk3399: merge CRU check within rk3399_force_power_on_reset
      rockchip: tpl: allow to call board/SoC-specific code before DRAM init
      rockchip: rk3399: move sysreset-gpio logic to TPL

 arch/arm/mach-rockchip/rk3399/rk3399.c | 56 ++++++++++++++++++----------------
 arch/arm/mach-rockchip/tpl.c           |  6 ++++
 configs/puma-rk3399_defconfig          |  3 ++
 drivers/pinctrl/Kconfig                |  8 +++++
 drivers/pinctrl/rockchip/Kconfig       |  7 +++++
 5 files changed, 54 insertions(+), 26 deletions(-)
---
base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
change-id: 20241105-rk3399-sysreset-gpio-tpl-50620781cdd9

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

