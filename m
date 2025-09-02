Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55328CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 13:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F2F83AEF;
	Tue,  2 Sep 2025 14:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="Ow93M7pm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31EB583A91; Tue,  2 Sep 2025 12:08:43 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8463883A6A
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 12:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=333b0acd5=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1756807720; x=1788343720;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NwmDpWp9M9KmKjmep34FoTNujruG5oAna2HU3QVYwfw=;
 b=Ow93M7pmLieLbwNYOyMTltJleGqJnWrVHS4PY09y7rAlziDOY8fjjJol
 iwl5pKZiYvNBbzYjd2lfkpnjBSRQXEzTRrPmsh9d4KyVJEOkU0wzfS07u
 1PJ2wZQLTl8MsIb4V0LkFI+Z8NME9Q6xAs14QjHfWHT0qF+62JT92eoEl
 8mQxys09Lf0FNCc/AqcZsopZk/VQ7G9cE9DaMC/GjPJUdBlsRHSYEfhVH
 ai0ucAWHQdVZ7bQQMBjOy4CMyYNzGa2pBvCvYHz33gL6La4Rb7aa7s5Zi
 8jb2lgZFjMK6dlWYunHvdu/shoz0XfHuQ/zUseC5Im47bxIlx+Ap6iDtI Q==;
X-CSE-ConnectionGUID: dAoXEF20Sg+QcJeUFj1LGA==
X-CSE-MsgGUID: m2fBVo9TRLqWwD95+sMYCA==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="45375671"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Sep 2025 03:08:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 03:07:34 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 03:07:32 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 4/6] doc: microchip: add mpfs_video.rst
Date: Tue, 2 Sep 2025 11:11:01 +0100
Message-ID: <20250902101105.3218793-5-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902101105.3218793-1-jamie.gibbons@microchip.com>
References: <20250902101105.3218793-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 02 Sep 2025 14:59:00 +0200
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

Add documentation to support the addition of the MPFS Video Kit.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 doc/board/microchip/index.rst      |   1 +
 doc/board/microchip/mpfs_video.rst | 105 +++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 doc/board/microchip/mpfs_video.rst

diff --git a/doc/board/microchip/index.rst b/doc/board/microchip/index.rst
index affc5a9e014..571b8877f08 100644
--- a/doc/board/microchip/index.rst
+++ b/doc/board/microchip/index.rst
@@ -7,3 +7,4 @@ Microchip
    :maxdepth: 2
 
    mpfs_icicle
+   mpfs_video
diff --git a/doc/board/microchip/mpfs_video.rst b/doc/board/microchip/mpfs_video.rst
new file mode 100644
index 00000000000..25df63ff14b
--- /dev/null
+++ b/doc/board/microchip/mpfs_video.rst
@@ -0,0 +1,105 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Microchip PolarFire SoC Video Kit
+==================================
+
+RISC-V PolarFire SoC
+--------------------
+
+The PolarFire SoC is the 4+1 64-bit RISC-V SoC from Microchip.
+
+The Video Kit development platform is based on PolarFire SoC and capable
+of running Linux.
+
+Mainline support
+----------------
+
+The support for following drivers are already enabled:
+
+1. NS16550 UART Driver.
+2. Microchip Clock Driver.
+3. Cadence MACB ethernet driver for networking support.
+4. Cadence MMC Driver for eMMC/SD support.
+5. Microchip I2C Driver.
+
+.. include:: mpfs_build_boot.rst
+
+Microchip boot-flow
+~~~~~~~~~~~~~~~~~~~
+
+HSS with OpenSBI (M-Mode) -> U-Boot (S-Mode) -> Linux (S-Mode)
+
+Build the HSS (Hart Software Services) - Microchip boot-flow
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+(Note: HSS git repo is at https://github.com/polarfire-soc/hart-software-services)
+
+1. Configure
+
+.. code-block:: none
+
+   make BOARD=mpfs-video-kit config
+
+Alternatively, copy the default config for Microchip boot-flow.
+
+.. code-block:: none
+
+   cp boards/mpfs-video-kit/def_config .config
+
+2. make BOARD=mpfs-video-kit
+3. In the Default subdirectory, the standard build will create hss.elf and
+   various binary formats (hss.hex and hss.bin).
+
+The FPGA design will use the hss.hex or hss.bin.
+
+.. include:: mpfs_design_hss.rst
+
+Custom boot-flow
+~~~~~~~~~~~~~~~~
+
+HSS without OpenSBI (M-Mode) -> OpenSBI (M-Mode) -> U-Boot (S-Mode) -> Linux (S-Mode)
+
+Build OpenSBI
+'''''''''''''
+
+1. Get the OpenSBI source
+
+.. code-block:: none
+
+   git clone https://github.com/riscv/opensbi.git
+   cd opensbi
+
+2. Build
+
+.. code-block:: none
+
+   make PLATFORM=generic FW_PAYLOAD_PATH=<u-boot-directory>/u-boot.bin
+   FW_FDT_PATH=<u-boot-directory>/dts/upstream/src/riscv/microchip/mpfs-sev-kit-.dtb
+
+3. Output "fw_payload.bin" file available at
+   "<opensbi-directory>/build/platform/generic/firmware/fw_payload.bin"
+
+Build the HSS (Hart Software Services)- Custom boot-flow
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+(Note: HSS git repo is at https://github.com/polarfire-soc/hart-software-services)
+
+1. Configure
+
+.. code-block:: none
+
+   make BOARD=mpfs-video-kit config
+
+Alternatively, copy the default custom config for Custom boot-flow.
+
+.. code-block:: none
+
+   cp boards/mpfs-video-kit/def_config_custom .config
+
+2. make BOARD=mpfs-video-kit
+3. In the Default subdirectory, the standard build will create hss.elf and
+   various binary formats (hss.hex and hss.bin).
+
+The FPGA design will use the hss.hex or hss.bin.
+
+.. include:: mpfs_common.rst
-- 
2.43.0

