Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478A5106F30F
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 09:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB1F83FAF;
	Thu, 26 Mar 2026 10:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lymJz/ot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A4181E18; Thu, 26 Mar 2026 10:12:08 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4844683F86
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=YSx6G/UikCX2TDNWw/wfbs86oUPB+8iR9ESa4TTdywk=; b=lymJz/otqHxcLiDjeUHWup/ehh
 49OlbhosuWfnjcWMOtKivTq87aJrhdLa9bl9pdH6ojPQj/vpDGfZ3G0gcXkwkdePBrhxLi5q5CkAL
 Reb9hlOUlmRDgMeuHJYzYlWAknFfajIN+d0TKgyHXlKBj2KX9sWsjR8+MjGPJoc6oLvcb04td11mF
 ha0LcRsCUdViPlpR/e+zmouaSMrlkU99KiZd4JfB/CsmyCNJfnU/FpZOFNPAqqk3XFz+37A8rJXG/
 NPFLNnJfeRFZmQiAKy2eepHfmKzrvxECjZcMH+4biMiRaPZGQBsjlsmOOPS+jA2nZj87v8ySTwW0y
 xYAGFOkA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5gl0-000O8b-0l; Thu, 26 Mar 2026 10:12:02 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w5gl0-000DCP-0B; Thu, 26 Mar 2026 10:12:01 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 8/8] doc: tqma7: add documentation
Date: Thu, 26 Mar 2026 10:11:36 +0100
Message-Id: <20260326091136.709342-9-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326091136.709342-1-Alexander.Feilke@ew.tq-group.com>
References: <20260326091136.709342-1-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Add readme for the tqma7 board.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 doc/board/tq/index.rst | 12 +++++++
 doc/board/tq/tqma7.rst | 77 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 doc/board/tq/index.rst
 create mode 100644 doc/board/tq/tqma7.rst

diff --git a/doc/board/tq/index.rst b/doc/board/tq/index.rst
new file mode 100644
index 00000000000..d6dc6101c2c
--- /dev/null
+++ b/doc/board/tq/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later or CC-BY-4.0
+
+.. Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+.. D-82229 Seefeld, Germany.
+
+TQ-Systems
+==========
+
+.. toctree::
+   :maxdepth: 2
+
+   tqma7
diff --git a/doc/board/tq/tqma7.rst b/doc/board/tq/tqma7.rst
new file mode 100644
index 00000000000..60fd883968d
--- /dev/null
+++ b/doc/board/tq/tqma7.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: CC-BY-4.0
+
+.. Copyright (c) 2020-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+.. D-82229 Seefeld, Germany.
+
+########################################
+U-Boot for the TQ-Systems TQMa7x modules
+########################################
+
+This file contains information for the port of
+U-Boot to the TQ-Systems TQMa7x modules.
+
+***********
+Boot source
+***********
+
+The following boot sources are supported:
+
+- SD/eMMC
+- USB (SDP)
+
+QSPI boot is functional but requires an additional prepended NXP header
+image. This currently unsupported in u-boot.
+
+********
+Building
+********
+
+To build U-Boot for the TQ-Systems TQMa7x modules:
+
+.. code-block:: bash
+
+	make tqma7_mba7_<boot>_defconfig
+	make
+
+**boot** is a placeholder for the boot device:
+
++------+-----------+
+| mmc  | SD/eMMC   |
++------+-----------+
+| uuu  | USB (SDP) |
++------+-----------+
+
+The default build artifact is named ``u-boot-with-spl.imx``.
+
+*****************************************
+Serial Download Protocol (SDP) / USB boot
+*****************************************
+
+The complete system image can be programmed with ``uuu``
+(https://github.com/nxp-imx/mfgtools) to eMMC.
+
+Serial Download Protocol is supported on the Micro-B USB port (X5) of MBa7x.
+The command ``fastboot usb 0`` is used to enable the fastboot gadget.
+
+Build SDP enabled U-Boot image
+==============================
+
+.. code-block:: bash
+
+	make <som>_mba7_uuu_defconfig
+	make
+
+Booting
+=======
+
+With UUU
+
+.. code-block:: bash
+
+	uuu -b spl <UUU U-Boot image>
+
+************
+Support Wiki
+************
+
+See `TQ Embedded Wiki for TQMa7x <https://support.tq-group.com/en/arm/tqma7x>`_.
-- 
2.34.1

