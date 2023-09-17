Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E52ACD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 11:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC2EA863E5;
	Sun, 17 Sep 2023 13:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EyhPXCgD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X/olAezp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5ECF8640F; Sun, 17 Sep 2023 13:49:54 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1299A86308
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 13:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpR745vHtz9sWt;
 Sun, 17 Sep 2023 13:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694951392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bh139EaSznqxiIc7ql0yB9XINC9YMdTsS5qzEbdnai0=;
 b=EyhPXCgD6jyI3RvbVbyOjaMGprKWOos/KuV6AuZD+IVGtmi9BOUjy+vczMMM/Hoy+hXq2N
 GbapYPaS6riUxwEOGay9ZwBPlGTHn3a9bZ3cs4tSn22bqqk0Hzjalxwm8qgtxVx8//Dr5E
 YlPK4k2czIPKBLyrFy21xUg70GLei9vxtATEIB34XfafDoqhRxsKUYeJXfg3PYcIUyRVaN
 sYRbjf9OWf3wGzzw53h23GnbXkbucKDjyKfJtzgi3iQMrL7dqBhVkDBJf3ioX6AvkDy/6C
 IfZfaB6qiEaXMnPPIn1do6w3dBw0JVVfbXBgZoko4BBbSQdD0SHFbsX6t21G2A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694951391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bh139EaSznqxiIc7ql0yB9XINC9YMdTsS5qzEbdnai0=;
 b=X/olAezptukBsnTVcZt7sz2qL74IC1SDEZ01X++x1vRkIlek9scjelTG0CL585luRUq76C
 zTBYjh0Tbjvc4oyu5arDRUrmm9coYVIOvbhOwAHjZvAJ/EMnFsepdiocdxnE1Q2uzIltzk
 X+qs82nB9iX0y6fQOsOtR+uaF2nBI2g244Njy9ibf5J9r9zcVJsrodYNdLG7j0MFUnNw47
 6ovw1uMBNP+5Gqae5Aj1h0b2aMowqtwuXxp3yZdHNnqkzAehj3NLzA45CvWlBIv1M+ueBe
 flN/YgEliwhEe4c/wfBqTlh93tYX3+Q24kYV5v2/WS6LQDcZOQeObRLd2Jkd7w==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] ARM: dts: renesas: Add compatible properties to KSZ9031
 Ethernet PHYs on Salvator-X boards
Date: Sun, 17 Sep 2023 13:49:30 +0200
Message-Id: <20230917114930.202882-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 26d767fc3f7b0449fc3
X-MBO-RS-META: e4bsgwu3pt3tcfd83gdhmbnzbhb3bo5i
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

Add compatible values to Ethernet PHY subnodes representing Micrel
KSZ9031 PHYs on R-Car Gen3 Salvator-X boards. This allows software
to identify the PHY model at any time, regardless of the state of
the PHY reset line.

This is a fix for missed addition of these properties on Salvator-X
boards.

Ported from Linux kernel commit 722d55f3a9bd810f3a1a31916cc74e2915a994ce .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/salvator-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/salvator-common.dtsi b/arch/arm/dts/salvator-common.dtsi
index 98bbcafc8c0..23fdd1115b2 100644
--- a/arch/arm/dts/salvator-common.dtsi
+++ b/arch/arm/dts/salvator-common.dtsi
@@ -328,6 +328,8 @@
 	status = "okay";
 
 	phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id0022.1622",
+			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
 		interrupt-parent = <&gpio2>;
-- 
2.40.1

