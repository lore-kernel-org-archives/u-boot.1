Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48D7E7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 03:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D8C800B2;
	Wed, 11 Dec 2024 04:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="icHxLJx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA94F801FD; Wed, 11 Dec 2024 04:26:16 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D99800AA
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 04:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1733887570; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HIPfjblMRASoMZml051VtLVst7RI4zf30wW4aOsKjM4iN1Xt32MVsVA4hiRnwSMxgyN0ZOMy4LRhSLpP5UlT67jDfeE9UYTcePmPNwbazVuZB7ZwY0KW405g1Cu1EFPbn9SKrnf3SK1mIPt7QNn0Kud4sGXZIwsvB15At5oO7Rs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1733887570;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rsDWxbPaNgRdq9a47rbk15f+IRep8Q7yHfOOT8OTLp4=; 
 b=PcDTr8pFGYDeGi5MhvnkcvrQBUAxZIXKKjgUhgTIRoiQDfXUpjQItHwEKvbdpBjzyb0F+JeWeryKYzvBr5t3tnkcD2EojQaTyJv6qraYg1X2NeIu8bXaO7pW/ye/M27rpCgXAQRt768/ragUIUR4EqcDQp1vnnuCTtwxCggrJOM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733887570; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=rsDWxbPaNgRdq9a47rbk15f+IRep8Q7yHfOOT8OTLp4=;
 b=icHxLJx/89uwInZYSF83atgztmPADhT7kYK1Ee7k/6DhWDmngFp3fQ5aXTIN41GI
 462m85hb8W9bDtV6EGCZBCLAQBzzEFj9+9/CEfiMS6Otv0qEJJedtpkKb77gkRjWfaq
 LDSaSgjXL9LDsAlP9TOw+WI8hO7uvFdr5bMNjk05IciZQN6YONY3YKtpKJdJto/9Wcx
 68mwJDxOuOXA3lnyH9ZN7XNsgZxO1x9k42STN/GSNxKskFjV28aI/ztvSUqfk1gKi8l
 ZThogV22Gp1IGMHPd9k1EEsD7b2ptpND18Ir5tg5Lt5VwPhITkMr3dRD94fZcYjbtr/
 XpoJPYZN3A==
Received: by mx.zohomail.com with SMTPS id 1733887568247294.73561054886784;
 Tue, 10 Dec 2024 19:26:08 -0800 (PST)
From: Icenowy Zheng <uwu@icenowy.me>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Tom Rini <trini@konsulko.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, u-boot@lists.denx.de,
 Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] boards/sunxi/MAINTAINERS: sort items
Date: Wed, 11 Dec 2024 11:25:58 +0800
Message-ID: <20241211032558.357258-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Some items are out of alphabetical order.

Put them to the corresponding position to fix the order.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 board/sunxi/MAINTAINERS | 44 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index 84799879e85..267d6d6d9f2 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -216,11 +216,6 @@ M:	Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
 S:	Maintained
 F:	configs/emlid_neutis_n5_devboard_defconfig
 
-LCTECH PI F1C200S
-M:	Andre Przywara <andre.przywara@arm.com>
-S:	Maintained
-F:	configs/lctech_pi_f1c200s_defconfig
-
 GEMEI-G9 TABLET
 M:	Priit Laes <plaes@plaes.org>
 S:	Maintained
@@ -276,6 +271,28 @@ M:	Jelle de Jong <jelledejong@powercraft.nl>
 S:	Maintained
 F:	configs/Lamobo_R1_defconfig
 
+LCTECH PI F1C200S
+M:	Andre Przywara <andre.przywara@arm.com>
+S:	Maintained
+F:	configs/lctech_pi_f1c200s_defconfig
+
+LIBRETECH ALL-H3-CC BOARDS
+M:	Chen-Yu Tsai <wens@csie.org>
+S:	Maintained
+F:	configs/libretech_all_h3_cc_h2_plus_defconfig
+F:	configs/libretech_all_h3_cc_h3_defconfig
+F:	configs/libretech_all_h3_cc_h5_defconfig
+
+LIBRETECH ALL-H3-IT BOARDS
+M:	Chen-Yu Tsai <wens@csie.org>
+S:	Maintained
+F:	configs/libretech_all_h3_it_h5_defconfig
+
+LIBRETECH ALL-H5-CC BOARDS
+M:	Chen-Yu Tsai <wens@csie.org>
+S:	Maintained
+F:	configs/libretech_all_h5_cc_h5_defconfig
+
 LICHEEPI-ZERO BOARD
 M:	Icenowy Zheng <icenowy@aosc.xyz>
 S:	Maintained
@@ -336,23 +353,6 @@ M:	Siarhei Siamashka <siarhei.siamashka@gmail.com>
 S:	Maintained
 F:	configs/MSI_Primo81_defconfig
 
-LIBRETECH ALL-H3-CC BOARDS
-M:	Chen-Yu Tsai <wens@csie.org>
-S:	Maintained
-F:	configs/libretech_all_h3_cc_h2_plus_defconfig
-F:	configs/libretech_all_h3_cc_h3_defconfig
-F:	configs/libretech_all_h3_cc_h5_defconfig
-
-LIBRETECH ALL-H3-IT BOARDS
-M:	Chen-Yu Tsai <wens@csie.org>
-S:	Maintained
-F:	configs/libretech_all_h3_it_h5_defconfig
-
-LIBRETECH ALL-H5-CC BOARDS
-M:	Chen-Yu Tsai <wens@csie.org>
-S:	Maintained
-F:	configs/libretech_all_h5_cc_h5_defconfig
-
 NANOPI DUO2 BOARD
 M:	Chuanhong Guo <gch981213@gmail.com>
 S:	Maintained
-- 
2.47.1

