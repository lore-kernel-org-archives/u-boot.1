Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAC7C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 07:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE7080214;
	Thu, 23 Jan 2025 08:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="SrL0gW3p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09DCD803B5; Thu, 23 Jan 2025 08:37:28 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E8280137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 08:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0C89B148A171; Thu, 23 Jan 2025 08:37:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737617845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uNcLj9RWeQKj/6zQkqNsp1tH6oXrQS9CzOZP0P9D8Qg=;
 b=SrL0gW3pub3VmTjPtMdoLi3lMYY88FLbAShkUr5slBJb2X6lFYlh7hsvA5+g5CwWHd2S9I
 UiwDQPmCd7REt0CY/9CELZc9sgwcl0GUH+LaojmgfnSuq17Yi1oY/7cAsrQlF+FQtHEa9R
 ov05cH21DU0T2exvVLqhzzKm+b1pFs+EZDPF05Ede/5O3tLfd5zypM72MvTSiK75iLWkV/
 yEid2wTY38+qBLnRLiKeFpz+7MtRGD97pjicqortEU7KRvNklGSg6sg8FhHAdV+Yi4PSK5
 H3HbAW3VAXcREYoZrsXzdN09Z3JMr5peUj5DqGg9Iwe62w9pKGFN/znsbDlsjQ==
From: Alexander Dahl <ada@thorsis.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 John Watts <contact@jookia.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de (open list)
Subject: [PATCH 1/2] spi: ca_sflash: Remove redundant dependency
Date: Thu, 23 Jan 2025 08:37:12 +0100
Message-Id: <20250123073713.2988293-2-ada@thorsis.com>
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

This is inside of an 'if DM_SPI' block, and thus always true.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 96ea033082b..6555142a41e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -135,7 +135,7 @@ config BCMSTB_SPI
 
 config CORTINA_SFLASH
 	bool "Cortina-Access Serial Flash controller driver"
-	depends on DM_SPI && SPI_MEM
+	depends on SPI_MEM
 	help
 	  Enable the Cortina-Access Serial Flash controller driver. This driver
 	  can be used to access the SPI NOR/NAND flash on platforms embedding this
-- 
2.39.5

