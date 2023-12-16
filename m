Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E96C4167B
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 05:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4FC287AF3;
	Sat, 16 Dec 2023 06:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702705002;
	bh=iG/PH68N6Y1jtMRYs+tk+qoN3BK0/FlkCFzjQAN5xmQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uRmk/wMGJTi60cUg7jKjt9u0x58wybgGsnKIjj4g84BfR37U128eScLW1a0vU2hKo
	 OHmHFoB0nz7tRa+dLMNuirUbTbEjolZY1/+H97JjUu+0SOPLWuSNPv9JWpmKPprvaw
	 tCGh2CFVt1+nWG7fVszO6nyCurMyDuNRb6cJx9EbQd2FmQ+O2Nble8EmxiyuP8v+gf
	 fOVlFggLT7AoiF5TzVH+RC36zXjhm9PtsijTo8uRZLHlLOEEeciFtto62zkqMP/owS
	 F9QstZRi0s8n7FM8Ym/1GmZr3+R66Wa6wHKrCBzz3cNIQwEua0RDjdLoS2tiszmu6t
	 p/GUtl8rBqN/g==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 36DE887A4E;
 Sat, 16 Dec 2023 06:36:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702705001;
 bh=iG/PH68N6Y1jtMRYs+tk+qoN3BK0/FlkCFzjQAN5xmQ=;
 h=From:To:Cc:Subject:Date:From;
 b=PHCKLf0scnxh1QAy2+ByQCc+oPVS93MkdAUkUyZ2zSxVW2IQJsRJ0x1FHY+DrKEvx
 YYm5/It06zLZ2enMyc0kh3MzmhYTqFkBm6dDMUHlkt51RujvKu1ic//tCvo0u4irm/
 AXO1+pKVPXMt3ZZVAlcCUYQBuDi2j+VQX64/z0+CF+78+R7lAuRxTFPizCJfJvvwID
 Wtvk4+M9xZ7/08Qxv8wHnIeh75ylRERl2gJ5igKwQSxM5LdkLQnAgtVeLwzO6CZ7QI
 Ndmp/NTn8qdPo2vdGPrzl16m+2eArFnN8Pt8DUyGPbxJzhSZFu8La05IXKk9Ca6reS
 GB/kNVY/ruQvQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: dts: imx7d-pico: Fix alias node indent
Date: Sat, 16 Dec 2023 06:36:01 +0100
Message-ID: <20231216053624.326731-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Switch from indent with spaces to indent with tabs. No functional change.

Fixes: f8548ce0e093 ("imx7d-pico: Fix the name of the u-boot.dtsi file")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/imx7d-pico-pi-u-boot.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi b/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
index c6856823c64..220748723b0 100644
--- a/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
+++ b/arch/arm/dts/imx7d-pico-pi-u-boot.dtsi
@@ -1,11 +1,11 @@
 #include "imx7s-u-boot.dtsi"
 
 /{
-    aliases {
-        mmc0 = &usdhc3;
-        usb0 = &usbotg1;
-        display0 = &lcdif;
-    };
+	aliases {
+		mmc0 = &usdhc3;
+		usb0 = &usbotg1;
+		display0 = &lcdif;
+	};
 
 	wdt-reboot {
 		compatible = "wdt-reboot";
-- 
2.43.0

