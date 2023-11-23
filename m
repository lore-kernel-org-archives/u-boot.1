Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD25C624B4
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 15:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69838766E;
	Thu, 23 Nov 2023 16:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987D387657; Thu, 23 Nov 2023 16:10:27 +0100 (CET)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF6B8760A
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 16:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89D3BE0006;
 Thu, 23 Nov 2023 15:10:23 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH next v2 0/6] rockchip: puma-rk3399/ringneck-px30: fix check
 against value in default environment variable
Date: Thu, 23 Nov 2023 16:10:04 +0100
Message-ID: <20231123-env_default_theobroma-v2-0-a80914c2c114@theobroma-systems.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: foss@0leil.net
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

For puma-rk3399 and ringneck-px30, U-Boot proper automatically modifies
boot_targets to swap the order in which MMC storage media are used for
standard boot based on which MMC storage medium was used to load U-Boot
proper. This is however only done if the user has not changed it
manually, therefore a check between the default and current value is
done.

This used to work fine until the migration to standard boot where
boot_targets value size in the default environment went above the 32
characters that env_get_default function can return, thus resulting in a
truncated variable.

Therefore the check between default and current value would always fail.

By adding the env_get_default_into function, a buffer of the appropriate
size can be allocated on the stack to get the whole value of
boot_targets in the default environment and thus fixing the check.

While at it, simplify maintenance by putting this logic in a common file
and stop using hardcoded DT paths for MMC controllers and SPI flash
memory.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Changes in v2:
- added board/theobroma-systems/common putting all storage medium logic
  into a common file,
- adapted the storage medium logic to be device-agnostic,
- added Rbs
- removed patches surrounding all code by an ifndef CONFIG_SPL_BUILD and
  do this at the Makefile level of each board,
- Link to v1: https://lore.kernel.org/r/20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com

---
Quentin Schulz (6):
      rockchip: ringneck-px30: do not hardcode MMC controller paths
      rockchip: puma-rk3399: do not hardcode MMC controller paths
      rockchip: ringneck-px30/puma-rk3399: factor out storage medium selection
      env: allow to copy value from default environment into a buffer
      env: migrate env_get_default to call env_get_default_into
      rockchip: theobroma-systems: fix modified boot_targets detection

 board/theobroma-systems/common/common.c            | 143 +++++++++++++++++++++
 board/theobroma-systems/common/common.h            |  19 +++
 board/theobroma-systems/puma_rk3399/MAINTAINERS    |   1 +
 board/theobroma-systems/puma_rk3399/Makefile       |   3 +
 board/theobroma-systems/puma_rk3399/puma-rk3399.c  | 143 +--------------------
 board/theobroma-systems/ringneck_px30/MAINTAINERS  |   1 +
 board/theobroma-systems/ringneck_px30/Makefile     |   3 +
 .../ringneck_px30/ringneck-px30.c                  | 142 +-------------------
 env/common.c                                       |  16 ++-
 include/env.h                                      |  10 ++
 10 files changed, 195 insertions(+), 286 deletions(-)
---
base-commit: 9e53e45292ee2f1d9d2ccc59914b161bef9b10d7
change-id: 20231108-env_default_theobroma-33774a337fe6

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>

