Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D52EC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 07:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B176388640;
	Tue, 30 Jul 2024 09:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F3388791; Tue, 30 Jul 2024 09:09:38 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2209887D1
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 09:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 59C9A2004C1;
 Tue, 30 Jul 2024 09:09:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D981200456;
 Tue, 30 Jul 2024 09:09:35 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 808F9183ACAC; Tue, 30 Jul 2024 15:09:33 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org, marex@denx.de, lukma@denx.de,
 seanga2@gmail.com, xypron.glpk@gmx.de
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 00/14] Add a subcommand 'release' to cmd/cpu.c
Date: Tue, 30 Jul 2024 15:29:49 +0800
Message-Id: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
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

Fixed some problems of the imx8_cpu.c and added i.MX 8M series SoCs
support.

Added ARM A53 core clock registration in clock driver of i.MX 8M Mini,
Nano and Plus SoCs.

And enabled the 'cpu' command and imx CPU driver for i.MX 8M series
EVK boards and i.MX 93 EVK board.

Hou Zhiqiang (14):
  clk: imx8m: register ARM A53 core clock
  cpu: add release_core callback
  cpu: sandbox: implement release_core callback
  test: cpu: add test for release CPU core.
  cpu: imx: fix the CPU frequency in cpu_imx_get_info()
  cpu: imx: fix the CPU type field width
  cpu: imx: removed the tail '\n' of the CPU description
  cpu: imx: Add i.MX 8M series SoCs
  cpu: imx: implement release_core callback
  cmd: cpu: add release subcommand
  doc: cmd: add documentation for cpu command
  MAINTAINERS: add entry for cpu command
  configs: imx8m: enable the 'cpu' command
  configs: imx93: enable the 'cpu' command

---
V4:
 - Moved the depended patch into this thread.
 - Removed the tail '\n' of the CPU description for imx CPU driver.
 - Refined the documentation of 'cpu' command.
V3:
 - Added documentation for 'cpu' command.
 - Fixed the getting cpu frequency issue in i.MX CPU driver.
V2:
 - Implemented release_core() in sandbox and added test for the new API.
 - Increased the CPU type mask in i.MX CPU driver.
 - Added i.MX 8M series SoCs in i.MX CPU driver

 MAINTAINERS                       |   7 +++
 cmd/cpu.c                         |  44 ++++++++++++-
 configs/imx8mm_evk_defconfig      |   3 +
 configs/imx8mn_evk_defconfig      |   3 +
 configs/imx8mp_evk_defconfig      |   3 +
 configs/imx93_11x11_evk_defconfig |   1 +
 doc/usage/cmd/cpu.rst             | 101 ++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx8mm.c      |   6 ++
 drivers/clk/imx/clk-imx8mn.c      |   7 +++
 drivers/clk/imx/clk-imx8mp.c      |   7 +++
 drivers/cpu/cpu-uclass.c          |  10 +++
 drivers/cpu/cpu_sandbox.c         |   6 ++
 drivers/cpu/imx8_cpu.c            |  38 +++++++++--
 include/cpu.h                     |  15 +++++
 test/dm/cpu.c                     |   2 +
 15 files changed, 246 insertions(+), 7 deletions(-)
 create mode 100644 doc/usage/cmd/cpu.rst

-- 
2.17.1

