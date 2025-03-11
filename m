Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF44C282DE
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 01:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A43D806D8;
	Tue, 11 Mar 2025 02:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741656889;
	bh=AqENxwpEdjfceYtnTiIO5GsFC6m6wrkOOHxyAWioMrc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iIS0a3Bx3qaGiwv01tnjcTosb7yn/cESX467IJJ9LvKewfTuFH8wbMSaGuZnQPm8M
	 JfEPG/8oPbfBhAgDJZ7rF0jJ7ksO4joUX5qSXMK4BRQzIgeF5gN58izKM+dodJ9R47
	 ozw4dEcKUyhgM+xMZPE51nVUgvni/f+kmPoIuORZEj2oIX4R2CRv2J3hp9xmkzCTjn
	 uomTjJfuatMQBH4yuHvqJJqroyQAl2s1Z7J3N1QCcxTEpNH07vgF1QeZ7nAQEigYwi
	 Ax3K7u2kZYNa8P6JyDpxJb2R88z2L1zm87tNl4uBgifasK8jp9H9lQGl/Tdxo50OvQ
	 8+cMxhsZxZDkw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C696807D9; Tue, 11 Mar 2025 02:34:47 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E51801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 02:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FmalLjb5"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E4DD510210BC0; Tue, 11 Mar 2025 02:34:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741656884; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=AqENxwpEdjfceYtnTiIO5GsFC6m6wrkOOHxyAWioMrc=;
 b=FmalLjb5ELFApmOOpbqX88qsnHC6aB1RIYM7aMT6n9VCch/eOLa/xXDKjEIlOi3NTsyb48
 TYsfgaY/pzwGwrfCieYO5P7N84nV9qnoiyz9PRA4Nk2oAjtN8KUK6dbio1ZuyeHDSlhlCU
 bgF5C1tW3iJahu9lpFhawV+T9tpvAD9TcOcY3WNoR1R7Ivdi7JHn3eUrj18wm+eZkVuVXt
 wwvZaYqYixEsSP4AiiBLUYvxzD0eyut/Tu6P/UmvubF/w/q7YtdxCmbRKCUm4bFmjh8arG
 CUUbDg1ID5hZsvCbLMGPJ8RzMgrG2HLivGYMECVH379+tq1zbBrn1iOqEhcTSQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH] ARM: dts: imx: Drop bogus regulator extras on DH i.MX6 DHCOM
 DRC02
Date: Tue, 11 Mar 2025 02:34:18 +0100
Message-ID: <20250311013430.510151-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The regulator extras should be placed in the USB H1 regulator node,
the /regulator-usb-h1-vbus. They are already present there in the
upstream DT, so delete this bogus node entirely.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/imx6qdl-dhcom-u-boot.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/dts/imx6qdl-dhcom-u-boot.dtsi b/arch/arm/dts/imx6qdl-dhcom-u-boot.dtsi
index 740a24d96ec..300e355c8ef 100644
--- a/arch/arm/dts/imx6qdl-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-dhcom-u-boot.dtsi
@@ -27,11 +27,6 @@
 	};
 };
 
-&reg_usb_otg_vbus {
-	gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
-	enable-active-high;
-};
-
 &wdog1 {
 	bootph-pre-ram;
 };
-- 
2.47.2

