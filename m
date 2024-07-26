Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D88FC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 17:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF4078859B;
	Fri, 26 Jul 2024 19:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F8888599; Fri, 26 Jul 2024 19:30:28 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90EB287B84
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 19:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BE691A0B06;
 Fri, 26 Jul 2024 19:30:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E80CF1A02C1;
 Fri, 26 Jul 2024 19:30:25 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 7ED31180222F; Sat, 27 Jul 2024 01:30:24 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 0/12] Add a subcommand 'release' to cmd/cpu.c
Date: Sat, 27 Jul 2024 01:50:56 +0800
Message-Id: <20240726175108.34704-1-Zhiqiang.Hou@nxp.com>
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

And enabled the 'cpu' command and imx CPU driver for i.MX 8M series
EVK boards and i.MX 93 EVK board.

dependence:
https://patchwork.ozlabs.org/project/uboot/patch/20240725083655.24486-1-Zhiqiang.Hou@nxp.com/

Hou Zhiqiang (12):
  cpu: add release_core callback
  cpu: sandbox: implement release_core callback
  test: cpu: add test for release CPU core.
  cpu: imx: fix the CPU frequency in cpu_imx_get_info()
  cpu: imx: fix the CPU type field width
  cpu: imx: Add i.MX 8M series SoCs
  cpu: imx: implement release_core callback
  cmd: cpu: add release subcommand
  doc: cmd: add documentation for cpu command
  MAINTAINERS: add entry for cpu command
  configs: imx8m: enable the 'cpu' command
  configs: imx93: enable the 'cpu' command

---
V3:
 - Added documentation for 'cpu' command.
 - Fixed the getting cpu frequency issue in i.MX CPU driver.
V2:
 - Implemented release_core() in sandbox and added test for the new API.
 - Increased the CPU type mask in i.MX CPU driver.
 - Added i.MX 8M series SoCs in i.MX CPU driver

 MAINTAINERS                       |  7 +++
 cmd/cpu.c                         | 44 ++++++++++++++++-
 configs/imx8mm_evk_defconfig      |  3 ++
 configs/imx8mn_evk_defconfig      |  3 ++
 configs/imx8mp_evk_defconfig      |  3 ++
 configs/imx93_11x11_evk_defconfig |  1 +
 doc/usage/cmd/cpu.rst             | 82 +++++++++++++++++++++++++++++++
 drivers/cpu/cpu-uclass.c          | 10 ++++
 drivers/cpu/cpu_sandbox.c         |  6 +++
 drivers/cpu/imx8_cpu.c            | 36 ++++++++++++--
 include/cpu.h                     | 15 ++++++
 test/dm/cpu.c                     |  2 +
 12 files changed, 207 insertions(+), 5 deletions(-)
 create mode 100644 doc/usage/cmd/cpu.rst

-- 
2.43.0

