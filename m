Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37350D7833A
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 17:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD6028941A;
	Mon,  2 Dec 2024 18:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="JpvRmxfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFEA0893EC; Mon,  2 Dec 2024 18:31:29 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 by phobos.denx.de (Postfix) with ESMTP id E294F86DBD
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 18:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1733160673;
 bh=0OFre6dJ08zDKejV/OR7aR8fJzE5qDP5SIN9V1NabpU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=JpvRmxfVgwH5BpBoRbwtewxCMrIJix5iPDoxiUiCkcg9It+ComBDxO+QMg8OKH/Cc
 rqehXcR1hvCVXT4c4+BO28V3HyQ6036C+/XO5h7dnFS4a3tG1VuSnjaM2iXE8A/kk7
 Wo7W9VLjdnNf4mpbY4cIsHQDpTPGjpin4NuEZ1qgAKl0WASmoB9Qb3x2ves0uL8HQU
 hu6ikXUCwYf3mF5Jru61S36qj8lDG9JLGtpiobUjTa0KkDWG3rRuPX9iOFFqwX+Y0s
 7X+tZgLX+3sGCl0tAgcWB3CKDqm7hz4o3VW8bxOMFLldQugCbCPTCzxg6OYkJjraoo
 OrgKR6yx7gVQw==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Marek Vasut
 <marex@denx.de>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V5 1/4] arm64: dts: imx8mp: Add aliases for the access to the
 EEPROM ID page node
Date: Mon, 2 Dec 2024 18:29:47 +0100
Message-ID: <20241202172950.35460-2-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20241202172950.35460-1-cniedermaier@dh-electronics.com>
References: <20241202172950.35460-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
that contains an additional write-lockable page called ID page. Add
aliases eeprom0wl and eeprom1wl for the access to the EEPROM ID
page node.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
V3: - Add this patch to the series
V4: - Typo in subject and commit message corrected
V5: - Add Reviewed-by tag
---
 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
index c065fb8299..546490a4a8 100644
--- a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
@@ -9,6 +9,8 @@
 	aliases {
 		eeprom0 = &eeprom0;
 		eeprom1 = &eeprom1;
+		eeprom0wl = &eeprom0wl;
+		eeprom1wl = &eeprom1wl;
 		mmc0 = &usdhc2;	/* MicroSD */
 		mmc1 = &usdhc3;	/* eMMC */
 		mmc2 = &usdhc1;	/* SDIO */
-- 
2.30.2

