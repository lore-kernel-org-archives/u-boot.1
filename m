Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7336C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 15:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13FF787FC8;
	Mon, 18 Mar 2024 16:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uMgQt1PX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IJiChxc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF53887F64; Mon, 18 Mar 2024 16:02:29 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3E687E6D
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Tyykp5NqNz9sWp;
 Mon, 18 Mar 2024 16:02:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sv2ymGmJRab4iIAV+8KU49n0a+b4KjJQHkOW1b+BS9c=;
 b=uMgQt1PXs3APqbUw1nuuxe1mwD7HQNjHlRgGjWtcEnayTbEOTo5Ak61sTojnIuqZElCo7n
 CeumypbEwsmjCVPcxfPqgWrBYCCFmc+Vuqf5KNIpZONfdK7ngP1RWCXpQC/e1r91QuBcHt
 YuK0tXXQWuxv7Oe7h/jxllqUIppZu1lLClsZJiwmFmkZvOiH8TLdDtQJ+/VImvElLxNzGe
 q4anIexgKktjEVbkBNo0wFtXBu7a+8IRiGK22nSmQOPFO6Qo+6b3YG99rFWHCsP4hbCw4q
 I4eZ+ZCEK79V7M0Et4nGsD7v07H2/4IpBxmL+MguSHCPZhQJutlpiewLdvQ5fw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sv2ymGmJRab4iIAV+8KU49n0a+b4KjJQHkOW1b+BS9c=;
 b=IJiChxc07XrxQ6l2rGlomUcUdgO1CVWKrRIu+vyCYODYQ7tbLdahsyVe69Q4RbSXuitRW3
 VV4iMptyNWJo2S7NNt/3TzxLkbqCEzF5LG1RfS8YDUJFn4DaawYz36P4NehOZBhQvq/vfu
 bjly5GppUubjYIN/3V1q/PVdMIN5vyjawd+q+LazEOKPHO1gVprQQu9rzqlsg9clGvFpbn
 rFxNsygIhgK6120jQjfsFnlh9mXpOKT8+3zmZrYX2bkdIKem39xUbLR/5HGfrype6Xoy+o
 8uOfYh9qjTrDONFcp0LupgQhtBFbaIWRudrXZukhXzl3EFT86sKtMX0mK2B/xg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/4] boot: fdt: Move usable variable below updated comment
Date: Mon, 18 Mar 2024 16:00:47 +0100
Message-ID: <20240318150200.8178-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
References: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pyd69s6a9i5c6zug4bo6ojw7hg8qfyko
X-MBO-RS-ID: a0f465a911911f7416c
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

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: - Update the comment, s@the the@the@ and quote 'usable'
    - Add RB from Laurent
---
 boot/image-fdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index c37442c9130..2b92bdaff16 100644
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
+			 * using the DRAM bank up to 'usable' address limit
+			 * for LMB allocation.
 			 */
+			usable = min(start + size, low + mapsize);
 			addr = lmb_alloc_base(lmb, of_len, 0x1000, usable);
 			of_start = map_sysmem(addr, of_len);
 			/* Allocation succeeded, use this block. */
-- 
2.43.0

