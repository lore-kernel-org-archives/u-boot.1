Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00B8C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF4D87B7D;
	Wed, 17 Jan 2024 18:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E08A87B43; Wed, 17 Jan 2024 18:43:09 +0100 (CET)
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [84.16.66.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D701A87947
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TFYBL3XWrzMq8pp;
 Wed, 17 Jan 2024 17:43:06 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TFYBK58fDzvq; Wed, 17 Jan 2024 18:43:05 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/6] rockchip: puma-rk3399/ringneck-px30: fix check against
 value in default environment variable
Date: Wed, 17 Jan 2024 18:42:47 +0100
Message-ID: <20240117-env_default_theobroma-v3-0-316c25a6733f@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
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
Changes in v3:
- fix compilation issue when ENV_IS_IN_MMC is not selected (undefined
  CONFIG_SYS_MMC_ENV_DEV),
- Link to v2: https://lore.kernel.org/r/20231123-env_default_theobroma-v2-0-a80914c2c114@theobroma-systems.com

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

 board/theobroma-systems/common/common.c            | 151 ++++++++++++++
 board/theobroma-systems/common/common.h            |  19 ++
 board/theobroma-systems/puma_rk3399/MAINTAINERS    |   1 +
 board/theobroma-systems/puma_rk3399/Makefile       |   3 +
 board/theobroma-systems/puma_rk3399/puma-rk3399.c  | 194 ------------------
 board/theobroma-systems/ringneck_px30/MAINTAINERS  |   1 +
 board/theobroma-systems/ringneck_px30/Makefile     |   3 +
 .../ringneck_px30/ringneck-px30.c                  | 224 ---------------------
 env/common.c                                       |  16 +-
 include/env.h                                      |  10 +
 10 files changed, 201 insertions(+), 421 deletions(-)
---
base-commit: 106332d6cc583c4339e07020989d09b567900a59
change-id: 20231108-env_default_theobroma-33774a337fe6

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>

