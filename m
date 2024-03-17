Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874EBC54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 06:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6612087E0D;
	Sun, 17 Mar 2024 07:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FQEw/Bni";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="v2ohvZdn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B93F87B30; Sun, 17 Mar 2024 07:17:54 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5177C8753A
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 07:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Ty7800VkKz9smc;
 Sun, 17 Mar 2024 07:17:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710656272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CnXsyqZphjuca35t2vmyNdFVVinGxIB+0ec74qUDiM=;
 b=FQEw/BniLSxqJyFv58n/BXp3UaqWxa86cC7cSmy69C2h3ES6sBdCTp6GUkAnsLBMnblWSQ
 Oxyihg0ftPj0L/4KhI+f+mQKyYW4qJTyCQFwhxc/vWe/hKn0Rbziip79fj+M20dpjD01lv
 MED6FFQ+smGKfXxZdov8rFD96UXjMbcvUpoHmR6N2v+g6NAXMXDb9PlYAi0XBDxCRlKnPZ
 5lI4/n1sGSXa7L91z26YOjrSBkmm8e/AXB95QxibVXOtj0u1Z/6f6zveY7kglDpS+lkQly
 HBmmbgKEBKaQw+XOki3A4cwCiOWts78g7irEW7pjP0RfwMpb/sZUBtmkP9QVNA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710656270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CnXsyqZphjuca35t2vmyNdFVVinGxIB+0ec74qUDiM=;
 b=v2ohvZdnx79rtfe8VbNVNOb1Ne1oJazAz6mcuvOSPUi7HB5/49ObAvcbHaemq7CDB2or+1
 /xDcQ/FREuCiwp4NP3DzvtH48xjZBYDXi66yFM72BFG9gJ3tcOP0oFc8AxhBRDn3aL2Xla
 4wtPHzxL8klp9gK4wPeZgc8TnLygMCmFY3946ErPXbgYxbOtkvadeAYEnHL+ti225YTS9s
 d2bxxdC8PHYY47sAHpTGGwaJVzyO8TZRC4NbdFdS+B+zRCcWi1Cw5m2J9E+R5vnoSlhoi0
 XamRJEiMoO6LyJoP6M1zGJbWUwsJhzATPlhg1noPI+4TYkP1dW0qBXfnswa37w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] boot: fdt: Move usable variable below updated comment
Date: Sun, 17 Mar 2024 07:16:31 +0100
Message-ID: <20240317061730.654893-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 64i1ro6g93pbxjxe93q5h73bi7zq53zi
X-MBO-RS-ID: 3effec404adfe22a816
X-Rspamd-Queue-Id: 4Ty7800VkKz9smc
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

Move the variable below comment which explains what the variable means.
Update the comment. No functional change.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 boot/image-fdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index c37442c9130..16cd15e7e44 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -218,12 +218,12 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
 			if (start + size < low)
 				continue;
 
-			usable = min(start + size, low + mapsize);
-
 			/*
 			 * At least part of this DRAM bank is usable, try
-			 * using it for LMB allocation.
+			 * using the the DRAM bank up to $usable address
+			 * limit for LMB allocation.
 			 */
+			usable = min(start + size, low + mapsize);
 			addr = lmb_alloc_base(lmb, of_len, 0x1000, usable);
 			of_start = map_sysmem(addr, of_len);
 			/* Allocation succeeded, use this block. */
-- 
2.43.0

