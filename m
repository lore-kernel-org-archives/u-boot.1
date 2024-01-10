Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34E0C4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 12:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C378187A7B;
	Wed, 10 Jan 2024 13:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lWEZuk4V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 036D787AB3; Wed, 10 Jan 2024 13:58:11 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED7A87A3B
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 13:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1704891486; x=1707483486;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Px1I9kTRbe+5sGLPRn+BUJfY6wNFXLIBP0E7fTKIeeU=;
 b=lWEZuk4VsBeN+wVgxvIAZanI4AiaD+ewDqMTVxgtwfqpDS45UO0vwROUnv+xrfNe
 ya1Dnpbfyv6EzzYZQBwGka6tItKxYvddloK6zuLsxXeEfZkI1bMr2MraQHWBUZN+
 DrgpJzPfgppU7kEbhidvGV+WmUZ7KdUup80RGLngvqw=;
X-AuditID: ac14000a-fadff7000000290d-b9-659e945e290c
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D9.45.10509.E549E956;
 Wed, 10 Jan 2024 13:58:06 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 10 Jan
 2024 13:58:06 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 10 Jan 2024 13:57:42 +0100
Subject: [PATCH 2/2] doc: board: phytec: Add phyGATE-Tauri board documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v1-2-1ba2d9220da6@phytec.de>
References: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v1-0-1ba2d9220da6@phytec.de>
In-Reply-To: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v1-0-1ba2d9220da6@phytec.de>
To: Fabio Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWyRpKBRzduyrxUg823rCweXvW3eLu3k91i
 yuP17Bbd79QdWDx2zrrL7nH2zg5Gj/7uFlaPje92MAWwRHHZpKTmZJalFunbJXBl3PhSV3BY
 sOLK/UOMDYzb+LoYOTkkBEwkDr88ygJiCwksZpJY/ykRwn7IKHHovBKIzSagIvH4xT3WLkYO
 DhYBVYlthwNATGGBAIklx6xBKngFBCVOznzCAhJmFtCUWL9LHyTMLCAvsf3tHGaIkgiJ3vM/
 oBZFSBw7fYwNxOYUiJRYdvoWWFxEoExiW28/1JgIiTmPzCBuFJZoX3SLCaJVVuLF+V52iLi8
 xLRzr5kh7FCJrV+2M01gFJqF5KBZCAfNQnLQAkbmVYxCuZnJ2alFmdl6BRmVJanJeimpmxhB
 YS3CwLWDsW+OxyFGJg7GQ4wSHMxKIrwKn+ekCvGmJFZWpRblxxeV5qQWH2KU5mBREudd3RGc
 KiSQnliSmp2aWpBaBJNl4uCUamCMemy7OKz7davjpQ8xQSu8Hi39s0Wcf+3TXyKrNJ2t/5zl
 ld59/l5swokNK2dzSSsvPXQ+Rf7ehA/8pxLDHA6GZcgKqHduv21QYaccp6i3Q1/O+Lqz40Gd
 vuQLizZrC6dmBupOU5UWyr6b/U5foPCA26aN+zlPpEc9Wlf17KGLtXCn45SYGDclluKMREMt
 5qLiRADojRlDWQIAAA==
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

Add brief documentation on how to build a bootable U-Boot image for the
phyGATE-Tauri-L.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 60 +++++++++++++++++++++++++++++
 doc/board/phytec/index.rst                  |  1 +
 2 files changed, 61 insertions(+)

diff --git a/doc/board/phytec/imx8mm-phygate-tauri-l.rst b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
new file mode 100644
index 00000000000..28b614fd144
--- /dev/null
+++ b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+phyGATE-Tauri-L-i.MX 8M Mini
+============================
+
+The phyGATE-Tauri-L-i.MX 8M Mini with 2GB of main memory is supported.
+
+Quick Start
+-----------
+
+- Build the ARM Trusted firmware binary
+- Get ddr firmware
+- Build U-Boot
+- Boot
+
+Build the ARM Trusted firmware binary
+-------------------------------------
+
+.. code-block:: bash
+
+   $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
+   $ cd trusted-firmware-a
+   $ export CROSS_COMPILE=aarch64-linux-gnu
+   $ export IMX_BOOT_UART_BASE=0x30880000
+   $ make PLAT=imx8mm bl31
+
+Get the ddr firmware
+--------------------
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.23.bin
+   $ chmod +x firmware-imx-8.23.bin
+   $ ./firmware-imx-8.23.bin
+
+Build U-Boot for SD card
+------------------------
+
+Copy binaries
+^^^^^^^^^^^^^
+
+.. code-block:: bash
+
+   $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
+   $ cp firmware-imx-8.23/firmware/ddr/synopsys/lpddr4*.bin .
+
+Build U-Boot
+^^^^^^^^^^^^
+
+.. code-block:: bash
+
+   $ make imx8mm-phygate-tauri-l_defconfig
+   $ make flash.bin
+
+Flash SD card
+^^^^^^^^^^^^^
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1024 seek=33 conv=sync
diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
index a5b442045ed..9996bce9741 100644
--- a/doc/board/phytec/index.rst
+++ b/doc/board/phytec/index.rst
@@ -6,5 +6,6 @@ PHYTEC
 .. toctree::
    :maxdepth: 2
 
+   imx8mm-phygate-tauri-l
    phycore-imx8mm
    phycore-imx8mp

-- 
2.34.1

