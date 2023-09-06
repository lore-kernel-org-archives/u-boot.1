Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A749EE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDBB86A08;
	Wed,  6 Sep 2023 23:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="X+CYg8Sd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="T50sabVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E969869A4; Wed,  6 Sep 2023 23:30:56 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD56C868BC
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RgwXY4LBPz9sqQ;
 Wed,  6 Sep 2023 23:30:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJNfqnqHb5RnaUHSZWzBK6titqbtpt+/+qA13roacts=;
 b=X+CYg8SdJZIydI9Ln0wJ+1Vk7Gos2rkDJn9S6apibCzSaLo166NS7KEuda4NGZ0scqTnKq
 38tPwK4ZVW6iugwMDR2l3AwkvZu4ngK8cuuaz8W9ydtjsGC7wk75UJKjjkuEmKD3FR9nna
 t3bCuiGW+xMFhBN8TmTgXEB2Rn9GhRy/tV9pFLWz0IpqsodZzoobZtmNkyFZMFjzzO3Ac3
 lmR/AGwKGWCdaQp7rdy9MY+hiPCCxJxYObluyCa7/dmjpHydM520Fd/KfZ3TiY1g42tJcp
 80EYwF1V5B4Ak/OQS/yZQICxPlSs3EJqhOyA8ZdPFU1GDY8j2Zac9uxR4bVwHA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJNfqnqHb5RnaUHSZWzBK6titqbtpt+/+qA13roacts=;
 b=T50sabVadjOE03+tRp+gE8q0TGzRgxvm2WqYO8/un9Ct4NpjSqSOv2XnrXt23e7aht6x05
 UGeiojVaPA5XivPUpi3jTXXjRCRpkIyZWs/bDoGCa4ZwLPt4yLJETwJyTztVUp76qqxLWs
 VgxPLZus7uYqFOkZeRo49gmuQRuI44gogMPRGXIwqSfUXuMNUg51MwFQw57aEoyxE4b0qC
 2ScnpeqOQXtIu/0qmhuyZz7vaFXJmLXvY0l3Bl2rwWAc1BErALTlJUnJm1fkUWMWFL2VWs
 /S1Ci8hXOTAtl9h/MlgkgC8lwzJQY19tSiyWYRW3Q33hGWSefGDJrcmoSU5BPg==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 21/35] cpu: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:01 +0200
Message-Id: <20230906213015.203437-22-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2ae1942425438a365ca
X-MBO-RS-META: 4pasub4icd5s5nur9t1qzx3dookjc7o7
X-Rspamd-Queue-Id: 4RgwXY4LBPz9sqQ
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
 drivers/cpu/cpu-uclass.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/cpu/cpu-uclass.c b/drivers/cpu/cpu-uclass.c
index a7548325265..9772578968b 100644
--- a/drivers/cpu/cpu-uclass.c
+++ b/drivers/cpu/cpu-uclass.c
@@ -127,36 +127,9 @@ static int uclass_cpu_init(struct uclass *uc)
 	return ret;
 }
 
-static int uclass_cpu_post_bind(struct udevice *dev)
-{
-	if (IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC) &&
-	    (gd->flags & GD_FLG_RELOC)) {
-		struct cpu_ops *ops = cpu_get_ops(dev);
-		static int reloc_done;
-
-		if (!reloc_done) {
-			if (ops->get_desc)
-				MANUAL_RELOC(ops->get_desc);
-			if (ops->get_info)
-				MANUAL_RELOC(ops->get_info);
-			if (ops->get_count)
-				MANUAL_RELOC(ops->get_count);
-			if (ops->get_vendor)
-				MANUAL_RELOC(ops->get_vendor);
-			if (ops->is_current)
-				MANUAL_RELOC(ops->is_current);
-
-			reloc_done++;
-		}
-	}
-
-	return 0;
-}
-
 UCLASS_DRIVER(cpu) = {
 	.id		= UCLASS_CPU,
 	.name		= "cpu",
 	.flags		= DM_UC_FLAG_SEQ_ALIAS,
 	.init		= uclass_cpu_init,
-	.post_bind	= uclass_cpu_post_bind,
 };
-- 
2.40.1

