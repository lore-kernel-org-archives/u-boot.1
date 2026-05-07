Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94878CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33FB384B5D;
	Thu,  7 May 2026 18:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QpjE64zN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G820TJ2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB85184B9D; Thu,  7 May 2026 18:42:06 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A08084A4F
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gBJ1k5CCGz9vHr;
 Thu,  7 May 2026 18:42:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GfJx3ez7eUChALsPoMNHtt75qghGxfvJA9fOGEQAzxM=;
 b=QpjE64zNI4x25VxpRYIVif+fnJ70kDOpskaabWGX14MGZeO7wAbkSaHZ2Q6PvN/PlJZPB9
 nRTu5Yn85VVx1aUG/c6ic7UVJ6TK4ekwG9EwwhGaxG7oheNuTqYVcPA0tQG7o+p7RBbmk1
 qMKwaR+AFaeBcZt7ZYOlqXAuI1hzbsuuU7rojpZ0VyO9HEaoYsAW1+vOi/5m7JfcQDXlNn
 PeirHoOjj2dE+HIDJt090Pj04UGQtsAoehrlj6NYHTqScwHAHRXEgVGykNXqtYkGdd/z1a
 HGf5IQqtGAwdAWg6eZILT79C4Exf1MLj+QjjTZfk+rVUXlf1qjWJmwTdmEkKrw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=G820TJ2r;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GfJx3ez7eUChALsPoMNHtt75qghGxfvJA9fOGEQAzxM=;
 b=G820TJ2rGT/DF9jUQBKeES5aaAFd6kk+fJbQyKQX0QHZRMMMhajxnJ3pXWATJV3SjFAjtR
 bIpGj9AWpeliEaTuZ9e72TJEWTlfH4wTk7R4ngUmVVDPzizGiScaVboD254jiquq8xUHhy
 rpORB4eHAJ0Jyq5Zs+wbYTW9ayE3H7C/Fk22xthsLqCB1jZAR8XzMRcD054lQnJ80KHrSV
 0OeisF7kp/5sORDcA5uI923ZFHFieD7DFj4x1icqRmRo7wZculRC/lP2KF264iJP73J/U9
 v2BTuUevCZeMOjoVLNnJ4t7KBLkI5n+Kj3vTn8f57D96q9hQIG1AqMMWhRl87Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikita Kiryanov <nikita@compulab.co.il>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: mx6: cm-fx6: Staticize and constify driver ops
Date: Thu,  7 May 2026 18:41:35 +0200
Message-ID: <20260507164157.59293-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gg9o6cdspamw1ysigor7ygcmzoyop3nw
X-MBO-RS-ID: 5958d93ba1e98d8da19
X-Rspamd-Queue-Id: 4gBJ1k5CCGz9vHr
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/compulab/cm_fx6/cm_fx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/compulab/cm_fx6/cm_fx6.c b/board/compulab/cm_fx6/cm_fx6.c
index 40047cf6783..e20350dc5d5 100644
--- a/board/compulab/cm_fx6/cm_fx6.c
+++ b/board/compulab/cm_fx6/cm_fx6.c
@@ -778,7 +778,7 @@ static int sata_imx_remove(struct udevice *dev)
 	return 0;
 }
 
-struct ahci_ops sata_imx_ops = {
+static const struct ahci_ops sata_imx_ops = {
 	.port_status = dwc_ahsata_port_status,
 	.reset	= dwc_ahsata_bus_reset,
 	.scan	= dwc_ahsata_scan,
-- 
2.53.0

