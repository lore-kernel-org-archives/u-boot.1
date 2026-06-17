Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49632CD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B6A3849E4;
	Wed, 17 Jun 2026 14:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thundersoft.com header.i=@thundersoft.com header.b="TyeXQ+pe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D88848D7; Wed, 17 Jun 2026 12:56:56 +0200 (CEST)
Received: from mail-m103131191113.xmail.ntesmail.com
 (mail-m103131191113.xmail.ntesmail.com [103.131.191.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D634984833
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=thundersoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongyang.zhao@thundersoft.com
Received: from [127.0.1.1] (unknown [36.129.139.90])
 by smtp.qiye.163.com (Hmail) with ESMTP id 42c14b66d;
 Wed, 17 Jun 2026 18:56:49 +0800 (GMT+08:00)
From: Hongyang Zhao <hongyang.zhao@thundersoft.com>
Date: Wed, 17 Jun 2026 18:56:13 +0800
Subject: [PATCH 3/3] doc: board: qualcomm: Document RUBIK Pi 3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-qcs6490-rubikpi3-v1-3-495f618a1e4c@thundersoft.com>
References: <20260617-qcs6490-rubikpi3-v1-0-495f618a1e4c@thundersoft.com>
In-Reply-To: <20260617-qcs6490-rubikpi3-v1-0-495f618a1e4c@thundersoft.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Hongyang Zhao <hongyang.zhao@thundersoft.com>, 
 Roger Shimizu <rosh@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781693803; l=2897;
 i=hongyang.zhao@thundersoft.com; s=20260127; h=from:subject:message-id;
 bh=m33uyyKz+p6zh0vouXwdZt/hsafe/+NF+wvJkGmdlEo=;
 b=F3SKKr1PmN9HhUqXffXYT2rSOOIgoZGoi+gnobvo8Zo3MgSsJXCv3kMYv+XGlRKv17kg11DUg
 vlzlwU9pILcBHephnWmohdiX3sm7MGD+sTnrpq7760lTzjknTcIWFWi
X-Developer-Key: i=hongyang.zhao@thundersoft.com; a=ed25519;
 pk=D9yL5W9Zj0lPBDAq9gzY++1849VlXuTWAkROzZ88J/4=
X-HM-Tid: 0a9ed53a020f09d5kunme9f1286a14f7e0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkJDVk5DGklJGhhDQkhJGVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKSUJVSkhCVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
 lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=TyeXQ+peWSAdw9sWXwOmiulmlqRDzzPx/2KQMdGDf0fvHrpKZnkYH+FQ/yTrIUtUeT5zt4CIFgAK4Vj7BeA8gU5bjnAh4dYXunyODI6IcsW+lE//R34kfVd46P0Amd0BUavBLm23aWXdD5DwhGoGnLLUCODpoEXxcp0S7AxpiXQ=;
 s=default; c=relaxed/relaxed; d=thundersoft.com; v=1; 
 bh=xwjcZeUrWqdzv+iiZjNPumM8qkXqS/2NJgSzw1tgZmA=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:21 +0200
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

Add build and flashing instructions for running U-Boot on the
Thundercomm RUBIK Pi 3 and include the page in the Qualcomm board
documentation index.

Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
---
 doc/board/qualcomm/index.rst    |  1 +
 doc/board/qualcomm/rubikpi3.rst | 51 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 3238a68e859..5bd9714d927 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -11,6 +11,7 @@ Qualcomm
    dragonboard410c
    dragonwing
    rb3gen2
+   rubikpi3
    iq8
    phones
    rdp
diff --git a/doc/board/qualcomm/rubikpi3.rst b/doc/board/qualcomm/rubikpi3.rst
new file mode 100644
index 00000000000..4ef60ddf536
--- /dev/null
+++ b/doc/board/qualcomm/rubikpi3.rst
@@ -0,0 +1,51 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Hongyang Zhao <hongyang.zhao@thundersoft.com>
+
+Thundercomm RUBIK Pi 3
+======================
+
+The RUBIK Pi 3 is a development board based on the Qualcomm QCS6490 SoC,
+with 8 GiB LPDDR4x memory and 128 GiB UFS 2.2 storage. More information
+can be found on `Thundercomm's product page`_.
+
+U-Boot can be used as a replacement for Qualcomm's original EDK2 bootloader
+by flashing it directly to the ``uefi_a`` (or ``uefi_b``) partition.
+
+.. _Thundercomm's product page: https://www.thundercomm.com/rubik-pi-3/en/docs/about-rubikpi/
+
+Installation
+------------
+
+First, set up ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for
+``qcs6490_rubikpi3``::
+
+  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+  $ make qcs6490_rubikpi3_defconfig
+  $ make -j8
+
+This will build ``u-boot.elf`` in the configured output directory.
+
+Although the RUBIK Pi 3 does not have secure boot set up by default,
+the firmware still expects firmware ELF images to be "signed". The signature
+does not provide any security in this case, but it provides the firmware with
+some required metadata.
+
+To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
+
+  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
+
+Then install the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
+on your device with ``fastboot flash uefi_a u-boot.mbn``.
+
+U-Boot should be running after a reboot (``fastboot reboot``).
+
+Note that fastboot may not be available after replacing the original firmware.
+To restore the original firmware, or to install a new version of U-Boot, EDL
+mode can be used with the firehose loader binary appropriate for the board.
+
+A tool like bkerler's `edl`_ can be used for flashing::
+
+  $ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
+
+.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
+.. _edl: https://github.com/bkerler/edl

-- 
2.43.0

