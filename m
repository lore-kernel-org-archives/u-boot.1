Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3345CCF9EE
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 11:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ADB7832AD;
	Mon, 27 Oct 2025 12:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eohC+Drz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC086836B2; Mon, 27 Oct 2025 12:05:51 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 964B880107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 12:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CA762457FB;
 Mon, 27 Oct 2025 11:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73812C113D0;
 Mon, 27 Oct 2025 11:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761563147;
 bh=yzUNjsZdUqFgfSW82aZU+x/5gLYcnTAE+2qjLEfsGDc=;
 h=From:To:Cc:Subject:Date:From;
 b=eohC+DrzvuUNVfhcams+IztbhOEJ3Gw8qxpZfJbwaw7CDnFXM4cTjfr9yH0gOupJj
 kwkoO71/uHNq3qtFPdeth/Cew+sU0o1WC+JtACgMLyYwLdgcw8FOOe24rUXpqk5xc0
 nUJS9Q41gVCNL8L2LXjnWTxODv1xw0wq2+lNuBfD3J0IZ2AAfgAMxLtJN5S4THqTVW
 /BqS8RL6XVPbGEzueJcVeGok8tHDvKXfU5yROXjvqbE2PgaTqK64X/XOC6p6fVgTLv
 JfPauJTIagfDnbraYBYQ4CBoh5vZMB1fUByyVqx+MfQ2/nAQc0AenpiaMWBTGelDY1
 dt7hWHkeWbHtg==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH] common/spl: fix endless loop in spl_fit_append_fdt()
Date: Mon, 27 Oct 2025 12:05:21 +0100
Message-ID: <20251027110523.1105773-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Technically, commit 24bf44cf88e7 ("spl: fit: Do not fail immediately if
an overlay is not available") introduced that regression as the code
will never advance if spl_fit_get_image_name() will return an error. But
at that time, spl_fit_get_image_node() was used in spl_fit_append_fdt()
which calls fdt_subnode_offset() to get the image node. And I presume
the commit was about the latter failing gracefully and trying the next
one.

But with commit b13eaf3bb4e6 ("spl: fit: Add board level function to
decide application of DTO") that behavior changed and the loop in
spl_fit_append_fdt() no longer uses spl_fit_get_image_node() but
spl_fit_get_image_name() directly. Thus it doesn't make any sense to not
break the loop if that fails.

Also, the original use case of commit 24bf44cf88e7 ("spl: fit: Do not
fail immediately if an overlay is not available") is preserved because
spl_subnode_offset() is now called within the loop and errors are
handled gracefully (and advancing the index).

Fixes: b13eaf3bb4e6 ("spl: fit: Add board level function to decide application of DTO")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 common/spl/spl_fit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 746c3d2fa28..342262dd112 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -448,8 +448,8 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 				debug("%s: No additional FDT node\n", __func__);
 				ret = 0;
 				break;
-			} else if (ret < 0) {
-				continue;
+			} else {
+				break;
 			}
 
 			ret = board_spl_fit_append_fdt_skip(str);
-- 
2.47.3

