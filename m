Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EB3C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 07:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9827780586;
	Thu, 23 Jan 2025 08:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="JdYH7jvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CC980137; Thu, 23 Jan 2025 08:37:28 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702B680243
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 08:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A14A31487435; Thu, 23 Jan 2025 08:37:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737617845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRnoLHKv9F6uz8dRJH31F9qGnrnr6MByZZA8xYqjm/4=;
 b=JdYH7jvPiG132COENQA/P8vjqEwxMeQy9ajB52UJuUgxXzkAdYQzTs0+jIyDs7jppuFWAR
 tqotKlwRkkUdcokri5vsedZeqEUoJ9PZlmnCNHWJqJL1VgOkLC+HyT0mUBFoKuiI4+TcbF
 pfx57W0hHuX7b3J1ZEQhT7OlN49JBaqplCkTV8c17Fhx8Yd+sb/d1822SLaHCMopplg452
 /atsJUFtVrIZ0JPgGctScj6+cWe5dPoThuoWtdnS9Ux7HcT4BXBgm7NWFfsMD9MKhteWO6
 1yRfsCKGWoOeCAF1Ypq5KE95zfMwcUr4FhdZZSFv3eMOxsyPKdD7fz963F375g==
From: Alexander Dahl <ada@thorsis.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, John Watts <contact@jookia.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de (open list)
Subject: [PATCH 2/2] spi: atmel-quadspi: Depend on SPI_MEM
Date: Thu, 23 Jan 2025 08:37:13 +0100
Message-Id: <20250123073713.2988293-3-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250123073713.2988293-1-ada@thorsis.com>
References: <20250123073713.2988293-1-ada@thorsis.com>
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

Most other spi-mem drivers also depend on SPI_MEM.  Fixes this build
error:

    arm-v5te-linux-gnueabi-ld.bfd: drivers/spi/atmel-quadspi.o: in function `atmel_qspi_supports_op':
    /mnt/data/adahl/src/u-boot/drivers/spi/atmel-quadspi.c:460: undefined reference to `spi_mem_default_supports_op'
    make[1]: *** [/mnt/data/adahl/src/u-boot/Makefile:1821: u-boot] Error 1

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6555142a41e..a916b711ba8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -85,7 +85,7 @@ config ATH79_SPI
 
 config ATMEL_QSPI
 	bool "Atmel Quad SPI Controller"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 && SPI_MEM
 	help
 	  Enable the Atmel Quad SPI controller in master mode. This driver
 	  does not support generic SPI. The implementation supports only the
-- 
2.39.5

