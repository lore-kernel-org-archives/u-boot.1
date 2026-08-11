Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3594FC5CFCF
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 09:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDB0440758;
	Tue, 11 Aug 2026 09:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ybDDdyPJGwg8; Tue, 11 Aug 2026 09:42:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0009440759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786441377;
	bh=x7axtadZVxQXGn0S2fXVjcJUQEsrEccDMg63HpDt4MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0CEWeyo09TjcFNOfrF1F5Skid2FiCzzpEQT32mRZsBHAlK+GqiVMN6pworbd34klz
	 J4En9xlQtxnRxVX5EjBXHUKRL7HOstc333zvE4B1AFR1O+j2vcouYd6G4WyoamTxJQ
	 4SYRfbhQg2C/YlCymcujLrZgx1yKKeCKVqzo7C/vcxqorj9c85ms+ljqUWLajffmB+
	 TQVQbCqXoS0IEUNbbrCCHbxNv/AYO6DLQzR+Bi0NZ/vMk5yZhVoBcDVRED+7DKhlPk
	 2ZaNYorA6h6d983dpPoPOk5AvV5TzBAjc09ki5ozHFucFZM57APikRxDweVZjp0pD0
	 6/W945LnBadAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0009440759;
	Tue, 11 Aug 2026 09:42:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2227259
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFFA540758
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KR2RJ3tgUEy0 for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 09:42:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 473AE4075D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 473AE4075D
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 473AE4075D
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:42:54 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com
Subject: [PATCH 2/3] board: imx6dl-sielaff: Remove board_boot_order()
 workaround
Date: Tue, 11 Aug 2026 11:34:19 +0200
Message-ID: <20260811093423.212986-2-frieder@fris.de>
In-Reply-To: <20260811093423.212986-1-frieder@fris.de>
References: <20260811093423.212986-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fris.de; s=mail; t=1786440889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7axtadZVxQXGn0S2fXVjcJUQEsrEccDMg63HpDt4MU=;
 b=3WpMFeAlGZgmlEeB+3AiuBOdAitoeu3QR9kiUAq6ipXOE2uAQayhiQXl2BZyS/ai/Xdyy8
 /T5axdswZFMB4EGj3ZKB9Gf0KHyivN5v07TdBTlUPdijk0hSgWw8L3oIBfQbAD/lTCQFF/
 sgpEJ3UupP1u31DdOtm/g3gUSmMm3FKD9hNKp7Ah5o8tuloxB3tj4i3mIqLq3aJEvjcrfm
 +rGfugcvLK9/4p69uVV696IWePgiJOBk85zSL6LUVGFFYlKtaVtPez5mrj8xeIkbHQ2P6v
 tjcnYFeDERJuwuikZOw9KUbYRIt6lsz2Bc7VAqQf76GHFJuHRMfYuQK/8Wzlww==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=fris.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=3WpMFeAl
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Now that the fallback to SPI NOR as boot device can be properly
detected, remove the workaround.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/sielaff/imx6dl-sielaff/spl.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/board/sielaff/imx6dl-sielaff/spl.c b/board/sielaff/imx6dl-sielaff/spl.c
index 6815952c0fb..ae36ff5712c 100644
--- a/board/sielaff/imx6dl-sielaff/spl.c
+++ b/board/sielaff/imx6dl-sielaff/spl.c
@@ -249,25 +249,3 @@ void board_init_f(ulong dummy)
 	/* load/boot image from boot device */
 	board_init_r(NULL, 0);
 }
-
-void board_boot_order(u32 *spl_boot_list)
-{
-	u32 bootdev = spl_boot_device();
-
-	/*
-	 * The default boot fuse settings use the SD card (MMC1) as primary
-	 * boot device, but allow SPI NOR as a fallback boot device.
-	 * We can't detect the fallback case and spl_boot_device() will return
-	 * BOOT_DEVICE_MMC1 despite the actual boot device being SPI NOR.
-	 * Therefore we try to load U-Boot proper vom SPI NOR after loading
-	 * from MMC has failed.
-	 */
-	spl_boot_list[0] = bootdev;
-
-	switch (bootdev) {
-	case BOOT_DEVICE_MMC1:
-	case BOOT_DEVICE_MMC2:
-		spl_boot_list[1] = BOOT_DEVICE_SPI;
-		break;
-	}
-}
-- 
2.55.0

