Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF98CD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 22:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0621688087;
	Tue, 26 Mar 2024 23:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="a57KVv5J";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Yv1b6wcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 451EB88073; Tue, 26 Mar 2024 23:15:08 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600B088044
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4V43yL0t3Mz9snV;
 Tue, 26 Mar 2024 23:15:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711491306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Obhrslo/dKK6L4YtKNeCYyN87nGSXSxJ3OjWEUQg7Ko=;
 b=a57KVv5JVgxp/lcVFkUCZ+mNoA7O/NUNAowM+FvkP+YMS5JE4R6i595kbRYhRpXetrgZVS
 SkNP+DXZG3hZL3GNda91dYjjgCXjIxjkMXnUt9hRRQ+HlIt9a5bXdK7bii7yJTAsDjTT3H
 9dylp4kjiYryDv81nlEBzK8GGi46NthRtUAzmbi+bITL7NXQpqYP/8fEEJgII8+M3iGiLe
 wEtBOVaA8gbsYqDBxZcAcVHEQXoFZJNm2unmAlTJjOiHuayQ8a8e13xlX9bV0RZP8mbJxA
 Q6bm86SYzaip6fu4MYxuws89M0ILs2lKaTgVg46Gyv7NxxmvnSUfmt9Ot3S8oQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711491304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Obhrslo/dKK6L4YtKNeCYyN87nGSXSxJ3OjWEUQg7Ko=;
 b=Yv1b6wcCrfRcnwYphsCIk3MyT/NzS0HnBpfEBFiG+aKWcPed0KYr2buYD+MFyqlTq3PywG
 2yhRLttn8MPnESt8KDVZbQdtkY6WpERxrQ6ur8gfHT9rdV/ir+qNxgUc9Z3F3hA81J/w4a
 loq+GvdTwpNYdyagtcRN2cx19Z2C1fduiGXCYo+pgxKujfxzSn3JoM+e26yRugIVDP7xRP
 U7TKATNsrZIz2oL3Vy+LP7yLLmW7A1XAYE043L3eFyGDYr495aRgAXescp+f9Do3sm7Dzq
 TB7pRYFpIcUhakr3Dbs3Yvomb99KLoTv0iNc/ddTPT2BXGFnsnAUgzVlRYOlCA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 6/6] boot: fdt: Move usable variable below updated comment
Date: Tue, 26 Mar 2024 23:13:16 +0100
Message-ID: <20240326221431.55346-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
References: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 32fc4031496fff74cdd
X-MBO-RS-META: qmw3x8e1um8st65b39nhm8475gg1z8ce
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
V4: No change
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

