Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7BCC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4FC87600;
	Tue, 31 Oct 2023 18:35:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=poczta.fm header.i=@poczta.fm header.b="J/IXCZ48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D01B87B81; Tue, 31 Oct 2023 17:13:44 +0100 (CET)
Received: from smtpo26.interia.pl (smtpo26.interia.pl [217.74.67.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0708487B58
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 17:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sst@poczta.fm
Received: from localhost (ipv4-80-68-225-159.net.internetunion.pl
 [80.68.225.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
 Tue, 31 Oct 2023 17:13:40 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 1/2] rockchip: rk3588: Add SPINAND as boot device
Date: Tue, 31 Oct 2023 17:13:26 +0100
Message-ID: <20231031161327.1104885-1-sst@poczta.fm>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
 t=1698768821; bh=+SRTR4ahFVSb4Ajhf6l0KgjfNFQhhrZ/VJCWfjneCQs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=J/IXCZ480H6h3V3NWABtQx1DOunz2hozCj0KcsFDzdLlFQDYDYikvI4ER+8fI/tkJ
 eVvUQSWA3QffeTHvP0WK8cIm8+f9UL4NP6qJC71jfBWsDBhf6kloM0wlHWQ8zvIp/T
 t5CMy0SQpVMX4L3s2jvB4TiDVZeP2AwicwzZs4lk=
X-Mailman-Approved-At: Tue, 31 Oct 2023 18:35:53 +0100
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

Mark the flash@0 as BROM_BOOTSOURCE_SPINAND.
Fixes use of same-as-spl in u-boot,spl-boot-order prop on Orange Pi 5
Plus.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 arch/arm/mach-rockchip/rk3588/rk3588.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index b1f535fad5..0c8f10a97c 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -42,6 +42,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
 	[BROM_BOOTSOURCE_SPINOR_RK3588] = "/spi@fe2b0000/flash@0",
+	[BROM_BOOTSOURCE_SPINAND] = "/spi@fe2b0000/flash@0",
 };
 
 static struct mm_region rk3588_mem_map[] = {
-- 
2.42.0

