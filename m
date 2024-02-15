Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57CFC48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 14:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5FC387DFD;
	Thu, 15 Feb 2024 15:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="UoOkAMPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF5E87E15; Thu, 15 Feb 2024 15:01:13 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 340A88785F
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 15:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DEA88BFB57; Thu, 15 Feb 2024 15:01:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1708005669; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=IXdp8sEdZjJ4Kj9Tfam9iquf1M/xONwKxqOO8gZFDg8=;
 b=UoOkAMPNNNr+Af0xeRA69+IfER58khdBoo/nJ49FgGtg4AhhkBLsCAQxego091ALNXrtWs
 Y63DoBzLpYzYth4J2EYxUM2PVduxab+qMHB3mwc/Cy5g6w231cURLZ2WKA9LyKB2IXwzns
 hP0TNjDEq74k/La8S/015M+QC2yTWWFGDuXTO4nEYWVLgqWSaBXy5flC5OqCWwnBHGx/Rv
 e4w2f5crLzZsNvp4BKbRLWy+SiMRbJiqCTKWYKZbkIcW7KmaX14fdERLpVc/18Elm1ljgs
 XoYpb2Gx7lkrcIqqxlii6u7nMeLLqZcJ42yc5kWEd58upf8PmFQDwnMhLcGm6g==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kongyang Liu <seashell11234455@gmail.com>, Nishanth Menon <nm@ti.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Wei Fu <wefu@redhat.com>
Subject: [PATCH v4 3/3] doc: board: Add minimal documentation for Sielaff
 i.MX6 Solo board
Date: Thu, 15 Feb 2024 15:00:36 +0100
Message-ID: <20240215140043.220680-3-frieder@fris.de>
In-Reply-To: <20240215140043.220680-1-frieder@fris.de>
References: <20240215140043.220680-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Describe how to build and boot for the Sielaff i.MX6 Solo board.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v4:
* changes requested by Heinrich (thanks!)

Changes in v3:
* include docs in upper-level index

Changes in v2:
* none
---
 doc/board/index.rst                  |  1 +
 doc/board/sielaff/imx6dl-sielaff.rst | 29 ++++++++++++++++++++++++++++
 doc/board/sielaff/index.rst          |  9 +++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 doc/board/sielaff/imx6dl-sielaff.rst
 create mode 100644 doc/board/sielaff/index.rst

diff --git a/doc/board/index.rst b/doc/board/index.rst
index d0f9f355d2e..62357c99388 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -42,6 +42,7 @@ Board-specific doc
    renesas/index
    rockchip/index
    samsung/index
+   sielaff/index
    siemens/index
    sifive/index
    sipeed/index
diff --git a/doc/board/sielaff/imx6dl-sielaff.rst b/doc/board/sielaff/imx6dl-sielaff.rst
new file mode 100644
index 00000000000..699079b3271
--- /dev/null
+++ b/doc/board/sielaff/imx6dl-sielaff.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Sielaff i.MX6 Solo Board
+========================
+
+The Sielaff i.MX6 Solo board is a control and Human Machine Interface (HMI)
+board for vending machines.
+
+Quick Start
+-----------
+
+Build U-Boot
+^^^^^^^^^^^^
+
+.. code-block:: bash
+
+   make imx6dl_sielaff_defconfig
+   make CROSS_COMPILE=arm-linux-gnueabi-
+
+Copy the flash.bin file to an SD card at an offset of 1 KiB:
+
+.. code-block:: bash
+
+   dd if=flash.bin of=/dev/sd[x] bs=1K seek=1
+
+Boot
+^^^^
+
+Put the SD card in the slot on the board and apply power.
diff --git a/doc/board/sielaff/index.rst b/doc/board/sielaff/index.rst
new file mode 100644
index 00000000000..a8376484d88
--- /dev/null
+++ b/doc/board/sielaff/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Sielaff
+=======
+
+.. toctree::
+   :maxdepth: 2
+
+   imx6dl-sielaff
-- 
2.43.0

