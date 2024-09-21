Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEBDCF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 09:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66C8881A2;
	Sat, 21 Sep 2024 11:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="g1bsaKSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C328E8814D; Sat, 21 Sep 2024 11:21:01 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 972F3881A2
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 11:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-104-110.46.114.pool.telefonica.de
 [46.114.104.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 670843F1C6; 
 Sat, 21 Sep 2024 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726910458;
 bh=GYFbh+gSQ2D+gne0ednsFQo2fdfBaVqpGGth+gOD2Gk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=g1bsaKSS0uwC18GG+e/imZAj6zu9NJ0lbp6X8WlyUCZpHuVCfsJjZjC+OKwoCrPBN
 cFcWEektR2oQ5aeQfytftUKw4mEErXbU7aPXHPQKJAHkZcrAkjGgGxEDY5bt6ECY94
 EQGO8YbLDNMCEzB886oBTtqnQ06YuT5KXTZ9F0O7XfTcjGa5/r56q6+7yVf64hoj9J
 jbvjPe1/uWITvx/Mhy3J6JPUQcz1nnD5mImA6wfOykOZpQORRhXysJ4VPjZJIRkM54
 kekK/bzJciPkUVHosoN3zQq5OAmeulxmt6IdVswpqEZWFx6uO21kkBU91UHMY4pQui
 x9KmKrfQkdTkg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: simplify CONFIG_CMD_USB_MASS_STORAGE dependencies
Date: Sat, 21 Sep 2024 11:20:50 +0200
Message-ID: <20240921092050.9260-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

CONFIG_USB_GADGET_DOWNLOAD depends on CONFIG_USB_GADGET.
It is sufficient to depend on the prior.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 4ccb0cef390..02b2569e713 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1685,9 +1685,8 @@ config CMD_ROCKUSB
 
 config CMD_USB_MASS_STORAGE
 	bool "UMS usb mass storage"
-	depends on USB_GADGET_DOWNLOAD
+	depends on BLK && USB_GADGET_DOWNLOAD
 	select USB_FUNCTION_MASS_STORAGE
-	depends on BLK && USB_GADGET
 	help
 	  Enables the command "ums" and the USB mass storage support to the
 	  export a block device: U-Boot, the USB device, acts as a simple
-- 
2.45.2

