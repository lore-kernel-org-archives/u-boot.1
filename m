Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60D0CD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 02:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF048848A2;
	Wed, 17 Jun 2026 04:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IEb/epv6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K3eN0Zm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA50848BA; Wed, 17 Jun 2026 04:38:26 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB6284894
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 04:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gg7MM58Zlz9tnq;
 Wed, 17 Jun 2026 04:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781663903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gTZRi/GBIWo9s+YDMNPSp0GgPh8cwebPyxx+/ariV4E=;
 b=IEb/epv6oGdvx4ZlaQXWbjEKfhC/TtXX1akzS3Cmmf8B/oVchwGTVpzCkUO0edn4y7thtW
 BTq06Ev55HGd3DC11YpGRM05zZC2rAPY8dHEDbUrphxsOYHtMIoaaM+GfoWjSAfAMMMg3p
 V7JkBIVEn4HvVqKGJ9NHH68u4ClQyXKfUvtudMupVf1DX5MqKatttaUDqduCIyzTu6qNG0
 YZkF0qO7al3lNyM07FMbuhQIp11lz409R+IFOhPizBps6E/krunbdS118zdNeN3iYo45q0
 Z/FNZl+tVAnKXYaglRoNbguCzR50IqXmHTk8cStnW2k73ogYlJJLV4EGIRBaxw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=K3eN0Zm0;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781663902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gTZRi/GBIWo9s+YDMNPSp0GgPh8cwebPyxx+/ariV4E=;
 b=K3eN0Zm0XGHjR4bMXXvxhB8Vm5S8R/c/vyRSavDF19Dt5wzT8EDNtrWH0Cz/yNx4bnnkK6
 eXEhcUFwK308JQcdbWHb8+zN+moE2VpY2vUkkvFwhSuvE4DOrTyDi5zgGcs+w/vZgcSLM6
 WZRIeSPMAK2wr76lujat08YygWk97pgINxpj/kMJqXPXrVem7m++poJgzvY5o99l7MzUAk
 MuqfXg1Rz6RfUben2ac9kgVglFfXCeqTW4ygTsyiPJvSVcCMjgyAN6QWrjr3v5kUdEkpWJ
 BtA80aC2g2a+gKSgSBV7vG5wxFm2DqMwWE0LO7o22QXoS8nI0s4Oczmbl8C0eg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Replace Cortina with N:
Date: Wed, 17 Jun 2026 04:38:04 +0200
Message-ID: <20260617023819.152378-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: d47tff8g4t4jqanb1mupcwuf143onyiw
X-MBO-RS-ID: b0b404e7d027c657955
X-Rspamd-Queue-Id: 4gg7MM58Zlz9tnq
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

Use N: to match on all cortina files, drop the large list of
entries which represent the same set of relevant files and miss a
few in the process.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 MAINTAINERS | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4de95b5eb82..ced8c6948c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -233,21 +233,10 @@ F:	drivers/spi/bcmstb_spi.c
 ARM CORTINA ACCESS CAxxxx
 M:	Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
 S:	Supported
-F:	board/cortina/common/
-F:	drivers/gpio/cortina_gpio.c
-F:	drivers/watchdog/cortina_wdt.c
-F:	drivers/serial/serial_cortina.c
-F:	drivers/led/led_cortina.c
+N:	cortina
 F:	drivers/mmc/ca_dw_mmc.c
 F:	drivers/spi/ca_sflash.c
-F:	drivers/i2c/i2c-cortina.c
-F:	drivers/i2c/i2c-cortina.h
-F:	drivers/mtd/nand/raw/cortina_nand.c
-F:	drivers/mtd/nand/raw/cortina_nand.h
-F:	drivers/net/cortina_ni.c
-F:	drivers/net/cortina_ni.h
 F:	drivers/net/phy/ca_phy.c
-F:	configs/cortina_presidio-asic-pnand_defconfig
 
 ARM FF-A
 M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
-- 
2.53.0

