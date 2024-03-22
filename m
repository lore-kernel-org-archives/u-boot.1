Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAFDC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EEF488210;
	Fri, 22 Mar 2024 12:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711107820;
	bh=pTguwxuGntk/JSW+XreRnzCcwPZjDumRfSo2+3nnEYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MKdJk1xXCKqQxHTZvzezLtfZdNBARL9OhwWGSswaAlzHLC6XT0sirTN2VgNYPC1KG
	 /rMVSTgIknWIPAQEQwQmM22eiLm58fMzI69BbWnOq0+TvX2/rPmmFQPB6YDelErdJN
	 qGVr8JnyIs3pBI5xkpiytIozp8vPYIlSlUbTxQYYov9mTxrTB0X9PsIX4ED8Cko9+B
	 ftEGevUAQYMmYgVTlBh1xqWoUCvjiQxn/LeLLsB35YrSDEFsCYnHVw9RSfWOOG5N9S
	 GEHVJr16hI6FrYrHI2dqEaB5ObL19lzQ2wg7DCRJm2j/FS1BVKpA3K33msf097//w6
	 DBGdUVh138XXw==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4F989881E6;
 Fri, 22 Mar 2024 12:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711107816;
 bh=pTguwxuGntk/JSW+XreRnzCcwPZjDumRfSo2+3nnEYY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lSvrX9Sf93T6Wi9TTYOiJUCL1k5muxHzdijJOUfS7FfhHxwt87T1mVy2g5xbM9k+U
 jkel358cdmBkuVvyl7EXGXyvA0F+RRDoZnJ0Z68RMc2y2Dl2IAEDwqAtEwR2fZU1Cv
 x4G5NNpwt+7AT/dfAOL8DupXBhrCtU0X66Xmiu6zh3FkTHciCRi+viYBFLf49C7zDZ
 6QR1oaBd+u5pKGjF+8/5HKUlPbiXIaS3WpnycPCDNNU91lS8FWE28ckFp0Frngb9Ek
 hlwMh8io+zEwwfHvDtwjYjjAPKqg7sm4Yavfq/IJ0QAOVsx5cNTZQHlqEgHCPv8AT6
 Lp7pmlzmrwyfA==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/12] dts: xea: Move phy-reset-gpios property to version
 specific DTS file
Date: Fri, 22 Mar 2024 12:43:07 +0100
Message-Id: <20240322114315.2720727-5-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322114315.2720727-1-lukma@denx.de>
References: <20240322114315.2720727-1-lukma@denx.de>
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

The DTS description in XEA for mac0 node in u-boot differs considerably
from what we do have available in Linux, as u-boot is not supporting L2
switch (i.e. 'fixed-link' property is used).

To facilitate HW revision management - this particular property has been
moved to version specific file.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 arch/arm/dts/imx28-xea-1-u-boot.dtsi | 4 ++++
 arch/arm/dts/imx28-xea-u-boot.dtsi   | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx28-xea-1-u-boot.dtsi b/arch/arm/dts/imx28-xea-1-u-boot.dtsi
index 4b2b21eeae..2903be2089 100644
--- a/arch/arm/dts/imx28-xea-1-u-boot.dtsi
+++ b/arch/arm/dts/imx28-xea-1-u-boot.dtsi
@@ -9,3 +9,7 @@
  * configuration in SPL for falcon boot.
  */
 #include "imx28-xea-u-boot.dtsi"
+
+&mac0 {
+	phy-reset-gpios = <&gpio2 13 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/dts/imx28-xea-u-boot.dtsi b/arch/arm/dts/imx28-xea-u-boot.dtsi
index bdbeca528c..13a581f7a6 100644
--- a/arch/arm/dts/imx28-xea-u-boot.dtsi
+++ b/arch/arm/dts/imx28-xea-u-boot.dtsi
@@ -50,7 +50,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mac0_pins_a>;
 	phy-supply = <&reg_fec_3v3>;
-	phy-reset-gpios = <&gpio2 13 GPIO_ACTIVE_LOW>;
 	phy-reset-duration = <1>;
 	phy-reset-post-delay = <1>;
 	status = "okay";
-- 
2.39.2

