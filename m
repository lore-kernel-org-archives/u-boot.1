Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A752EEE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 716E786AA7;
	Wed,  6 Sep 2023 23:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SBvmvc1o";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZwQAEAvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D133E86AB5; Wed,  6 Sep 2023 23:31:04 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3750869EB
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgwXd47Z2z9tTZ;
 Wed,  6 Sep 2023 23:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pwx8h8WhbZQqQ0TEymLEKSwUtiyZ8z5Sh96Xmb9GZ9Q=;
 b=SBvmvc1o319Wy+M3o7Tkk3pJ0yJntOrSlFOXt6jXJgLCwX7mFtEH7TEoPt2+QLgNO4kPsv
 aFGoq5W18iA3+EDZ+V/1NdlL3WdzPbGkkusSKyltFR3PF8K3MYzc72Htm0WIoJL3thzgLT
 hwXRvRcUw1BN7BhtQOS4UFjt6eGy9wXe4P+75GgGQOPYY5cLzBg3HWlTRT4tB1GaVlqVGg
 2puPowxZAo0YaWRHRAqe6MAOups0rOHA+ewEIFc17GiCUN7Qb4V3usbFQI0Z71eXmU2vJq
 tt7aYhyKW6XjuvNILrgyZrgIjnOqAnXE+otmKvFNeLEN7ChLE68qx88uulibjA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pwx8h8WhbZQqQ0TEymLEKSwUtiyZ8z5Sh96Xmb9GZ9Q=;
 b=ZwQAEAvEHxhRb0WMfTayJMdk4Na7OCaBlmd1ee6XiF3q6AKv8x80YRqpbKbrQdnA61LHit
 6m80nZZfh9tKJiI+V3abKRKeRIcWpg7C0wJUQqqCUCe4sNiiG5JWXo3aUwN3yKV756JPbO
 7aylGQOSkVocKjaaRFlizGPh6St1GDB1wasAkst4RlLLTWCaIh6jR/k/HMJPZH67Ec/xBu
 oXL4kW6ja6NsKbc2vzDlgor95PT7kiJtNjDmNoq4X2/ko6FkFFKZUJMrMK3u1rknJ1uA9u
 tRBZt20YrYp6fT+FAfxwxyGaM7usHD5NLN4ylVBX2OCS9Y1IEAguv6IUk+AXiA==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 27/35] net: eth: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:07 +0200
Message-Id: <20230906213015.203437-28-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: oo1zh14jejh8aynny4ohkc6tzi5hr1po
X-MBO-RS-ID: 4f47049dc49192f9565
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
 net/eth-uclass.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index c393600fabc..4311f3fe6e8 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -556,32 +556,6 @@ static int eth_post_probe(struct udevice *dev)
 	unsigned char env_enetaddr[ARP_HLEN];
 	char *source = "DT";
 
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	struct eth_ops *ops = eth_get_ops(dev);
-	static int reloc_done;
-
-	if (!reloc_done) {
-		if (ops->start)
-			ops->start += gd->reloc_off;
-		if (ops->send)
-			ops->send += gd->reloc_off;
-		if (ops->recv)
-			ops->recv += gd->reloc_off;
-		if (ops->free_pkt)
-			ops->free_pkt += gd->reloc_off;
-		if (ops->stop)
-			ops->stop += gd->reloc_off;
-		if (ops->mcast)
-			ops->mcast += gd->reloc_off;
-		if (ops->write_hwaddr)
-			ops->write_hwaddr += gd->reloc_off;
-		if (ops->read_rom_hwaddr)
-			ops->read_rom_hwaddr += gd->reloc_off;
-
-		reloc_done++;
-	}
-#endif
-
 	priv->state = ETH_STATE_INIT;
 	priv->running = false;
 
-- 
2.40.1

