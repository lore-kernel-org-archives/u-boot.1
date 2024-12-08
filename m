Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C65E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD3289578;
	Sun,  8 Dec 2024 23:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CCIJLk+F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SsQY9Aeu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7450B894FF; Sun,  8 Dec 2024 23:06:26 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE95E89520
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y5zbg5GTSz9snJ;
 Sun,  8 Dec 2024 23:06:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p7AUp4q8a4U+kzftv4pjU9B1f8q+7K3e37Wzp+0ehXg=;
 b=CCIJLk+FDcj9QJXSHYa8TtBlAkRB2cHzcSoAwDCt/NRaA3NIEyNFdneNp42GYM9PVUenkw
 QC777hHAzHK6Eai/UfqgMgsFsa5okZtgt6ttBsg4wnXZoNnFtPk6dYFNRT7uW0HPeBsxOU
 i/ET1DAOD9S8jraAffxqETNq+E4/xxmjW59UhhnwuhZ1Dqlk/VqHJU0JhvGtkeGvJPZr0F
 j/oqnLbeZXTTlTbE+1RMJFH5XjLBjES7EWEvyIM22DsM4TSqMXtgB7kJ/EXKBx+A9zfdlm
 /TFL4VI6UQ0ePihKYP+jagvVCH9gjjjPY5/zRPg/H+Sg++BBvDqqJdvMUdN9nw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p7AUp4q8a4U+kzftv4pjU9B1f8q+7K3e37Wzp+0ehXg=;
 b=SsQY9AeueaJHXLHZE6yT2ioMFfhHzqAnrc3NHXEWLPJiLbcFA/alCRur3dRvRsifNITc1b
 gxv1Cn7avOz+ZubaT+Z+oTzfFsoWU7U1UU6gRX5sD883ifEei6aXM8hkW0AfEiuJeJ4skA
 o1uq1X1wH5bD5ZTFDSNDAmBuXcdZROvyZaBAPDO57he2jrYWiYcoBWEZTRlXaifag3ViKd
 ticf18aM4cFyLaFTMmhtMTwUoqI5zrWqjtZjn6MjTNHI+dw7wPnJn4JUp2svYnDRR6epsz
 DseI1CDpg3yB+kvyhHxnSP7UDx+2QmRH06RLpiPq0UeGGcGRTfQDx/H3aU3dEg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/13] gpio: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:03:57 +0100
Message-ID: <20241208220551.204743-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gpkun1y9o43yuqfpmmnhwrsr48mqu46p
X-MBO-RS-ID: ecd625c4d06167cb2b5
X-Rspamd-Queue-Id: 4Y5zbg5GTSz9snJ
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/gpio/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 92a8597420a..f4a453e1cdd 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -358,10 +358,10 @@ config PCF8575_GPIO
 	 chips are from NXP and TI.
 
 config RCAR_GPIO
-	bool "Renesas RCar GPIO driver"
+	bool "Renesas R-Car GPIO driver"
 	depends on DM_GPIO && ARCH_RENESAS
 	help
-	  This driver supports the GPIO banks on Renesas RCar SoCs.
+	  This driver supports the GPIO banks on Renesas R-Car SoCs.
 
 config RZA1_GPIO
 	bool "Renesas RZ/A1 GPIO driver"
-- 
2.45.2

