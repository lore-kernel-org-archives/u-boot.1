Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC19C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 09:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114DD871C3;
	Tue, 19 Dec 2023 10:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gSgIq6Bc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD5086EEB; Tue, 19 Dec 2023 10:56:12 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02330870A4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 10:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7C0106128D;
 Tue, 19 Dec 2023 09:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1DBC433C7;
 Tue, 19 Dec 2023 09:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702979768;
 bh=F/JgX13yBaWo01Aw8m+N6urLjKgLj4byrJVRFQTqFeA=;
 h=From:To:Cc:Subject:Date:From;
 b=gSgIq6BccwY6gPIyEUyLGmP38nYYQv9g+/xZ4t+YK35RCoauj/nZ9C8xgqyZsWy3u
 iMMnbse77bx1hhHCdUioqdDF4iAE/dkZ/PQ1wwasKjkfGQN1G+CUNp0JdDaQhxFT+0
 2nx1hVl/CKcOlbTl5b3ez3E9S3oc//Pzl+njZkfS+hB4bjCS6x4Ee6CZWPST9j1psv
 8LJ9zjCfljuT1vCLbW1eP/tvbSpO5uEDeAZX6HjNfQECCsjobtgU4d9dBbZWvVCpiR
 WP0bWrX654rSStKviJ0WU2rLYo4a/pqOopX29M+17dmMkHOwt7o2AiU2fX72MVfK8y
 qbIDb9FtX4tKg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell] arm: mvebu: turris_omnia: Enable networking
 via ethernet switch
Date: Tue, 19 Dec 2023 10:55:55 +0100
Message-ID: <20231219095555.31418-1-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Marek Mojík <marek.mojik@nic.cz>

The Turris Omnia contains the Marvell 88E6176 ethernet switch. Add
config options and device tree to enable the support.

Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Stefan, this patch depends on
  [v2] net: mv88e6xxx: fix missing SMI address initialization 
  https://patchwork.ozlabs.org/project/uboot/patch/62eoapvurxkedw74vpzb55q3nuqgb4cef3bl2laayx57cpjzus@vlpx57cjc4ph/
---
 .../dts/armada-385-turris-omnia-u-boot.dtsi   | 51 +++++++++++++++++++
 configs/turris_omnia_defconfig                |  2 +
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/dts/armada-385-turris-omnia-u-boot.dtsi b/arch/arm/dts/armada-385-turris-omnia-u-boot.dtsi
index 509d6ca69c..c63a331d69 100644
--- a/arch/arm/dts/armada-385-turris-omnia-u-boot.dtsi
+++ b/arch/arm/dts/armada-385-turris-omnia-u-boot.dtsi
@@ -35,6 +35,57 @@
 	};
 };
 
+&mdio {
+	switch@10 {
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sw_phy0: ethernet-phy@0 {
+				reg = <0x0>;
+			};
+
+			sw_phy1: ethernet-phy@1 {
+				reg = <0x1>;
+			};
+
+			sw_phy2: ethernet-phy@2 {
+				reg = <0x2>;
+			};
+
+			sw_phy3: ethernet-phy@3 {
+				reg = <0x3>;
+			};
+
+			sw_phy4: ethernet-phy@4 {
+				reg = <0x4>;
+			};
+		};
+		ports {
+			ports@0 {
+				phy-handle = <&sw_phy0>;
+				phy-mode = "internal";
+			};
+			ports@1 {
+				phy-handle = <&sw_phy1>;
+				phy-mode = "internal";
+			};
+			ports@2 {
+				phy-handle = <&sw_phy2>;
+				phy-mode = "internal";
+			};
+			ports@3 {
+				phy-handle = <&sw_phy3>;
+				phy-mode = "internal";
+			};
+			ports@4 {
+				phy-handle = <&sw_phy4>;
+				phy-mode = "internal";
+			};
+		};
+	};
+};
+
 #ifdef CONFIG_ENV_IS_IN_SPI_FLASH
 &spi0 {
 	flash@0 {
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 65d4a296e7..3aaee276ea 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -96,7 +96,9 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_FIXED=y
+CONFIG_DM_DSA=y
 CONFIG_PHY_GIGE=y
+CONFIG_MV88E6XXX=y
 CONFIG_MVNETA=y
 CONFIG_MII=y
 CONFIG_MVMDIO=y
-- 
2.41.0

