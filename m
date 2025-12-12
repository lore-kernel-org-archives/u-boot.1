Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE7ED59D82
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 18:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D5F83984;
	Fri, 12 Dec 2025 19:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4230083984; Fri, 12 Dec 2025 19:13:37 +0100 (CET)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fa9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C06835B3
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 19:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dScyd55FgzkSs;
 Fri, 12 Dec 2025 19:13:29 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dScyc0zTbzJ7k; Fri, 12 Dec 2025 19:13:28 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 12 Dec 2025 19:13:13 +0100
Subject: [PATCH 1/8] Kconfig: put TPL_OPTIMIZE_INLINING next to
 SPL_OPTIMIZE_INLINING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-kconfig-reorg-v1-1-72441d8cc53c@cherry.de>
References: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
In-Reply-To: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
To: u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Justin Klaassen <justin@tidylabs.net>, Samuel Holland <samuel@sholland.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Right now LTO is in-between both when using menuconfig.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Kconfig b/Kconfig
index 1d600342685..c435fb43182 100644
--- a/Kconfig
+++ b/Kconfig
@@ -140,6 +140,15 @@ config SPL_OPTIMIZE_INLINING
 	  do what it thinks is best, which is desirable in some cases for size
 	  reasons.
 
+config TPL_OPTIMIZE_INLINING
+	bool "Allow compiler to uninline functions marked 'inline' in TPL"
+	depends on TPL
+	help
+	  This option determines if U-Boot forces gcc to inline the functions
+	  developers have marked 'inline'. Doing so takes away freedom from gcc to
+	  do what it thinks is best, which is desirable in some cases for size
+	  reasons.
+
 config ARCH_SUPPORTS_LTO
 	bool
 
@@ -163,15 +172,6 @@ config LTO
 
 	  If unsure, say n.
 
-config TPL_OPTIMIZE_INLINING
-	bool "Allow compiler to uninline functions marked 'inline' in TPL"
-	depends on TPL
-	help
-	  This option determines if U-Boot forces gcc to inline the functions
-	  developers have marked 'inline'. Doing so takes away freedom from gcc to
-	  do what it thinks is best, which is desirable in some cases for size
-	  reasons.
-
 config CC_COVERAGE
 	bool "Enable code coverage analysis"
 	depends on SANDBOX

-- 
2.52.0

