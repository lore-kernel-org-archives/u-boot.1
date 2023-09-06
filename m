Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4E6EE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B8D486A8A;
	Wed,  6 Sep 2023 23:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NqIbmKGn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ok2ThJML";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7604886A0C; Wed,  6 Sep 2023 23:30:58 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F4F86A30
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RgwXb3hZ7z9sqQ;
 Wed,  6 Sep 2023 23:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueb7d+C+AvXZfWjKlHKT3sFmGhRvFgmNZT+8oyN5Mjs=;
 b=NqIbmKGn0EMTJSifWYMqrIyVpr4+HWwGsfEChoBaxaDuoODgkRCgoOwibSKMd22OkvVrYu
 tlrfMek9icUh5yIfxwDohCVXHcRxsWMLEzCVKWsSnnDfMxyySZyXDAbBKZybXLZOl2x9GA
 kO5xiamVNMhwUN6TRvf2hm7zzNwYpRZ8Vt6TpXyxHJezI5+mw+/Ox1gkvgSj4XwWF7akzR
 eVw2vbgRB8LlEa1VLkWc9PiGNAb1nfhhnB8RnJ+N6F5pC326dGG1uuP06Zhq4bSQTsGwTd
 Io7xdtpwF+BteUuYJh0baTUPVXVlzRoVGaOjIKMlwbpoLYcXiTf61SYldPvV9A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueb7d+C+AvXZfWjKlHKT3sFmGhRvFgmNZT+8oyN5Mjs=;
 b=Ok2ThJMLO4T94GXOPW9YD+Leo+yMwXej/CKyKMlop+Pzy71ft34wvGEKILeGYKpAjdZgrP
 g/v/Ea63u7gvETAmp7isJN53Fey29m7Pmcvc6EygQBm5qjcjomWRC5LGXK+yvUajPJW4xj
 7+8DwWCU2Y1VM8KWF0lFlULG6YARgaxm2z7tZX0HWmRq7vPkw8n7Ty42Hqjb8B4LVp8mz/
 /Iqya2K0NoKidSWVq/KDQvwSfIAPKa3O6kZmkPcJO3kJiLBD+QqUj1QiAvg7vTa/Ve9LBG
 QZDrjuH+xCMd8GmHNXSfigV9hPMIcLSU60eP53bD4oxxjP71z14QTttDv2H5Aw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 24/35] hwspinlock: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:04 +0200
Message-Id: <20230906213015.203437-25-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p5nxsr4hdafpjd9tj9skudj89uihjofy
X-MBO-RS-ID: 2759071ae7612f74f6a
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
 drivers/hwspinlock/hwspinlock-uclass.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/hwspinlock/hwspinlock-uclass.c b/drivers/hwspinlock/hwspinlock-uclass.c
index e012d5a4c93..e9a4d7f9fbb 100644
--- a/drivers/hwspinlock/hwspinlock-uclass.c
+++ b/drivers/hwspinlock/hwspinlock-uclass.c
@@ -123,28 +123,7 @@ int hwspinlock_unlock(struct hwspinlock *hws)
 	return ops->unlock(hws->dev, hws->id);
 }
 
-static int hwspinlock_post_bind(struct udevice *dev)
-{
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	struct hwspinlock_ops *ops = device_get_ops(dev);
-	static int reloc_done;
-
-	if (!reloc_done) {
-		if (ops->lock)
-			ops->lock += gd->reloc_off;
-		if (ops->unlock)
-			ops->unlock += gd->reloc_off;
-		if (ops->relax)
-			ops->relax += gd->reloc_off;
-
-		reloc_done++;
-	}
-#endif
-	return 0;
-}
-
 UCLASS_DRIVER(hwspinlock) = {
 	.id		= UCLASS_HWSPINLOCK,
 	.name		= "hwspinlock",
-	.post_bind	= hwspinlock_post_bind,
 };
-- 
2.40.1

