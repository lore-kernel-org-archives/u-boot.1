Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D965CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B994D84B76;
	Thu,  7 May 2026 18:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BBaSzwiv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LcFQIled";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80C784BB3; Thu,  7 May 2026 18:42:33 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1DFF84A4F
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBJ2H5wWwz9txq;
 Thu,  7 May 2026 18:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQwRI1HHP9xREdVYF18AlUVglgfbvuazzm7qgSZTujQ=;
 b=BBaSzwivTgat/DJj4D29rPHbSgMEVyi40OthDSGNZyjSad8pHOwaiA0Wu583gKkkfZrZ9R
 2fCBF6VgvduE2xqAg1VnLTDgHmU5fKn6V3Nt9XhPuzjnrAOiXHPDIQ4LBMqo757zfL4mCM
 bRnIk/01ZxTgNG22CWkP9JEqJ84X3rgLRPEjfMSQI4Qkg6c0GQtw9F0tkvF+VDglr/0VQZ
 ueJkAQmW76C33BLbt8UWki67BLZ53URhdHiGZK7OiNhug1HdMRy8R0NXpIOYENicdnwt83
 QOnjzL6Uk3ANnB+G8O+jpRZVYUAlrPNNAR8bGvMFqF4dXe7V5XN0X5+bD/sf8g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQwRI1HHP9xREdVYF18AlUVglgfbvuazzm7qgSZTujQ=;
 b=LcFQIledK4brmCkZ2nw6hpKchLjvuAJ3GiROisGBD6eqCEd+v+QzASeT9DpSORtYHp/jfv
 oDz8NL2jVna78GfaK7TWFSxEocVIu099F+lZFN1kJ2nV4D8DLkli+rtPsKCXUAv9apF9as
 +x1A6yzq3H0sAv/WQIvOw8TZaQsQZYltAQdJfEd9fPsFtWkLe7jkOnazsrkcECYbhdta3l
 cjXd9WIZjizxiP33o46vDc+xlidAM1Js/HG4aXu6HwrAcn7FY99xweNElf41iTjNLKOjQt
 Qjafe9q780ixcegtfWFWXjXVKJrtlxD5towRyi5tqdeLmkZvu9CNnlt+ZTT0kg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] ata: bootstd: Staticize and constify driver ops
Date: Thu,  7 May 2026 18:42:07 +0200
Message-ID: <20260507164225.59325-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
References: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: abrpzdzpd8sp4jnbc4jswu1847b6wsdt
X-MBO-RS-ID: 3ab8ebcb10af81780e3
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
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ata/sata_bootdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_bootdev.c b/drivers/ata/sata_bootdev.c
index a5ca6f6fd5b..85f30040d05 100644
--- a/drivers/ata/sata_bootdev.c
+++ b/drivers/ata/sata_bootdev.c
@@ -37,7 +37,7 @@ static int sata_bootdev_hunt(struct bootdev_hunter *info, bool show)
 	return 0;
 }
 
-struct bootdev_ops sata_bootdev_ops = {
+static const struct bootdev_ops sata_bootdev_ops = {
 };
 
 static const struct udevice_id sata_bootdev_ids[] = {
-- 
2.53.0

