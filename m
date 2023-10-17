Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A4ACDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 21:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56D1586F70;
	Tue, 17 Oct 2023 23:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0OVC/nqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D083586F07; Tue, 17 Oct 2023 23:41:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FBEB86F76
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 23:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=165c=GA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1697578851; bh=E7qpHTFNG8I9LDdl5/23GJ3tU3Vdx8MNvTa6HcAVJbc=;
 b=0OVC/nqZZXeUdmin67oCtERdcSvMIch8ean1LhUY+kJI9sz2wNr12B5sY1REF2zILJ6pkW7h9
 uoxEfWuXD1XHbLT4cJ0Z3luBhWaprSZixIibFFDb4Cfur9vURuvhyA/SNZ/wwZdx946StXIoZLa
 s4PjBJgKOkEphLJkrYBaCo8wasTpZVYghYrTnNdlSSmSvTayGrbmd+IvjVAJcvJRaQ2oA7FjRih
 H+auNhOBKhqAlZKLNLFcjwQSlSNQ33W2EVL76y2wytviGRpJd9iqOBAUWFP3HZXMOuATs/8xHL7
 /gCo8sefEt1TmEBOVnp+eM1LnOECb1hmTuGkERoydjAQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>, Ricardo Pardini
 <ricardo@pardini.net>
Subject: [PATCH 1/3] mtd: spi-nor: Add support for XMC XM25QU128C
Date: Tue, 17 Oct 2023 21:40:20 +0000
Message-ID: <20231017214031.1704250-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017214031.1704250-1-jonas@kwiboo.se>
References: <20231017214031.1704250-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 652eff628bd555e0b7613265
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

From: Ricardo Pardini <ricardo@pardini.net>

Add support for XMC XM25QU128C (128M-bit) Serial Flash memory. Used on
the Xunlong Orange Pi 3B, 5 and 5 Plus boards.

Datasheet:
https://www.xmcwh.com/uploads/806/XM25QU128C_Ver2.0.pdf

Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
[jonas@kwiboo.se: update commit message]
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 5c35171ffd55..392db5c99e84 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -536,6 +536,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XTX
 	/* XTX Technology Limited */
-- 
2.42.0

