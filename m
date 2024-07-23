Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62CFC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E4E387BF4;
	Tue, 23 Jul 2024 16:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29BD4879C1; Tue, 23 Jul 2024 16:43:23 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E54D879C1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BF1221A1165;
 Tue, 23 Jul 2024 16:43:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 87F641A0C15;
 Tue, 23 Jul 2024 16:43:17 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 41FB11802183; Tue, 23 Jul 2024 22:43:16 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv1 0/5] Add a subcommand 'release' to cmd/cpu.c
Date: Tue, 23 Jul 2024 23:03:55 +0800
Message-Id: <20240723150400.16650-1-Zhiqiang.Hou@nxp.com>
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

Hou Zhiqiang (5):
  cpu: add release_core callback
  cpu: imx: implement release_core callback
  cmd: cpu: add release subcommand
  configs: imx8m: enable the 'cpu' command
  configs: imx93: enable the 'cpu' command

 cmd/cpu.c                         | 44 +++++++++++++++++++++++++++++--
 configs/imx8mm_evk_defconfig      |  3 +++
 configs/imx8mn_evk_defconfig      |  3 +++
 configs/imx8mp_evk_defconfig      |  3 +++
 configs/imx93_11x11_evk_defconfig |  1 +
 drivers/cpu/cpu-uclass.c          | 10 +++++++
 drivers/cpu/imx8_cpu.c            | 26 +++++++++++++++++-
 include/cpu.h                     | 15 +++++++++++
 8 files changed, 102 insertions(+), 3 deletions(-)

-- 
2.17.1

