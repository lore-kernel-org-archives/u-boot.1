Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75FEFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F7B83BC4;
	Mon, 27 Apr 2026 15:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="e0EP0de4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C856784178; Mon, 27 Apr 2026 15:58:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C407C83BC4
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A70E51684;
 Mon, 27 Apr 2026 06:58:22 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 463F93F763;
 Mon, 27 Apr 2026 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777298308; bh=QZ1r7xvI3w3wqabz7J+d/q+8yyT/afyu1ZnTDuVW4fc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e0EP0de4qnzJtcjl3ZB/Uq71HNdxxPEbtZpAkMY6nf6z31p4U1hzASzqfi/DXG5uU
 66NM21TzTUuOVibuCwlnPNTMvZ47SWOIccFmhOsPzuF3xqjaRogSVjveAAOeV2b9nW
 qGTN9oApIMzxxnnD/Bse8MdZ6u1doWpd2VuFeAs8=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Philippe Simons <simons.philippe@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>
Subject: [PATCH v3 1/2] sunxi: H616: dram: fix LPDDR3 TPR6 parsing
Date: Mon, 27 Apr 2026 15:58:18 +0200
Message-ID: <20260427135819.2577234-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427135819.2577234-1-andre.przywara@arm.com>
References: <20260427135819.2577234-1-andre.przywara@arm.com>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

Allwinner's DRAM initialisation code defines a parameter named TPR6,
presumably containing some "Vref" parameter, but containing values for
*all* DRAM types. The runtime code selects one byte based on the DRAM
type used.
This selection code was wrong for LPDDR3, the value is encoded in
bits [23:16], not [15:8]. Fix that in the code, which also aligns it
with the very similar code for the A133 and A523.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reported-by: Philippe Simons <simons.philippe@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 3345c9b8e82..42a0550e015 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -975,7 +975,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 		val = para->tpr6 & 0xff;
 		break;
 	case SUNXI_DRAM_TYPE_LPDDR3:
-		val = para->tpr6 >> 8 & 0xff;
+		val = para->tpr6 >> 16 & 0xff;
 		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		val = para->tpr6 >> 24 & 0xff;
-- 
2.43.0

