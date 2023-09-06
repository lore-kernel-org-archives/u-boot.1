Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72778EE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B1E86AC6;
	Wed,  6 Sep 2023 23:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Bzz60Gr7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OqiUQ3MD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E9286AAC; Wed,  6 Sep 2023 23:31:07 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A23C0868BC
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgwXj362Vz9tTZ;
 Wed,  6 Sep 2023 23:31:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTocCfghmsZlpHayZK2AH4wC/vEj14akfH6kigSiR1c=;
 b=Bzz60Gr71MZb7DVjBUfk8sB76vcc3gt1a/3u9jMucbOFqmyotaXzpQ9+4eVYlN7MyB1ZNl
 yuHpRuAr+pyZuU41obiQWE7OYa93XwoB+NFlrSJxRelnaFDaWQX0xKcdYgjAQtUS0pHjPC
 mZC30fouy7mV6uF1RJi69Rz6wBoCo8gDrtXWx7SFX9rRzf6ABU6N+/IBqRN3jMq6pTTSr0
 MgklewBm4D35rqLwKz2z+Zcf/WWmBXNedvTtVq3KPBnwpf1bKTkUTA5u3OFLZ2A1j5Y8dJ
 tywkuE3d95lXJN4m2vDMj7aybUrVjPwvm3db/aC5DggE8SBbpUHVqMLVUyOjsQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTocCfghmsZlpHayZK2AH4wC/vEj14akfH6kigSiR1c=;
 b=OqiUQ3MDGsBWdT7s+JrWo+X5htnTbw0I47IlNzjF8n2siZZlhxd1zDIAfugC+04SUgZY8l
 IJ1WwFP7a86Ng/43DfFUZjPZmYvUVpWShjahDMpI4S2gCefkRtWkKJWTU8w3HGrlSRCATo
 yFwJKbckJypB5RZp5ahT7OHy7yPbeUFOfi07Y4Qzk/RBBxMIngbD6R+iTFc5ZN2KSgFIef
 PrFcpxXH0+UqxtCcFWOj/HJpBTD9uRIG5lybuwc6nqwldIlUR9RWcwmstc9wNKt1v6h6nR
 yInm401rFODscdN6/tD2zYmcTG3CjA44318+IXoPbSJ9HC87poibqosmkTE23Q==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 33/35] timer: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:13 +0200
Message-Id: <20230906213015.203437-34-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: af5ef6e3e44d869abbb
X-MBO-RS-META: gsc64rsqg1prnrsfr75mawsk9f5amtt3
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
 drivers/timer/timer-uclass.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/timer/timer-uclass.c b/drivers/timer/timer-uclass.c
index f4b871ac23a..0c2018bfe3b 100644
--- a/drivers/timer/timer-uclass.c
+++ b/drivers/timer/timer-uclass.c
@@ -51,19 +51,6 @@ unsigned long notrace timer_get_rate(struct udevice *dev)
 
 static int timer_pre_probe(struct udevice *dev)
 {
-	if (IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC) &&
-	    (gd->flags & GD_FLG_RELOC)) {
-		struct timer_ops *ops = timer_get_ops(dev);
-		static int reloc_done;
-
-		if (!reloc_done) {
-			if (ops->get_count)
-				MANUAL_RELOC(ops->get_count);
-
-			reloc_done++;
-		}
-	}
-
 	if (CONFIG_IS_ENABLED(OF_REAL)) {
 		struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 		struct clk timer_clk;
-- 
2.40.1

