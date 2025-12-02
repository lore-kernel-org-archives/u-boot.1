Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21193D116F5
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 14:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E2DD83E88;
	Tue,  2 Dec 2025 15:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB13683700; Tue,  2 Dec 2025 11:05:35 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D27280433
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 11:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C91691A00B1;
 Tue,  2 Dec 2025 11:05:32 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 92F821A0090;
 Tue,  2 Dec 2025 11:05:32 +0100 (CET)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A6719180009C;
 Tue,  2 Dec 2025 18:05:29 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Subject: [PATCH v2 0/2] Add FRDM-IMX91 initial support
Date: Tue, 02 Dec 2025 19:05:01 +0900
Message-Id: <20251202-imx91_frdm-v2-0-992b8aa99375@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM25LmkC/1XMQQ7CIBCF4as0sxZTJm0prryHaQwWsLOANmAIp
 uHuYuPG5f+S9+0QTSAT4dLsEEyiSKuvgacG5kX5p2GkawO22HPOBSOXJb/boB0TCvVD9haF1FA
 PWzCW8oHdptoLxdca3oed+Hf9MfjHJM5aNtoOh27Qo1T66vN2nlcHUynlA/2iQ7uiAAAA
X-Change-ID: 20251117-imx91_frdm-7a2db95f279d
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Francesco Valla <francesco@valla.it>, Jacky Bai <ping.bai@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Justin Jiang <justin.jiang@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764669929; l=2591;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=hv2NDLEEsv3MlZjvTglvcj7dv3toBg9DLWyMYpU6ukg=;
 b=YFUbo5+BmCDeCdVh1uIB3VFh+Ohu3dgQdd2GUGLGSX2AAq3kh8gpP+N4eM4YkS/2UAkhaJmDc
 9oxXcVlJ7zLBTYxqXR153t0ksRqcxeHO+7qS6Z3BfIHH8EAxBL+OtWk
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Mailman-Approved-At: Tue, 02 Dec 2025 15:06:33 +0100
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

This series add initial support for the FRDM i.MX91 11x11 development
board in U-Boot:
https://www.nxp.com/design/design-center/development-boards-and-designs/FRDM-IMX91

Include:
- Device tree for the board.
- Defconfig and Kconfig for the board.
- Header file defining memory layout and hadware addresses.

The board devicetree already attempted to upstream, but not been accepted yet:
https://lore.kernel.org/all/20251114-imx91_frdm-v1-0-e5763bdf9336@nxp.com/

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
Changes in v2:
- add upstream link
- rename 'vrpi' to 'vexp' to keep align with upstream dts
- move bootph- property from u-boot.dtsi to dts   
- correct commit message 'EVK' to 'FRDM'
- use #include in ecc config file to avoid duplication
- add ecc description in README
- drop extraneous includes
- rename 'imx91_frdm.rst' to 'imx91_11x11_frdm.rst'
- drop IMX91_FRDM_LPDDR4 symbol
- Link to v1: https://lore.kernel.org/r/20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com

---
Joseph Guo (2):
      arm64: dts: add NXP FRDM-IMX91 device tree
      imx: Support i.MX91 11x11 FRDM board

 arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi          |   51 +
 arch/arm/dts/imx91-11x11-frdm.dts                  |  767 ++++++++
 arch/arm/mach-imx/imx9/Kconfig                     |    9 +
 board/freescale/imx91_frdm/Kconfig                 |   12 +
 board/freescale/imx91_frdm/MAINTAINERS             |    7 +
 board/freescale/imx91_frdm/Makefile                |   16 +
 board/freescale/imx91_frdm/imx91_frdm.c            |   25 +
 board/freescale/imx91_frdm/imx91_frdm.env          |   88 +
 .../imx91_frdm/lpddr4_2400mts_1gb_timing.c         | 1996 ++++++++++++++++++++
 .../imx91_frdm/lpddr4_2400mts_2gb_timing.c         | 1996 ++++++++++++++++++++
 .../imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c     | 1996 ++++++++++++++++++++
 .../imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c     | 1996 ++++++++++++++++++++
 board/freescale/imx91_frdm/lpddr4_timing.h         |   12 +
 board/freescale/imx91_frdm/spl.c                   |  193 ++
 configs/imx91_11x11_frdm_defconfig                 |  143 ++
 configs/imx91_11x11_frdm_inline_ecc_defconfig      |    3 +
 doc/board/nxp/imx91_11x11_frdm.rst                 |  100 +
 doc/board/nxp/index.rst                            |    1 +
 include/configs/imx91_frdm.h                       |   25 +
 19 files changed, 9436 insertions(+)
---
base-commit: e199db57c00ba2c2aba81069800126b6543a644c
change-id: 20251117-imx91_frdm-7a2db95f279d

Best regards,
-- 
Joseph Guo <qijian.guo@nxp.com>

