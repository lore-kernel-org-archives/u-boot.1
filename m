Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29211CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D975384B8D;
	Thu,  7 May 2026 18:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D0284B8D; Thu,  7 May 2026 18:40:50 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EAFD84A4D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wL1m8-000000006eE-2Db5; Thu, 07 May 2026 16:40:36 +0000
Date: Thu, 7 May 2026 17:40:33 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v3 1/7] image: fit: add dm-verity property name constants
Message-ID: <2e31c86281b809565469b0cd136aa3edf275ad35.1778171184.git.daniel@makrotopia.org>
References: <cover.1778171184.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778171184.git.daniel@makrotopia.org>
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
v3: no changes
v2: no changes

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
