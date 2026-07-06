Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA00DC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 05:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A86E8498B;
	Mon,  6 Jul 2026 07:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.b="V5YB0Zo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6306846B4; Mon,  6 Jul 2026 03:46:07 +0200 (CEST)
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C5C84105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 03:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhuxu_ran@zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1783302303; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GNOuHms/JSskOFqh8PSHcx7gdWAgE/vKG011lON/A2f8t2C6nLc0Ss/W4xBUaHFRVTcWE+5gwhFgU3y6pmBRXS1i14Cwf0dYVRVZ88gD6hZJz1wQKqjWf0n58GaUlMm8cp8K0MpWJbEpcwljovBX3xeeybSttbW7eXV4K0XFsH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783302303;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rTekK4ciIrLXube0MIcCp1TlYXsdpymNzp+FmKfF1Ps=; 
 b=QlgIaU/rCEZvYbtEkGUOmBnQr8N2oQfbMZEOIZeahC0fCDGJ0P3azZqDz4Gz/wwnlii3hM+tKVeQuRa6DyQudvYWb4qtpixKmH+LqokgCyKF+L/5+an+JhsFEaIo30r6ahyGamUXiXsbMP7hpYklzqWe4+bToxTZY3tsmmm5IRg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783302303; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=rTekK4ciIrLXube0MIcCp1TlYXsdpymNzp+FmKfF1Ps=;
 b=V5YB0Zo9KnuABkNxXmGFFcasmEvWuTF4MiVL47vEVSxyPFVbHVNiA5hTUEZcxRSj
 U8CgGi8SXhfylO6EGUj1M0udfcUr/ZYlYDG/j+0FjuElAZbYv7mn16AINuQ97NZHiBQ
 nUtxJZl2M34o7pVAmjsxw56EJMPWQ86TXPIYtZh4=
Received: by mx.zohomail.com with SMTPS id 1783302295384509.12898213614847;
 Sun, 5 Jul 2026 18:44:55 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Mon, 06 Jul 2026 09:43:43 +0800
Subject: [PATCH 3/3] riscv: dts: milkv_duo: Drop local devicetree files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-milkv-duo-upstream-dts-v1-3-8d010ddda7ca@zohomail.com>
References: <20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com>
In-Reply-To: <20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Martin Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, Yao Zi <me@ziyao.cc>, 
 Andreas Schwab <schwab@suse.de>, Zhuxu Ran <zhuxu_ran@zohomail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227561bb23ca48fba93dfa0ca400000a84e2843b6f08d1dbf87c720e997690c9a204f8ad89df2631c:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:06:30 +0200
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

Milk-V Duo now uses the upstream devicetree, so the local board
dts and CV1800B dtsi are no longer used. Remove them and drop
the local dtb target from arch/riscv/dts/Makefile.

Keep cv18xx.dtsi since it is still used by the SG2002 local
devicetree.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 arch/riscv/dts/Makefile              |  1 -
 arch/riscv/dts/cv1800b-milkv-duo.dts | 64 ------------------------------------
 arch/riscv/dts/cv1800b.dtsi          | 22 -------------
 3 files changed, 87 deletions(-)

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 8e591cb7aa9..498aa6c7f5d 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -5,7 +5,6 @@ dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
 dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
-dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
diff --git a/arch/riscv/dts/cv1800b-milkv-duo.dts b/arch/riscv/dts/cv1800b-milkv-duo.dts
deleted file mode 100644
index e7cc0e8bd14..00000000000
--- a/arch/riscv/dts/cv1800b-milkv-duo.dts
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- */
-
-/dts-v1/;
-
-#include "cv1800b.dtsi"
-
-/ {
-	model = "Milk-V Duo";
-	compatible = "milkv,duo", "sophgo,cv1800b";
-
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x3f40000>;
-	};
-};
-
-&ethernet0 {
-	status = "okay";
-	phy-mode = "rmii";
-};
-
-&osc {
-	clock-frequency = <25000000>;
-};
-
-&sdhci0 {
-	status = "okay";
-	bus-width = <4>;
-	no-1-8-v;
-	no-mmc;
-	no-sdio;
-};
-
-&spif {
-	status = "okay";
-
-	spiflash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <75000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-		m25p,fast-read;
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/riscv/dts/cv1800b.dtsi b/arch/riscv/dts/cv1800b.dtsi
deleted file mode 100644
index baf641829e7..00000000000
--- a/arch/riscv/dts/cv1800b.dtsi
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
- */
-
-#include "cv18xx.dtsi"
-
-/ {
-	compatible = "sophgo,cv1800b";
-};
-
-&plic {
-	compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
-};
-
-&clint {
-	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
-};
-
-&clk {
-	compatible = "sophgo,cv1800-clk";
-};

-- 
2.55.0

