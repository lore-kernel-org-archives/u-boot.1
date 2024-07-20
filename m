Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AB2C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35E9E88C94;
	Sat, 20 Jul 2024 14:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bXkjfrKx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vBOx1U/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99CDD88CBA; Sat, 20 Jul 2024 14:44:03 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E36488CA1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WR5ns1kLkz9sWs;
 Sat, 20 Jul 2024 14:44:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKtHJZdGmMi8+E/g+JSkkRE3Xj7w9AfKVqj07M5wVRw=;
 b=bXkjfrKxeRLXJPqaIZG0bJmwwEfCwLsrHTAD9bXGT3er5iBfjf4y9d5b3KiEIFxVSI9qiP
 LUDC9gDZvYUmLoMCCPqbl0lNkjsv2s/EE+V3j9Y2sTNJ0ITts2qqYM4z2s6h8LZ3uGpFvx
 fsZQP5InnlOw9DXPi7frzoJR8tNwSZElNDN1jlcFtYVLu6CAzdF1dk+iM/9o0VegI8fTsJ
 NwRR6j3rZqoYD1rW+OLFKtfLfzIaaAuR8zDvs3kx2DSkgmBsOI8EAjI5V0OJyrlfwhlxvq
 TQGkcV2BtyJ8FCl0wyABBtyDV0GYJ9AFK2gghwpwQrXkRpVtRbgOlSE+aD4xPw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKtHJZdGmMi8+E/g+JSkkRE3Xj7w9AfKVqj07M5wVRw=;
 b=vBOx1U/KDfrDgce+yWhzTa4nmAgEEqJm7prYJBJv1Lqoon4YdiLLgFBcyqFHRfZ4wVCQzR
 D8EluabJsQ/iLPLoutpogyc7mnwvm0E9SBa7ABcB8bfh57OxajJHDZfYmqffKynlzyNtlC
 P1JRDM2BoN8DfpJ8GRA5romoh6MT2AsebgOLjjtd3arKuDIU1MjmuHLPVdDLZ7CpKHEMer
 pc8wZ8/O29QZXdrRmUHvgqDp8G9YMuswJjBSo6V/ZW0L4p6msdZlEjONcfv/XtRWEsy5Di
 qXB9ZGLMYvbZeu1dL+jZbksHK4+lpXQywAmGPVLuxNuz4/7E4iGjGQrndAP1Ng==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 31/40] drivers: soc: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:56 +0200
Message-ID: <20240720124239.7553-31-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a11ddc61cb817068178
X-MBO-RS-META: hytexxg5467ii5hrabgc9ti8tak883rp
X-Rspamd-Queue-Id: 4WR5ns1kLkz9sWs
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
 drivers/soc/ti/k3-navss-ringacc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index d3f3d4761c2..b2643a30d3d 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -80,7 +80,6 @@ struct k3_nav_ring_rt_regs {
 #define K3_DMARING_RING_RT_DB_ENTRY_MASK		GENMASK(7, 0)
 #define K3_DMARING_RING_RT_DB_TDOWN_ACK		BIT(31)
 
-
 /**
  * struct k3_nav_ring_fifo_regs -  The Ring Accelerator Queues Registers region
  */
-- 
2.43.0

