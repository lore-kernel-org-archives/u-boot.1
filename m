Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575B010A1E7E
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF9183A1B;
	Thu, 26 Mar 2026 12:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="zla5o0Sn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC8B483A1B; Thu, 26 Mar 2026 12:29:31 +0100 (CET)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0387F83EB3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-1279eced0b9so1117956c88.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774524566; x=1775129366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uYnRRFBKtfFZJvcBAbJuT5yLysd0yKRklR57uUPvxU=;
 b=zla5o0SnZsmaWs8Xn/XRimUrDdZrX1K98dkuJ+qjILRPWYHsLrEgtaTnQ/48usj77I
 ljCXt0JBhCH8hBluiagMDaFSCadN8fKMtJoRbg+4SCoMX7KlBcjwFcY5ZPwcS0qhvrmR
 7c1I5vieGLk2A8IIsB+V2kvJKdJQf7PXBHdX1KfNcuNYeUn6YUm+pqgWJmbj8F+C+Qb+
 vfvJp201tdSXyNdAQmKfqWIhRfcW9NmVlIHEoTVW/ZcTqkQhFvghjgJzY5moEd36o7Dc
 1NaIwQR/pFu12GxSgAIPXsO2HIY4lSfSidrh1sifG2xqqRAGpJRZIUJZOFB56KKjGNQ0
 hyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524566; x=1775129366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2uYnRRFBKtfFZJvcBAbJuT5yLysd0yKRklR57uUPvxU=;
 b=P0l4yFMH8y02PFYa/+pS8ivbSetmXI+YzYzb+ydWXV11VATrbHAJXH23BnzVNunbas
 ihIAfQb3h+QADe2vWQy1iEElFZp4IXufNGVIVwuT+Fpj43gfsivY15iJlK0zGVT5XKHs
 VaZ6fE89gSVDf1ZgYNNnlNZEN4fgq2AwgUMdXtrvUJ/TrQYu/zZNEKtjnMshho4b25Kx
 I49pW55o7lE6co3/u5qLX+pkxJKE4oN3iCNNKWGr0IAC0jKkCnFpXsnnxRa1frQGIhHj
 faBu3WUFIWg34lEsVkzkQAom84CIUGXmH3r3lBKjkYfTstLGgEJ8O94R08w43MzQmPya
 B6nw==
X-Gm-Message-State: AOJu0YyXYNSw7wqTnUlgDYzIGMbx0afNBzD57qbIkaHhcAufcoEq/el8
 tBHaIJQ5JpGFMgGczZTDaX1uO5mxcNOAHQQ+N/3fizTOsBQiRAwS2w3bdhjvN/wvXp8XCvnKxqQ
 ownNzIsdGGrzGGHCR8wJ/Emo4yzprvYA+Yz79N+xZWWf3WXMm3KakLZNm/AAkAdvRu0cuV0Uycg
 q+hgGNJA+7TcmFhmEfRNbHcy1bHqp2lpbQXqG95KCA1HI=
X-Gm-Gg: ATEYQzx1amt1D8ErmKssqyBWK8LbaBGjhmBFE1AAthw5vfbQ0Xv08mSrPriYHBHbZ5n
 eVOLUd6/HnZhJRpXg4jcl4u4MJdNRhQftcIZVLw8OJO6IvVTt716roH147Ypt83jRb5BeIMe8dD
 80tIxAb0L1j7HXL7wbuO1XHFpSyCSU5IUe2989mGJeIwKqtviqID5Y8rN8NWnxZ/QBkJNFlWwb/
 ahfYeVPuNWLfHtPFUtQ7QbGhO0I2Dd8momc0uk4Sy5JXK7kzcskWAB6RN6A4DwpZ526NrBUoth7
 eDF8hisvjbpyY3CUmayMInsBciKxndKiQqhlokZw1qnXV1+EYLzVQwY27orY1XdZrAHbWahyXVA
 C8Z/mKUDJ1x/rIQJJvp4tFDs5WIdBEezufJTauJUGvS3RSdBMCl7KT0IrXp1eW+ZVKDhQlcle/E
 lr3aDCyxT6J28I4Fjn7PpHzC0sQmg3t0ZDHoAyivIGMXTmO8+DtsJoRpBj
X-Received: by 2002:a05:7022:6b98:b0:128:ba6e:f889 with SMTP id
 a92af1059eb24-12a96efc515mr3951765c88.37.1774524565821; 
 Thu, 26 Mar 2026 04:29:25 -0700 (PDT)
Received: from fedora (cpe-109-60-83-68.zg3.cable.xnet.hr. [109.60.83.68])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm3729221c88.11.2026.03.26.04.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:29:25 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 11/14] spi: atmel-quadspi: add Microchip LAN969x support
Date: Thu, 26 Mar 2026 12:26:52 +0100
Message-ID: <20260326112830.313874-11-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326112830.313874-1-robert.marko@sartura.hr>
References: <20260326112830.313874-1-robert.marko@sartura.hr>
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

Add support for Microchip LAN969x SoC-s.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/spi/Kconfig         |  3 ++-
 drivers/spi/atmel-quadspi.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8c6c095a8cf..f837568c482 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -102,7 +102,8 @@ config ATH79_SPI
 
 config ATMEL_QSPI
 	bool "Atmel Quad SPI Controller"
-	depends on ARCH_AT91 && SPI_MEM
+	depends on ARCH_AT91 || ARCH_MICROCHIPSW
+	depends on SPI_MEM
 	help
 	  Enable the Atmel Quad SPI controller in master mode. This driver
 	  does not support generic SPI. The implementation supports only the
diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index b2b96e1c4b9..d830c2cd5bd 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -24,7 +24,9 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/ioport.h>
+#if IS_ENABLED(CONFIG_ARCH_AT91)
 #include <mach/clk.h>
+#endif
 #include <spi.h>
 #include <spi-mem.h>
 
@@ -1311,6 +1313,11 @@ static const struct atmel_qspi_caps atmel_sama7g5_qspi_caps = {
 	.has_gclk = true,
 };
 
+static const struct atmel_qspi_caps microchip_lan9691_qspi_caps = {
+	.has_gclk = true,
+	.has_ricr = true,
+};
+
 static const struct udevice_id atmel_qspi_ids[] = {
 	{
 		.compatible = "atmel,sama5d2-qspi",
@@ -1328,6 +1335,10 @@ static const struct udevice_id atmel_qspi_ids[] = {
 		.compatible = "microchip,sama7g5-qspi",
 		.data = (ulong)&atmel_sama7g5_qspi_caps,
 	},
+	{
+		.compatible = "microchip,lan9691-qspi",
+		.data = (ulong)&microchip_lan9691_qspi_caps,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.53.0

