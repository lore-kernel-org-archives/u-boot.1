Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB183C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3471C87EB7;
	Fri,  9 Feb 2024 10:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C05487E78; Fri,  9 Feb 2024 10:50:49 +0100 (CET)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc0d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1D9487EBB
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TWTcb2c9pzcCS;
 Fri,  9 Feb 2024 10:50:39 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TWTcZ0pyFzMppKP; Fri,  9 Feb 2024 10:50:38 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 09 Feb 2024 10:50:16 +0100
Subject: [PATCH v2 20/20] rockchip: ringneck_px30: update website link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-jaguar-v2-20-6c9ffe09b924@theobroma-systems.com>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
In-Reply-To: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.12.4
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The original link returns a custom 404, so let's point to a link that
works today instead.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 board/theobroma-systems/ringneck_px30/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/theobroma-systems/ringneck_px30/MAINTAINERS b/board/theobroma-systems/ringneck_px30/MAINTAINERS
index 601830fe45b..97baf334d02 100644
--- a/board/theobroma-systems/ringneck_px30/MAINTAINERS
+++ b/board/theobroma-systems/ringneck_px30/MAINTAINERS
@@ -8,4 +8,4 @@ F:	doc/board/theobroma-systems/
 F:	include/configs/ringneck_px30.h
 F:	arch/arm/dts/px30-ringneck*
 F:	configs/ringneck-px30_defconfig
-W:	https://www.theobroma-systems.com/px30-uq7#tech-spec
+W:	https://theobroma-systems.com/product/ringneck-som-px30-uq7/

-- 
2.43.0

