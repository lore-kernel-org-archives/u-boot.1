Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E22C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A47D8648B;
	Mon, 28 Aug 2023 19:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XiczuopR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7413786423; Mon, 28 Aug 2023 19:09:31 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C2C1864B7
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SH9PAq084786;
 Mon, 28 Aug 2023 12:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693242565;
 bh=e49f1H2HC5a27zCHvRUCzANRtKSWoxfYaKmrJfZ0mC4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=XiczuopRu/yi2fmA1eHK6ITihjvmbHv4omGGge7sBTBtCwaT+trqt54tlhzXWuVet
 YoPoLJhrhn2Sfgf5+C8Oa3pkBwo6UjFyXv0aMMj8QTeVahuBgRCsTccUhQv0Bpujlp
 JdecQbwmP1faAZQjoPMYTBu6hBLADoa1AFqfd5D4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SH9PYO071022
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 12:09:25 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 12:09:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 12:09:24 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SH9OCi034438;
 Mon, 28 Aug 2023 12:09:24 -0500
Date: Mon, 28 Aug 2023 12:09:24 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
Subject: Re: [PATCH v1 2/4] arm: dts: k3-j721e: Sync with v6.5-rc1
Message-ID: <20230828170924.3ptnptzmhffbhylr@sharpness>
References: <20230828113109.2533045-1-n-francis@ti.com>
 <20230828113109.2533045-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230828113109.2533045-3-n-francis@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 17:01-20230828, Neha Malcom Francis wrote:
> Sync k3-j721e DTS with kernel.org v6.5-rc1.
> 	* pcie_epx nodes have been deleted, they are not needed [1]
> 	* use mcu_timer0 instead of the redundant timer1. Also delete
> 	  clock and power domain properties since J721E follows legacy
> 	  boot flow where system firmware is not yet available to modify
> 	  clocks
> 	* remove mcu_i2c0 as it is used for tps659413 PMIC in j721e-sk
> 	  for which support is not yet added.
> 	* remove main_i2c2 pinmux for j721e-sk as it is connected to the
> 	  test automation header for which support is not there
> 	* change mcu_secproxy to secure_proxy_mcu since linux has
> 	  defined these nodes
> 	* hbmc nodes have been disabled as their support in kernel
> 	  itself is unfinished (dependent series not merged) [2]
> 	* Drop mcu_cpsw node in U-Boot as it is no longer needed here
> 	  thanks to [3]
> 
> [1] https://lore.kernel.org/lkml/20230515172137.474626-2-afd@ti.com/
> [2] https://lore.kernel.org/all/20230513123313.11462-2-vaishnav.a@ti.com/
> [3] https://lore.kernel.org/all/20230722193151.117345-1-rogerq@kernel.org/
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  .../k3-j721e-common-proc-board-u-boot.dtsi    | 139 ++-
>  arch/arm/dts/k3-j721e-common-proc-board.dts   | 483 ++++++---
>  arch/arm/dts/k3-j721e-main.dtsi               | 974 ++++++++++++++++--
>  arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         | 280 ++++-
>  .../arm/dts/k3-j721e-r5-common-proc-board.dts | 270 +----
>  arch/arm/dts/k3-j721e-r5-sk.dts               | 493 +--------
>  arch/arm/dts/k3-j721e-sk-u-boot.dtsi          | 158 +--
>  arch/arm/dts/k3-j721e-sk.dts                  | 663 +++++++++---
>  arch/arm/dts/k3-j721e-som-p0.dtsi             | 213 ++--

Are you sure you copied this correctly?
I see this change when i copy in files from 6.5-rc1 linux kernel *after*
I applied this series of patches.

diff --git a/arch/arm/dts/k3-j721e-som-p0.dtsi b/arch/arm/dts/k3-j721e-som-p0.dtsi
index e90e43202546..38ae13cc3aa3 100644
--- a/arch/arm/dts/k3-j721e-som-p0.dtsi
+++ b/arch/arm/dts/k3-j721e-som-p0.dtsi
@@ -201,6 +201,19 @@
 	};
 };
 
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		/* CAV24C256WE-GT3 */
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
