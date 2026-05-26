Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EC9CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 17:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8DA684898;
	Tue, 26 May 2026 19:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="JcYLslcm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6F8848BF; Tue, 26 May 2026 19:18:24 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6809A847B0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 19:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4C1BAB00579;
 Tue, 26 May 2026 19:18:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1779815902;
 bh=FpPwdwcBOafMrkKktZaYdok9AtyOnPnxy5ZsCeUNNF4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JcYLslcmP2Tvr5ZI0TmANX88WvM6LYzeNFAPoU94RG9YEykcglY0abf0cP2pixcYx
 wuUuFuLshJtNc3mQtI+YU0DA3HEJMtHhaiGEjo5HQtheraE0I+GJ7bwKmTJ3gcoh9I
 unvX/SXKQInrGhn1Y10wvAjutqqzqbIaP87KcYqgLdzfFQa1QCtcP+c/OA7a6jWRBl
 IHexJU5lXLiIwXGRoNkP7gB0Tq3tqcYM798YW5tuyX0Q4MowWWxX1ZW7+LrEOA0VsL
 6mLRmaTfCE5hri7Ij1OWSsgEkURrafiZxk5nt9vt+/C/WbyX3RfIk5+1Odp5Vd7DEC
 6BPkaWOVFfdzw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Wasim Khan <wasim.khan@nxp.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v2] arm: dts: fsl-lx2162a-qds: drop &dspi{0,1,2} block
Date: Tue, 26 May 2026 19:17:35 +0200
Message-ID: <20260526171801.393543-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <"<20260510203738.515452-1-vjardin@free.fr>">
References: <"<20260510203738.515452-1-vjardin@free.fr>">
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

arch/arm/dts/fsl-lx2162a-qds.dts carries a verbatim copy of the three
&dspi{0,1,2} overrides that are already provided by the parent include
arch/arm/dts/fsl-lx2160a-qds.dtsi

No functional change, the parent's &dspi{0,1,2} block keeps its
bus-num, status and flash children intact.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

Link: https://patchwork.ozlabs.org/project/uboot/patch/20260510203738.515452-1-vjardin@free.fr/  # v1
---

Changes in v2:
- Rebased onto Tom Rini's next branch per DM with Peng Fan's request (v1 had
  conflicts with next).
- Drop rename hunks: already landed on next as commit 8c60833124c
  ("arm: dts: layerscape: Fix DT build warning in SPI nodes", Ye Li, May 2026).
- Retain only the duplicate &dspi{0,1,2} removal in
  fsl-lx2162a-qds.dts (still outstanding on next).
- Adjust subject and body to match the narrower scope.

 arch/arm/dts/fsl-lx2162a-qds.dts | 99 --------------------------------
 1 file changed, 99 deletions(-)

diff --git a/arch/arm/dts/fsl-lx2162a-qds.dts b/arch/arm/dts/fsl-lx2162a-qds.dts
index 4eaf982529d..35d80639958 100644
--- a/arch/arm/dts/fsl-lx2162a-qds.dts
+++ b/arch/arm/dts/fsl-lx2162a-qds.dts
@@ -37,105 +37,6 @@
 	status = "disabled";
 };
 
-&dspi0 {
-	bus-num = <0>;
-	status = "okay";
-
-	dflash0: n25q128a@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <0>;
-	};
-	dflash1: sst25wf040b@1 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <1>;
-	};
-	dflash2: en25s64@2 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <2>;
-	};
-};
-
-&dspi1 {
-	bus-num = <0>;
-	status = "okay";
-
-	dflash3: n25q128a@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <0>;
-	};
-	dflash4: sst25wf040b@1 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <1>;
-	};
-	dflash5: en25s64@2 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <2>;
-	};
-};
-
-&dspi2 {
-	bus-num = <0>;
-	status = "okay";
-
-	dflash6: n25q128a@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <0>;
-	};
-	dflash7: sst25wf040b@1 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <1>;
-	};
-	dflash8: en25s64@2 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <3000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <2>;
-	};
-};
-
 &esdhc1 {
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
-- 
2.43.0

base-commit: 8d5f30b52f7c800c2177188fc4d331fb7af2c46a
branch: for-upstream/dts-layerscape-warnings-v2
