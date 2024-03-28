Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD99CD1283
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 21:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E0D881EE;
	Thu, 28 Mar 2024 22:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ny/9Ip1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6388881E5; Thu, 28 Mar 2024 22:46:12 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F7288204
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 22:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D887B3F078; 
 Thu, 28 Mar 2024 21:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711662369;
 bh=J3rH95kaAx9F6Fk/jwKI/nKPZL1NvMPurKKYQTMX0MI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ny/9Ip1b6JAhSQ+i8YYCG/fW5uhMFIDeuPcZrqsWldDqCVPJBzJ2uJH9SIfDDi2Bm
 +O44ouDkO2x+aean78RN6ay7TJR/LrPB4d78mOxfwHJvKYVAo3ZzLDmWbutLwlg05p
 ck+/5fLa50StiMPRcAT0wR33a14hUnlvevwlSTqMh83fOGu48DaC3PddW8bkfVPCOq
 b7OI/Nvp1R9SE+WMy6475rakOzE5MkTpzutQP0Y7pxOs5m0tRjQ6LEay4JZQez6zhe
 F7HD9H29VshXmGhorbN/P8/4tPuXZZ6Te3pcSkETZna3c/YCcGlUeM38XClRcEszAY
 MnlDTk3I+QDOQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Aurelien Jarno <aurelien@aurel32.net>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: starfive: MMC card detect
Date: Thu, 28 Mar 2024 22:46:15 +0100
Message-ID: <20240328214615.21501-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The VisionFive 2 board uses GPIO 41 as card detect as documented in
https://doc-en.rvspace.org/VisionFive2/PDF/SCH_RV002_V1.2A_20221216.pdf.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
index f2c6bec9298..e11babc1cde 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
@@ -298,7 +298,7 @@
 	pinctrl-0 = <&mmc1_pins>;
 	no-sdio;
 	no-mmc;
-	broken-cd;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
 	cap-sd-highspeed;
 	post-power-on-delay-ms = <200>;
 	status = "okay";
-- 
2.43.0

