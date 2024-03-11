Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D24C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 15:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B346887150;
	Mon, 11 Mar 2024 16:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="ozWyOyPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AEEC87EDB; Mon, 11 Mar 2024 16:23:10 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F17C8573F
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 16:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710170587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WC5jIQUulJyVz/ub1V6vVoOw7eF7tppn9f2nFTPiiTg=;
 b=ozWyOyPm1cH9nnlwwkE8B5+nIWDIqekCaajw8IcTuaUlP1RWwSSH4j5RTJIT4VYDZYGYcY
 Hq10VAkCSXhScvQVv6aUyZwz1IOZtssqZuM5Olc0zr0+0XIq+GocWlMbgN73xJgeqKc85Z
 kOVbMIguzTWxlGin9wl99sPFImnkWExT+aszQ9XPn9XXloDWuM2QhFBYWGDAzw0SSrkc1M
 omC6oci3/yyfFlukFfGOl64OxXCx4zFrU9kxTWjf/38ElsPcwHCGFZW8BR0QuXAyk+nej+
 IO/pY06OVE/HP5yicNxrruFw50zrExBnAwJpCSzHyIFut0gQZrJbN51gQuuRZA==
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>
Subject: [RFC PATCH 2/3] memory: atmel-ebi: Add compatible for older 9260 cores
Date: Mon, 11 Mar 2024 16:23:05 +0100
Message-Id: <20240311152306.2358845-3-ada@thorsis.com>
In-Reply-To: <20240311152306.2358845-1-ada@thorsis.com>
References: <20240311152306.2358845-1-ada@thorsis.com>
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

Required for using the new dm enabled nand controller driver on old
boards like the at91sam9g20-ek.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/memory/atmel_ebi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/atmel_ebi.c b/drivers/memory/atmel_ebi.c
index 4739eef1b75..503e2ea707b 100644
--- a/drivers/memory/atmel_ebi.c
+++ b/drivers/memory/atmel_ebi.c
@@ -23,6 +23,7 @@ static int atmel_ebi_probe(struct udevice *dev)
 }
 
 static const struct udevice_id atmel_ebi_match[] = {
+	{.compatible = "atmel,at91sam9260-ebi"},
 	{.compatible = "microchip,sam9x60-ebi"},
 	{.compatible = "atmel,sama5d3-ebi"},
 	{ /* Sentinel */ }
-- 
2.39.2

