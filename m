Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2228CAC592
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 18:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B7C834D4;
	Mon, 15 Sep 2025 20:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=easynet.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=easynet.dev header.i=@easynet.dev header.b="fH3NGFLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD00283496; Mon, 15 Sep 2025 17:56:53 +0200 (CEST)
Received: from smtp01.easynet.dev (smtp01.easynet.dev
 [IPv6:2a00:ece1:2:10::1:110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 869D282AE1
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 17:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=easynet.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devel@easynet.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=easynet.dev; s=mail;
 t=1757951810; bh=j/fbGCRFcN5VucQuodB+LRtSOpkRSmAsLfMCCiUWMKE=;
 h=From:To:Cc:Subject:Date:From;
 b=fH3NGFLK0QoA365PJYkmSV5e55UaPIgSxayC9i0t7Qa5Nz5Y3uRCSNY932HhOjf8P
 BstFFu4F9qIIv/oh4w5INn9XcnUUIb2jp2t/LtON2VYTWFp0rASn79On2z9nXU2xqL
 tNU7UpvzrM1UXyK/tDtGUtVgac9/9ZEDUeRx7uxY71SBJloPUD1ALGES6AZigjM0jK
 PdeVdBfs/siHqGRAkiP4YGF8Ke3bSW1cIKuXyr80yBHtac7OBauKZRniQVkHtuXy0A
 EoBJBaYUL9K7ACq/x6kisoli0jD0RPvlr++6kotoO+hVoFOZClR0gMN1zXVJl1xBg1
 ZtqMiwTc6pW1Q==
Received: from Ryzen5900X.easynet.dev (unknown
 [IPv6:2001:171b:2267:5ac1:2fe9:54e:2253:6697])
 (Authenticated sender: adrian@easynet.dev)
 by smtp1.easynet.dev (Postfix) with ESMTPSA id B4A8B60024;
 Mon, 15 Sep 2025 18:56:50 +0300 (EEST)
From: EasyNetDev <devel@easynet.dev>
To: u-boot@lists.denx.de
Cc: EasyNetDev <devel@easynet.dev>
Subject: [PATCH] Fix Linux reboot on MT7988 using EFI and PSCI
Date: Mon, 15 Sep 2025 17:56:34 +0200
Message-ID: <20250915155638.2913446-1-devel@easynet.dev>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Sep 2025 20:52:46 +0200
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

Signed-off-by: EasyNetDev <devel@easynet.dev>

I'm proposing adding PSCI in DTS for MT7988 SoC which solves the problem
when U-Boot is compiled with CONFIG_PSCI_RESET=y.
If this code in DTS is missing and the system is using U-Boot EFI -> GRUB EFI -> Linux Kernel,
then the Linux kernel is not able to reboot the board on systemctl reboot.

This simple code fixes this issue.

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

