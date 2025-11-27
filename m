Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B862DCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 12:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC9184380;
	Thu, 27 Nov 2025 13:16:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B978A8439E; Thu, 27 Nov 2025 10:55:04 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E8A084370
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 10:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7671520004F;
 Thu, 27 Nov 2025 10:55:01 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3F351200064;
 Thu, 27 Nov 2025 10:55:01 +0100 (CET)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7B0221800093;
 Thu, 27 Nov 2025 17:54:58 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Subject: [PATCH 0/2] Add FRDM-IMX91 initial support
Date: Thu, 27 Nov 2025 18:54:56 +0900
Message-Id: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPAfKGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0Nz3czcCkvD+LSilFxd80SjlCRL0zQjc8sUJaCGgqLUtMwKsGHRsbW
 1AJOdktNcAAAA
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
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764237298; l=1863;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=P8ebul3LuzgiWOwX0euw4kL9NWcXh+sZn/mK61SRPqY=;
 b=xZo9xYPASLliRmoWeI6i6Qjkr+haRkFnTuxJNc+O6+yoAs1v9g5JGEkYBP+jYKvUQTW6JgnWr
 twwtXjTHcWIClizinUI/jUtJL5zkXG/nJSd+tRNIwZLLmmS3pAjQqYx
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Mailman-Approved-At: Thu, 27 Nov 2025 13:16:04 +0100
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
board in U-Boot.

Include:
- Device tree for the board.
- Defconfig and Kconfig for the board.
- Header file defining memory layout and hadware addresses.

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
Joseph Guo (2):
      arm64: dts: add NXP FRDM-IMX91 device tree
      imx: Support i.MX91 11x11 FRDM board

 arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi          |  195 ++
 arch/arm/dts/imx91-11x11-frdm.dts                  |  670 +++++++
 arch/arm/mach-imx/imx9/Kconfig                     |    8 +
 board/freescale/imx91_frdm/Kconfig                 |   19 +
 board/freescale/imx91_frdm/MAINTAINERS             |    7 +
 board/freescale/imx91_frdm/Makefile                |   16 +
 board/freescale/imx91_frdm/imx91_frdm.c            |   28 +
 board/freescale/imx91_frdm/imx91_frdm.env          |   88 +
 .../imx91_frdm/lpddr4_2400mts_1gb_timing.c         | 1996 ++++++++++++++++++++
 .../imx91_frdm/lpddr4_2400mts_2gb_timing.c         | 1996 ++++++++++++++++++++
 .../imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c     | 1996 ++++++++++++++++++++
 .../imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c     | 1996 ++++++++++++++++++++
 board/freescale/imx91_frdm/lpddr4_timing.h         |   12 +
 board/freescale/imx91_frdm/spl.c                   |  204 ++
 configs/imx91_11x11_frdm_defconfig                 |  143 ++
 configs/imx91_11x11_frdm_inline_ecc_defconfig      |  143 ++
 doc/board/nxp/imx91_frdm.rst                       |   99 +
 doc/board/nxp/index.rst                            |    1 +
 include/configs/imx91_frdm.h                       |   25 +
 19 files changed, 9642 insertions(+)
---
base-commit: 69cc92d6869b8ff4591e5b8850872da34934bab9
change-id: 20251117-imx91_frdm-7a2db95f279d

Best regards,
-- 
Joseph Guo <qijian.guo@nxp.com>

