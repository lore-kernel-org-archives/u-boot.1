Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58FECD11C2
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 20:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53814880E0;
	Wed, 20 Mar 2024 21:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SyS+B272";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WFUOAgkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE8AC880C0; Wed, 20 Mar 2024 21:54:40 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE44880B9
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 21:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4V0LSF12yxz9tRS;
 Wed, 20 Mar 2024 21:54:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710968077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzJGOfSQTMk4yQKorWohGedYDNxcRQyKAMJ2Jwzs2qw=;
 b=SyS+B272yahb6IPG3KmbTzP16do3I26YGmOU+H2bkDu0iE4wfbOv007G08iL1+2N6stpmx
 N+vc7NaU/0URsMR9N7pQXpt37HF1vkLbvDQGeSgzU0j2jnNRD0sjehmWQckiJMbdUkm9LN
 UN/sS/3B9mndcW76R84nynaUq4zUtA7kK0un2cLMD5FPV4yVSL3cBf4sV/VmGflaiYhKcv
 vSXO7DRQTas0Rdvpo/M4RkNNMkn4r+VhXXKjgv47PVT7BzmSGdxo5XS+NkVonFGTCIl2ii
 928l/G4iL9D/yGLaR5zRWkB+lyGjqRbeYeqnpLdxGoeX4QMw8cJUvT2ljiHWIQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710968075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzJGOfSQTMk4yQKorWohGedYDNxcRQyKAMJ2Jwzs2qw=;
 b=WFUOAgkRN+31bbhZ3pldhm9/7EGheDgAAL5n2pcZgph/FkLmHlQDrDS3jOA9XsG16yUEKf
 nzJ4nfiZfN8t8lsWPgA96y+J1GnUGHxnvcIcClqxXQwQGduzUlfovzV1WLqIwhpRsNZ5OD
 V26kHHawyZrc5st/if3eNHr9aIYMEZROpbalbfubOX5UDgS+Gdm1i01ShjurhmCL+LzlHw
 rIzW6BJ/DoFYmobNUR8Fwqtpwk8Cs+i0mcK2l0yyZA23rfkjjGWIllmSWK6GL6AfaP46zS
 BO5ptup+KrwHkY0/rvgMDrgoJkau+44xU8dIfZv+qfYRwn0jNwYDBlzK5nUHJQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 5/5] boot: fdt: Move usable variable below updated comment
Date: Wed, 20 Mar 2024 21:53:09 +0100
Message-ID: <20240320205413.32555-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240320205413.32555-1-marek.vasut+renesas@mailbox.org>
References: <20240320205413.32555-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a3dc16997e897b34b66
X-MBO-RS-META: yf85o7g3btd543qa3k1uzwcp4e8jnuqk
X-Rspamd-Queue-Id: 4V0LSF12yxz9tRS
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
V3: No change
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

