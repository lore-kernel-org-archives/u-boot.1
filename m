Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE4FD185EC
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 12:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84C2383B8A;
	Thu,  8 Jan 2026 13:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2918A84119; Thu,  8 Jan 2026 13:28:46 +0100 (CET)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8CCF839F1
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 13:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dn42M37GBz6h8;
 Thu,  8 Jan 2026 13:28:43 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dn42L2BYcz8Mw; Thu,  8 Jan 2026 13:28:42 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 08 Jan 2026 13:28:36 +0100
Subject: [PATCH v2] spl: fix incorrect dependency for SPL_NET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-spl_net-deps-v2-1-e412128520f2@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMywqDMBBFf0Vm3RTzsBpX/Y8iRcykCZQYMhIqk
 n9v6r7Lcy/nHECYPBKMzQEJsye/hgri0sDi5vBC5k1lEK3ouOADo/h+BtyYwUjsJtpe2HooOUN
 VYkLrP2fuMVV2nrY17Wc989/6J5Q54wy1klYOWne9ui8OU9qvBmEqpXwBsbKdsqgAAAA=
X-Change-ID: 20251218-spl_net-deps-62072f51243a
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Jerome Forissier <jerome@forissier.org>, 
 Jerome Forissier <jerome@forissier.org>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
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

When SPL_NET is included, scripts/Makefile.xpl includes net/. However,
in this directory, the Makefile only compiles things if CONFIG_NET or
CONFIG_NET_LWIP is defined (it doesn't use $(PHASE_)). Therefore, at
least one networking stack needs to be enabled for SPL_NET=y to do
anything meaningful.

In certain cases (e.g. am62px_evm_r5_ethboot_defconfig + NO_NET=y via
menuconfig), it is possible to fail the build with undefined references
(since include/net-common.h does check with CONFIG_IS_ENABLED(NET) which
would be true for SPL_NET, but the implementation wouldn't be compiled).

Fix this oversight by making sure a network stack (and the legacy one)
is available when selecting SPL_NET.

Fixes: 8cb330355bd5 ("net: introduce alternative implementation as net/lwip/")
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
I'm wondering if this is the proper fix... Maybe we should migrate
net/Makefile to use $(PHASE_) there instead? This would allow SPL_NET
(haven't checked the whole codebase, maybe we still have CONFIG_NET
checks instead of IS_ENABLED(NET) where we shouldn't) to build without
any network stack in proper (meaning that SPL_NET is selecting the
legacy networking stack for SPL only), and maybe even that would allow
us to have legacy stack in SPL and lwip stack in proper? This seems like
a much bigger task than this simple patch here.
---
Changes in v2:
- Added Rb from Jerome,
- Reworded commit log,
- Added question on whether this is the proper fix now that I spent a
  bit more time looking at it,
- Rebased on top of master,
- Link to v1: https://patch.msgid.link/20251218-spl_net-deps-v1-1-e943f3899574@cherry.de
---
 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4f4119f5806..c7db88345b4 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1153,7 +1153,7 @@ config SPL_DM_SPI_FLASH
 
 config SPL_NET
 	bool "Support networking"
-	depends on !NET_LWIP
+	depends on NET
 	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF
 	help
 	  Enable support for network devices (such as Ethernet) in SPL.

---
base-commit: 141be72e2a9d43aa4e3d1a6a6e0ab8f9eb8784c6
change-id: 20251218-spl_net-deps-62072f51243a

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

