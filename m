Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DC9C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 22:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24EC98498B;
	Wed,  8 Jul 2026 00:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CkGzIa7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97BD284994; Wed,  8 Jul 2026 00:03:11 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 701A584942
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 00:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6a190528769so1773840eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 15:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783461788; x=1784066588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KQBPk04d/PdhRbNJAfnx3JY3c3OSk+YfA3gkKgMgiuU=;
 b=CkGzIa7gWitLxfH+R/z+VcI21XeE3Xr2cpXyGrV72nJIDorOAuj+qXcwKwiwIWM3qH
 1xHEloHFIdwPTEd3ztYNWfu53CoB2BNa4WlVTIWdn9tBwavkMeUPlDeqbIlNk7VK4bQY
 yvlp/FUQOJkhLXXuJd6DfPF1vLa7wcJ8aSKDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783461788; x=1784066588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQBPk04d/PdhRbNJAfnx3JY3c3OSk+YfA3gkKgMgiuU=;
 b=PGIvfTnLA5sRs0Kxn6dYvIue6vcf6wDx8WQOCsqyMj4XxShGyDjhUpzm2SX5HcjSK+
 D76ubyWhYNAzPpvq000YI0v7Ij+6Bw9pnlrdKK/drITV8o65Ph/HD4ENSp2d/aczk4bX
 S476c7kAupZh6tYuYhHa6o8SjIP16PDnWCPK3fEufFTomZaGeHvm0ojKqlKChXOA4fqC
 ni1Vkvf8aPuuLEWgGM891t/pnMI/jWVqUwHnPCy2domLq8tiFyq5CSITSy57WXnR8awW
 zipKWH4ZZ1uKUiPDojS/CjjY+Rkp16ItcAdrOhUd79faREpLn9xjcSFkIypO2Fy3y1U2
 oIKg==
X-Gm-Message-State: AOJu0YxUq8ZqztnPxYzDPYbDuwHzDn6PFcVLZ/vcDBzPzM3MfJGsTWst
 YtGlP2axlw3nRbjB5Rq0Tf9Xxeqf55S1qi69yYaZyWKwIR5nypT8aaghreIi8SFPHDN2LW6WUfD
 YZSkuas8=
X-Gm-Gg: AfdE7cnIJPow6lT+lF4fJXzK+h8ZeLy9WmmfPtTn3WftLdctwpuRHOWA23VYYpH1+1t
 n4kUMb35rs2UhsPXjWQLAflwdvTPiJdYZQHVV1W8JnAfMrZReCiCh8thbvppxzkjXfvDokEBXdD
 xOLHMy9j7NRW9+KqSTd/lr4F9xQzusf0jhhTu0h7S3DH8Ge0yPEPl2M0Qn7uEzi8Q15sMN+6iHt
 eVxNC9JG61LzEVJeKTLvNjKplOKs+i+isNEQXdjzixcEogj4jafoyzX8MpovwWQuZHtVUyTj5OB
 ZlrH1UA72WTjw3aHH0HP3XsMS+Ns2CQGmrTbh23TmSzkfAgPWfKRuFT93NyjvVoNBHVyZuMGnsc
 bAqhE971187dlBTZ1K//RNHRwDpRICDGQAIbeA3edzQTSpixRTnZey+q5R5sr7DkWaLNB6fYAiq
 JF1gksfNT3uHLOzrUug0nbrclm6EuRjzbg1uyOyoDGTB8zZLfx8ft7TQ7OidjglobT/Cm/w0Wax
 A5uMHcCNCqv6jjSJbwQfhu2B8O21LDBF53KmU4o9PAcINt1jG71zqEWsJs16w==
X-Received: by 2002:a05:6820:4cc5:b0:6a3:c5:30ca with SMTP id
 006d021491bc7-6a355573dfbmr4669375eaf.31.1783461783285; 
 Tue, 07 Jul 2026 15:03:03 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb67156csm15323139fac.18.2026.07.07.15.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:03:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: [PATCH] arm: imx943: Update dts files to build with v7.1-dts tag
Date: Tue,  7 Jul 2026 16:03:01 -0600
Message-ID: <20260707220301.252935-1-trini@konsulko.com>
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

When moving to the v7,1-dts tag, we see a few problems trying to build
this platform. In turn, when looking at the upstream changes we can see
that USB3 support has been included now, but isn't exactly the same as
in our tree either. Modify things such that we build again.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Please note that these files are not covered directly by a MAINTAINERS
entry, so an update to fix that would be appreciated. I'm also not sure
if we retain exactly the same functionality after this patch, so a
replacement patch to update correctly would also be good.

Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 13 -------------
 arch/arm/dts/imx943-u-boot.dtsi     | 29 -----------------------------
 2 files changed, 42 deletions(-)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 3b3619d22327..c27f7b066498 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -126,19 +126,6 @@
 	status = "okay";
 };
 
-&usb3_dwc3 {
-	bootph-pre-ram;
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-	usb-role-switch;
-	role-switch-default-mode = "peripheral";
-	snps,dis-u1-entry-quirk;
-	snps,dis-u2-entry-quirk;
-	status = "okay";
-};
-
 &usb3_phy {
 	bootph-pre-ram;
 	orientation-switch;
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 74481aeefb5d..8bd63d2e213d 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -249,35 +249,6 @@
 &{/soc} {
 	bootph-all;
 
-	usb3: usb@4c010010 {
-		compatible = "fsl,imx95-dwc3", "fsl,imx8mp-dwc3";
-		reg = <0x0 0x4c010010 0x0 0x04>,
-		      <0x0 0x4c1f0000 0x0 0x20>;
-		ranges;
-		interrupts = <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		clocks = <&scmi_clk IMX94_CLK_HSIO>,
-			 <&scmi_clk IMX94_CLK_32K>;
-		clock-names = "hsio", "suspend";
-		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
-		status = "disabled";
-
-		usb3_dwc3: usb@4c100000 {
-			compatible = "snps,dwc3";
-			reg = <0x0 0x4c100000 0x0 0x10000>;
-			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&scmi_clk IMX94_CLK_HSIO>,
-				 <&scmi_clk IMX94_CLK_24M>,
-				 <&scmi_clk IMX94_CLK_32K>;
-			clock-names = "bus_early", "ref", "suspend";
-			phys = <&usb3_phy>, <&usb3_phy>;
-			phy-names = "usb2-phy", "usb3-phy";
-			snps,gfladj-refclk-lpm-sel-quirk;
-			snps,parkmode-disable-ss-quirk;
-		};
-	};
-
 	usb3_phy: phy@4c1f0040 {
 		compatible = "fsl,imx95-usb-phy", "fsl,imx8mp-usb-phy";
 		reg = <0x0 0x4c1f0040 0x0 0x40>,
-- 
2.43.0

