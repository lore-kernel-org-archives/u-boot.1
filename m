Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B34EC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 11:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545858800B;
	Thu, 21 Mar 2024 12:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="Ar2cAE4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C7C8808A; Thu, 21 Mar 2024 07:58:00 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D41C58809C
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rnCN5-0006FP-Hd; Thu, 21 Mar 2024 02:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=wrpqsZD4fvHuWmp+1TCLpnnMJz6Jfw/Z7SzxOhzD42Y=; b=Ar2cAE4LL+b7++ClH3XM
 HwxHEi8mbkk62EsG8pSidraW1Gn3j2F79KB7jA+BgAAB6JD1yHs8orH/fEkwQOhkq1sSVgqjc0t9C
 fIGYcT2XvvfDozRM6lzQSS0vFsYL0m/H0H8FC9pwYvSXK0jsNLgNkrh3+X8ZCDwt/8nNS4rLlwVgJ
 yC5CeSaDv+D9yFroo8OFwNRVlEkFWhZZRIjdr29NJ/hnedUv89xNMSprerkx2vRFyTV4q+H30MjX4
 IQiFP1s7iuXtDWrWW0JrIo79gbQbiglrOvXWH45vFEUtH3uaS/pubbmp0fCk1K15LKVw6pxhKn6Zt
 QheTzqG9Y9aDDQ==;
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
Subject: [PATCH v2 1/3] arm: dts: imx93-phyboard-segin: Add USB support
Date: Thu, 21 Mar 2024 07:57:40 +0100
Message-ID: <20240321065742.32441-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321065742.32441-1-othacehe@gnu.org>
References: <20240321065742.32441-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Mar 2024 12:32:10 +0100
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

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm/dts/imx93-phyboard-segin.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/dts/imx93-phyboard-segin.dts b/arch/arm/dts/imx93-phyboard-segin.dts
index 85fb188b057..acf307a3192 100644
--- a/arch/arm/dts/imx93-phyboard-segin.dts
+++ b/arch/arm/dts/imx93-phyboard-segin.dts
@@ -40,6 +40,19 @@
 	status = "okay";
 };
 
+/* USB  */
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
 /* eMMC */
 &usdhc1 {
 	no-1-8-v;
-- 
2.41.0

