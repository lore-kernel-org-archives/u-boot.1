Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6898C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C9BF88C36;
	Sat, 20 Jul 2024 14:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PszPw6Ye";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fmItxuod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B67EC888AA; Sat, 20 Jul 2024 14:43:39 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC74888815
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WR5nP4lN8z9sRn;
 Sat, 20 Jul 2024 14:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNo2qfilqZ3eXMNgsEUdDu0JkbTt6xIUQlKdQeRzb3Y=;
 b=PszPw6YeZUE/yfl47ZZkMxpEkus2wN1sHZC2V/cA08cSdt+nnf9KR6j50G5Jcy/EV62JMT
 GUGydHNaVR+TBB5Q6djHzAIKWyVFkOk8ZMeQVanwpMYUhx60vNiSTcQe4dkLdgHe77ndqw
 SznRo4gBSeBT8u1ZGsSmVVLce4woyUvdZt0TOcK+3i6PLJNESa4zGJKnys0h1Q9feGymkq
 QJ3f5X6RCYzZhHm/GPgSmuO6l/89avL8P9WYUlX6M5rVER5dCOpTzlLS9e6SF4PXNkmrYF
 lHepC/T98dm5xKVYD4X2SwuJnKQmZ6p7Ha9iVdl591+UGv5pPwkOumV7XTUONQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNo2qfilqZ3eXMNgsEUdDu0JkbTt6xIUQlKdQeRzb3Y=;
 b=fmItxuodpah/wTOxqYt/KKr2Uvr8w3YIOwe0flnD2DBjOpv5VN19j1RlH8reA+KAGCECJE
 9ciHmnHMO9a0a71XD4HKQof2+Jk2G6gy/WXGcJmjB5/ZosV4IAq8HbtnvjXUZlnh7URtyZ
 16pXdiawuYKvKI1UOgVJlAybFXYbflFYOqN2AM7zOTEd4eAGXmbsHJFPjLe5HYxNmIJ14C
 nfDrLYQtt0pqV9zLvmZ1N6seb9py3OqKRnHEqnuhTW3nf8IahUalt0wIYqR4G9TsWk66hv
 7po/IYkeuXsQFkkxUXNbpxuMEm1gLdopwnqavDwxM8RADgdhRtGuN0MihzAZjQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 06/40] drivers: core: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:31 +0200
Message-ID: <20240720124239.7553-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8d7b1c9e75125a0aa82
X-MBO-RS-META: 7a1bns6sma8e9sejb3mp1koi8mkdbwsc
X-Rspamd-Queue-Id: 4WR5nP4lN8z9sRn
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
 drivers/core/of_addr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/core/of_addr.c b/drivers/core/of_addr.c
index c893447a1b1..6c7b4c97d67 100644
--- a/drivers/core/of_addr.c
+++ b/drivers/core/of_addr.c
@@ -401,7 +401,6 @@ out:
 	return ret;
 }
 
-
 static int __of_address_to_resource(const struct device_node *dev,
 		const __be32 *addrp, u64 size, unsigned int flags,
 		const char *name, struct resource *r)
-- 
2.43.0

