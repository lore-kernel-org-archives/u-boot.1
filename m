Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA20D31769
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 17:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1309891E4;
	Tue,  5 Nov 2024 18:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089A488C44; Tue,  5 Nov 2024 18:22:16 +0100 (CET)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch
 [83.166.143.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D1A891D4
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XjZs05yPkzXgJ;
 Tue,  5 Nov 2024 18:22:12 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4XjZs01K16zxB5; Tue,  5 Nov 2024 18:22:12 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 05 Nov 2024 18:21:59 +0100
Subject: [PATCH next RFC 5/5] ram: rk3399: fail DRAM init when pctl channel
 init fails instead of hanging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-rk3399-dram-init-v1-5-1e29acdf0966@cherry.de>
References: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
In-Reply-To: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Instead of hanging via an infinite while loop, propagate the fail to the
caller and let it handle the fail. For RK3399, this means that panic()
will be called, (by default) resetting the CPU and giving another chance
at doing a DRAM init.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/ram/rockchip/sdram_rk3399.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index d953dda13cd3daa689fa362dc511c372db454064..591e1469afb25ba606d8f7e44f63e50905b4ab31 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -817,8 +817,7 @@ static int pctl_start(struct dram_info *dram,
 			if (count > 1000) {
 				printf("%s: Failed to init pctl channel 0\n",
 				       __func__);
-				while (1)
-					;
+				return -1;
 			}
 			udelay(1);
 			count++;
@@ -853,8 +852,7 @@ static int pctl_start(struct dram_info *dram,
 			if (count > 1000) {
 				printf("%s: Failed to init pctl channel 1\n",
 				       __func__);
-				while (1)
-					;
+				return -2;
 			}
 			udelay(1);
 			count++;

-- 
2.47.0

