Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA526E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 22:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F025D8036B;
	Tue,  7 Jan 2025 23:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736290778;
	bh=FP7g7nCndhDDwEGJktdCJwFecmRIrYWKgtWx6RXYTwU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XjlLRoR6lvc7oQysIfjosWPG0//Yzek0oFRsCyw35XVmKShjwqH4xC+GxCymG3iY2
	 XRiDcHNIs2fSnkz7HVPZsRUy8+WWVVDyzScfMtWdhnO5ti488EKNEoIAIgpgYXEzY5
	 tiCGxSUTfb2Cs/8EQ58VpTweitGGoEawHmZ2inpWQXKvnMv+PQe0oaF7xn0I0Qz06z
	 DHriRRHvCLWSAtgHbBCSS6mo20QpnhDry2K8ONZxhAgB4gsd0IJfFhWTI/ct04EUkb
	 u5LwypM0LAq/dg5yDN/wbAYetK4SL4ZDL28Ax+aQwRLOvfRKEO9lJ02k3ybhSLduV2
	 eq7jWTv4IvFIQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF81803DC; Tue,  7 Jan 2025 23:59:36 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B028C801FD
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 23:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="WzLDi8GE"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BB63310485590; Tue,  7 Jan 2025 23:59:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736290773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FP7g7nCndhDDwEGJktdCJwFecmRIrYWKgtWx6RXYTwU=;
 b=WzLDi8GEhdY9xMPWgFuov3a4WmDEqGnybXLoIOjXGMvdxvKUdbW3LUvQ69M33E2YqMfzXI
 SK91WLMun6mqIrgmbTdtllq0dIw/PDz5Dd0il3IU6tf2NsMaWivEFmEvv36+nicSFYnjpr
 euvVHKhCC/UunRXWDJ6RRmA1rh6oAW9VNvbBoQja9tfMWIyicFzKCsZYJpEyUUt6F7lDjp
 ne7ZbNYlh2f0Co7rjvxT9qIKP/UWpa96E9cDdGBKH5Zr/5PV5JHEq1BNxSaQTAcIdXqdMH
 6gFPJF8UjcGDA3s11qdwZvut9b4XjWkbRg/0/fwYwKOqKgb9Bo+RMoPIx27aow==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: ehci-mx6: Add i.MX95 support
Date: Tue,  7 Jan 2025 23:59:07 +0100
Message-ID: <20250107225919.196131-1-marex@denx.de>
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

i.MX95 uses the same USB IP as i.MX8MM. It can then reuse the ehci-mx6
driver.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mathieu Othacehe <othacehe@gnu.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/host/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 24786a2bc91..a656265890e 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -217,14 +217,14 @@ config USB_EHCI_MX6
 	  Enables support for the on-chip EHCI controller on i.MX6 SoCs.
 
 config USB_EHCI_MX7
-	bool "Support for i.MX7 on-chip EHCI USB controller"
-	depends on ARCH_MX7 || IMX8M || IMX93
+	bool "Support for i.MX7/i.MX8M/i.MX9 on-chip EHCI USB controller"
+	depends on ARCH_MX7 || IMX8M || IMX93 || IMX95
 	select EHCI_HCD_INIT_AFTER_RESET if ARCH_MX7
-	select PHY if IMX8M || IMX93
-	select NOP_PHY if IMX8M || IMX93
+	select PHY if IMX8M || IMX93 || IMX95
+	select NOP_PHY if IMX8M || IMX93 || IMX95
 	default y
 	---help---
-	  Enables support for the on-chip EHCI controller on i.MX7 SoCs.
+	  Enables support for the on-chip EHCI controller on i.MX7/i.MX8M/i.MX9 SoCs.
 
 config USB_EHCI_MXS
 	bool "Support for i.MX23/i.MX28 EHCI USB controller"
-- 
2.45.2

