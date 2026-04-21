Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D01F94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 377C7842FD;
	Wed, 22 Apr 2026 00:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="WWtDWdy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8BC384368; Wed, 22 Apr 2026 00:51:19 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A222483AC5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 607C5114935; Wed, 22 Apr 2026 00:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1776811875; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=XH8w6NlOsYb9HLoIdI+l+yf3Sqx6C8z+OqGapMIbcyU=;
 b=WWtDWdy9N7PlMhO8gnetC5HE2UVmzKe5oG7Rlf45i2xST0htGMR3MJfuw/NqHwl/tne1Wm
 QTaCBxYSDZVkYASc0gTfJhAUMSDtWalalMXmywWkulYdJPHsIiniqUOIB9PEQO2nuUBQx6
 0oxgc452KfD4mc9x8yDsO5NQ0/Y8fmxrWwk0rxYlOXRoJPI3tYaPMQhrE6aT0wR5ufdMvf
 Cc2MsyuxzA4s3G0LEaPWFbLYVEM2uBWEZjoH3T8ruQDEeOVwf6xD1m+TLBsuicx+OPSHyu
 kjCJMIxr/OlVtozz5WbTu23qkIgsJ//s4CsLGMNRc6C6VFFgW4Je2mn0fB6gGA==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Use N: for NXP entry
Date: Wed, 22 Apr 2026 00:50:42 +0200
Message-ID: <20260421225111.218951-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Reduce the NXP MAINTAINERS entry by using N: entry glob.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP i.MX U-Boot Team <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 056902f6ef2..7b39fe9b11c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -305,26 +305,13 @@ M:	Fabio Estevam <festevam@gmail.com>
 R:	NXP i.MX U-Boot Team <uboot-imx@nxp.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-imx.git
-F:	arch/Kconfig.nxp
+N:	imx
+N:	mxc
+N:	nxp
+N:	vf610
 F:	arch/arm/cpu/arm1136/mx*/
 F:	arch/arm/cpu/arm926ejs/mx*/
-F:	arch/arm/cpu/armv7/vf610/
-F:	arch/arm/dts/*imx*
-F:	arch/arm/mach-imx/
-F:	arch/arm/include/asm/arch-imx*/
 F:	arch/arm/include/asm/arch-mx*/
-F:	arch/arm/include/asm/arch-vf610/
-F:	arch/arm/include/asm/mach-imx/
-F:	board/nxp/*mx*/
-F:	board/nxp/common/
-F:	common/spl/spl_imx_container.c
-F:	doc/board/nxp/
-F:	doc/imx/
-F:	drivers/mailbox/imx-mailbox.c
-F:	drivers/remoteproc/imx*
-F:	drivers/serial/serial_mxc.c
-F:	drivers/spi/nxp_xspi.c
-F:	include/imx_container.h
 
 ARM HISILICON
 M:	Peter Griffin <peter.griffin@linaro.org>
-- 
2.53.0

