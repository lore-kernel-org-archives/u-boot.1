Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4731FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FBBE841D7;
	Sat, 25 Apr 2026 19:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8115841D7; Sat, 25 Apr 2026 19:15:09 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9083B84413
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wGKNL-000000000Mf-06Ge; Fri, 24 Apr 2026 17:31:35 +0000
Date: Fri, 24 Apr 2026 18:31:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/7] include: hexdump: make hex2bin() usable from host
 tools
Message-ID: <aeuo7zLvywgUvyTM@makrotopia.org>
References: <cover.1776302805.git.daniel@makrotopia.org>
 <8a5a44f1c0b0ede9e8a3f66e9cfad8807963e756.1776302806.git.daniel@makrotopia.org>
 <0F930E8B-9434-4365-9F64-2714E6C2A117@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0F930E8B-9434-4365-9F64-2714E6C2A117@gmx.de>
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

On Thu, Apr 16, 2026 at 01:00:31PM +0200, Heinrich Schuchardt wrote:
> Am 16. April 2026 03:46:42 MESZ schrieb Daniel Golle <daniel@makrotopia.org>:
> >Make hexdump.h work in host-tool builds by using 'uint8_t' instead
> >of 'u8', and including either user-space libc <ctype.h> for host-tools
> >or <linux/ctype.h> when building U-Boot itself.
> >
> >Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >---
> >v2: new patch
> >
> > include/hexdump.h | 8 ++++++--
> > 1 file changed, 6 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/hexdump.h b/include/hexdump.h
> >index f2ca4793d69..5cb48d79efe 100644
> >--- a/include/hexdump.h
> >+++ b/include/hexdump.h
> >@@ -7,7 +7,11 @@
> > #ifndef HEXDUMP_H
> > #define HEXDUMP_H
> > 
> >+#ifdef USE_HOSTCC
> >+#include <ctype.h>
> >+#else
> > #include <linux/ctype.h>
> 
> uin8_t is defined in stdint.h.
> Don't we need it in the HOSTCC case?

tools/Makefile force-includes include/compiler.h for every host-tool
compiler.h, and that unconditionally #include <stdint.h> in its
USE_HOSTCC.

While uint*_t are widely used, the general mechanism seems to be to
rely on compiler.h rather than explicitely including stdint.h
(but exceptions do exist)
