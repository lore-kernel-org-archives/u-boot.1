Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170F6C2BB3F
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 14:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5632E8755D;
	Mon, 20 Nov 2023 15:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aR0ME+pg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A7987548; Mon, 20 Nov 2023 15:56:45 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE54A87550
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 15:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3702E3F941; 
 Mon, 20 Nov 2023 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700492202;
 bh=PhPBqfpRcFUbxKiH0DLiz7bPIK+02wHTyDXDuWsqllU=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=aR0ME+pgS23r4y8B69Fayja4y5Qfw3HKtx29Qm7F/EUYV2UMX2NjRYuvacfhFg0r6
 EzE8zqh9vVVwCW9oMXdHTqUUUNLPOm55gGBVtSYxccauj8SGkC+nLSih9eg1NipXgE
 Xj7kko8QjLXzwQV8w4N2KEOUKqdNy/Miou0Ko6mM2MiQ1jTEvw8ACrjT9DIV8S6uI9
 ZH7TBy85Cv/SY47w08xupw7qhZq1fyRq8lAD/y+JG08kIioABKsohd6cbZsfiD8Wuc
 0sdaov8yf+j9jL1Uuo7TozavyiXbaHI1imgvsDj9/Y8Lawy027/pvFv/aX4zU4GzLi
 zfun3mulLNyrQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] usb: USB_XHCI_PCI depends on PCI
Date: Mon, 20 Nov 2023 15:56:36 +0100
Message-Id: <20231120145636.110466-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Compiling with CONFIG_USB_XHCI_PCI and CONFIG_PCI=n results in

    usb/host/xhci-pci.c:48:(.text.xhci_pci_probe+0x44):
    undefined reference to `dm_pci_write_config32

Add the missing Kconfig dependency.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/usb/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index b501ea514b..35610ffc2b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -90,7 +90,7 @@ config USB_XHCI_OMAP
 
 config USB_XHCI_PCI
 	bool "Support for PCI-based xHCI USB controller"
-	depends on DM_USB
+	depends on DM_USB && PCI
 	default y if X86
 	help
 	  Enables support for the PCI-based xHCI controller.
-- 
2.40.1

