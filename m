Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5277FCD5BAB
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 20:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72A284825;
	Thu, 21 May 2026 22:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WXbZc72T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UTxHPub8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFBFD846FA; Thu, 21 May 2026 22:17:34 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A7784825
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 22:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gM07t2TBKz9v8d;
 Thu, 21 May 2026 22:17:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779394650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ju7txLQMPC55QO+Ww0LC/zg3VjoodRh4mXIA1zk7UDc=;
 b=WXbZc72TpokzHj9BHb7yB3uwfKNcsDhxAlVZFivsyoRKoQZqrvCpLxymdfq3hAi6pKb+sv
 LkLuHMb29AHU9+6kwDB2oWBXSdGxvJJj48nklFCHMej9dVFd8PCSx0yzxwivtXEVwrTlVQ
 ZFZDQSoEqr3ACZuK+BJSwP8k7U9d4wcUMDkVaxkHQIlVIPDdazW1V0GIEOVOlMPptxBmwB
 5xEgVHbNgumnlGYNMNazfYRMpj974RtyduAlZCE8opzj12UD2eOTvJmLYJI1WC+cF6fu+p
 XgLRln92Eda1xN/Xdxg0ydG303lwQJufxi7O+929vWZv7Taz3kG7w28qk4WheQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=UTxHPub8;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779394648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ju7txLQMPC55QO+Ww0LC/zg3VjoodRh4mXIA1zk7UDc=;
 b=UTxHPub8EG3K4Wck+uBvC7sthVuUIAlIM8tnGc+RdbWtFm56MRJtqS/+pe7+bAGyS9Z9er
 hIOaGeP1WiSLziRamrnVzFug161ojRnrPnN1Mn9Vx5ruq56FX1R1JG/ex8QTOdDMPgXUKZ
 /zHyKqKKu3DtaVpWzOq9K/4/mVq9D2SPoKGw4hfhrsVDW9dEsokmBvd0eVoK4V99GqCh2y
 Mm4fP2V6K4xacBksV8uD3deDvfHVTTrQZkFk2GBEIb182iAmq67YcrZZ8B3HjlF98qdlF2
 gOjtenCVgjCcWH8YSySb2q7T6j8E8to6dcFo5uMyzAp3blgoZrAi5SMFT09Ghg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Replace Altera/SoCFPGA/Agilex with N:
Date: Thu, 21 May 2026 22:17:18 +0200
Message-ID: <20260521201724.43978-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qhpdqtb4aziraot7y7o3rzg9ws7mcjh4
X-MBO-RS-ID: 04a2659a231f91a2ba0
X-Rspamd-Queue-Id: 4gM07t2TBKz9v8d
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

Use N: to match on all altera/socfpga/agilex files, drop
the large list of entries which represent the same set of
relevant files and miss a few in the process.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 MAINTAINERS | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e83d52dc528..5eba287a980 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -151,13 +151,9 @@ M:	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
 M:	Tien Fong Chee <tien.fong.chee@altera.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
-F:	arch/arm/dts/socfpga_*
-F:	arch/arm/mach-socfpga/
-F:	board/intel/agilex-socdk/
-F:	configs/socfpga_*
-F:	drivers/ddr/altera/
-F:	drivers/power/domain/altr-pmgr-agilex5.c
-F:	drivers/sysreset/sysreset_socfpga*
+N:	altera
+N:	agilex
+N:	socfpga
 
 ARM AMLOGIC SOC SUPPORT
 M:	Neil Armstrong <neil.armstrong@linaro.org>
-- 
2.53.0

