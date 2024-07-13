Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF79CC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BFF68889A;
	Sat, 13 Jul 2024 15:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ia0FQBZb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uw+wO9KX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F27E888A2; Sat, 13 Jul 2024 15:21:33 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9021288888
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WLpyL2fg1z9sZF;
 Sat, 13 Jul 2024 15:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGgxBCS3w9iBLF04ODiV+xy/eBFd1NrRSqrbW3LtWiY=;
 b=Ia0FQBZbTxksFz1c/RoRYHzbrDMMqpbcrmNaHLhw7FeQAwDKo0bZVv6VINqJBVLV9fGJDA
 aEB0Nk4DFaKy40lUS2CAeDsP0zSix+BH0yLcDNX12b1FGxWovQVco4ogs7mM/WattVOx0p
 uafkaxx8xsdeKSktdzJaIlHVZzudNkCRzo4wXiUAczp0DBpXdxElepPoc1TUSFQmjmG70l
 BY56qsMY3Hw4oObwR4BO7ULin6RXuCTA4F9q7EtQFPQqrIJsl9FSO5f4J5E4kWHmPN1vqZ
 3jUuhYdMPbrXUwy8jYyIghML17Qnmr/r1LTmUs23tEXC4Fd8T41cNR0Me+8Efg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGgxBCS3w9iBLF04ODiV+xy/eBFd1NrRSqrbW3LtWiY=;
 b=uw+wO9KXCKXYB3YJBnpFEkHEAotx+jasTp/ro5AID7pw+uDzTAo/HIp603eG/TqJZpV2Dd
 hfjoMW3r1FQyNuF0y2c7Pl5CbeNOKrDrQVqpIWa3ITKbRMcXGAzLX9k8D+ktlL+stH3YKe
 TaksOdI1tBZIrM5Xtup9TE/Br3NDcBwcyTVnE95c4BlKDVqrW2leISAWhGsUbKkx2r55ZC
 Hlmw4yk1Yu43B/qVxDyRHoCHmhfGGaueDQmUboHYPzRgQlPTA9hFrrOZgQTvAmaRmS6dL1
 MGKRNz4ep6ZURWse9Gm2hYd+j2z0+6/Hf5jtNfrwJ1bExiPTTx9RWxIuINlVOw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 22/45] arm: mach: stm32: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:13 +0200
Message-ID: <20240713132021.57650-22-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2ee7de31eb500d617ac
X-MBO-RS-META: ug88xcg7zss1tmaedm39tzc4mgiw9zw7
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
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
index 967fa4e06c0..04640e476e6 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
@@ -187,7 +187,6 @@ U_BOOT_CMD(stm32prog, 5, 0, do_stm32prog,
 	   "  <size> = size of flashlayout (optional for image with STM32 header)\n"
 );
 
-
 bool stm32prog_get_fsbl_nor(void)
 {
 	if (stm32prog_data)
-- 
2.43.0

