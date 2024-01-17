Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A652C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C5387A18;
	Wed, 17 Jan 2024 18:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE9BD87A03; Wed, 17 Jan 2024 18:59:33 +0100 (CET)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:3:17::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8783E876FC
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
 by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TFYYH0w81zMqK4L;
 Wed, 17 Jan 2024 17:59:31 +0000 (UTC)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TFYYF6qfZz1C9; Wed, 17 Jan 2024 18:59:29 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 0/6] rockchip: puma-rk3399/ringneck-px30: fix check
 against value in default environment variable
Date: Wed, 17 Jan 2024 18:59:07 +0100
Message-ID: <20240117-env_default_theobroma-v4-0-12019172b482@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: quoted-printable
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

For puma-rk3399 and ringneck-px30, U-Boot proper automatically modifies=0D
boot_targets to swap the order in which MMC storage media are used for=0D
standard boot based on which MMC storage medium was used to load U-Boot=0D
proper. This is however only done if the user has not changed it=0D
manually, therefore a check between the default and current value is=0D
done.=0D
=0D
This used to work fine until the migration to standard boot where=0D
boot_targets value size in the default environment went above the 32=0D
characters that env_get_default function can return, thus resulting in a=0D
truncated variable.=0D
=0D
Therefore the check between default and current value would always fail.=0D
=0D
By adding the env_get_default_into function, a buffer of the appropriate=0D
size can be allocated on the stack to get the whole value of=0D
boot_targets in the default environment and thus fixing the check.=0D
=0D
While at it, simplify maintenance by putting this logic in a common file=0D
and stop using hardcoded DT paths for MMC controllers and SPI flash=0D
memory.=0D
=0D
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
---=0D
Changes in v4:=0D
- re-add board/theobroma-systems/puma_rk3399/puma-rk3399.c and=0D
  board/theobroma-systems/ringneck_px30/ringneck-px30.c that somehow=0D
  got deleted in v3,=0D
- Link to v3: https://lore.kernel.org/r/20240117-env_default_theobroma-v3-0=
-316c25a6733f@theobroma-systems.com=0D
=0D
Changes in v3:=0D
- fix compilation issue when ENV_IS_IN_MMC is not selected (undefined=0D
  CONFIG_SYS_MMC_ENV_DEV),=0D
- Link to v2: https://lore.kernel.org/r/20231123-env_default_theobroma-v2-0=
-a80914c2c114@theobroma-systems.com=0D
=0D
Changes in v2:=0D
- added board/theobroma-systems/common putting all storage medium logic=0D
  into a common file,=0D
- adapted the storage medium logic to be device-agnostic,=0D
- added Rbs=0D
- removed patches surrounding all code by an ifndef CONFIG_SPL_BUILD and=0D
  do this at the Makefile level of each board,=0D
- Link to v1: https://lore.kernel.org/r/20231108-env_default_theobroma-v1-0=
-cb493bfdeffd@theobroma-systems.com=0D
=0D
---=0D
Quentin Schulz (6):=0D
      rockchip: ringneck-px30: do not hardcode MMC controller paths=0D
      rockchip: puma-rk3399: do not hardcode MMC controller paths=0D
      rockchip: ringneck-px30/puma-rk3399: factor out storage medium select=
ion=0D
      env: allow to copy value from default environment into a buffer=0D
      env: migrate env_get_default to call env_get_default_into=0D
      rockchip: theobroma-systems: fix modified boot_targets detection=0D
=0D
 board/theobroma-systems/common/common.c            | 151 +++++++++++++++++=
++++=0D
 board/theobroma-systems/common/common.h            |  19 +++=0D
 board/theobroma-systems/puma_rk3399/MAINTAINERS    |   1 +=0D
 board/theobroma-systems/puma_rk3399/Makefile       |   3 +=0D
 board/theobroma-systems/puma_rk3399/puma-rk3399.c  | 143 +----------------=
--=0D
 board/theobroma-systems/ringneck_px30/MAINTAINERS  |   1 +=0D
 board/theobroma-systems/ringneck_px30/Makefile     |   3 +=0D
 .../ringneck_px30/ringneck-px30.c                  | 142 +----------------=
--=0D
 env/common.c                                       |  16 ++-=0D
 include/env.h                                      |  10 ++=0D
 10 files changed, 203 insertions(+), 286 deletions(-)=0D
---=0D
base-commit: 106332d6cc583c4339e07020989d09b567900a59=0D
change-id: 20231108-env_default_theobroma-33774a337fe6=0D
=0D
Best regards,=0D
-- =0D
Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
=0D
