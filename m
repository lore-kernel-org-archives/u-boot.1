Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACF3C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C118876EA;
	Thu, 25 Jul 2024 11:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B09E8752A; Thu, 25 Jul 2024 11:32:50 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D44B686D4C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B49E2005D9;
 Thu, 25 Jul 2024 11:32:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 50FC4200604;
 Thu, 25 Jul 2024 11:32:47 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 631341802183; Thu, 25 Jul 2024 17:32:46 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 0/9] Add a subcommand 'release' to cmd/cpu.c
Date: Thu, 25 Jul 2024 17:53:22 +0800
Message-Id: <20240725095331.14245-1-Zhiqiang.Hou@nxp.com>
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

This patch set is to add a subcommand 'release' to the 'cpu' command
in cmd/cpu.c, making the command is able to release a core to run
baremetal and RTOS applications.

And enabled the 'cpu' command and imx CPU driver for i.MX 8M series
EVK boards and i.MX 93 EVK board.

dependence:
https://patchwork.ozlabs.org/project/uboot/patch/20240725083655.24486-1-Zhiqiang.Hou@nxp.com/

Hou Zhiqiang (9):
  cpu: add release_core callback
  cpu: sandbox: implement release_core callback
  test: cpu: add test for release CPU core.
  cpu: imx: implement release_core callback
  cpu: imx: fix the CPU type field width
  cpu: imx: Add i.MX 8M series SoCs
  cmd: cpu: add release subcommand
  configs: imx8m: enable the 'cpu' command
  configs: imx93: enable the 'cpu' command

---
V2:
 - Implemented release_core() in sandbox and added test for the new API.
 - Increased the CPU type mask in i.MX CPU driver.
 - Added i.MX 8M series SoCs in i.MX CPU driver

 cmd/cpu.c                         | 44 +++++++++++++++++++++++++++++--
 configs/imx8mm_evk_defconfig      |  3 +++
 configs/imx8mn_evk_defconfig      |  3 +++
 configs/imx8mp_evk_defconfig      |  3 +++
 configs/imx93_11x11_evk_defconfig |  1 +
 drivers/cpu/cpu-uclass.c          | 10 +++++++
 drivers/cpu/cpu_sandbox.c         |  6 +++++
 drivers/cpu/imx8_cpu.c            | 34 ++++++++++++++++++++++--
 include/cpu.h                     | 15 +++++++++++
 test/dm/cpu.c                     |  2 ++
 10 files changed, 117 insertions(+), 4 deletions(-)

-- 
2.43.0

