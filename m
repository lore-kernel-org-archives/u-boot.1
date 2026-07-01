Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD9FC43602
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54BA084B50;
	Wed,  1 Jul 2026 11:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KYl3swrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D75184AE9; Wed,  1 Jul 2026 11:11:32 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B930A84B2B
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Y89mZXpFkgniapnXx4iY1MfHRu3faksXiMnxDkfxso4=; b=KYl3swrCWavSRAeOqdX3B/fGSM
 y2dt16NR8sxbQosjJ7tzXkjXeG1ZQf17ciJggMlAD4jzMc+sVHdHZtKrEECeOq0NiyClcwworoKzk
 sN5o0OgDqJ0dplWRqS84r5FZB0b++RKWF91vKyWY5Okjoq0YCt7Fbrjt8G2HKoYDbqa/7BCFEJYYk
 R5IppfqcNh3r19AVcVqIoH7sV6OB2vAQyvzj0BChAy7IcTBzmIqe/K1m5W3P+zIg+byvA4XIE6hg2
 1MYcYHwJ3PIrORGaFgAcV9ew7sK/wLzF0lUZNOtZQr0VoN6phluKgfShGHLCDZLcMiPTiQ/NYlVeA
 cucy0Zdw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1weqye-000A4S-32; Wed, 01 Jul 2026 11:11:29 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1weqyf-0007Md-18; Wed, 01 Jul 2026 11:11:28 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH 1/4] sysinfo: tq_eeprom: select NVMEM
Date: Wed,  1 Jul 2026 11:11:16 +0200
Message-ID: <20260701091122.1479350-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701091122.1479350-1-Max.Merchel@ew.tq-group.com>
References: <20260701091122.1479350-1-Max.Merchel@ew.tq-group.com>
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

The SYSINFO_TQ_EEPROM driver requires NVMEM to access the SoM EEPROM.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 drivers/sysinfo/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sysinfo/Kconfig b/drivers/sysinfo/Kconfig
index 6922dac9170..adcf1aed8a8 100644
--- a/drivers/sysinfo/Kconfig
+++ b/drivers/sysinfo/Kconfig
@@ -63,6 +63,7 @@ config SYSINFO_TQ_EEPROM
 	bool "Enable TQ-Systems EEPROM sysinfo driver"
 	depends on I2C_EEPROM
 	depends on SPL_I2C_EEPROM || !SPL_SYSINFO
+	select NVMEM
 	help
 	  Support querying EEPROM of TQ-Systems SOMs to determine board
 	  information.
-- 
2.43.0

