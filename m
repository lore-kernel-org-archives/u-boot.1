Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B143C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BCD588C88;
	Sat, 20 Jul 2024 14:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RB6Vdn/N";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nJxcB7tN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF556886F9; Sat, 20 Jul 2024 14:43:50 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 475A488C67
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WR5nc04P7z9sT1;
 Sat, 20 Jul 2024 14:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Lr+kgq1kC/EiQcjnXPcWn8rT0PGE4LP1h4syvCfN3c=;
 b=RB6Vdn/N/DCD6I7WFKtfpixIXPYuRk2re3yl71x2hLGyPCzpxMT/HXIKqAiSSDtod3PmAl
 KDYVWEtbGqaSfi3TYfzSn3itAByGucScb3rF1NMlJJYdK5Sh1DyuG1tj3NJxXzSG5ZlM8m
 21forKNsNdxBZ1zgykjzAQT8uzL1KkbgtQCPt/3igOyz80qPu9nezddVu05yuu56TW1q7F
 PeKDPKZjusjvZChtcI0bovlAkgMlHvUgARAxSoYFx815OOwX5Pu9+v/YASs+7AOb905raX
 J0eyCUNnjI3aP/HLTm+Z6Oo+y+4Jsn395KwTi1CDH3nAhM9eZULhTE+mQJ+SGg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Lr+kgq1kC/EiQcjnXPcWn8rT0PGE4LP1h4syvCfN3c=;
 b=nJxcB7tNHL28TsGks9xTW3KYjLgY0zXkoRBhI0F5sRmnbB8H6vgIwQuKvKL5CSFq1FAg+F
 uQwyKfWs0LMslcW6oMoP0SAcYPA4iGpZKUCtjuhx36BsjhPTLXmW7y7G1xwBBpIRFO4yif
 eKIKVjH+I7un5VyXhAmsa/e+rAF8uN9g/XiF6MDmbFQ8RBXwcCJqb5Js1ts4jYtYl0l+qu
 69TUcyjCP86huZenWbW2gE50VCpWwJLhsaIzzNFzB1czyDs/TEoXUEFQ5M9tbuIedMWMuS
 w7HaCcO1dr9pA+gt090+6qbK/+C422EOHGF56v9q8hJQ+iLNiT7mh8tarzD+hg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 17/40] drivers: misc: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:42 +0200
Message-ID: <20240720124239.7553-17-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ef5da31de0d289a6f85
X-MBO-RS-META: 3nb18zfqm3599si46xjnosnqfu1s9kp4
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/misc/cros_ec_i2c.c | 1 -
 drivers/misc/stm32_rcc.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/misc/cros_ec_i2c.c b/drivers/misc/cros_ec_i2c.c
index 5516aa8b3ff..cbdc55054ba 100644
--- a/drivers/misc/cros_ec_i2c.c
+++ b/drivers/misc/cros_ec_i2c.c
@@ -99,7 +99,6 @@ static int cros_ec_i2c_packet(struct udevice *udev, int out_bytes, int in_bytes)
 		return -EBADMSG;
 	}
 
-
 	/* drop result and packet_len */
 	memmove(dev->din, &ec_response_i2c->ec_response, in_bytes);
 
diff --git a/drivers/misc/stm32_rcc.c b/drivers/misc/stm32_rcc.c
index 0dd827e1dd0..5a6f979f91b 100644
--- a/drivers/misc/stm32_rcc.c
+++ b/drivers/misc/stm32_rcc.c
@@ -76,7 +76,6 @@ static int stm32_rcc_bind(struct udevice *dev)
 					    dev_ofnode(dev), &child);
 }
 
-
 static const struct udevice_id stm32_rcc_ids[] = {
 	{.compatible = "st,stm32f42xx-rcc", .data = (ulong)&stm32_rcc_clk_f42x },
 	{.compatible = "st,stm32f469-rcc", .data = (ulong)&stm32_rcc_clk_f469 },
-- 
2.43.0

