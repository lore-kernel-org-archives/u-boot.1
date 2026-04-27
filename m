Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B731DFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F92984106;
	Mon, 27 Apr 2026 15:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ifm.com header.i=@ifm.com header.b="b02kUk+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C875583AA9; Mon, 27 Apr 2026 15:33:03 +0200 (CEST)
Received: from pp0155.ppsmtp.net (pp0155.ppsmtp.net [132.145.231.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D971F80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedor.ross@ifm.com
Received: from pps.filterd (pp2080.ppsmtp.internal [127.0.0.1])
 by pp2080.ppsmtp.internal (8.18.1.7/8.18.1.7) with ESMTP id 63RDUtK7001239;
 Mon, 27 Apr 2026 15:32:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pps; bh=K2rYCRbN2tcpDuC9V3i46tdRCLz7
 I+E+H1KMN8PATP0=; b=b02kUk+9bPe5jbFrYfcKEl2SomKzv4S+arrzs4ugHj1t
 QgSE+HDGh8FDFnsBbnHJ1TYzItZH0NslBMao2VjechkLFXqC2vK8rIRJyQc0So/2
 Qwr4V4/m28An/sKuW0P42o5CBlNhEEyvDwHizXrhU/Guixt7L5LOb/nQdX7tncFJ
 mfvggIEFb/7nsLEqXp0xbEo2/+02oFTgYfYdR2YbuOXRg5k5uT53JTfo5j/ATJ95
 PL54bTyBV/J9DCJO2hA6zs6K4bYfNg3tF8TEMh/AyltodYZ3ub3AnsKepE+31yi1
 Xgg5a6ZdBqyRIiWGO6RP3L/U94zTIilimLgmb0enGA==
From: <fedor.ross@ifm.com>
Subject: [PATCH v2 0/2] Add SPI NOR A/B switching support and detect A/B
 image on MX95
Date: Mon, 27 Apr 2026 15:32:49 +0200
Message-ID: <20260427-b4-imx95_img_set_sel-v2-0-b5d760ebc89b@ifm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIFl72kC/22NQQqDMBREryJ/3ZQkjYntqvcoIka/+qExJRGxS
 O7eVOiui1m8gXmzQ8RAGOFW7BBwpUh+ziBPBXRTO4/IqM8MkkvNleTMKkZuu5YNubGJuOQ8mVG
 orRKqR2kgT18BB9oO7aPOPFFcfHgfL6v4tj/h5b9wFYwzoSuBbWVFyc2dBnfuvIM6pfQBkB/FL
 7YAAAA=
X-Change-ID: 20260420-b4-imx95_img_set_sel-74e6b414de27
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 "Ji Luo" <ji.luo@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, "Ranjani
 Vaidyanathan" <ranjani.vaidyanathan@nxp.com>,
 Fedor Ross <fedor.ross@ifm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777296777; l=1231;
 i=fedor.ross@ifm.com; s=20251127; h=from:subject:message-id;
 bh=uuZkGL2n/lqu+ZrqGC/kemTiS3nzItfXsDchU6GL6Ss=;
 b=yaasMVltZAw44/MS+GYViY2C0GQIV1Seeoi7icEyxLoR20LEHVKX0RfwLUyVaaNygqq94/htl
 Kdo0RcOQDniDcbZZHLgnzP2Z/Zm0lOZ8kBvONEVwjaemvKQWuccJ6x+
X-Developer-Key: i=fedor.ross@ifm.com; a=ed25519;
 pk=QXV2AUGQzqdu1EMmSJgH2f2Z1Mu1wSx7+5+dcQzQ864=
X-Originating-IP: [172.19.129.123]
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=4drntpc4n7 QID=4drntpc4n7-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
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

This series adds support for SPI NOR A/B switching support on i.MX95 .
Therefore, add a function to obtain selected boot image by reading out
ROM data via SCMI. With this in place, it is also possible to implement
the getprisec subcommand of bmode command to detect which of A/B image
was booted.

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
Changes in v2:
- declare imx95_detect_secondary_image_boot()
  in arch/arm/include/asm/arch-imx9/sys_proto.h
- tweak preprocessor conditionals
- Link to v1: https://lore.kernel.org/r/20260423-b4-imx95_img_set_sel-v1-0-1681ea8b1507@ifm.com

---
Fedor Ross (1):
      imx9: scmi: soc: Add support for detecting primary/secondary bmode on MX95

Marek Vasut (1):
      imx: Add SPI NOR A/B switching support

 arch/arm/include/asm/arch-imx9/sys_proto.h |  2 ++
 arch/arm/mach-imx/Kconfig                  |  2 +-
 arch/arm/mach-imx/image-container.c        |  8 +++++++-
 arch/arm/mach-imx/imx9/scmi/soc.c          | 18 ++++++++++++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)
---
base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
change-id: 20260420-b4-imx95_img_set_sel-74e6b414de27

Best regards,
-- 
Fedor Ross <fedor.ross@ifm.com>

