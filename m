Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6928ACCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 10:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AEAC83F7A;
	Tue, 11 Nov 2025 11:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="XapMGRcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A3D83F7A; Tue, 11 Nov 2025 11:31:54 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0863C83F6E
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 05FE8C9EF6; Tue, 11 Nov 2025 11:31:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1762857111; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=f8HnJqm5/LTkk5sXTAQZAm+39U6RNe/C5Ez5eERL/Tw=;
 b=XapMGRcUTAAkGIWR8tJs4yPaWRTyrgmh72e1dTp+XV/Q8n/C61XKFVK6Po07edFT5w9D1c
 cR7t9vvTtJVBffP0SyUsIlicadsLUWlzcXb67dOOfVqdud2+fHTpmmyxon2eVgG3ccVB9U
 fHbZX3lm3QF7NPiSp7bBnWEP9kMyQVO//8thiw6RBhclvykXb9ZvCVsrhFnt6oNCudrZYC
 JDY8fPAPwul/85xrMfXGEF/pyOUQqGDReo8oPf9f6fHTeUzAdSfqlJMqHJ2AMJnx7QTooZ
 NB8A73hpr7Ufb0TiEL2mz8oFiZgZ96rhSofDLPodAvMJg0/CuLb2p/IDMB+H+Q==
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Wadim Egorov <w.egorov@phytec.de>,
 Yannic Moog <y.moog@phytec.de>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 3/4] arm: imx: imx9: Use arch override for env_get_location()
Date: Tue, 11 Nov 2025 11:28:12 +0100
Message-ID: <20251111102904.157931-4-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111102904.157931-1-frieder@fris.de>
References: <20251111102904.157931-1-frieder@fris.de>
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

