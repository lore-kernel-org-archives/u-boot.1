Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F26FCD37AC
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 02:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC9FD83EF9;
	Wed, 13 May 2026 04:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F2B4845C8; Wed, 13 May 2026 04:09:32 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B36783EEF
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 04:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wMz2D-000000008HU-2ecL; Wed, 13 May 2026 02:09:17 +0000
Date: Wed, 13 May 2026 03:09:13 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Daniel Golle <daniel@makrotopia.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v4 3/8] include: hexdump: make hex2bin() usable from host tools
Message-ID: <d49e33616a266fe597b13cc679ea9af39de3082c.1778637233.git.daniel@makrotopia.org>
References: <cover.1778637233.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778637233.git.daniel@makrotopia.org>
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

Make hexdump.h work in host-tool builds by using 'uint8_t' instead
of 'u8', and including either user-space libc <ctype.h> for host-tools
or <linux/ctype.h> when building U-Boot itself.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v4: no changes
v3: no changes
v2: new patch

 include/hexdump.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hexdump.h b/include/hexdump.h
index f2ca4793d69..5cb48d79efe 100644
--- a/include/hexdump.h
+++ b/include/hexdump.h
@@ -7,7 +7,11 @@
 #ifndef HEXDUMP_H
 #define HEXDUMP_H
 
+#ifdef USE_HOSTCC
+#include <ctype.h>
+#else
 #include <linux/ctype.h>
+#endif
 #include <linux/types.h>
 
 enum dump_prefix_t {
@@ -20,7 +24,7 @@ extern const char hex_asc[];
 #define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
 #define hex_asc_hi(x)	hex_asc[((x) & 0xf0) >> 4]
 
-static inline char *hex_byte_pack(char *buf, u8 byte)
+static inline char *hex_byte_pack(char *buf, uint8_t byte)
 {
 	*buf++ = hex_asc_hi(byte);
 	*buf++ = hex_asc_lo(byte);
@@ -52,7 +56,7 @@ static inline int hex_to_bin(char ch)
  *
  * Return 0 on success, -1 in case of bad input.
  */
-static inline int hex2bin(u8 *dst, const char *src, size_t count)
+static inline int hex2bin(uint8_t *dst, const char *src, size_t count)
 {
 	while (count--) {
 		int hi = hex_to_bin(*src++);
-- 
2.54.0
