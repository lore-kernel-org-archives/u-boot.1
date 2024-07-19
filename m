Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6781FC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 09:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B642388B22;
	Fri, 19 Jul 2024 11:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0215E88B62; Fri, 19 Jul 2024 11:47:06 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A00A884E2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 11:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 91C06200D99;
 Fri, 19 Jul 2024 11:47:03 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 590A8202723;
 Fri, 19 Jul 2024 11:47:03 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 E8B401820F77; Fri, 19 Jul 2024 17:47:01 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, sbabic@denx.de, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv1 0/2] Enable the 'cpu' command for i.MX8M series EVK boards
Date: Fri, 19 Jul 2024 18:07:56 +0800
Message-Id: <20240719100758.1917-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch set is to enable the 'cpu' command for i.MX8M Plus,
Mini and Nano EVK, so that it can kick one CPU core to run the
barematel or RTOS applicatons under U-Boot.

Hou Zhiqiang (1):
  mp: imx8m: add cpu command support

Jiafei Pan (1):
  mp: imx8m: enable CONFIG_MP to support cpu command

 arch/arm/mach-imx/imx8m/Makefile  |   3 +-
 arch/arm/mach-imx/imx8m/mp.c      | 100 ++++++++++++++++++++++++++++++
 configs/imx8mm_evk_defconfig      |   1 +
 configs/imx8mn_ddr4_evk_defconfig |   1 +
 configs/imx8mp_evk_defconfig      |   1 +
 5 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/imx8m/mp.c

-- 
2.43.0

