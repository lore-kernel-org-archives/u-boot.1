Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13C0E77188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B6F8069D;
	Thu, 16 Jan 2025 05:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000337;
	bh=yGNCqWxD7v1ApaM9MiHjSDAB02HXPKdg8ihKRPNp/fQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GvlSg7ZeIH5Fm3WjbNgj4SwAZSikAMGyoZgnuOOekpc7ogIEIF2ttslRAEU117biF
	 BBhvTOG9fSK0ZGrEUX11L5zBHnCkChCaSbTgR/qBZyT8nmc617ex+9L9huD1xjAAJl
	 15ujjpf2iVXFMCX16bHbHDnBghQ+ZyBcpXqri8T2cui/NB4A2mYU5ce/Wtu8b+wxoX
	 hyOMNPTF2S7RhGMLfBd9T3XNOJHUiAmffFX0xTNWMhI8xWuML3Jr1X0qlrexaAFNPx
	 MlTKIG4UkG23x9ZCVEoOdgNQb7L7QyMejLYEjCCoRPudUHlukvTged9dT5kbEKv54D
	 RBkG5xWXzIHkg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5131806D4; Thu, 16 Jan 2025 05:05:36 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2C680214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VktX8Z/s"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2D5D91040DBDB; Thu, 16 Jan 2025 05:05:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yGNCqWxD7v1ApaM9MiHjSDAB02HXPKdg8ihKRPNp/fQ=;
 b=VktX8Z/sg7OPCYIzGB6GvY/jAA09KIy+hgQIDpSgZtp+v4Cm95ThUMhl7iDpWpvmyobo9C
 xCSBYkaGG1uDs4hNtmj0Asli7SuqEATUfuMiUxRUK9beDLCxX9f/p5lIJ1ER+RDT6dQdLJ
 oT9j6mwoTPaVheAAytzF4g0bJvwCWTg8sq9TY+f64+WfYQWwr5ykkzSFI5mi6pLvtnH/ia
 V7fQeVw7wO2a6O6lMw5cimzVLUVioOFAblghhauUnLPEaItdXfGfXH+EhxU6GtCsOwAf+W
 aFn8sn794kcJJRvnbK8t+EJs31SeLJLnf9cgzAzCAum09m552ceTqa2nxuMuhw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH 01/13] net: fsl_enetc: Introduce enetc_is_ls1028a()
Date: Thu, 16 Jan 2025 05:03:18 +0100
Message-ID: <20250116040449.306098-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Introduce accurate test for LS1028A compatibility based both on
IS_ENABLED(CONFIG_ARCH_LS1028A) and PCI vendor ID. This is done
in preparation for adding ENETCv4 support, which has a different
PCI vendor ID.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Markus Gothe <markus.gothe@genexis.eu>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>
Cc: Romain Naour <romain.naour@smile.fr>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/fsl_enetc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index a6b0bafc8c6..d1414167723 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -23,6 +23,15 @@
 
 static int enetc_remove(struct udevice *dev);
 
+static int enetc_is_ls1028a(struct udevice *dev)
+{
+	struct pci_child_plat *pplat = dev_get_parent_plat(dev);
+
+	/* Test whether this is LS1028A ENETC. This may be optimized out. */
+	return IS_ENABLED(CONFIG_ARCH_LS1028A) &&
+	       pplat->vendor == PCI_VENDOR_ID_FREESCALE;
+}
+
 /*
  * sets the MAC address in IERB registers, this setting is persistent and
  * carried over to Linux.
@@ -416,7 +425,7 @@ static int enetc_write_hwaddr(struct udevice *dev)
 	struct enetc_priv *priv = dev_get_priv(dev);
 	u8 *addr = plat->enetaddr;
 
-	if (IS_ENABLED(CONFIG_ARCH_LS1028A))
+	if (enetc_is_ls1028a(dev))
 		return enetc_ls1028a_write_hwaddr(dev);
 
 	u16 lower = *(const u16 *)(addr + 4);
-- 
2.45.2

