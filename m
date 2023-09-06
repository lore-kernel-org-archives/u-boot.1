Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB0FEE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E397B86A94;
	Wed,  6 Sep 2023 23:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OJwx5Txb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CHaI9LTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FBD086AAE; Wed,  6 Sep 2023 23:31:02 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1635B86A84
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RgwXg3rplz9t0Y;
 Wed,  6 Sep 2023 23:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULzPRA+sQfPqpoZKwlw/cY5ZNLpa1KhuVkCMPk7o6FE=;
 b=OJwx5TxbUtb1hdyfSqEv6+Gv4tXMoEm1hoCnk38nKeoWsJKNzpmcyx/rQLtuu0LZOiwPLW
 k2Og6IxadhtXdlmeISYI41mxIOMqmwF+u4o2msD7gVBHLIHJ5vQnCihsEn8DO5sYvc1g5u
 M6pmn2ueDisM16hn9nD12KDxn5EouRgegYc322n9IaXkd/sD8C0m8IVYo4E/IxHigt2+De
 byW0NpthzEUIbvHXMPsVBHhGhvgot4nvHrh9HQnEIAvTseKOOHEg+lN/f3wRnHUj5mpV5/
 ggO+Sr9Ic5iv+PTcBaJHVgkw1WuYgFv3x9c3mcy5H6jzEeEIOSBmLhcTvUdJ0Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULzPRA+sQfPqpoZKwlw/cY5ZNLpa1KhuVkCMPk7o6FE=;
 b=CHaI9LTavvwd921j4IEm9QRQGDqKNghHQxj21bO3oUVhIB93ttimJiu58HVhiptWQVo6uO
 Sl9Jx68z07QDXqEWuric37e2Q7AKpacnNqvo/b1miRusVtq9jA+z4Qfv5VjEVf+0R/g98J
 sLDZ+ub3iwe4NjaXOgjenoGZb5sQzX9CFUslHpKAMO1oV1N3CIERcnOVmZKBtslUCpa0UE
 cejFM3K5oWq9d176kZdfDDPBfqGoKT64tkMZXi/mopYNm7baA2xvZuRbPk1ewjMUmpbyqr
 jjXJQ2/zVuyRJlbFWbBE2vGSOJv+8ElVFoV7gg4+z+LRzFJEbxrJUTBwC/HkJw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 30/35] serial: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:10 +0200
Message-Id: <20230906213015.203437-31-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jia5g8obi8wmmegnuqbcq79iwwt3u19u
X-MBO-RS-ID: 9843a93dbb24d2001a3
X-Rspamd-Queue-Id: 4RgwXg3rplz9t0Y
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/serial/serial-uclass.c | 22 ----------------------
 drivers/serial/serial.c        | 17 -----------------
 2 files changed, 39 deletions(-)

diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index e954f0189bb..5e2e7dfbcb3 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -508,28 +508,6 @@ static int serial_post_probe(struct udevice *dev)
 #endif
 	int ret;
 
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	if (ops->setbrg)
-		ops->setbrg += gd->reloc_off;
-	if (ops->getc)
-		ops->getc += gd->reloc_off;
-	if (ops->putc)
-		ops->putc += gd->reloc_off;
-	if (ops->pending)
-		ops->pending += gd->reloc_off;
-	if (ops->clear)
-		ops->clear += gd->reloc_off;
-	if (ops->getconfig)
-		ops->getconfig += gd->reloc_off;
-	if (ops->setconfig)
-		ops->setconfig += gd->reloc_off;
-#if CFG_POST & CFG_SYS_POST_UART
-	if (ops->loop)
-		ops->loop += gd->reloc_off;
-#endif
-	if (ops->getinfo)
-		ops->getinfo += gd->reloc_off;
-#endif
 	/* Set the baud rate */
 	if (ops->setbrg) {
 		ret = ops->setbrg(dev, gd->baudrate);
diff --git a/drivers/serial/serial.c b/drivers/serial/serial.c
index 9a380d7c5e7..787edd53602 100644
--- a/drivers/serial/serial.c
+++ b/drivers/serial/serial.c
@@ -142,23 +142,6 @@ serial_initfunc(mtk_serial_initialize);
  */
 void serial_register(struct serial_device *dev)
 {
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-	if (dev->start)
-		dev->start += gd->reloc_off;
-	if (dev->stop)
-		dev->stop += gd->reloc_off;
-	if (dev->setbrg)
-		dev->setbrg += gd->reloc_off;
-	if (dev->getc)
-		dev->getc += gd->reloc_off;
-	if (dev->tstc)
-		dev->tstc += gd->reloc_off;
-	if (dev->putc)
-		dev->putc += gd->reloc_off;
-	if (dev->puts)
-		dev->puts += gd->reloc_off;
-#endif
-
 	dev->next = serial_devices;
 	serial_devices = dev;
 }
-- 
2.40.1

