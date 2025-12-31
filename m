Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF24EE57C5
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 20:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88CBE841CD;
	Wed, 31 Dec 2025 21:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fNySQz6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01AE841D2; Wed, 31 Dec 2025 21:01:39 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A14A6841CC
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 21:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3857340D8E;
 Wed, 31 Dec 2025 20:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09182C113D0;
 Wed, 31 Dec 2025 20:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767211296;
 bh=CiQpY/kucNbFEJTnPEhH+Pg6KzSabj4gS79Z0TNG3+g=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=fNySQz6JN9pNmzkKcuSCvzFEqbz5Vb8rk0xypk0ArsEzjDzqvi86v8C2acwflEAlb
 BZWoXBIaeAiKWwxMdd5Iz43Fw+/FpJUVn0r/3eBpX0gDD8ND5CRSrIBmfYiDxG2hJ7
 2iC/+fLZmre1+dOc3+6caJio1LZrAckkDx41ov5F7e2y949aFAMW+glTqcUHCG3I2A
 1atXCuJvqzkQGv6U94Dwekpnunt0kCC3mE6lIfo11SzM3Cpv8D6s0ohlF9mq2QYdQM
 UDU+NcFwriEV0gZnZXkm3AT5ijUOecDZdgcxr2Gch01i7pqRlmAJesg7g4Nj4no1Uw
 rxFfj9ZpocX1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E89BFEE57C5;
 Wed, 31 Dec 2025 20:01:35 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 31 Dec 2025 21:01:30 +0100
Subject: [PATCH] Update links to doc/develop/falcon.rst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251231-falcon-v1-1-19c85b9660e6@posteo.net>
X-B4-Tracking: v=1; b=H4sIABmBVWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI2ND3bTEnOT8PF3zREtzI0PD1OSkpFQloOKCotS0zAqwQdGxtbUARof
 SBVgAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767211294; l=2407;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=J+TyZ145oHtwMkRYzz4f88+nsFYihWKo59QXQ6LSdWA=;
 b=t7k8bl5fDl8dP/dhs20WLqrjaI4WJFsuIfPEvkOMd3pimQc1b0OaTB40+Tyn5zkLS/inYJwe0
 K1EiOD5s68kDAQ1tT+17RPEjKsaIo/Yx+g06T9IiZrmhvINO1jSiU60
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

README.falcon was converted to HTML in 2023.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 cmd/Kconfig                 | 4 ++--
 common/spl/Kconfig          | 2 +-
 doc/board/ti/am335x_evm.rst | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

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
index 40e144948a3..a54439de29f 100644
--- a/doc/board/ti/am335x_evm.rst
+++ b/doc/board/ti/am335x_evm.rst
@@ -274,7 +274,7 @@ into memory, then written to NAND.
 Falcon Mode
 -----------
 
-The default build includes "Falcon Mode" (see doc/README.falcon) via NAND,
+The default build includes "Falcon Mode" (see doc/develop/falcon.rst) via NAND,
 eMMC (or raw SD cards) and FAT SD cards.  Our default behavior currently is
 to read a 'c' on the console while in SPL at any point prior to loading the
 OS payload (so as soon as possible) to opt to booting full U-Boot.  Also

---
base-commit: 8f520c0d5656196ec4912c837cc156a399350c33
change-id: 20251231-falcon-7a97211ecbbe

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


