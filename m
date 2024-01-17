Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696CFC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F548879ED;
	Wed, 17 Jan 2024 18:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B91879F8; Wed, 17 Jan 2024 18:24:08 +0100 (CET)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 514FC8796A
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TFXmK5gRbzMq2wp;
 Wed, 17 Jan 2024 17:24:01 +0000 (UTC)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TFXmJ5HSgznpb; Wed, 17 Jan 2024 18:24:00 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: heiko@sntech.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 jonas@kwiboo.se, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v3 0/6] rockchip: add vendor-wide support for detecting
 U-Boot proper boot medium
Date: Wed, 17 Jan 2024 18:22:54 +0100
Message-ID: <20240117-rk3588-spl-boot-dev-v3-0-72cb989e6da8@theobroma-systems.com>
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

It is possible to boot U-Boot proper from a different storage medium=0D
than the one used by the BOOTROM to load the SPL. This information is=0D
stored in the u-boot,spl-boot-device Device Tree property and is=0D
accessible from U-Boot proper so that it has knowledge at runtime where=0D
it was loaded from.=0D
=0D
This is already supported on rk3399 and px30 but with duplicated code,=0D
so this patch series also factor out all of this into spl-boot-order of=0D
Rockchip platforms. Finally, let's invert the logic used to define the=0D
BOOT_DEVICE_ value in a different function so that=0D
/chosen/u-boot,spl-boot-device can be transparently added without any=0D
further work for existing and future SoCs.=0D
=0D
While at it, let's do some cleanups for Rockchip platforms.=0D
=0D
Tested on RK3399 Puma, PX30 Ringneck and (upcoming) RK3588 Jaguar.=0D
=0D
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
---=0D
Changes in v3:=0D
- revamp spl_decode_boot_device to not necessitate hardcoded arrays,=0D
  instead, the info is gotten from the inverted logic from=0D
  spl_node_to_boot_device where the BOOT_DEVICE_* is set=0D
- add Rbs=0D
- Link to v2: https://lore.kernel.org/r/20231108-rk3588-spl-boot-dev-v2-0-e=
67e26202c85@theobroma-systems.com=0D
=0D
Changes in v2:=0D
- add factoring into spl-boot-order=0D
- rework rk3588 support to use the factored out function=0D
- add global data ptr cleanup=0D
- remove rk3128 main SoC file (useless content)=0D
- Link to v1: https://lore.kernel.org/r/20230502-rk3588-spl-boot-dev-v1-1-0=
71722a85d2d@theobroma-systems.com=0D
=0D
---=0D
Quentin Schulz (6):=0D
      rockchip: rk3399: simplify logic for getting SPL boot medium DT node=
=0D
      rockchip: px30: simplify logic for getting SPL boot medium DT node=0D
      rockchip: factor out spl_perform_fixups into common spl-boot-order=0D
      rockchip: find U-boot proper boot device by inverting the logic that =
sets it=0D
      rockchip: remove unused global data ptr=0D
      rockchip: rk3128: remove noop file=0D
=0D
 arch/arm/mach-rockchip/board.c          |   3 -=0D
 arch/arm/mach-rockchip/px30/px30.c      |  49 ---------------=0D
 arch/arm/mach-rockchip/rk3128/Makefile  |   1 -=0D
 arch/arm/mach-rockchip/rk3128/rk3128.c  |  16 -----=0D
 arch/arm/mach-rockchip/rk3308/rk3308.c  |   3 -=0D
 arch/arm/mach-rockchip/rk3328/rk3328.c  |   3 -=0D
 arch/arm/mach-rockchip/rk3368/rk3368.c  |   3 -=0D
 arch/arm/mach-rockchip/rk3399/rk3399.c  |  51 ----------------=0D
 arch/arm/mach-rockchip/rk3588/rk3588.c  |   2 -=0D
 arch/arm/mach-rockchip/spl-boot-order.c | 104 ++++++++++++++++++++++++++++=
++++=0D
 10 files changed, 104 insertions(+), 131 deletions(-)=0D
---=0D
base-commit: 106332d6cc583c4339e07020989d09b567900a59=0D
change-id: 20230502-rk3588-spl-boot-dev-efa2777cc21b=0D
=0D
Best regards,=0D
-- =0D
Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
=0D
