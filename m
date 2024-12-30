Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB5DE77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 14:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 838B0805EB;
	Mon, 30 Dec 2024 15:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KdLF5uEs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FAC805EB; Mon, 30 Dec 2024 04:30:53 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2529980570
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 04:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+liujh2818.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 94DB0A409B4;
 Mon, 30 Dec 2024 03:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCF28C4CED7;
 Mon, 30 Dec 2024 03:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735529449;
 bh=diwlpw/qVJ32TZ3EWzkeY+vVzvBBT97n0QOQYIlluvA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=KdLF5uEs0+EfuP60eJNujNS1I42j+DWKZKsHXi/1NEhipgNoR+7OsZhYd6rzggGda
 4liIlvJ5Zf+FHHPxJ0/ardjiaphHypd6Jxkt3zGocKVok/tkrT2iWwqzoBUge9mWcs
 /LGfuIYfGmAzeporOWurIPNJ1uHzB319X8R59j4n7BAt4r4aS1L55gsg8t2kU7UXw6
 SBVlLwfXGecpX1s8asTl5aOLfquoKkG64aNtMUQmPFLzX4rD8Ngo06s//zGEK4v+m/
 ODtSmgf46+D/ywMdzX5piHRW85MrVNu1MPKQbVDDurlfpFL1KHLiNpmcxbXV4OZ0Q6
 rJt5tZKjTsOOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C1621E7718F;
 Mon, 30 Dec 2024 03:30:49 +0000 (UTC)
From: Junhui Liu via B4 Relay <devnull+liujh2818.outlook.com@kernel.org>
Date: Mon, 30 Dec 2024 11:30:18 +0800
Subject: [PATCH v2 3/8] USB: dwc2: Fix HBstLen setting for external DMA
 mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241230-dwc2-dev-v2-3-12cd9b8a2358@outlook.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
In-Reply-To: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Junhui Liu <liujh2818@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735529447; l=1579;
 i=liujh2818@outlook.com; s=20241030; h=from:subject:message-id;
 bh=X2wPlAec1lTbhEc4kHMvFzI7dPaWHtgbyCFMMHoPHXM=;
 b=i59f4eY4FVgdY6MTwEtkEpQjYSIIdbLb8NUPjevDckfmhGN/NWErizUqKyw9uX0UOSeeIdkCu
 jlcu+bicvc+C7YOp7FBIMNz5K46UqWwRgiSBgh5UMPvnsGmXykeXF5q
X-Developer-Key: i=liujh2818@outlook.com; a=ed25519;
 pk=ApYwI6KD3EjynMw61RqGa6c5BGbStQnKSrbNN+aQqT4=
X-Endpoint-Received: by B4 Relay for liujh2818@outlook.com/20241030 with
 auth_id=259
X-Original-From: Junhui Liu <liujh2818@outlook.com>
X-Mailman-Approved-At: Mon, 30 Dec 2024 15:35:32 +0100
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
Reply-To: liujh2818@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Kongyang Liu <seashell11234455@gmail.com>

The loop used to calculate HBstLen for extern DMA mode does not produce
the correct result according to the datasheet [1]. Replacing that loop
with a direct calculation using LOG2 to correctly assign the burst length
in the GAHBCFG register for external DMA mode.

[1] https://rockchip.fr/RK312X%20TRM/chapter-26-usb-otg-2-0.pdf#page=24

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
Signed-off-by: Junhui Liu <liujh2818@outlook.com>

---
Additionally, the boards I have only use internal DMA mode, and it’s
unclear which chips employ external DMA. The testing was performed by
comparing against the datasheet, and the results are shown in [2].

[2] https://gist.github.com/Judehahh/34530da390b58728102778406e602cb1
---
 drivers/usb/host/dwc2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 609de18faa3abc5f4ecb0c23cf3590966bad7992..954650d856a4f2e95d74e1b5716c0ebe83fa9ba8 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -448,11 +448,8 @@ static void dwc_otg_core_init(struct udevice *dev)
 	case DWC2_HWCFG2_ARCHITECTURE_SLAVE_ONLY:
 		break;
 	case DWC2_HWCFG2_ARCHITECTURE_EXT_DMA:
-		while (brst_sz > 1) {
-			ahbcfg |= ahbcfg + (1 << DWC2_GAHBCFG_HBURSTLEN_OFFSET);
-			ahbcfg &= DWC2_GAHBCFG_HBURSTLEN_MASK;
-			brst_sz >>= 1;
-		}
+		ahbcfg |= (LOG2(brst_sz >> 1) << DWC2_GAHBCFG_HBURSTLEN_OFFSET) &
+			  DWC2_GAHBCFG_HBURSTLEN_MASK;
 
 #ifdef DWC2_DMA_ENABLE
 		ahbcfg |= DWC2_GAHBCFG_DMAENABLE;

-- 
2.39.2


