Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762A3CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 08:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B07F83957;
	Wed,  8 Oct 2025 10:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="orE7tHs4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3832B83956; Wed,  8 Oct 2025 07:57:28 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5FBF8393F
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 07:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=369ecc0ec=Dharma.B@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1759903045; x=1791439045;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sEPjzVtPfcoB2Sv+h1LUccGUcQrX/eMe9E8ydHYeovE=;
 b=orE7tHs4uhGLRbsMljfHg7DxasGeOxUXJVn9OOXQPvlVGQYC6Ic1L7YO
 /iJ5ya30E4CJugzZ5LFGP4K2Pxq9Sa0Ko/z2exWSDOs3yEWzmtz3jsdMF
 bnTSXarB8WtyDzKNaxPChPA9kAgmSRRyDcu6TwvLZPVUnqLsJeG6sf6KY
 LyZq6eMIa0jv48ttuMZYtzRn753dLcKxeD35OqWPkDz8KWvzomUbXpull
 BBiok4rFi654UMhPcVCtKtFRhgZ+HWPf9utulwkwiOVLeCajKjDO2OVFG
 sIXFewjmq5EJik9eZ4oPqRH3mo/erVBcfW22vmlVk7o3MJexjLou9xI6a w==;
X-CSE-ConnectionGUID: MNDwbnlUTqupViu3hxj74w==
X-CSE-MsgGUID: D9H0UcVlRNmlkzu+0zSeNQ==
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="53535152"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 07 Oct 2025 22:57:23 -0700
Received: from chn-vm-ex1.mchp-main.com (10.10.87.30) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 7 Oct 2025 22:56:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 7 Oct 2025 22:56:43 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 7 Oct 2025 22:56:40 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <u-boot@lists.denx.de>
CC: Dharma Balasubiramani <dharma.b@microchip.com>, Balamanikandan Gunasundar
 <balamanikandan.gunasundar@microchip.com>, Eugen Hristev
 <eugen.hristev@linaro.org>, Manikandan Muralidharan
 <manikandan.m@microchip.com>, Miquel Raynal <miquel.raynal@bootlin.com>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH] ARM: dts: sam9x60ek: select PIT as tick-timer
Date: Wed, 8 Oct 2025 11:26:33 +0530
Message-ID: <20251008055636.17462-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 08 Oct 2025 10:05:29 +0200
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

U-Boot currently enables the UPLL during boot, which triggers a udelay()
call that depends on the system tick timer. Since no explicit tick source
is defined in the device tree, boot stalls on this board.

Define the "tick-timer" property under /chosen and point it to the PIT
node, ensuring U-Boot uses the PIT as the tick source.

Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---

 arch/arm/dts/sam9x60ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/sam9x60ek.dts b/arch/arm/dts/sam9x60ek.dts
index 6521585ee9c..1c09c92ae18 100644
--- a/arch/arm/dts/sam9x60ek.dts
+++ b/arch/arm/dts/sam9x60ek.dts
@@ -17,6 +17,7 @@
 	chosen {
 		stdout-path = &dbgu;
 		i2c0 = &flx0;
+		tick-timer = &pit;
 	};
 
 	clocks {
-- 
2.43.0

base-commit: 92dcb3ad5d98f494b2448a7345e1cb7eefa50278
branch: master
