Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA6DD59D82
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 18:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FCB18389A;
	Fri, 12 Dec 2025 19:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EB36839A8; Fri, 12 Dec 2025 19:13:35 +0100 (CET)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B2E83869
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 19:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dScyj18xhzn23;
 Fri, 12 Dec 2025 19:13:33 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dScyg4PW3zGBT; Fri, 12 Dec 2025 19:13:31 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 12 Dec 2025 19:13:15 +0100
Subject: [PATCH 3/8] boot: fix prompt for SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-kconfig-reorg-v1-3-72441d8cc53c@cherry.de>
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

The prompt currently doesn't specify this applies to the SPL stage only,
so let's fix this oversight.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 07ae6cc585a..3e882d3f4f9 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -292,7 +292,7 @@ config SPL_LOAD_FIT_APPLY_OVERLAY
 config SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
 	depends on SPL_LOAD_FIT_APPLY_OVERLAY
 	default 0x10000
-	hex "size of temporary buffer used to load the overlays"
+	hex "size of temporary buffer used to load the overlays within SPL"
 	help
 	  The size of the area where the overlays will be loaded and
 	  uncompress. Must be at least as large as biggest overlay

-- 
2.52.0

