Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88594C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 09:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8975878A1;
	Fri, 23 Feb 2024 10:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="GdJI8FIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA8087D5E; Fri, 23 Feb 2024 10:12:59 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57CCD8791E
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 10:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id BCFBD21198;
 Fri, 23 Feb 2024 10:11:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708679518;
 bh=HWPXJ+1ulsrUIIsy4IJPomFQHVaD71bhql7sGN2L+X8=; h=From:To:Subject;
 b=GdJI8FITCY5R5PcMXIPuwx12sulEoaZxIRw335znlSVIpDsgI6AID+m4tJB2vxO1u
 BSIC7VgkbgVxbtwV8UTg2VIHoXfnUfwUCy0ur7mlxC7TDIJNAhBkbuOXX7ArOnKz/s
 TnkC3XULNmVUMTt1U2CEuAsXZoTqPa2icYyVm7Y4YM3qiqKERcjHY04JCe/qpE7Zt/
 9yTrdGMnzRAZZlWy3Da+mhNRgLraACTt0iPTSiHh8Q6mMo6wmk60MW+cGTAgkDnEzh
 9tZkRvrJUtpRwvE4b49gfRURUqC128sKFaSZQWZnT8vYS480jHU5T88oIdFV/7sNJD
 xja8sD+/UaoUQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 1/7] toradex: Fix recursive call to checkboard
Date: Fri, 23 Feb 2024 10:11:37 +0100
Message-Id: <20240223091143.9561-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223091143.9561-1-francesco@dolcini.it>
References: <20240223091143.9561-1-francesco@dolcini.it>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Since checkboard() is used instead of show_board_info(), in case toradex
config block is missing or malformed, checkboard is recursively called.
It prints a long list of "MISSING TORADEX CONFIG BLOCK" till the stack
is full.

Fixes: edb0ecd18708 ("toradex: Use checkboard() instead of show_board_info()")
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com> # Verdin iMX8M Plus
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/common/tdx-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index ed8f0a6a4756..ddc4a175da68 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -103,7 +103,6 @@ int tdx_checkboard(void)
 	if (read_tdx_cfg_block()) {
 		printf("MISSING TORADEX CONFIG BLOCK\n");
 		get_mac_from_serial(tdx_serial, &tdx_eth_addr);
-		checkboard();
 	} else {
 		snprintf(tdx_serial_str, sizeof(tdx_serial_str),
 			 "%08u", tdx_serial);
-- 
2.39.2

