Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B1FCEB2C9
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 09:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5708483F33;
	Sat, 15 Nov 2025 10:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="faCKWKgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A61883F4F; Sat, 15 Nov 2025 10:58:29 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8183A83F2F
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 10:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BCB77408CF; 
 Sat, 15 Nov 2025 09:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763200705;
 bh=ZJ3Q0LIBfPnBTBjiADRndFCPVvGvD90VvP/52ZIlCZU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=faCKWKgZVK6em3gOZMnJp/ha65bHO504jllY6MkEdpG0b6mXCfZhvtwMdumAQlCZR
 AOXuducmBqPHyvCkSQBygZ6HV0pxEvIjFEjkUk4DqFf9mlgnx49LH4ituzydiKgvMb
 KvxmaiGcieTm1aeS3WPePZH08bZVi4lMeldBdJMdi6QFUrAdRCeLgSLEEX1CLnSLIN
 +Txu95wSXaJOpWm6W+AwP+kD6rlvINcF4Ta+AirDLewGVn6d0OtPEveCotJhUys9ik
 Vtzp/cvZSnUtP4yahr/U2zgKtk4pCgcJ2SsfgplQI325yX3UUfQPDH5Pz2/M0RtPWY
 UHwyx0BQUMGiScOJke8c018L0Al/xNOQTTFqKrRXk4jjAzRUxeFsnWKxRHIgF3hKMx
 PoU5bV8okrVl/0gKBI245fX85qXOVGDwY6uZRZhULhsU0CrriZQE0hgIF0U1T0QTHx
 by3IU1EyYRTGIiKPiW8Con+xnzizM0FwIwyHt7sCC5KSkHHseak0OuAi1PUQ8xEdxK
 Hkkr6+pQ3Dt6wNmmoCUWQxsrNVOmNglMtuE60zqqleJ1FMWptruSOwoTD7HLJtF6CU
 V3K0cU7ekDU0q0VuM+ydQz0dmOdzn8xs1FrCrnT2ZRP+1V89hsf04/yaEvCZdRoo4y
 qBBSfPWRWOnVIIFVVZorxFpQ=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] usb: USB_EHCI_PCI depends on PCI
Date: Sat, 15 Nov 2025 10:58:20 +0100
Message-ID: <20251115095820.11206-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

CONFIG_USB_EHCI_PCI cannot work without CONFIG_PCI.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	remove duplicate USB_EHCI_HCD dependency
---
 drivers/usb/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 427b62e934b..99f381db9f9 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -271,6 +271,7 @@ config USB_EHCI_MSM
 
 config USB_EHCI_PCI
 	bool "Support for PCI-based EHCI USB controller"
+	depends on PCI
 	default y if X86
 	help
 	  Enables support for the PCI-based EHCI controller.
-- 
2.51.0

