Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B7ECCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 13:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65DA1838D7;
	Fri, 31 Oct 2025 14:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dOM2RvC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1495838DD; Fri, 31 Oct 2025 14:14:34 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2D6836F0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 14:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0124641A2A;
 Fri, 31 Oct 2025 13:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D90CC4CEE7;
 Fri, 31 Oct 2025 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761916470;
 bh=hFMt3G0efjr6GbGoXTBVKyD+ji0oLDOMw/tazhyldMs=;
 h=From:To:Cc:Subject:Date:From;
 b=dOM2RvC6yo+yEQVsQNYZ1itj45UiidZvhttfHEjfku34jRotrxut7naHNSjGTl2ra
 iwytzFHmKdea8KLAi5MzS7rNdyW2Ued7C7dy5+ZhatjRihUcQfF5Bf2kvWGpDjaGRz
 wbeeAWh4dRo4QwctBhz5DBqNA78KDbisjb+5Ghoesz8BNnhjlaKqqbwbiDO9LKlpnv
 0Tl28Dl/1WuBRZdXUKib4E+SDm2L021Bh+Nw87QQRseGicAimIvEidxPa8MOFc1fs3
 Jg7tShMlgnMJM2HyamCmikyHoaQHivNp/QKObADZMNSMOIblSFJo29FFyDcHAzxLwe
 v7DSXfRUiwVdQ==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2] common/spl: fix endless loop in spl_fit_append_fdt()
Date: Fri, 31 Oct 2025 14:13:52 +0100
Message-ID: <20251031131425.1473448-1-mwalle@kernel.org>
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
v2:
 - only break on error, that is ret != 0. While v1 did break the
   endless loop, it also broke the subsequent code. Sorry.
   Tom, I've not picked your Reviewed-by because of the change. Feel
   free to give it again.

 common/spl/spl_fit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 746c3d2fa28..d8cb2aa2fa3 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -448,8 +448,8 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 				debug("%s: No additional FDT node\n", __func__);
 				ret = 0;
 				break;
-			} else if (ret < 0) {
-				continue;
+			} else if (ret) {
+				break;
 			}
 
 			ret = board_spl_fit_append_fdt_skip(str);
-- 
2.47.3

