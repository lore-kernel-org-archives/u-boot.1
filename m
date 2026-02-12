Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795E4EDF031
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 04:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3920483DB6;
	Thu, 12 Feb 2026 05:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BBE683C4B; Thu, 12 Feb 2026 03:41:03 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89CA83981
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 03:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 64F741A10B7;
 Thu, 12 Feb 2026 03:40:56 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE6341A100A;
 Thu, 12 Feb 2026 03:40:55 +0100 (CET)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2CB981800241;
 Thu, 12 Feb 2026 10:40:53 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Subject: [PATCH v2 0/2] Add i.MX95 15x15 FRDM support
Date: Thu, 12 Feb 2026 11:40:49 +0900
Message-Id: <20260212-imx95_frdm-v2-0-9a535a506b95@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALE9jWkC/03MSw7CIBSF4a00dyzmlkgDjtxH0xjkYe+AtgFDM
 A17F+vE4X+S8+2QXCSX4NrtEF2mROvSgp86MLNeno6RbQ0c+YA9CkahKHH30QampXo4JaVWHqE
 dtug8lQMbp9Yzpdca34ed++/6Yzhe/pncM2RSWCOxaXqwt6VsZ7MGmGqtHzRb4FiiAAAA
X-Change-ID: 20260105-imx95_frdm-a89be988a9f0
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Lei Xu <lei.xu@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ji Luo <ji.luo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Justin Jiang <justin.jiang@nxp.com>, 
 qijian.guo@oss.nxp.com, xinyu.chen@nxp.com, Jacky Bai <ping.bai@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770864052; l=1346;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=6CsDRKoaL66mQ/K7NuqHvNPJJfCkL520Lsy6EZ44xeE=;
 b=p5B/1U752v+Ljpf8RcHKk68p30UVKseBNP6QkWPWrfAzGiUx2gYV12Q3vZlAelqjIhaQKk3qT
 KhbMPL3dUIlBL60k3PTu2tjy44AVGgDm18ySZJvw+o2X6DBqopg46+I
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Mailman-Approved-At: Thu, 12 Feb 2026 05:50:31 +0100
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

The patchset adds basic support for i.MX95 15x15 FRDM Board.

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
Changes in v2:
- drop OF_UPSTREAM
- sort header
- align the macros in imx95_frdm.h
- Link to v1: https://lore.kernel.org/r/20260204-imx95_frdm-v1-0-85dc80e98a6d@nxp.com

---
Joseph Guo (2):
      arm64: dts: freescale: add basic dts for FRDM-IMX95 in u-boot
      imx: Add FRDM-IMX95 initial support

 arch/arm/dts/imx95-15x15-frdm-u-boot.dtsi |  85 +++
 arch/arm/dts/imx95-15x15-frdm.dts         | 964 ++++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig            |   7 +
 board/nxp/imx95_frdm/Kconfig              |  12 +
 board/nxp/imx95_frdm/MAINTAINERS          |   6 +
 board/nxp/imx95_frdm/Makefile             |  11 +
 board/nxp/imx95_frdm/imx95_frdm.c         |  31 +
 board/nxp/imx95_frdm/imx95_frdm.env       |  91 +++
 board/nxp/imx95_frdm/spl.c                |  80 +++
 configs/imx95_15x15_frdm_defconfig        | 143 +++++
 doc/board/nxp/imx95_frdm.rst              | 131 ++++
 doc/board/nxp/index.rst                   |   1 +
 include/configs/imx95_frdm.h              |  25 +
 13 files changed, 1587 insertions(+)
---
base-commit: eed514b11d04a2f8a949521ad3bffba3ec98bd2f
change-id: 20260105-imx95_frdm-a89be988a9f0

Best regards,
-- 
Joseph Guo <qijian.guo@nxp.com>

