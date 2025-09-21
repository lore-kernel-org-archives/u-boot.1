Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45899CAC59A
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 15:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E7183211;
	Sun, 21 Sep 2025 17:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=easynet.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=easynet.dev header.i=@easynet.dev header.b="FHGGVRsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D673832DA; Sun, 21 Sep 2025 17:56:36 +0200 (CEST)
Received: from smtp01.easynet.dev (smtp01.easynet.dev
 [IPv6:2a00:ece1:2:10::1:110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9AEE8317B
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 17:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=easynet.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devel@easynet.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=easynet.dev; s=mail;
 t=1758470193; bh=3Zu/iD2XUkdbP7IHpMmFK/iKR4HUNjGuCjE1fWaEV2o=;
 h=From:To:Cc:Subject:Date:From;
 b=FHGGVRsyJDxBqjXLViBPWbeTxmKNtpjQh7z1DK3ISrhlaaZDcDAbl3tNP/TGMrglO
 tBPYGJy5K6E7fmw8BULUhPe/+7Xa6fDbDCGaQcCceIqUGg5xcoeuu4o6D8LyRfBTJx
 tsJc0usQccPk3D6H6m7lQgaD/3NRG6+5Ns92EKDeWLX3oogX/ojzL7vXRLQMUODi+t
 prEMz6jtJjY/vjhkzfvihjHC7iSyIe7OU+nJe/3zksSUGV7LXfeH9Bz/ZQaqvjpTWI
 j27+7v46suoiGIMVnmkA7s6w7VhwVUmXo9GwQ7sZ8FmA6XRUi2o6DApZLqj0fgTfjW
 JbeJ5KRxT1iXA==
Received: from Ryzen5900X.easynet.dev (unknown
 [IPv6:2001:171b:2267:5ac1:f86e:749b:e8ed:f7dc])
 (Authenticated sender: adrian@easynet.dev)
 by smtp1.easynet.dev (Postfix) with ESMTPSA id 025476007F;
 Sun, 21 Sep 2025 18:56:32 +0300 (EEST)
From: Adrian Ban <devel@easynet.dev>
To: u-boot@lists.denx.de
Cc: EasyNetDev <devel@easynet.dev>
Subject: [PATCH] Fix Linux reboot on MT7988 using EFI and PSCI
Date: Sun, 21 Sep 2025 17:56:04 +0200
Message-ID: <20250921155605.1592643-1-devel@easynet.dev>
X-Mailer: git-send-email 2.51.0
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

From: EasyNetDev <devel@easynet.dev>

When booting Linux Kernel with U-Boot EFI -> GRUB EFI -> Linux Kernel
reboot is not possible using "system reboot".

Adding PSCI node in devicetree fixes this issue.

Signed-off-by: Adrian Ban <devel@easynet.dev>
---
 arch/arm/dts/mt7988.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index 2d57c6f5709..e907cf89396 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -51,6 +51,11 @@
 		};
 	};
 
+	psci {
+		compatible  = "arm,psci-0.2";
+		method      = "smc";
+	};
+
 	system_clk: dummy40m {
 		compatible = "fixed-clock";
 		clock-frequency = <40000000>;
-- 
2.51.0

