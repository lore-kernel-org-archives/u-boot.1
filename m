Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A542DC54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 15:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9CB88134;
	Thu, 21 Mar 2024 16:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="eQ6hI1n2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C776C87BE0; Thu, 21 Mar 2024 15:46:05 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1074880BE
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 15:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rnJg6-0006ou-3o; Thu, 21 Mar 2024 10:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=tqhUSWZWFUPjsl2Euy0GSbL6gIY+3LbATeGNgmv9B6s=; b=eQ6hI1n2BI3i5tovn27W
 wMc8SrXNfH2gQB6043sSCObAmQ+82UAUF/qucf2S6n2F18nXfXpI3WE2S/OkmGEQyD3Bkg09EW46k
 HWsVqXMz+f7YRzrllIA5BkTP+qFrFmO1PeqdeIKzxPFKSMXb01GwSvED2bLAzfWQaNQhJYJpWFBBQ
 aIl5/fyFGz2BMb9e4lSCcvdl+gwcTx2Luw2FbW1XlCeV9xFmOpKd+7C57QqdCIf3uAlh/QZfq/nhM
 pgnDfhceFDf/CElcygltkD8TNaSX7z7gkuBCLgonsJEucZdpFvJfT+Yg24UQf0gGwcIwCBsKuLkOa
 cjhC9R2wruPRiA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v3 1/3] arm: dts: imx93-phyboard-segin: Add USB support
Date: Thu, 21 Mar 2024 15:45:39 +0100
Message-ID: <20240321144541.15314-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321144541.15314-1-othacehe@gnu.org>
References: <20240321144541.15314-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Mar 2024 16:01:03 +0100
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

Enable both usbotg1 and usbotg2 ports. Disable over-current as OC pins are
not connected to the SoC.

This is temporary, until USB support is added to imx93-phyboard-segin.dts
in Linux.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
index 8bf28c2de87..6897c91f4d9 100644
--- a/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
+++ b/arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
@@ -121,6 +121,21 @@
 	bootph-some-ram;
 };
 
+/*
+ * Remove once USB support is added to imx93-phyboard-segin.dts upstream.
+ */
+&usbotg1 {
+	disable-over-current;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbotg2 {
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 	bootph-some-ram;
-- 
2.41.0

