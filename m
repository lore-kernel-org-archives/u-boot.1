Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA3DC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 13:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F28A87E3A;
	Thu, 15 Feb 2024 14:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="gNwdib90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D72787E2A; Thu, 15 Feb 2024 14:36:16 +0100 (CET)
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF2187E20
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 14:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7076EBFBF8; Thu, 15 Feb 2024 14:36:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1708004166; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ME3YN3I4cTFYPbEp46GadvtFr4NveAU4IGUVh6Zx0FM=;
 b=gNwdib90GnyPV/m13YtC2hlPNXRNvLrpdblsagtf0S+jiSYdgzIf6JMvrAU+4y0mpO+Syg
 lKXl8pXEboZd64zhWCLZArCTrjvU4UidncAg4ncZCMBViJE6HC+hSQ4oxZrFag10LJzxri
 RdjTXBtj4422x+FoOqMwKKmCPEuBvHrpsD6+HbRjNEsp46nY884ZUsHyk/ST/3a14H1oKK
 dzIdWc1YmbkKNiBTvcEm7ExAoLKfhOAKLtK5B/X+k1RVWuhmDy6GYRF8Pp5do8wfT9W3Zx
 RtBaxL9mf+dssCzqmBinzK57N9KBdu/lMfyccxRAMtfvVInqeckn+cta22Ce+w==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kongyang Liu <seashell11234455@gmail.com>, Nishanth Menon <nm@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v3 3/3] doc: board: Add minimal documentation for Sielaff
 i.MX6 Solo board
Date: Thu, 15 Feb 2024 14:35:21 +0100
Message-ID: <20240215133527.216126-3-frieder@fris.de>
In-Reply-To: <20240215133527.216126-1-frieder@fris.de>
References: <20240215133527.216126-1-frieder@fris.de>
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
Changes in v3:
* include docs in upper-level index

Changes in v2:
* none
---
 doc/board/index.rst                  |  1 +
 doc/board/sielaff/imx6dl-sielaff.rst | 32 ++++++++++++++++++++++++++++
 doc/board/sielaff/index.rst          |  9 ++++++++
 3 files changed, 42 insertions(+)
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
index 00000000000..24dd67ccaef
--- /dev/null
+++ b/doc/board/sielaff/imx6dl-sielaff.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Sielaff i.MX6 Solo Board
+========================
+
+The Sielaff i.MX6 Solo board is a control and HMI board for vending
+machines.
+
+Quick Start
+-----------
+
+- Build U-Boot
+- Boot
+
+Build U-Boot
+^^^^^^^^^^^^
+
+.. code-block:: bash
+
+   $ make imx6dl_sielaff_defconfig
+   $ make CROSS_COMPILE=arm-none-linux-gnueabihf-
+
+Burn the flash.bin to SD card at an offset of 1 KiB:
+
+.. code-block:: bash
+
+   $ dd if=flash.bin of=/dev/sd[x] bs=1K seek=1 conv=notrunc
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

