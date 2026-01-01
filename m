Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8EAEED60F
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 14:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF1083EB7;
	Thu,  1 Jan 2026 15:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jK5C6nLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0BA683FC0; Thu,  1 Jan 2026 15:17:13 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E32F83BB1
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 15:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AB44F60008;
 Thu,  1 Jan 2026 14:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59FE2C4CEF7;
 Thu,  1 Jan 2026 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767277029;
 bh=UHOa5I4FdX8qTSRHSKE4cmEk3ExnlAZAg2EqFMdzuRE=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=jK5C6nLxFilIl8+eopWUbnP/lEd+tyIoC5O75+/0M9JWu+2ukDlcFsiekofHTWeJR
 JVHZ7fa/2oihZRftL2xbScSMZaISVpMmdUTt4TLXcgZ4e0XVXl38bl2TWnPCEEboFc
 y2JN7rf2kKTsJi1Kw3aKe2S9gqPU4XpmiHmtTy7YhQi4ka8XiT08+I1hRPtorbHjIZ
 EJNqHbBqHrH6qk5INIndVqvLmfqoVNUOlf8bjrNMbbSxGAWwBbMIrvFQFRqUnaSLtI
 9nYb9LNPTahMfiGLKmP9M9h6oefCBNq/aoEEtq3K+B40eWTcF4aVbEbbNoZwDqu96T
 l4e2E6WKOlupg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 46FE9EED601;
 Thu,  1 Jan 2026 14:17:09 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 01 Jan 2026 15:17:01 +0100
Subject: [PATCH v2] Update links to doc/develop/falcon.rst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260101-falcon-v2-1-75896535ad0f@posteo.net>
X-B4-Tracking: v=1; b=H4sIANyBVmkC/2WMQQrDIBBFrxJmXUvGElO7yj1KFmonzUDRoCItw
 bvXZlv+6n0eb4dEkSnBrdshUuHEwTeQpw7cavyTBD8ag+zlgPKCYjEvF7wYjR4lIjlrCZq8RVr
 4fYTuc+OVUw7xc3QL/t6/REHRpt11sFqpntS0hZQpnD1lmGutX1ReOgKdAAAA
X-Change-ID: 20251231-falcon-7a97211ecbbe
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sidharth Seela <sidharthseela@gmail.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767277028; l=2880;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=uzyoTCT099z/Hlho/K2kyDiQU5MpWiXI/6PFq2lGyu4=;
 b=h1splMZr22ZTTifPeBQXfcAoDneceK8Fanc20Gp6OvJgB8PbHkYJPlCPx2syIz3qYXezvKYFJ
 Xpq5WzB6biFARFZFiTTSJPnO2xnnQGkueJ0L/gXHDEO7T/Ez9rfTKOD
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

README.falcon was converted to ReST/HTML in 2023.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v2:
- Use a proper link within ReST (thanks to Heinrich Schuchardt's review)
- Link to v1: https://lore.kernel.org/r/20251231-falcon-v1-1-19c85b9660e6@posteo.net
---
 cmd/Kconfig                 | 4 ++--
 common/spl/Kconfig          | 2 +-
 doc/board/ti/am335x_evm.rst | 2 +-
 doc/develop/falcon.rst      | 1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b71ac554c0b..fca2a0b0e39 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -620,7 +620,7 @@ config CMD_SPL
 	help
 	  Falcon mode allows booting directly from SPL into an Operating
 	  System such as Linux, thus skipping U-Boot proper. See
-	  doc/README.falcon for full information about how to use this
+	  doc/develop/falcon.rst for full information about how to use this
 	  command.
 
 config CMD_SPL_NAND_OFS
@@ -629,7 +629,7 @@ config CMD_SPL_NAND_OFS
 	default 0x0
 	help
 	  This provides the offset of the command line arguments for Linux
-	  when booting from NAND in Falcon mode.  See doc/README.falcon
+	  when booting from NAND in Falcon mode.  See doc/develop/falcon.rst
 	  for full information about how to use this option (and also see
 	  board/gateworks/gw_ventana/README for an example).
 
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4b10e9c3880..f0612acf0c2 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1209,7 +1209,7 @@ config SPL_OS_BOOT
 	depends on ARM || MICROBLAZE || PPC
 	help
 	  Enable booting directly to an OS from SPL.
-	  for more info read doc/README.falcon
+	  for more info read doc/develop/falcon.rst
 
 config SPL_OS_BOOT_SECURE
 	bool "Allow Falcon Mode on secure devices"
diff --git a/doc/board/ti/am335x_evm.rst b/doc/board/ti/am335x_evm.rst
index 40e144948a3..b14ba41917e 100644
--- a/doc/board/ti/am335x_evm.rst
+++ b/doc/board/ti/am335x_evm.rst
@@ -274,7 +274,7 @@ into memory, then written to NAND.
 Falcon Mode
 -----------
 
-The default build includes "Falcon Mode" (see doc/README.falcon) via NAND,
+The default build includes :ref:`falcon-mode` via NAND,
 eMMC (or raw SD cards) and FAT SD cards.  Our default behavior currently is
 to read a 'c' on the console while in SPL at any point prior to loading the
 OS payload (so as soon as possible) to opt to booting full U-Boot.  Also
diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
index 528a9c389bf..3fc23f65c45 100644
--- a/doc/develop/falcon.rst
+++ b/doc/develop/falcon.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
+.. _falcon-mode:
 
 Falcon Mode
 ===========

---
base-commit: 4933a0e67578789a57f540a378ce0698435b7b17
change-id: 20251231-falcon-7a97211ecbbe

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


