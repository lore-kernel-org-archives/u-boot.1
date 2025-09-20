Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B0ECAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 15:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B208E8004F;
	Sat, 20 Sep 2025 17:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=easynet.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=easynet.dev header.i=@easynet.dev header.b="nO7G56Ys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25FBB82B07; Sat, 20 Sep 2025 17:43:14 +0200 (CEST)
Received: from smtp02.easynet.dev (smtp02.easynet.dev [89.38.58.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E72318003E
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 17:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=easynet.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devel@easynet.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=easynet.dev; s=mail;
 t=1758382991; bh=j/fbGCRFcN5VucQuodB+LRtSOpkRSmAsLfMCCiUWMKE=;
 h=From:To:Cc:Subject:Date:From;
 b=nO7G56YsZNA4o9Wlb1+e9b1XraS0eAaIZSLIl+hh9j3j4bg2IXAhojI97Ar1JvU81
 zH8i2iTWDo7P3GzgGFLb+IIaviOasNYLDZk6mxWJsE38CleGKcpj6PeadZGj7+Qa5f
 gqRCZERNId9k/X+oE4b7xPj6hQ/hZw+KbPauhhW6gHa9eDS7mNOsMov3A6PHs6z0pZ
 zO0Ca5fobNDqd9If4HF91kPeKH9EfA3rVybEHzc8FnWoxXAOSy6x7oebt4tMebW0+G
 xTkSsKgwGo3Kj6A7WwFwtUKCsDaLimLyfW5pE24G8AjmIfqvP/dtbSdyte6Ep9seM5
 cSKFEe3O6K3yA==
Received: from Ryzen5900X.easynet.dev (unknown
 [IPv6:2001:171b:2267:5ac1:f86e:749b:e8ed:f7dc])
 (Authenticated sender: adrian@easynet.dev)
 by smtp1.easynet.dev (Postfix) with ESMTPSA id 05EDF60036;
 Sat, 20 Sep 2025 18:43:10 +0300 (EEST)
From: EasyNetDev <devel@easynet.dev>
To: u-boot@lists.denx.de
Cc: EasyNetDev <devel@easynet.dev>
Subject: [PATCH] Fix Linux reboot on MT7988 using EFI and PSCI
Date: Sat, 20 Sep 2025 17:42:45 +0200
Message-ID: <20250920154248.789281-1-devel@easynet.dev>
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

