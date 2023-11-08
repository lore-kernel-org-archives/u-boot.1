Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD188C4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 17:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D71F5871AB;
	Wed,  8 Nov 2023 18:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73605871C0; Wed,  8 Nov 2023 18:26:03 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB03B86CBD
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 18:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 660D7C0004;
 Wed,  8 Nov 2023 17:25:57 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 jonas@kwiboo.se, Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 heiko@sntech.de
Subject: [PATCH next v2 0/6] rockchip: rk3588: add support for detecting
 U-Boot proper boot medium
Date: Wed,  8 Nov 2023 18:25:36 +0100
Message-ID: <20231108-rk3588-spl-boot-dev-v2-0-e67e26202c85@theobroma-systems.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: quoted-printable
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

It is possible to boot U-Boot proper from a different storage medium=0D
than the one used by the BOOTROM to load the SPL. This information is=0D
stored in the u-boot,spl-boot-device Device Tree property and is=0D
accessible from U-Boot proper so that it has knowledge at runtime where=0D
it was loaded from.=0D
=0D
This is already supported on rk3399 and px30 but with duplicated code,=0D
so this patch series also factor out all of this into spl-boot-order of=0D
Rockchip platforms, which makes it drastically easier to add support to=0D
other SoCs, just a simple array needing to be added to the appropriate=0D
SoC file.=0D
=0D
Let's add support for this feature for rk3588 the same way it was done=0D
for px30 and rk3399.=0D
=0D
While at it, let's do some cleanups for Rockchip platforms.=0D
=0D
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
---=0D
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
      rockchip: rk3588: insert u-boot,spl-boot-device into U-Boot device tr=
ee=0D
      rockchip: remove unused global data ptr=0D
      rockchip: rk3128: remove noop file=0D
=0D
 arch/arm/mach-rockchip/board.c          |  3 --=0D
 arch/arm/mach-rockchip/px30/px30.c      | 50 +++--------------------------=
-=0D
 arch/arm/mach-rockchip/rk3128/Makefile  |  1 -=0D
 arch/arm/mach-rockchip/rk3128/rk3128.c  | 16 ----------=0D
 arch/arm/mach-rockchip/rk3308/rk3308.c  |  3 --=0D
 arch/arm/mach-rockchip/rk3328/rk3328.c  |  3 --=0D
 arch/arm/mach-rockchip/rk3368/rk3368.c  |  3 --=0D
 arch/arm/mach-rockchip/rk3399/rk3399.c  | 55 +++--------------------------=
----=0D
 arch/arm/mach-rockchip/rk3588/rk3588.c  | 10 ++++--=0D
 arch/arm/mach-rockchip/spl-boot-order.c | 49 +++++++++++++++++++++++++++++=
=0D
 10 files changed, 66 insertions(+), 127 deletions(-)=0D
---=0D
base-commit: e17d174773e9ba9447596708e702b7382e47a6cf=0D
change-id: 20230502-rk3588-spl-boot-dev-efa2777cc21b=0D
=0D
Best regards,=0D
-- =0D
Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
=0D
