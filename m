Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A83BC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA4D487FC0;
	Tue, 20 Feb 2024 12:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="JqojCMJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2A987F5D; Tue, 20 Feb 2024 11:36:01 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B878387DDB
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rcNTX-00014V-Gr; Tue, 20 Feb 2024 05:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=d8cNVSXdHaSVP2epv560mhDnh2AC/3hj/Q9FlupkeEs=; b=JqojCMJSik9KQM+Kf+Jv
 4HpLvjRivXJXaZb9TpP88UkDExZg451YpBEECJ/4liOCpHJoD17XHWLzKnL+QaBjMBKs9r/IYbl3I
 flElenDm9Paeb5af+O7iqAxUNhGnR7Po+VS8fm65kaghGujbmOiSM5AM3nzvIPNg9xMfbJIh0BYBw
 53PTtVI94hKPvKRw2+ZWbohtrGMkYxKEvAk2FZA1b+TD3BgSOMedKXM6DOwSSqwgSJNbrhv09dBoD
 G7GkI9YQsmcT+7f4FiF1Mzqiuv8U5AzwSC2lW5Fh/yPkI92uxgI76v5nq6+KyHmcdjU+Df02eTNPy
 yhpEFQmBDEzllg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 2/5] arm: dts: imx93-var-som-symphony: Add USB support.
Date: Tue, 20 Feb 2024 11:35:03 +0100
Message-ID: <20240220103506.17218-3-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220103506.17218-1-othacehe@gnu.org>
References: <20240220103506.17218-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Feb 2024 12:03:24 +0100
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

Enable both usbotg1 and usbotg2 ports.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm/dts/imx93-var-som-symphony.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/dts/imx93-var-som-symphony.dts b/arch/arm/dts/imx93-var-som-symphony.dts
index a67bd005e54..1bc61942716 100644
--- a/arch/arm/dts/imx93-var-som-symphony.dts
+++ b/arch/arm/dts/imx93-var-som-symphony.dts
@@ -285,6 +285,24 @@
 	status = "okay";
 };
 
+&usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	disable-over-current;
+	status = "okay";
+};
+
 /* SD */
 &usdhc2 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-- 
2.41.0

