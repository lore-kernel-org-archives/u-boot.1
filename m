Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECF1C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 19:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89289843BF;
	Wed,  6 Aug 2025 21:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="R0nmnfjC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rIG4hJtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C59F9843C0; Wed,  6 Aug 2025 21:24:25 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 666A5843BC
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 21:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4by0bW11Ncz9tn5;
 Wed,  6 Aug 2025 21:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754508263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jvI1quIjjkEyyCl1MpQ29XPgsW7h+Kq98Nqk1sYpJss=;
 b=R0nmnfjCWFJzm76aW/NRKBpK+MR9PuyTbfBjmJ1k+QxVebC3sDmGMoi2Cc6r4DmnHc3ujf
 sckCXOZKVxUFCvJRSwE1kDvf872CErubUt2hZKRjFYDbm+EbCPZ7dXBfs67HtKm8NFPAcs
 bFrCq3aqxPkQL47bHTAMDvu6BnPhIqBoxLe+9DKOXM07m6jRcFT0BPLIsLLQd89Sfu2NSN
 f5sod1Zx5iGuFMvgMd0RPufTgpdgm024/vsUfGZARSYNKBre/dIvznNFlqBRayX6OGmcbv
 OvGHszywWpAUWe+hRYYHWtAThZogP/tUvrGkKhOA7fPZWdaQohnTqfDs5pFJ7Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754508261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jvI1quIjjkEyyCl1MpQ29XPgsW7h+Kq98Nqk1sYpJss=;
 b=rIG4hJtE/jBPCCRofBB0eGhIXJD0x9dhVaoh512gRoZdlCis3Jp5n0ovEeHGeP0Ge0nYUP
 XIdXsIYfqQyJ2Y5WkhNUaPlS0j225axMR6xLx8qWThrsEb9gZjs/0w7rO4Wup2FXwun/4I
 tGDlE6fdByYKTsuCyHfFhT/X7MDb66QkZaGbYpAQB5xR2N0rEZAqpfBbaBJ/DagLkQ8OHd
 RMUrRuGX7VukzgGYA/VbZntPAvW5UC62b8cMePiiEHsk6bv1+4J7g8ZmNV6y5qecjP+cOn
 /wYtE37foPpkpQMVcDmlRd8HDDHnStivG789FkAKcWr5ptO3yfFpHQUFthPglw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] pci: pcie-rcar-gen4: Fix PHY initialization
Date: Wed,  6 Aug 2025 21:23:54 +0200
Message-ID: <20250806192404.133063-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1jor5963wztibs8xcoigyq3kec3h46uq
X-MBO-RS-ID: 917368327d628efc86c
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

R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025
page 4581 Figure 104.3b Initial Setting of PCIEC(example) middle
of the figure indicates that fourth write into register 0x148 [2:0]
is 0x3 or GENMASK(1, 0). The current code writes GENMASK(11, 0)
which is a typo. Fix the typo.

Fixes: be3dd0dc2fd9 ("pci: pcie-rcar-gen4: Add Renesas R-Car Gen4 DW PCIe controller driver")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/pci/pci-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
index 87cd69f989d..41f0d958447 100644
--- a/drivers/pci/pci-rcar-gen4.c
+++ b/drivers/pci/pci-rcar-gen4.c
@@ -235,7 +235,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	clrsetbits_le32(rcar->phy_base + 0x148, GENMASK(23, 22), BIT(22));
 	clrsetbits_le32(rcar->phy_base + 0x148, GENMASK(18, 16), GENMASK(17, 16));
 	clrsetbits_le32(rcar->phy_base + 0x148, GENMASK(7, 6), BIT(6));
-	clrsetbits_le32(rcar->phy_base + 0x148, GENMASK(2, 0), GENMASK(11, 0));
+	clrsetbits_le32(rcar->phy_base + 0x148, GENMASK(2, 0), GENMASK(1, 0));
 	clrsetbits_le32(rcar->phy_base + 0x1d4, GENMASK(16, 15), GENMASK(16, 15));
 	clrsetbits_le32(rcar->phy_base + 0x514, BIT(26), BIT(26));
 	clrsetbits_le32(rcar->phy_base + 0x0f8, BIT(16), 0);
-- 
2.47.2

