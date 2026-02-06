Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F110FEE6B5E
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 20:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5721783B86;
	Fri,  6 Feb 2026 21:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="hNojySSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5603283B9D; Fri,  6 Feb 2026 21:55:48 +0100 (CET)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF21583B0B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 21:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=MjDH3TQhb/kPaFaGf810C43/7n2hjXkgVbIJxCi9ZbA=; b=hNojySSIhJyWMLaaI9F/mvZEEA
 nG6OKjNTtvPFMcX9UsdWeGZNCnIgNqrLTFXisp20hlAnYuju6Hod4nnKuD5TMr/C5mCIncN+GZ65z
 vi5sPkuXqmdJkVA9yfC0ytTWiXKfsq6nPt5fDHQHPSaM5UlC0lRuJf8qxeoXTcfhI/Qw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35962
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1voSre-0001FX-Ny; Fri, 06 Feb 2026 15:55:42 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: hvilleneuve@dimonoff.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	hugo@hugovil.com
Date: Fri,  6 Feb 2026 15:55:25 -0500
Message-ID: <20260206205537.2906980-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206205537.2906980-1-hugo@hugovil.com>
References: <20260206205537.2906980-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH 2/6] arm: dts: imx8mn-var-som: add som-eeprom alias to SOM
 u-boot dtsi
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The som-eeprom alias is specific to U-Boot, and not present in upstream
linux imx8mn-var-som device tree.

Add it to the SOM U-Boot specific device tree file in preparation
for migration to OF_UPSTREAM.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 arch/arm/dts/imx8mn-var-som-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/imx8mn-var-som-u-boot.dtsi b/arch/arm/dts/imx8mn-var-som-u-boot.dtsi
index c27ad08377e..8f4e4efd8d9 100644
--- a/arch/arm/dts/imx8mn-var-som-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-var-som-u-boot.dtsi
@@ -5,6 +5,12 @@
 
 #include "imx8mn-u-boot.dtsi"
 
+/ {
+	aliases {
+		eeprom-som = &eeprom_som;
+	};
+};
+
 &{/soc@0/bus@30800000/i2c@30a20000/pmic@4b} {
 	bootph-pre-ram;
 };
-- 
2.47.3

