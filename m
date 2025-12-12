Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9910D59D81
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 18:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 502FD83A41;
	Fri, 12 Dec 2025 19:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B213881D6A; Fri, 12 Dec 2025 19:13:43 +0100 (CET)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52BD83993
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 19:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dScym35dTzfGj;
 Fri, 12 Dec 2025 19:13:36 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dScyk6NfFzJ7p; Fri, 12 Dec 2025 19:13:34 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 12 Dec 2025 19:13:17 +0100
Subject: [PATCH 5/8] boot: specify VPL_FIT_FULL_CHECK applies to VPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-kconfig-reorg-v1-5-72441d8cc53c@cherry.de>
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

VPL_FIT_FULL_CHECK currently shares its description and help text with
FIT_FULL_CHECK which is quite confusing, so let's specify this applies
to VPL.

Fixes: 4218456b3fac ("vbe: Add Kconfig options for VPL")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index dc6988aca71..29179848418 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -379,13 +379,13 @@ config VPL_FIT_PRINT
 	  Support printing the content of the fitImage in a verbose manner in VPL.
 
 config VPL_FIT_FULL_CHECK
-	bool "Do a full check of the FIT before using it"
+	bool "Do a full check of the FIT within VPL before using it"
 	default y
 	help
-	  Enable this do a full check of the FIT to make sure it is valid. This
-	  helps to protect against carefully crafted FITs which take advantage
-	  of bugs or omissions in the code. This includes a bad structure,
-	  multiple root nodes and the like.
+	  Enable this do a full check of the FIT within VPL to make sure it is
+	  valid. This helps to protect against carefully crafted FITs which take
+	  advantage of bugs or omissions in the code. This includes a bad
+	  structure, multiple root nodes and the like.
 
 config VPL_FIT_SIGNATURE
 	bool "Enable signature verification of FIT firmware within VPL"

-- 
2.52.0

