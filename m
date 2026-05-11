Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3A5CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 20:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6870683C2B;
	Mon, 11 May 2026 22:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="OS5dNGUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F64784662; Mon, 11 May 2026 22:13:17 +0200 (CEST)
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7797B8394E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 2026051120131350ec6f8669000207e9 for <u-boot@lists.denx.de>;
 Mon, 11 May 2026 22:13:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xXbtGimuM6BCyw2dXhmvJKlfmmB+rX7PYyaKlZh61IY=;
 b=OS5dNGUynwBDNvfj28RYfFOSovT3i1z9mKyNJVb/xXawlQYVYfkbJNJZRPQXv7bzyzxE5Q
 +eUCx6GNzWh3m3UUVT2NiwZec16+2881SYrf4b3ZXzklPZvHGPZr3JTwCVzNAG1rUl2+9iMc
 1DcvQAV0If7uM1plc5iK3fw+cipaC6sacX9/DNjhPmtNR59W5f8q03S0FpSK1nfT1tfakVxY
 MoFJd9WVLBHx2tT0BDy4qUVPbsdj8w8guLtrUwKzXIpBI0gjuCI7O2ITSbsIO1tR/EXAgO0a
 O29JAiuYL5xESXzpCZYpufg20+gLngQ0KIwydmIfYPsoBZq5QBtNWotg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Moteen Shah <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Ji Luo <ji.luo@nxp.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/4] Pass reset reason to Linux via FDT
Date: Mon, 11 May 2026 22:12:29 +0200
Message-ID: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Make get_reset_reason() available on TI K3 AM62x and AM64x SoCs a model
for further SoC/platform-specific implementations.

Introduce new CONFIG_RESET_REASON_FDT option and optionally populate reset
reason in FDT passed to Linux under /chosen/reset-reason with a string
returned by get_reset_reason().

The above paves a way to pass reset reason information to Linux user space
in a platform-agnostic way.

Alexander Sverdlin (4):
  arm: mach-k3: Allow for calling get_reset_reason() twice
  nxp: imx9: rename get_reset_reason() -> print_reset_reason()
  common: Make TI K3 get_reset_reason() a weak global
  fdt: Optionally populate /chosen/reset-reason

 arch/arm/include/asm/arch-imx9/sys_proto.h |  2 +-
 arch/arm/include/asm/global_data.h         |  3 +++
 arch/arm/mach-imx/imx9/scmi/soc.c          |  2 +-
 arch/arm/mach-k3/am62x/boot.c              | 13 ++++++++++---
 arch/arm/mach-k3/am64x/boot.c              | 13 ++++++++++---
 arch/arm/mach-k3/common.c                  |  5 -----
 arch/arm/mach-k3/include/mach/hardware.h   |  1 -
 board/nxp/imx94_evk/spl.c                  |  2 +-
 board/nxp/imx95_evk/spl.c                  |  2 +-
 board/toradex/smarc-imx95/spl.c            |  2 +-
 boot/fdt_support.c                         | 14 ++++++++++++++
 common/board_info.c                        |  5 +++++
 include/init.h                             | 12 ++++++++++++
 lib/Kconfig                                |  9 +++++++++
 14 files changed, 68 insertions(+), 17 deletions(-)

-- 
2.52.0

