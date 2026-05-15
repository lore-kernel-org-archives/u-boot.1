Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE145CD343F
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3858F84812;
	Sat, 16 May 2026 03:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E6B84886; Sat, 16 May 2026 01:38:12 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5DA084812
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wO26F-000000004g3-0qqz; Fri, 15 May 2026 23:37:47 +0000
Date: Sat, 16 May 2026 00:37:43 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Daniel Golle <daniel@makrotopia.org>, Anshul Dalal <anshuld@ti.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v5 1/8] image: fit: add dm-verity property name constants
Message-ID: <723fa7d7d9211fea1e66ad18b07722cb9625cb14.1778887196.git.daniel@makrotopia.org>
References: <cover.1778887196.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778887196.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Sat, 16 May 2026 03:04:00 +0200
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

Add FIT_VERITY_NODENAME and the complete set of FIT_VERITY_*_PROP
constants for the dm-verity child node of filesystem-type images, plus
the five optional boolean error-handling property names aligned with the
flat-image-tree specification.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
v5: no changes
v4: no changes
v3: no changes
v2: no changes
---
 include/image.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/image.h b/include/image.h
index 34efac6056d..482446a8115 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1079,6 +1079,23 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_CIPHER_NODENAME	"cipher"
 #define FIT_ALGO_PROP		"algo"
 
+/* dm-verity node */
+#define FIT_VERITY_NODENAME	"dm-verity"
+#define FIT_VERITY_ALGO_PROP	"algo"
+#define FIT_VERITY_DBS_PROP	"data-block-size"
+#define FIT_VERITY_HBS_PROP	"hash-block-size"
+#define FIT_VERITY_NBLK_PROP	"num-data-blocks"
+#define FIT_VERITY_HBLK_PROP	"hash-start-block"
+#define FIT_VERITY_DIGEST_PROP	"digest"
+#define FIT_VERITY_SALT_PROP	"salt"
+
+/* dm-verity error-handling modes (optional boolean property names) */
+#define FIT_VERITY_OPT_RESTART	"restart-on-corruption"
+#define FIT_VERITY_OPT_PANIC	"panic-on-corruption"
+#define FIT_VERITY_OPT_RERR	"restart-on-error"
+#define FIT_VERITY_OPT_PERR	"panic-on-error"
+#define FIT_VERITY_OPT_ONCE	"check-at-most-once"
+
 /* image node */
 #define FIT_DATA_PROP		"data"
 #define FIT_DATA_POSITION_PROP	"data-position"
-- 
2.54.0
