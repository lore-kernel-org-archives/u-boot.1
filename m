Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977C1CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 16:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE7583BC7;
	Tue, 11 Nov 2025 17:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="vxVlHqYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A05D83BC9; Tue, 11 Nov 2025 17:55:28 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE64183BB5
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 17:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2973DC9F42; Tue, 11 Nov 2025 17:55:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1762880127; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=9UM3vIqKq01y5F0ihG7uvudDaYfabt2yCFVTr0zMQeQ=;
 b=vxVlHqYepwCnEAPsttJ84hOcXFLlMoPG3Mf8IuMGO+l3IAW1QPnI/6A5ESKOy2Urysrtp0
 NgnMZ241kCuGkyOOT+j7LXTGtbO+lGt8vNQ3N8mYNq+2t6TYa0POKlG5gCdv4tuaNBwQWR
 qtkEfoTcKpnNY9o+jjH7taXhbnMSXtf5CQLAKFRpK44ua5Sb2QM88a6ScPRN3qjk9srCcr
 Jl80fuiDZRkw5jWOIjOzCbZPzdnIkRI8hsRfoPaUKexsCT+zm3GUepx1r+xzTggmqHu7Nr
 31zM4/MeAzAgSXQBFuem0CqB9X17eZ6n6HZkqgoOJzNV3NWMJrb7ZWCM9beprw==
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Wadim Egorov <w.egorov@phytec.de>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v2 2/3] arm: imx: imx9: Use arch override for
 env_get_location()
Date: Tue, 11 Nov 2025 17:54:19 +0100
Message-ID: <20251111165509.212632-3-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111165509.212632-1-frieder@fris.de>
References: <20251111165509.212632-1-frieder@fris.de>
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The arch-level implementation should be used here so that
env_get_location() can be used on board-level.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* none
---
 arch/arm/mach-imx/imx9/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 3f7dafdcce5..583c3a5a464 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -783,7 +783,7 @@ int timer_init(void)
 	return 0;
 }
 
-enum env_location env_get_location(enum env_operation op, int prio)
+enum env_location arch_env_get_location(enum env_operation op, int prio)
 {
 	enum boot_device dev = get_boot_device();
 
-- 
2.51.0

