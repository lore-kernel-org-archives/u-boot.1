Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45622C4451B
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 22:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DB084AD9;
	Mon, 20 Jul 2026 00:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="HBj8Em+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAD5A84AD9; Mon, 20 Jul 2026 00:02:54 +0200 (CEST)
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch
 [79.135.106.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 456B284A9E
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 00:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anoduck@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1784498569; x=1784757769;
 bh=J0lAQuqkMEnJdex4vqe0phGtTk49+IJNhum/MIaPFvk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=HBj8Em+3j+iUejyEP4QBeg2oBFWFjNmsrN+4eo2fsoqlhjGnnu345TqzR+NY8Yjn9
 5D6lZXmqeCBPYUeDjJvi0nlLuRFiYJu8HcjIKPOqJz8UlHD9GOpYKNH/UEhCJYcAUc
 W7GARP0LBOR2dfzk0hPbPyJs62lhtBCXeJvbjUixWb206tQDllt2yHkb1ZwNnAB0L1
 G+YiFAZoNAxw/oGfNsC+UDCpRCaAyQpsX8KH0r8vR+tfmFjGL+cnDMUJodIX6TmrmF
 5mbeNYou7IGjFcLpk4HEsuNaPLMLfpx04y17k1n0PrNf2C3zLqUvah6pWqdezGWfgt
 MUHCCGtcZxq/Q==
Date: Sun, 19 Jul 2026 22:02:40 +0000
To: u-boot@lists.denx.de
From: anoduck <anoduck@protonmail.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 anoduck <anoduck@protonmail.com>, The Anoduck <anoduck@protonmail.co>
Subject: [PATCH RFC PineTab-V DTS File v2 2/2] RFC: Pine64 Pinetab-V Device
 Tree File
Message-ID: <20260719-develop-v2-2-91fdc4cd60a2@protonmail.com>
In-Reply-To: <20260719-develop-v2-0-91fdc4cd60a2@protonmail.com>
References: <20260719-develop-v2-0-91fdc4cd60a2@protonmail.com>
Feedback-ID: 3493375:user:proton
X-Pm-Message-ID: 65a5b9082cbeb5a99c4660bb8ef936b0fb318e4b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Added device tree file to allow support for Pine64's Pinetab-V Risc-V 64bit=
 Tablet

Signed-Off-By: The Anoduck <anoduck@protonmail.co>
---
 arch/riscv/dts/jh7110-pine64-pinetabv-u-boot.dtsi  | 1756 ++++++++++++++++=
++++
 arch/riscv/dts/jh7110-pine64-pinetabv.dts          |  116 ++
 .../src/riscv/starfive/jh7110-pine64-pinetabv.dts  |  115 --
 .../jh7110-starfive-visionfive-2-pinetab-v.dts     |   12 -
 4 files changed, 1872 insertions(+), 127 deletions(-)

diff --git a/arch/riscv/dts/jh7110-pine64-pinetabv-u-boot.dtsi b/arch/riscv=
/dts/jh7110-pine64-pinetabv-u-boot.dtsi
new file mode 100644
index 00000000000..581bd54d71d
--- /dev/null
+++ b/arch/riscv/dts/jh7110-pine64-pinetabv-u-boot.dtsi
@@ -0,0 +1,1756 @@
+/dts-v1/;
+
+/ {
+=09compatible =3D "starfive,jh7110";
+=09#address-cells =3D <0x02>;
+=09#size-cells =3D <0x02>;
+
+=09cpus {
+=09=09#address-cells =3D <0x01>;
+=09=09#size-cells =3D <0x00>;
+=09=09timebase-frequency =3D "", "=3D\t";
+=09=09phandle =3D <0x43>;
+
+=09=09cpu@0 {
+=09=09=09compatible =3D "sifive,s7", "riscv";
+=09=09=09reg =3D <0x00>;
+=09=09=09device_type =3D "cpu";
+=09=09=09i-cache-block-size =3D <0x40>;
+=09=09=09i-cache-sets =3D <0x40>;
+=09=09=09i-cache-size =3D <0x4000>;
+=09=09=09next-level-cache =3D <0x01>;
+=09=09=09riscv,isa =3D "rv64imac_zba_zbb";
+=09=09=09riscv,isa-base =3D "rv64i";
+=09=09=09riscv,isa-extensions =3D "i", "m", "a", "c", "zba", "zbb", "zicnt=
r", "zicsr", "zifencei", "zihpm";
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x05>;
+
+=09=09=09interrupt-controller {
+=09=09=09=09compatible =3D "riscv,cpu-intc";
+=09=09=09=09bootph-pre-ram;
+=09=09=09=09interrupt-controller;
+=09=09=09=09#interrupt-cells =3D <0x01>;
+=09=09=09=09phandle =3D <0x0d>;
+=09=09=09};
+=09=09};
+
+=09=09cpu@1 {
+=09=09=09compatible =3D "sifive,u74-mc", "riscv";
+=09=09=09reg =3D <0x01>;
+=09=09=09d-cache-block-size =3D <0x40>;
+=09=09=09d-cache-sets =3D <0x40>;
+=09=09=09d-cache-size =3D <0x8000>;
+=09=09=09d-tlb-sets =3D <0x01>;
+=09=09=09d-tlb-size =3D <0x28>;
+=09=09=09device_type =3D "cpu";
+=09=09=09i-cache-block-size =3D <0x40>;
+=09=09=09i-cache-sets =3D <0x40>;
+=09=09=09i-cache-size =3D <0x8000>;
+=09=09=09i-tlb-sets =3D <0x01>;
+=09=09=09i-tlb-size =3D <0x28>;
+=09=09=09mmu-type =3D "riscv,sv39";
+=09=09=09next-level-cache =3D <0x01>;
+=09=09=09riscv,isa =3D "rv64imafdc_zba_zbb";
+=09=09=09riscv,isa-base =3D "rv64i";
+=09=09=09riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zb=
b", "zicntr", "zicsr", "zifencei", "zihpm";
+=09=09=09tlb-split;
+=09=09=09operating-points-v2 =3D <0x02>;
+=09=09=09clocks =3D <0x03 0x01>;
+=09=09=09clock-names =3D "cpu";
+=09=09=09#cooling-cells =3D <0x02>;
+=09=09=09cpu-supply =3D <0x04>;
+=09=09=09phandle =3D <0x06>;
+
+=09=09=09interrupt-controller {
+=09=09=09=09compatible =3D "riscv,cpu-intc";
+=09=09=09=09bootph-pre-ram;
+=09=09=09=09interrupt-controller;
+=09=09=09=09#interrupt-cells =3D <0x01>;
+=09=09=09=09phandle =3D <0x0e>;
+=09=09=09};
+=09=09};
+
+=09=09cpu@2 {
+=09=09=09compatible =3D "sifive,u74-mc", "riscv";
+=09=09=09reg =3D <0x02>;
+=09=09=09d-cache-block-size =3D <0x40>;
+=09=09=09d-cache-sets =3D <0x40>;
+=09=09=09d-cache-size =3D <0x8000>;
+=09=09=09d-tlb-sets =3D <0x01>;
+=09=09=09d-tlb-size =3D <0x28>;
+=09=09=09device_type =3D "cpu";
+=09=09=09i-cache-block-size =3D <0x40>;
+=09=09=09i-cache-sets =3D <0x40>;
+=09=09=09i-cache-size =3D <0x8000>;
+=09=09=09i-tlb-sets =3D <0x01>;
+=09=09=09i-tlb-size =3D <0x28>;
+=09=09=09mmu-type =3D "riscv,sv39";
+=09=09=09next-level-cache =3D <0x01>;
+=09=09=09riscv,isa =3D "rv64imafdc_zba_zbb";
+=09=09=09riscv,isa-base =3D "rv64i";
+=09=09=09riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zb=
b", "zicntr", "zicsr", "zifencei", "zihpm";
+=09=09=09tlb-split;
+=09=09=09operating-points-v2 =3D <0x02>;
+=09=09=09clocks =3D <0x03 0x01>;
+=09=09=09clock-names =3D "cpu";
+=09=09=09#cooling-cells =3D <0x02>;
+=09=09=09cpu-supply =3D <0x04>;
+=09=09=09phandle =3D <0x07>;
+
+=09=09=09interrupt-controller {
+=09=09=09=09compatible =3D "riscv,cpu-intc";
+=09=09=09=09bootph-pre-ram;
+=09=09=09=09interrupt-controller;
+=09=09=09=09#interrupt-cells =3D <0x01>;
+=09=09=09=09phandle =3D <0x0f>;
+=09=09=09};
+=09=09};
+
+=09=09cpu@3 {
+=09=09=09compatible =3D "sifive,u74-mc", "riscv";
+=09=09=09reg =3D <0x03>;
+=09=09=09d-cache-block-size =3D <0x40>;
+=09=09=09d-cache-sets =3D <0x40>;
+=09=09=09d-cache-size =3D <0x8000>;
+=09=09=09d-tlb-sets =3D <0x01>;
+=09=09=09d-tlb-size =3D <0x28>;
+=09=09=09device_type =3D "cpu";
+=09=09=09i-cache-block-size =3D <0x40>;
+=09=09=09i-cache-sets =3D <0x40>;
+=09=09=09i-cache-size =3D <0x8000>;
+=09=09=09i-tlb-sets =3D <0x01>;
+=09=09=09i-tlb-size =3D <0x28>;
+=09=09=09mmu-type =3D "riscv,sv39";
+=09=09=09next-level-cache =3D <0x01>;
+=09=09=09riscv,isa =3D "rv64imafdc_zba_zbb";
+=09=09=09riscv,isa-base =3D "rv64i";
+=09=09=09riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zb=
b", "zicntr", "zicsr", "zifencei", "zihpm";
+=09=09=09tlb-split;
+=09=09=09operating-points-v2 =3D <0x02>;
+=09=09=09clocks =3D <0x03 0x01>;
+=09=09=09clock-names =3D "cpu";
+=09=09=09#cooling-cells =3D <0x02>;
+=09=09=09cpu-supply =3D <0x04>;
+=09=09=09phandle =3D <0x08>;
+
+=09=09=09interrupt-controller {
+=09=09=09=09compatible =3D "riscv,cpu-intc";
+=09=09=09=09bootph-pre-ram;
+=09=09=09=09interrupt-controller;
+=09=09=09=09#interrupt-cells =3D <0x01>;
+=09=09=09=09phandle =3D <0x10>;
+=09=09=09};
+=09=09};
+
+=09=09cpu@4 {
+=09=09=09compatible =3D "sifive,u74-mc", "riscv";
+=09=09=09reg =3D <0x04>;
+=09=09=09d-cache-block-size =3D <0x40>;
+=09=09=09d-cache-sets =3D <0x40>;
+=09=09=09d-cache-size =3D <0x8000>;
+=09=09=09d-tlb-sets =3D <0x01>;
+=09=09=09d-tlb-size =3D <0x28>;
+=09=09=09device_type =3D "cpu";
+=09=09=09i-cache-block-size =3D <0x40>;
+=09=09=09i-cache-sets =3D <0x40>;
+=09=09=09i-cache-size =3D <0x8000>;
+=09=09=09i-tlb-sets =3D <0x01>;
+=09=09=09i-tlb-size =3D <0x28>;
+=09=09=09mmu-type =3D "riscv,sv39";
+=09=09=09next-level-cache =3D <0x01>;
+=09=09=09riscv,isa =3D "rv64imafdc_zba_zbb";
+=09=09=09riscv,isa-base =3D "rv64i";
+=09=09=09riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zb=
b", "zicntr", "zicsr", "zifencei", "zihpm";
+=09=09=09tlb-split;
+=09=09=09operating-points-v2 =3D <0x02>;
+=09=09=09clocks =3D <0x03 0x01>;
+=09=09=09clock-names =3D "cpu";
+=09=09=09#cooling-cells =3D <0x02>;
+=09=09=09cpu-supply =3D <0x04>;
+=09=09=09phandle =3D <0x09>;
+
+=09=09=09interrupt-controller {
+=09=09=09=09compatible =3D "riscv,cpu-intc";
+=09=09=09=09bootph-pre-ram;
+=09=09=09=09interrupt-controller;
+=09=09=09=09#interrupt-cells =3D <0x01>;
+=09=09=09=09phandle =3D <0x11>;
+=09=09=09};
+=09=09};
+
+=09=09cpu-map {
+
+=09=09=09cluster0 {
+
+=09=09=09=09core0 {
+=09=09=09=09=09cpu =3D <0x05>;
+=09=09=09=09};
+
+=09=09=09=09core1 {
+=09=09=09=09=09cpu =3D <0x06>;
+=09=09=09=09};
+
+=09=09=09=09core2 {
+=09=09=09=09=09cpu =3D <0x07>;
+=09=09=09=09};
+
+=09=09=09=09core3 {
+=09=09=09=09=09cpu =3D <0x08>;
+=09=09=09=09};
+
+=09=09=09=09core4 {
+=09=09=09=09=09cpu =3D <0x09>;
+=09=09=09=09};
+=09=09=09};
+=09=09};
+=09};
+
+=09opp-table-0 {
+=09=09compatible =3D "operating-points-v2";
+=09=09opp-shared;
+=09=09phandle =3D <0x02>;
+
+=09=09opp-375000000 {
+=09=09=09opp-hz =3D <0x00 0x165a0bc0>;
+=09=09=09opp-microvolt =3D "", "\f5";
+=09=09};
+
+=09=09opp-500000000 {
+=09=09=09opp-hz =3D <0x00 0x1dcd6500>;
+=09=09=09opp-microvolt =3D "", "\f5";
+=09=09};
+
+=09=09opp-750000000 {
+=09=09=09opp-hz =3D <0x00 0x2cb41780>;
+=09=09=09opp-microvolt =3D "", "\f5";
+=09=09};
+
+=09=09opp-1500000000 {
+=09=09=09opp-hz =3D <0x00 0x59682f00>;
+=09=09=09opp-microvolt =3D <0xfde80>;
+=09=09};
+=09};
+
+=09thermal-zones {
+
+=09=09cpu-thermal {
+=09=09=09polling-delay-passive =3D <0xfa>;
+=09=09=09polling-delay =3D <0x3a98>;
+=09=09=09thermal-sensors =3D <0x0a>;
+
+=09=09=09cooling-maps {
+
+=09=09=09=09map0 {
+=09=09=09=09=09trip =3D <0x0b>;
+=09=09=09=09=09cooling-device =3D <0x06 0xffffffff 0xffffffff 0x07 0xfffff=
fff 0xffffffff 0x08 0xffffffff 0xffffffff 0x09 0xffffffff 0xffffffff>;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09trips {
+
+=09=09=09=09cpu-alert0 {
+=09=09=09=09=09temperature =3D <0x14c08>;
+=09=09=09=09=09hysteresis =3D <0x7d0>;
+=09=09=09=09=09type =3D "passive";
+=09=09=09=09=09phandle =3D <0x0b>;
+=09=09=09=09};
+
+=09=09=09=09cpu-crit {
+=09=09=09=09=09temperature =3D <0x186a0>;
+=09=09=09=09=09hysteresis =3D <0x7d0>;
+=09=09=09=09=09type =3D "critical";
+=09=09=09=09};
+=09=09=09};
+=09=09};
+=09};
+
+=09dvp-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09clock-output-names =3D "dvp_clk";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0x46cf710>;
+=09=09phandle =3D <0x35>;
+=09};
+
+=09gmac0-rgmii-rxin-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09clock-output-names =3D "gmac0_rgmii_rxin";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0x7735940>;
+=09=09phandle =3D <0x31>;
+=09};
+
+=09gmac0-rmii-refin-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09clock-output-names =3D "gmac0_rmii_refin";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0x2faf080>;
+=09=09phandle =3D <0x30>;
+=09};
+
+=09gmac1-rgmii-rxin-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09bootph-pre-ram;
+=09=09clock-output-names =3D "gmac1_rgmii_rxin";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0x7735940>;
+=09=09phandle =3D <0x27>;
+=09};
+
+=09gmac1-rmii-refin-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09bootph-pre-ram;
+=09=09clock-output-names =3D "gmac1_rmii_refin";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0x2faf080>;
+=09=09phandle =3D <0x26>;
+=09};
+
+=09hdmitx0-pixel-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09clock-output-names =3D "hdmitx0_pixelclk";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0x11b3dc40>;
+=09=09phandle =3D <0x37>;
+=09};
+
+=09i2srx-bclk-ext-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09clock-output-names =3D "i2srx_bclk_ext";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0xbb8000>;
+=09=09phandle =3D <0x19>;
+=09};
+
+=09i2srx-lrck-ext-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09clock-output-names =3D "i2srx_lrck_ext";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0x2ee00>;
+=09=09phandle =3D <0x1a>;
+=09};
+
+=09i2stx-bclk-ext-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09clock-output-names =3D "i2stx_bclk_ext";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0xbb8000>;
+=09=09phandle =3D <0x23>;
+=09};
+
+=09i2stx-lrck-ext-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09clock-output-names =3D "i2stx_lrck_ext";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0x2ee00>;
+=09=09phandle =3D <0x24>;
+=09};
+
+=09mclk-ext-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09clock-output-names =3D "mclk_ext";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0xbb8000>;
+=09=09phandle =3D <0x18>;
+=09};
+
+=09oscillator {
+=09=09compatible =3D "fixed-clock";
+=09=09bootph-pre-ram;
+=09=09clock-output-names =3D "osc";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0x16e3600>;
+=09=09phandle =3D <0x20>;
+=09};
+
+=09rtc-oscillator {
+=09=09compatible =3D "fixed-clock";
+=09=09clock-output-names =3D "rtc_osc";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0x8000>;
+=09=09phandle =3D <0x32>;
+=09};
+
+=09stmmac-axi-config {
+=09=09snps,lpi_en;
+=09=09snps,wr_osr_lmt =3D <0x0f>;
+=09=09snps,rd_osr_lmt =3D <0x0f>;
+=09=09snps,blen =3D <0x100 0x80 0x40 0x20 0x00 0x00 0x00>;
+=09=09phandle =3D <0x2d>;
+=09};
+
+=09tdm-ext-clock {
+=09=09compatible =3D "fixed-clock";
+=09=09clock-output-names =3D "tdm_ext";
+=09=09#clock-cells =3D <0x00>;
+=09=09clock-frequency =3D <0x2ee0000>;
+=09=09phandle =3D <0x16>;
+=09};
+
+=09soc {
+=09=09compatible =3D "simple-bus";
+=09=09interrupt-parent =3D <0x0c>;
+=09=09#address-cells =3D <0x02>;
+=09=09#size-cells =3D <0x02>;
+=09=09ranges;
+
+=09=09timer@2000000 {
+=09=09=09compatible =3D "starfive,jh7110-clint", "sifive,clint0";
+=09=09=09reg =3D <0x00 0x2000000 0x00 0x10000>;
+=09=09=09bootph-pre-ram;
+=09=09=09interrupts-extended =3D <0x0d 0x03 0x0d 0x07 0x0e 0x03 0x0e 0x07 =
0x0f 0x03 0x0f 0x07 0x10 0x03 0x10 0x07 0x11 0x03 0x11 0x07>;
+=09=09=09phandle =3D <0x44>;
+=09=09};
+
+=09=09cache-controller@2010000 {
+=09=09=09compatible =3D "starfive,jh7110-ccache", "sifive,ccache0", "cache=
";
+=09=09=09reg =3D <0x00 0x2010000 0x00 0x4000>;
+=09=09=09interrupts =3D <0x01 0x03 0x04 0x02>;
+=09=09=09cache-block-size =3D <0x40>;
+=09=09=09cache-level =3D <0x02>;
+=09=09=09cache-sets =3D <0x800>;
+=09=09=09cache-size =3D <0x200000>;
+=09=09=09cache-unified;
+=09=09=09phandle =3D <0x01>;
+=09=09};
+
+=09=09interrupt-controller@c000000 {
+=09=09=09compatible =3D "starfive,jh7110-plic", "sifive,plic-1.0.0";
+=09=09=09reg =3D <0x00 0xc000000 0x00 0x4000000>;
+=09=09=09interrupts-extended =3D <0x0d 0x0b 0x0e 0x0b 0x0e 0x09 0x0f 0x0b =
0x0f 0x09 0x10 0x0b 0x10 0x09 0x11 0x0b 0x11 0x09>;
+=09=09=09interrupt-controller;
+=09=09=09#interrupt-cells =3D <0x01>;
+=09=09=09#address-cells =3D <0x00>;
+=09=09=09riscv,ndev =3D <0x88>;
+=09=09=09phandle =3D <0x0c>;
+=09=09};
+
+=09=09serial@10000000 {
+=09=09=09compatible =3D "starfive,jh7110-uart", "snps,dw-apb-uart";
+=09=09=09reg =3D <0x00 0x10000000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x92 0x03 0x91>;
+=09=09=09clock-names =3D "baudclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x53 0x03 0x54>;
+=09=09=09interrupts =3D <0x20>;
+=09=09=09reg-io-width =3D <0x04>;
+=09=09=09reg-shift =3D <0x02>;
+=09=09=09status =3D "okay";
+=09=09=09bootph-pre-ram;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x12>;
+=09=09=09phandle =3D <0x45>;
+=09=09};
+
+=09=09serial@10010000 {
+=09=09=09compatible =3D "starfive,jh7110-uart", "snps,dw-apb-uart";
+=09=09=09reg =3D <0x00 0x10010000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x94 0x03 0x93>;
+=09=09=09clock-names =3D "baudclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x55 0x03 0x56>;
+=09=09=09interrupts =3D <0x21>;
+=09=09=09reg-io-width =3D <0x04>;
+=09=09=09reg-shift =3D <0x02>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x46>;
+=09=09};
+
+=09=09serial@10020000 {
+=09=09=09compatible =3D "starfive,jh7110-uart", "snps,dw-apb-uart";
+=09=09=09reg =3D <0x00 0x10020000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x96 0x03 0x95>;
+=09=09=09clock-names =3D "baudclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x57 0x03 0x58>;
+=09=09=09interrupts =3D <0x22>;
+=09=09=09reg-io-width =3D <0x04>;
+=09=09=09reg-shift =3D <0x02>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x47>;
+=09=09};
+
+=09=09i2c@10030000 {
+=09=09=09compatible =3D "snps,designware-i2c";
+=09=09=09reg =3D <0x00 0x10030000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x8a>;
+=09=09=09clock-names =3D "ref";
+=09=09=09resets =3D <0x03 0x4c>;
+=09=09=09interrupts =3D <0x23>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09clock-frequency =3D <0x186a0>;
+=09=09=09i2c-sda-hold-time-ns =3D <0x12c>;
+=09=09=09i2c-sda-falling-time-ns =3D <0x1fe>;
+=09=09=09i2c-scl-falling-time-ns =3D <0x1fe>;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x13>;
+=09=09=09phandle =3D <0x48>;
+=09=09};
+
+=09=09i2c@10040000 {
+=09=09=09compatible =3D "snps,designware-i2c";
+=09=09=09reg =3D <0x00 0x10040000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x8b>;
+=09=09=09clock-names =3D "ref";
+=09=09=09resets =3D <0x03 0x4d>;
+=09=09=09interrupts =3D <0x24>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x49>;
+=09=09};
+
+=09=09i2c@10050000 {
+=09=09=09compatible =3D "snps,designware-i2c";
+=09=09=09reg =3D <0x00 0x10050000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x8c>;
+=09=09=09clock-names =3D "ref";
+=09=09=09resets =3D <0x03 0x4e>;
+=09=09=09interrupts =3D <0x25>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "okay";
+=09=09=09clock-frequency =3D <0x186a0>;
+=09=09=09i2c-sda-hold-time-ns =3D <0x12c>;
+=09=09=09i2c-sda-falling-time-ns =3D <0x1fe>;
+=09=09=09i2c-scl-falling-time-ns =3D <0x1fe>;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x14>;
+=09=09=09phandle =3D <0x4a>;
+=09=09};
+
+=09=09spi@10060000 {
+=09=09=09compatible =3D "arm,pl022", "arm,primecell";
+=09=09=09reg =3D <0x00 0x10060000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x83 0x03 0x83>;
+=09=09=09clock-names =3D "sspclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x45>;
+=09=09=09interrupts =3D <0x26>;
+=09=09=09arm,primecell-periphid =3D <0x41022>;
+=09=09=09num-cs =3D <0x01>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x15>;
+=09=09=09phandle =3D <0x4b>;
+=09=09};
+
+=09=09spi@10070000 {
+=09=09=09compatible =3D "arm,pl022", "arm,primecell";
+=09=09=09reg =3D <0x00 0x10070000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x84 0x03 0x84>;
+=09=09=09clock-names =3D "sspclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x46>;
+=09=09=09interrupts =3D <0x27>;
+=09=09=09arm,primecell-periphid =3D <0x41022>;
+=09=09=09num-cs =3D <0x01>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x4c>;
+=09=09};
+
+=09=09spi@10080000 {
+=09=09=09compatible =3D "arm,pl022", "arm,primecell";
+=09=09=09reg =3D <0x00 0x10080000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x85 0x03 0x85>;
+=09=09=09clock-names =3D "sspclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x47>;
+=09=09=09interrupts =3D <0x28>;
+=09=09=09arm,primecell-periphid =3D <0x41022>;
+=09=09=09num-cs =3D <0x01>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x4d>;
+=09=09};
+
+=09=09tdm@10090000 {
+=09=09=09compatible =3D "starfive,jh7110-tdm";
+=09=09=09reg =3D <0x00 0x10090000 0x00 0x1000>;
+=09=09=09clocks =3D <0x03 0xb8 0x03 0xb9 0x03 0xba 0x03 0xbb 0x03 0x11 0x1=
6>;
+=09=09=09clock-names =3D "tdm_ahb", "tdm_apb", "tdm_internal", "tdm", "mcl=
k_inner", "tdm_ext";
+=09=09=09resets =3D <0x03 0x69 0x03 0x6b 0x03 0x6a>;
+=09=09=09dmas =3D <0x17 0x14 0x17 0x15>;
+=09=09=09dma-names =3D "rx", "tx";
+=09=09=09#sound-dai-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x4e>;
+=09=09};
+
+=09=09i2s@100e0000 {
+=09=09=09compatible =3D "starfive,jh7110-i2srx";
+=09=09=09reg =3D <0x00 0x100e0000 0x00 0x1000>;
+=09=09=09clocks =3D <0x03 0xb0 0x03 0xaf 0x03 0x12 0x03 0x11 0x18 0x03 0xb=
3 0x03 0xb5 0x19 0x1a>;
+=09=09=09clock-names =3D "i2sclk", "apb", "mclk", "mclk_inner", "mclk_ext"=
, "bclk", "lrck", "bclk_ext", "lrck_ext";
+=09=09=09resets =3D <0x03 0x63 0x03 0x64>;
+=09=09=09dmas =3D <0x00 0x17 0x18>;
+=09=09=09dma-names =3D "tx", "rx";
+=09=09=09starfive,syscon =3D <0x1b 0x18 0x02>;
+=09=09=09#sound-dai-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x4f>;
+=09=09};
+
+=09=09pwmdac@100b0000 {
+=09=09=09compatible =3D "starfive,jh7110-pwmdac";
+=09=09=09reg =3D <0x00 0x100b0000 0x00 0x1000>;
+=09=09=09clocks =3D <0x03 0x9d 0x03 0x9e>;
+=09=09=09clock-names =3D "apb", "core";
+=09=09=09resets =3D <0x03 0x60>;
+=09=09=09dmas =3D <0x17 0x16>;
+=09=09=09dma-names =3D "tx";
+=09=09=09#sound-dai-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x1c>;
+=09=09=09phandle =3D <0x41>;
+=09=09};
+
+=09=09usb@10100000 {
+=09=09=09compatible =3D "starfive,jh7110-usb";
+=09=09=09ranges =3D <0x00 0x00 0x10100000 0x100000>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x01>;
+=09=09=09starfive,stg-syscon =3D <0x1d 0x04>;
+=09=09=09clocks =3D <0x1e 0x04 0x1e 0x05 0x1e 0x01 0x1e 0x03 0x1e 0x02>;
+=09=09=09clock-names =3D "lpm", "stb", "apb", "axi", "utmi_apb";
+=09=09=09resets =3D <0x1e 0x0a 0x1e 0x08 0x1e 0x07 0x1e 0x09>;
+=09=09=09reset-names =3D "pwrup", "apb", "axi", "utmi_apb";
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x50>;
+
+=09=09=09usb@0 {
+=09=09=09=09compatible =3D "cdns,usb3";
+=09=09=09=09reg =3D <0x00 0x10000 0x10000 0x10000 0x20000 0x10000>;
+=09=09=09=09reg-names =3D "otg", "xhci", "dev";
+=09=09=09=09interrupts =3D <0x64 0x6c 0x6e>;
+=09=09=09=09interrupt-names =3D "host", "peripheral", "otg";
+=09=09=09=09phys =3D <0x1f>;
+=09=09=09=09phy-names =3D "cdns3,usb2-phy";
+=09=09=09=09phandle =3D <0x51>;
+=09=09=09};
+=09=09};
+
+=09=09phy@10200000 {
+=09=09=09compatible =3D "starfive,jh7110-usb-phy";
+=09=09=09reg =3D <0x00 0x10200000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x5f 0x1e 0x06>;
+=09=09=09clock-names =3D "125m", "app_125m";
+=09=09=09#phy-cells =3D <0x00>;
+=09=09=09phandle =3D <0x1f>;
+=09=09};
+
+=09=09phy@10210000 {
+=09=09=09compatible =3D "starfive,jh7110-pcie-phy";
+=09=09=09reg =3D <0x00 0x10210000 0x00 0x10000>;
+=09=09=09starfive,sys-syscon =3D <0x1b 0x18>;
+=09=09=09starfive,stg-syscon =3D <0x1d 0x148 0x1f4>;
+=09=09=09#phy-cells =3D <0x00>;
+=09=09=09phandle =3D <0x3a>;
+=09=09};
+
+=09=09phy@10220000 {
+=09=09=09compatible =3D "starfive,jh7110-pcie-phy";
+=09=09=09reg =3D <0x00 0x10220000 0x00 0x10000>;
+=09=09=09#phy-cells =3D <0x00>;
+=09=09=09phandle =3D <0x3d>;
+=09=09};
+
+=09=09clock-controller@10230000 {
+=09=09=09compatible =3D "starfive,jh7110-stgcrg";
+=09=09=09reg =3D <0x00 0x10230000 0x00 0x10000>;
+=09=09=09clocks =3D <0x20 0x03 0x36 0x03 0x08 0x03 0x5f 0x03 0x02 0x03 0x3=
7 0x03 0x06 0x03 0x0b>;
+=09=09=09clock-names =3D "osc", "hifi4_core", "stg_axiahb", "usb_125m", "c=
pu_bus", "hifi4_axi", "nocstg_bus", "apb_bus";
+=09=09=09#clock-cells =3D <0x01>;
+=09=09=09#reset-cells =3D <0x01>;
+=09=09=09phandle =3D <0x1e>;
+=09=09};
+
+=09=09syscon@10240000 {
+=09=09=09compatible =3D "starfive,jh7110-stg-syscon", "syscon";
+=09=09=09reg =3D <0x00 0x10240000 0x00 0x1000>;
+=09=09=09phandle =3D <0x1d>;
+=09=09};
+
+=09=09serial@12000000 {
+=09=09=09compatible =3D "starfive,jh7110-uart", "snps,dw-apb-uart";
+=09=09=09reg =3D <0x00 0x12000000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x98 0x03 0x97>;
+=09=09=09clock-names =3D "baudclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x59 0x03 0x5a>;
+=09=09=09interrupts =3D <0x2d>;
+=09=09=09reg-io-width =3D <0x04>;
+=09=09=09reg-shift =3D <0x02>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x52>;
+=09=09};
+
+=09=09serial@12010000 {
+=09=09=09compatible =3D "starfive,jh7110-uart", "snps,dw-apb-uart";
+=09=09=09reg =3D <0x00 0x12010000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x9a 0x03 0x99>;
+=09=09=09clock-names =3D "baudclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x5b 0x03 0x5c>;
+=09=09=09interrupts =3D <0x2e>;
+=09=09=09reg-io-width =3D <0x04>;
+=09=09=09reg-shift =3D <0x02>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x53>;
+=09=09};
+
+=09=09serial@12020000 {
+=09=09=09compatible =3D "starfive,jh7110-uart", "snps,dw-apb-uart";
+=09=09=09reg =3D <0x00 0x12020000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x9c 0x03 0x9b>;
+=09=09=09clock-names =3D "baudclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x5d 0x03 0x5e>;
+=09=09=09interrupts =3D <0x2f>;
+=09=09=09reg-io-width =3D <0x04>;
+=09=09=09reg-shift =3D <0x02>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x54>;
+=09=09};
+
+=09=09i2c@12030000 {
+=09=09=09compatible =3D "snps,designware-i2c";
+=09=09=09reg =3D <0x00 0x12030000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x8d>;
+=09=09=09clock-names =3D "ref";
+=09=09=09resets =3D <0x03 0x4f>;
+=09=09=09interrupts =3D <0x30>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x55>;
+=09=09};
+
+=09=09i2c@12040000 {
+=09=09=09compatible =3D "snps,designware-i2c";
+=09=09=09reg =3D <0x00 0x12040000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x8e>;
+=09=09=09clock-names =3D "ref";
+=09=09=09resets =3D <0x03 0x50>;
+=09=09=09interrupts =3D <0x31>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x56>;
+=09=09};
+
+=09=09i2c@12050000 {
+=09=09=09compatible =3D "snps,designware-i2c";
+=09=09=09reg =3D <0x00 0x12050000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x8f>;
+=09=09=09clock-names =3D "ref";
+=09=09=09resets =3D <0x03 0x51>;
+=09=09=09interrupts =3D <0x32>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "okay";
+=09=09=09clock-frequency =3D <0x186a0>;
+=09=09=09i2c-sda-hold-time-ns =3D <0x12c>;
+=09=09=09i2c-sda-falling-time-ns =3D <0x1fe>;
+=09=09=09i2c-scl-falling-time-ns =3D <0x1fe>;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x21>;
+=09=09=09phandle =3D <0x57>;
+
+=09=09=09pmic@36 {
+=09=09=09=09compatible =3D "x-powers,axp15060";
+=09=09=09=09reg =3D <0x36>;
+=09=09=09=09interrupt-controller;
+=09=09=09=09#interrupt-cells =3D <0x01>;
+=09=09=09=09phandle =3D <0x58>;
+
+=09=09=09=09regulators {
+
+=09=09=09=09=09dcdc1 {
+=09=09=09=09=09=09regulator-boot-on;
+=09=09=09=09=09=09regulator-always-on;
+=09=09=09=09=09=09regulator-min-microvolt =3D <0x325aa0>;
+=09=09=09=09=09=09regulator-max-microvolt =3D <0x325aa0>;
+=09=09=09=09=09=09regulator-name =3D "vcc_3v3";
+=09=09=09=09=09=09phandle =3D <0x59>;
+=09=09=09=09=09};
+
+=09=09=09=09=09dcdc2 {
+=09=09=09=09=09=09regulator-always-on;
+=09=09=09=09=09=09regulator-min-microvolt =3D <0x7a120>;
+=09=09=09=09=09=09regulator-max-microvolt =3D <0x177fa0>;
+=09=09=09=09=09=09regulator-name =3D "vdd_cpu";
+=09=09=09=09=09=09phandle =3D <0x04>;
+=09=09=09=09=09};
+
+=09=09=09=09=09aldo4 {
+=09=09=09=09=09=09regulator-boot-on;
+=09=09=09=09=09=09regulator-always-on;
+=09=09=09=09=09=09regulator-min-microvolt =3D <0x1b7740>;
+=09=09=09=09=09=09regulator-max-microvolt =3D <0x325aa0>;
+=09=09=09=09=09=09regulator-name =3D "emmc_vdd";
+=09=09=09=09=09=09phandle =3D <0x5a>;
+=09=09=09=09=09};
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09eeprom@50 {
+=09=09=09=09compatible =3D "atmel,24c04";
+=09=09=09=09reg =3D <0x50>;
+=09=09=09=09bootph-pre-ram;
+=09=09=09=09pagesize =3D <0x10>;
+=09=09=09};
+=09=09};
+
+=09=09i2c@12060000 {
+=09=09=09compatible =3D "snps,designware-i2c";
+=09=09=09reg =3D <0x00 0x12060000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x90>;
+=09=09=09clock-names =3D "ref";
+=09=09=09resets =3D <0x03 0x52>;
+=09=09=09interrupts =3D <0x33>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "okay";
+=09=09=09clock-frequency =3D <0x186a0>;
+=09=09=09i2c-sda-hold-time-ns =3D <0x12c>;
+=09=09=09i2c-sda-falling-time-ns =3D <0x1fe>;
+=09=09=09i2c-scl-falling-time-ns =3D <0x1fe>;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x22>;
+=09=09=09phandle =3D <0x5b>;
+=09=09};
+
+=09=09spi@12070000 {
+=09=09=09compatible =3D "arm,pl022", "arm,primecell";
+=09=09=09reg =3D <0x00 0x12070000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x86 0x03 0x86>;
+=09=09=09clock-names =3D "sspclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x48>;
+=09=09=09interrupts =3D <0x34>;
+=09=09=09arm,primecell-periphid =3D <0x41022>;
+=09=09=09num-cs =3D <0x01>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x5c>;
+=09=09};
+
+=09=09spi@12080000 {
+=09=09=09compatible =3D "arm,pl022", "arm,primecell";
+=09=09=09reg =3D <0x00 0x12080000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x87 0x03 0x87>;
+=09=09=09clock-names =3D "sspclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x49>;
+=09=09=09interrupts =3D <0x35>;
+=09=09=09arm,primecell-periphid =3D <0x41022>;
+=09=09=09num-cs =3D <0x01>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x5d>;
+=09=09};
+
+=09=09spi@12090000 {
+=09=09=09compatible =3D "arm,pl022", "arm,primecell";
+=09=09=09reg =3D <0x00 0x12090000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x88 0x03 0x88>;
+=09=09=09clock-names =3D "sspclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x4a>;
+=09=09=09interrupts =3D <0x36>;
+=09=09=09arm,primecell-periphid =3D <0x41022>;
+=09=09=09num-cs =3D <0x01>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x5e>;
+=09=09};
+
+=09=09spi@120a0000 {
+=09=09=09compatible =3D "arm,pl022", "arm,primecell";
+=09=09=09reg =3D <0x00 0x120a0000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x89 0x03 0x89>;
+=09=09=09clock-names =3D "sspclk", "apb_pclk";
+=09=09=09resets =3D <0x03 0x4b>;
+=09=09=09interrupts =3D <0x37>;
+=09=09=09arm,primecell-periphid =3D <0x41022>;
+=09=09=09num-cs =3D <0x01>;
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x5f>;
+=09=09};
+
+=09=09i2s@120b0000 {
+=09=09=09compatible =3D "starfive,jh7110-i2stx0";
+=09=09=09reg =3D <0x00 0x120b0000 0x00 0x1000>;
+=09=09=09clocks =3D <0x03 0xa2 0x03 0xa1 0x03 0x12 0x03 0x11 0x18>;
+=09=09=09clock-names =3D "i2sclk", "apb", "mclk", "mclk_inner", "mclk_ext"=
;
+=09=09=09resets =3D <0x03 0x65 0x03 0x66>;
+=09=09=09dmas =3D <0x17 0x2f>;
+=09=09=09dma-names =3D "tx";
+=09=09=09#sound-dai-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x60>;
+=09=09};
+
+=09=09i2s@120c0000 {
+=09=09=09compatible =3D "starfive,jh7110-i2stx1";
+=09=09=09reg =3D <0x00 0x120c0000 0x00 0x1000>;
+=09=09=09clocks =3D <0x03 0xa9 0x03 0xa8 0x03 0x12 0x03 0x11 0x18 0x03 0xa=
c 0x03 0xae 0x23 0x24>;
+=09=09=09clock-names =3D "i2sclk", "apb", "mclk", "mclk_inner", "mclk_ext"=
, "bclk", "lrck", "bclk_ext", "lrck_ext";
+=09=09=09resets =3D <0x03 0x67 0x03 0x68>;
+=09=09=09dmas =3D <0x17 0x30>;
+=09=09=09dma-names =3D "tx";
+=09=09=09#sound-dai-cells =3D <0x00>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x61>;
+=09=09};
+
+=09=09pwm@120d0000 {
+=09=09=09compatible =3D "starfive,jh7110-pwm", "opencores,pwm-v1";
+=09=09=09reg =3D <0x00 0x120d0000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x79>;
+=09=09=09resets =3D <0x03 0x6c>;
+=09=09=09#pwm-cells =3D <0x03>;
+=09=09=09status =3D "disabled";
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x25>;
+=09=09=09phandle =3D <0x62>;
+=09=09};
+
+=09=09temperature-sensor@120e0000 {
+=09=09=09compatible =3D "starfive,jh7110-temp";
+=09=09=09reg =3D <0x00 0x120e0000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x82 0x03 0x81>;
+=09=09=09clock-names =3D "sense", "bus";
+=09=09=09resets =3D <0x03 0x7c 0x03 0x7b>;
+=09=09=09reset-names =3D "sense", "bus";
+=09=09=09#thermal-sensor-cells =3D <0x00>;
+=09=09=09phandle =3D <0x0a>;
+=09=09};
+
+=09=09spi@13010000 {
+=09=09=09compatible =3D "starfive,jh7110-qspi", "cdns,qspi-nor";
+=09=09=09reg =3D <0x00 0x13010000 0x00 0x10000 0x00 0x21000000 0x00 0x4000=
00>;
+=09=09=09interrupts =3D <0x19>;
+=09=09=09clocks =3D <0x03 0x5a 0x03 0x57 0x03 0x58>;
+=09=09=09clock-names =3D "ref", "ahb", "apb";
+=09=09=09resets =3D <0x03 0x3e 0x03 0x3d 0x03 0x3f>;
+=09=09=09reset-names =3D "qspi", "qspi-ocp", "rstc_ref";
+=09=09=09cdns,fifo-depth =3D <0x100>;
+=09=09=09cdns,fifo-width =3D <0x04>;
+=09=09=09cdns,trigger-address =3D <0x00>;
+=09=09=09status =3D "okay";
+=09=09=09#address-cells =3D <0x01>;
+=09=09=09#size-cells =3D <0x00>;
+=09=09=09phandle =3D <0x63>;
+
+=09=09=09flash@0 {
+=09=09=09=09compatible =3D "jedec,spi-nor";
+=09=09=09=09reg =3D <0x00>;
+=09=09=09=09bootph-pre-ram;
+=09=09=09=09cdns,read-delay =3D <0x02>;
+=09=09=09=09spi-max-frequency =3D <0x5f5e100>;
+=09=09=09=09cdns,tshsl-ns =3D <0x01>;
+=09=09=09=09cdns,tsd2d-ns =3D <0x01>;
+=09=09=09=09cdns,tchsh-ns =3D <0x01>;
+=09=09=09=09cdns,tslch-ns =3D <0x01>;
+=09=09=09=09phandle =3D <0x64>;
+
+=09=09=09=09partitions {
+=09=09=09=09=09compatible =3D "fixed-partitions";
+=09=09=09=09=09#address-cells =3D <0x01>;
+=09=09=09=09=09#size-cells =3D <0x01>;
+
+=09=09=09=09=09spl@0 {
+=09=09=09=09=09=09reg =3D <0x00 0xf0000>;
+=09=09=09=09=09};
+
+=09=09=09=09=09uboot-env@f0000 {
+=09=09=09=09=09=09reg =3D <0xf0000 0x10000>;
+=09=09=09=09=09};
+
+=09=09=09=09=09uboot@100000 {
+=09=09=09=09=09=09reg =3D <0x100000 0xf00000>;
+=09=09=09=09=09};
+=09=09=09=09};
+=09=09=09};
+=09=09};
+
+=09=09clock-controller@13020000 {
+=09=09=09compatible =3D "starfive,jh7110-syscrg";
+=09=09=09reg =3D <0x00 0x13020000 0x00 0x10000>;
+=09=09=09bootph-pre-ram;
+=09=09=09clocks =3D <0x20 0x26 0x27 0x23 0x24 0x19 0x1a 0x16 0x18 0x28 0x0=
0 0x28 0x01 0x28 0x02>;
+=09=09=09clock-names =3D "osc", "gmac1_rmii_refin", "gmac1_rgmii_rxin", "i=
2stx_bclk_ext", "i2stx_lrck_ext", "i2srx_bclk_ext", "i2srx_lrck_ext", "tdm_=
ext", "mclk_ext", "pll0_out", "pll1_out", "pll2_out";
+=09=09=09#clock-cells =3D <0x01>;
+=09=09=09#reset-cells =3D <0x01>;
+=09=09=09assigned-clocks =3D <0x03 0x00 0x03 0x05 0x03 0x04 0x03 0x5a 0x03=
 0x01 0x28 0x00>;
+=09=09=09assigned-clock-parents =3D <0x28 0x00 0x28 0x02 0x28 0x02 0x03 0x=
59>;
+=09=09=09assigned-clock-rates =3D <0x00 0x00 0x00 0x00 0x1dcd6500 0x59682f=
00>;
+=09=09=09phandle =3D <0x03>;
+=09=09};
+
+=09=09syscon@13030000 {
+=09=09=09compatible =3D "starfive,jh7110-sys-syscon", "syscon", "simple-mf=
d";
+=09=09=09reg =3D <0x00 0x13030000 0x00 0x1000>;
+=09=09=09phandle =3D <0x1b>;
+
+=09=09=09clock-controller {
+=09=09=09=09compatible =3D "starfive,jh7110-pll";
+=09=09=09=09bootph-pre-ram;
+=09=09=09=09clocks =3D <0x20>;
+=09=09=09=09#clock-cells =3D <0x01>;
+=09=09=09=09phandle =3D <0x28>;
+=09=09=09};
+=09=09};
+
+=09=09pinctrl@13040000 {
+=09=09=09compatible =3D "starfive,jh7110-sys-pinctrl";
+=09=09=09reg =3D <0x00 0x13040000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x70>;
+=09=09=09resets =3D <0x03 0x02>;
+=09=09=09interrupts =3D <0x56>;
+=09=09=09interrupt-controller;
+=09=09=09#interrupt-cells =3D <0x02>;
+=09=09=09gpio-controller;
+=09=09=09#gpio-cells =3D <0x02>;
+=09=09=09phandle =3D <0x39>;
+
+=09=09=09i2c0-0 {
+=09=09=09=09phandle =3D <0x13>;
+
+=09=09=09=09i2c-pins {
+=09=09=09=09=09pinmux =3D <0x9001439 0xa00183a>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09=09input-enable;
+=09=09=09=09=09input-schmitt-enable;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09i2c2-0 {
+=09=09=09=09phandle =3D <0x14>;
+
+=09=09=09=09i2c-pins {
+=09=09=09=09=09pinmux =3D <0x3b007803 0x3c007c02>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09=09input-enable;
+=09=09=09=09=09input-schmitt-enable;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09i2c5-0 {
+=09=09=09=09bootph-pre-ram;
+=09=09=09=09phandle =3D <0x21>;
+
+=09=09=09=09i2c-pins {
+=09=09=09=09=09pinmux =3D <0x4f00a813 0x5000ac14>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09=09bootph-pre-ram;
+=09=09=09=09=09input-enable;
+=09=09=09=09=09input-schmitt-enable;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09i2c6-0 {
+=09=09=09=09phandle =3D <0x22>;
+
+=09=09=09=09i2c-pins {
+=09=09=09=09=09pinmux =3D <0x5600b810 0x5700bc11>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09=09input-enable;
+=09=09=09=09=09input-schmitt-enable;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09mmc0-0 {
+=09=09=09=09phandle =3D <0x2a>;
+
+=09=09=09=09mmc-pins {
+=09=09=09=09=09pinmux =3D <0x440 0x441 0x442 0x443 0x444 0x445 0x446 0x447=
 0x448 0x449>;
+=09=09=09=09=09bias-pull-up;
+=09=09=09=09=09drive-strength =3D <0x0c>;
+=09=09=09=09=09input-enable;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09mmc1-0 {
+=09=09=09=09phandle =3D <0x2b>;
+
+=09=09=09=09clk-pins {
+=09=09=09=09=09pinmux =3D <0xff37000a>;
+=09=09=09=09=09bias-pull-up;
+=09=09=09=09=09drive-strength =3D <0x0c>;
+=09=09=09=09=09input-disable;
+=09=09=09=09=09input-schmitt-disable;
+=09=09=09=09=09slew-rate =3D <0x00>;
+=09=09=09=09};
+
+=09=09=09=09mmc-pins {
+=09=09=09=09=09pinmux =3D <0x2c394c09 0x2d3a500b 0x2e3b540c 0x2f3c5807 0x3=
03d5c08>;
+=09=09=09=09=09bias-pull-up;
+=09=09=09=09=09drive-strength =3D <0x0c>;
+=09=09=09=09=09input-enable;
+=09=09=09=09=09input-schmitt-enable;
+=09=09=09=09=09slew-rate =3D <0x00>;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09pcie0-0 {
+=09=09=09=09phandle =3D <0x3b>;
+
+=09=09=09=09clkreq-pins {
+=09=09=09=09=09pinmux =3D <0xff00041b>;
+=09=09=09=09=09bias-pull-down;
+=09=09=09=09=09drive-strength =3D <0x02>;
+=09=09=09=09=09input-enable;
+=09=09=09=09=09input-schmitt-disable;
+=09=09=09=09=09slew-rate =3D <0x00>;
+=09=09=09=09};
+
+=09=09=09=09wake-pins {
+=09=09=09=09=09pinmux =3D <0xff000420>;
+=09=09=09=09=09bias-pull-up;
+=09=09=09=09=09drive-strength =3D <0x02>;
+=09=09=09=09=09input-enable;
+=09=09=09=09=09input-schmitt-disable;
+=09=09=09=09=09slew-rate =3D <0x00>;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09pcie1-0 {
+=09=09=09=09phandle =3D <0x3e>;
+
+=09=09=09=09clkreq-pins {
+=09=09=09=09=09pinmux =3D <0xff00041d>;
+=09=09=09=09=09bias-pull-down;
+=09=09=09=09=09drive-strength =3D <0x02>;
+=09=09=09=09=09input-enable;
+=09=09=09=09=09input-schmitt-disable;
+=09=09=09=09=09slew-rate =3D <0x00>;
+=09=09=09=09};
+
+=09=09=09=09wake-pins {
+=09=09=09=09=09pinmux =3D <0xff000415>;
+=09=09=09=09=09bias-pull-up;
+=09=09=09=09=09drive-strength =3D <0x02>;
+=09=09=09=09=09input-enable;
+=09=09=09=09=09input-schmitt-disable;
+=09=09=09=09=09slew-rate =3D <0x00>;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09pwmdac-0 {
+=09=09=09=09phandle =3D <0x1c>;
+
+=09=09=09=09pwmdac-pins {
+=09=09=09=09=09pinmux =3D <0xff1c0021 0xff1d0022>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09=09drive-strength =3D <0x02>;
+=09=09=09=09=09input-disable;
+=09=09=09=09=09input-schmitt-disable;
+=09=09=09=09=09slew-rate =3D <0x00>;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09pwm-0 {
+=09=09=09=09phandle =3D <0x25>;
+
+=09=09=09=09pwm-pins {
+=09=09=09=09=09pinmux =3D <0xff18242e 0xff19283b>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09=09drive-strength =3D <0x0c>;
+=09=09=09=09=09input-disable;
+=09=09=09=09=09input-schmitt-disable;
+=09=09=09=09=09slew-rate =3D <0x00>;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09spi0-0 {
+=09=09=09=09phandle =3D <0x15>;
+
+=09=09=09=09mosi-pins {
+=09=09=09=09=09pinmux =3D <0xff200034>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09=09input-disable;
+=09=09=09=09=09input-schmitt-disable;
+=09=09=09=09};
+
+=09=09=09=09miso-pins {
+=09=09=09=09=09pinmux =3D <0x1c000435>;
+=09=09=09=09=09bias-pull-up;
+=09=09=09=09=09input-enable;
+=09=09=09=09=09input-schmitt-enable;
+=09=09=09=09};
+
+=09=09=09=09sck-pins {
+=09=09=09=09=09pinmux =3D <0x1a1e0030>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09=09input-disable;
+=09=09=09=09=09input-schmitt-disable;
+=09=09=09=09};
+
+=09=09=09=09ss-pins {
+=09=09=09=09=09pinmux =3D <0x1b1f0031>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09=09input-disable;
+=09=09=09=09=09input-schmitt-disable;
+=09=09=09=09};
+=09=09=09};
+
+=09=09=09uart0-0 {
+=09=09=09=09phandle =3D <0x12>;
+
+=09=09=09=09tx-pins {
+=09=09=09=09=09pinmux =3D <0xff140005>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09=09drive-strength =3D <0x0c>;
+=09=09=09=09=09input-disable;
+=09=09=09=09=09input-schmitt-disable;
+=09=09=09=09=09slew-rate =3D <0x00>;
+=09=09=09=09};
+
+=09=09=09=09rx-pins {
+=09=09=09=09=09pinmux =3D <0xe000406>;
+=09=09=09=09=09bias-disable;
+=09=09=09=09=09drive-strength =3D <0x02>;
+=09=09=09=09=09input-enable;
+=09=09=09=09=09input-schmitt-enable;
+=09=09=09=09=09slew-rate =3D <0x00>;
+=09=09=09=09};
+=09=09=09};
+=09=09};
+
+=09=09watchdog@13070000 {
+=09=09=09compatible =3D "starfive,jh7110-wdt";
+=09=09=09reg =3D <0x00 0x13070000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x7a 0x03 0x7b>;
+=09=09=09clock-names =3D "apb", "core";
+=09=09=09resets =3D <0x03 0x6d 0x03 0x6e>;
+=09=09};
+
+=09=09memory-controller@15700000 {
+=09=09=09compatible =3D "starfive,jh7110-dmc";
+=09=09=09reg =3D <0x00 0x15700000 0x00 0x10000 0x00 0x13000000 0x00 0x1000=
0>;
+=09=09=09bootph-pre-ram;
+=09=09=09clocks =3D <0x03 0x01>;
+=09=09=09clock-names =3D "pll";
+=09=09=09resets =3D <0x03 0x26 0x03 0x27 0x03 0x28>;
+=09=09=09reset-names =3D "axi", "osc", "apb";
+=09=09};
+
+=09=09crypto@16000000 {
+=09=09=09compatible =3D "starfive,jh7110-crypto";
+=09=09=09reg =3D <0x00 0x16000000 0x00 0x4000>;
+=09=09=09clocks =3D <0x1e 0x0f 0x1e 0x10>;
+=09=09=09clock-names =3D "hclk", "ahb";
+=09=09=09interrupts =3D <0x1c>;
+=09=09=09resets =3D <0x1e 0x03>;
+=09=09=09dmas =3D <0x29 0x01 0x02 0x29 0x00 0x02>;
+=09=09=09dma-names =3D "tx", "rx";
+=09=09=09phandle =3D <0x65>;
+=09=09};
+
+=09=09dma-controller@16008000 {
+=09=09=09compatible =3D "arm,pl080", "arm,primecell";
+=09=09=09arm,primecell-periphid =3D <0x41080>;
+=09=09=09reg =3D <0x00 0x16008000 0x00 0x4000>;
+=09=09=09interrupts =3D <0x1d>;
+=09=09=09clocks =3D <0x1e 0x0f>;
+=09=09=09clock-names =3D "apb_pclk";
+=09=09=09resets =3D <0x1e 0x03>;
+=09=09=09lli-bus-interface-ahb1;
+=09=09=09mem-bus-interface-ahb1;
+=09=09=09memcpy-burst-size =3D <0x100>;
+=09=09=09memcpy-bus-width =3D <0x20>;
+=09=09=09#dma-cells =3D <0x02>;
+=09=09=09phandle =3D <0x29>;
+=09=09};
+
+=09=09rng@1600c000 {
+=09=09=09compatible =3D "starfive,jh7110-trng";
+=09=09=09reg =3D <0x00 0x1600c000 0x00 0x4000>;
+=09=09=09clocks =3D <0x1e 0x0f 0x1e 0x10>;
+=09=09=09clock-names =3D "hclk", "ahb";
+=09=09=09resets =3D <0x1e 0x03>;
+=09=09=09interrupts =3D <0x1e>;
+=09=09=09phandle =3D <0x66>;
+=09=09};
+
+=09=09mmc@16010000 {
+=09=09=09compatible =3D "starfive,jh7110-mmc";
+=09=09=09reg =3D <0x00 0x16010000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x5b 0x03 0x5d>;
+=09=09=09clock-names =3D "biu", "ciu";
+=09=09=09resets =3D <0x03 0x40>;
+=09=09=09reset-names =3D "reset";
+=09=09=09interrupts =3D <0x4a>;
+=09=09=09fifo-depth =3D <0x20>;
+=09=09=09fifo-watermark-aligned;
+=09=09=09data-addr =3D <0x00>;
+=09=09=09starfive,sysreg =3D <0x1b 0x14 0x1a 0x7c000000>;
+=09=09=09status =3D "okay";
+=09=09=09max-frequency =3D <0x5f5e100>;
+=09=09=09assigned-clocks =3D <0x03 0x5d>;
+=09=09=09assigned-clock-rates =3D <0x2faf080>;
+=09=09=09bus-width =3D <0x08>;
+=09=09=09bootph-pre-ram;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x2a>;
+=09=09=09phandle =3D <0x67>;
+=09=09};
+
+=09=09mmc@16020000 {
+=09=09=09compatible =3D "starfive,jh7110-mmc";
+=09=09=09reg =3D <0x00 0x16020000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x5c 0x03 0x5e>;
+=09=09=09clock-names =3D "biu", "ciu";
+=09=09=09resets =3D <0x03 0x41>;
+=09=09=09reset-names =3D "reset";
+=09=09=09interrupts =3D <0x4b>;
+=09=09=09fifo-depth =3D <0x20>;
+=09=09=09fifo-watermark-aligned;
+=09=09=09data-addr =3D <0x00>;
+=09=09=09starfive,sysreg =3D <0x1b 0x9c 0x01 0x3e>;
+=09=09=09status =3D "okay";
+=09=09=09max-frequency =3D <0x5f5e100>;
+=09=09=09assigned-clocks =3D <0x03 0x5e>;
+=09=09=09assigned-clock-rates =3D <0x2faf080>;
+=09=09=09bus-width =3D <0x04>;
+=09=09=09bootph-pre-ram;
+=09=09=09cap-sd-highspeed;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x2b>;
+=09=09=09phandle =3D <0x68>;
+=09=09};
+
+=09=09ethernet@16030000 {
+=09=09=09compatible =3D "starfive,jh7110-dwmac", "snps,dwmac-5.20";
+=09=09=09reg =3D <0x00 0x16030000 0x00 0x10000>;
+=09=09=09clocks =3D <0x2c 0x03 0x2c 0x02 0x03 0x6d 0x2c 0x06 0x03 0x6f>;
+=09=09=09clock-names =3D "stmmaceth", "pclk", "ptp_ref", "tx", "gtx";
+=09=09=09resets =3D <0x2c 0x00 0x2c 0x01>;
+=09=09=09reset-names =3D "stmmaceth", "ahb";
+=09=09=09interrupts =3D <0x07 0x06 0x05>;
+=09=09=09interrupt-names =3D "macirq", "eth_wake_irq", "eth_lpi";
+=09=09=09rx-fifo-depth =3D <0x800>;
+=09=09=09tx-fifo-depth =3D <0x800>;
+=09=09=09snps,multicast-filter-bins =3D <0x40>;
+=09=09=09snps,perfect-filter-entries =3D <0x100>;
+=09=09=09snps,fixed-burst;
+=09=09=09snps,no-pbl-x8;
+=09=09=09snps,force_thresh_dma_mode;
+=09=09=09snps,axi-config =3D <0x2d>;
+=09=09=09snps,tso;
+=09=09=09snps,txpbl =3D <0x10>;
+=09=09=09snps,rxpbl =3D <0x10>;
+=09=09=09starfive,syscon =3D <0x2e 0x0c 0x12>;
+=09=09=09status =3D "disabled";
+=09=09=09phy-handle =3D <0x2f>;
+=09=09=09phy-mode =3D "rgmii-id";
+=09=09=09phandle =3D <0x69>;
+
+=09=09=09mdio {
+=09=09=09=09#address-cells =3D <0x01>;
+=09=09=09=09#size-cells =3D <0x00>;
+=09=09=09=09compatible =3D "snps,dwmac-mdio";
+
+=09=09=09=09ethernet-phy@0 {
+=09=09=09=09=09reg =3D <0x00>;
+=09=09=09=09=09phandle =3D <0x2f>;
+=09=09=09=09};
+=09=09=09};
+=09=09};
+
+=09=09ethernet@16040000 {
+=09=09=09compatible =3D "starfive,jh7110-dwmac", "snps,dwmac-5.20";
+=09=09=09reg =3D <0x00 0x16040000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x62 0x03 0x61 0x03 0x66 0x03 0x6a 0x03 0x6b>;
+=09=09=09clock-names =3D "stmmaceth", "pclk", "ptp_ref", "tx", "gtx";
+=09=09=09resets =3D <0x03 0x42 0x03 0x43>;
+=09=09=09reset-names =3D "stmmaceth", "ahb";
+=09=09=09interrupts =3D <0x4e 0x4d 0x4c>;
+=09=09=09interrupt-names =3D "macirq", "eth_wake_irq", "eth_lpi";
+=09=09=09rx-fifo-depth =3D <0x800>;
+=09=09=09tx-fifo-depth =3D <0x800>;
+=09=09=09snps,multicast-filter-bins =3D <0x40>;
+=09=09=09snps,perfect-filter-entries =3D <0x100>;
+=09=09=09snps,fixed-burst;
+=09=09=09snps,no-pbl-x8;
+=09=09=09snps,force_thresh_dma_mode;
+=09=09=09snps,axi-config =3D <0x2d>;
+=09=09=09snps,tso;
+=09=09=09snps,txpbl =3D <0x10>;
+=09=09=09snps,rxpbl =3D <0x10>;
+=09=09=09starfive,syscon =3D <0x1b 0x90 0x02>;
+=09=09=09status =3D "disabled";
+=09=09=09phandle =3D <0x6a>;
+=09=09};
+
+=09=09dma-controller@16050000 {
+=09=09=09compatible =3D "starfive,jh7110-axi-dma";
+=09=09=09reg =3D <0x00 0x16050000 0x00 0x10000>;
+=09=09=09clocks =3D <0x1e 0x1b 0x1e 0x1c>;
+=09=09=09clock-names =3D "core-clk", "cfgr-clk";
+=09=09=09resets =3D <0x1e 0x05 0x1e 0x06>;
+=09=09=09interrupts =3D <0x49>;
+=09=09=09#dma-cells =3D <0x01>;
+=09=09=09dma-channels =3D <0x04>;
+=09=09=09snps,dma-masters =3D <0x01>;
+=09=09=09snps,data-width =3D <0x03>;
+=09=09=09snps,block-size =3D <0x10000 0x10000 0x10000 0x10000>;
+=09=09=09snps,priority =3D <0x00 0x01 0x02 0x03>;
+=09=09=09snps,axi-max-burst-len =3D <0x10>;
+=09=09=09phandle =3D <0x17>;
+=09=09};
+
+=09=09clock-controller@17000000 {
+=09=09=09compatible =3D "starfive,jh7110-aoncrg";
+=09=09=09reg =3D <0x00 0x17000000 0x00 0x10000>;
+=09=09=09clocks =3D <0x20 0x30 0x31 0x03 0x08 0x03 0x0b 0x03 0x6c 0x32>;
+=09=09=09clock-names =3D "osc", "gmac0_rmii_refin", "gmac0_rgmii_rxin", "s=
tg_axiahb", "apb_bus", "gmac0_gtxclk", "rtc_osc";
+=09=09=09#clock-cells =3D <0x01>;
+=09=09=09#reset-cells =3D <0x01>;
+=09=09=09phandle =3D <0x2c>;
+=09=09};
+
+=09=09syscon@17010000 {
+=09=09=09compatible =3D "starfive,jh7110-aon-syscon", "syscon";
+=09=09=09reg =3D <0x00 0x17010000 0x00 0x1000>;
+=09=09=09#power-domain-cells =3D <0x01>;
+=09=09=09phandle =3D <0x2e>;
+=09=09};
+
+=09=09pinctrl@17020000 {
+=09=09=09compatible =3D "starfive,jh7110-aon-pinctrl";
+=09=09=09reg =3D <0x00 0x17020000 0x00 0x10000>;
+=09=09=09resets =3D <0x2c 0x02>;
+=09=09=09interrupts =3D <0x55>;
+=09=09=09interrupt-controller;
+=09=09=09#interrupt-cells =3D <0x02>;
+=09=09=09gpio-controller;
+=09=09=09#gpio-cells =3D <0x02>;
+=09=09=09phandle =3D <0x3f>;
+=09=09};
+
+=09=09power-controller@17030000 {
+=09=09=09compatible =3D "starfive,jh7110-pmu";
+=09=09=09reg =3D <0x00 0x17030000 0x00 0x10000>;
+=09=09=09interrupts =3D <0x6f>;
+=09=09=09#power-domain-cells =3D <0x01>;
+=09=09=09phandle =3D <0x36>;
+=09=09};
+
+=09=09csi@19800000 {
+=09=09=09compatible =3D "starfive,jh7110-csi2rx", "cdns,csi2rx";
+=09=09=09reg =3D <0x00 0x19800000 0x00 0x10000>;
+=09=09=09clocks =3D <0x33 0x07 0x33 0x06 0x33 0x08 0x33 0x09 0x33 0x0a 0x3=
3 0x0b>;
+=09=09=09clock-names =3D "sys_clk", "p_clk", "pixel_if0_clk", "pixel_if1_c=
lk", "pixel_if2_clk", "pixel_if3_clk";
+=09=09=09resets =3D <0x33 0x09 0x33 0x04 0x33 0x05 0x33 0x06 0x33 0x07 0x3=
3 0x08>;
+=09=09=09reset-names =3D "sys", "reg_bank", "pixel_if0", "pixel_if1", "pix=
el_if2", "pixel_if3";
+=09=09=09phys =3D <0x34>;
+=09=09=09phy-names =3D "dphy";
+=09=09=09status =3D "disabled";
+=09=09=09assigned-clocks =3D <0x33 0x07>;
+=09=09=09assigned-clock-rates =3D <0x11b3dc40>;
+=09=09=09phandle =3D <0x6b>;
+
+=09=09=09ports {
+=09=09=09=09#address-cells =3D <0x01>;
+=09=09=09=09#size-cells =3D <0x00>;
+
+=09=09=09=09port@0 {
+=09=09=09=09=09reg =3D <0x00>;
+=09=09=09=09};
+
+=09=09=09=09port@1 {
+=09=09=09=09=09reg =3D <0x01>;
+=09=09=09=09};
+=09=09=09};
+=09=09};
+
+=09=09clock-controller@19810000 {
+=09=09=09compatible =3D "starfive,jh7110-ispcrg";
+=09=09=09reg =3D <0x00 0x19810000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x33 0x03 0x34 0x03 0x35 0x35>;
+=09=09=09clock-names =3D "isp_top_core", "isp_top_axi", "noc_bus_isp_axi",=
 "dvp_clk";
+=09=09=09resets =3D <0x03 0x29 0x03 0x2a 0x03 0x1c>;
+=09=09=09#clock-cells =3D <0x01>;
+=09=09=09#reset-cells =3D <0x01>;
+=09=09=09power-domains =3D <0x36 0x05>;
+=09=09=09phandle =3D <0x33>;
+=09=09};
+
+=09=09phy@19820000 {
+=09=09=09compatible =3D "starfive,jh7110-dphy-rx";
+=09=09=09reg =3D <0x00 0x19820000 0x00 0x10000>;
+=09=09=09clocks =3D <0x33 0x03 0x33 0x04 0x33 0x05>;
+=09=09=09clock-names =3D "cfg", "ref", "tx";
+=09=09=09resets =3D <0x33 0x02 0x33 0x03>;
+=09=09=09power-domains =3D <0x2e 0x01>;
+=09=09=09#phy-cells =3D <0x00>;
+=09=09=09phandle =3D <0x34>;
+=09=09};
+
+=09=09clock-controller@295c0000 {
+=09=09=09compatible =3D "starfive,jh7110-voutcrg";
+=09=09=09reg =3D <0x00 0x295c0000 0x00 0x10000>;
+=09=09=09clocks =3D <0x03 0x3a 0x03 0x3d 0x03 0x3e 0x03 0x3f 0x03 0xa5 0x3=
7>;
+=09=09=09clock-names =3D "vout_src", "vout_top_ahb", "vout_top_axi", "vout=
_top_hdmitx0_mclk", "i2stx0_bclk", "hdmitx0_pixelclk";
+=09=09=09resets =3D <0x03 0x2b>;
+=09=09=09#clock-cells =3D <0x01>;
+=09=09=09#reset-cells =3D <0x01>;
+=09=09=09power-domains =3D <0x36 0x04>;
+=09=09=09phandle =3D <0x6c>;
+=09=09};
+
+=09=09pcie@940000000 {
+=09=09=09compatible =3D "starfive,jh7110-pcie";
+=09=09=09reg =3D <0x09 0x40000000 0x00 0x1000000 0x00 0x2b000000 0x00 0x10=
0000>;
+=09=09=09reg-names =3D "cfg", "apb";
+=09=09=09linux,pci-domain =3D <0x00>;
+=09=09=09#address-cells =3D <0x03>;
+=09=09=09#size-cells =3D <0x02>;
+=09=09=09#interrupt-cells =3D <0x01>;
+=09=09=09ranges =3D <0x82000000 0x00 0x30000000 0x00 0x30000000 0x00 0x800=
0000 0xc3000000 0x09 0x00 0x09 0x00 0x00 0x40000000>;
+=09=09=09interrupts =3D <0x38>;
+=09=09=09interrupt-map-mask =3D <0x00 0x00 0x00 0x07>;
+=09=09=09interrupt-map =3D <0x00 0x00 0x00 0x01 0x38 0x01 0x00 0x00 0x00 0=
x02 0x38 0x02 0x00 0x00 0x00 0x03 0x38 0x03 0x00 0x00 0x00 0x04 0x38 0x04>;
+=09=09=09msi-controller;
+=09=09=09device_type =3D "pci";
+=09=09=09starfive,stg-syscon =3D <0x1d>;
+=09=09=09bus-range =3D <0x00 0xff>;
+=09=09=09clocks =3D <0x03 0x60 0x1e 0x0a 0x1e 0x08 0x1e 0x09>;
+=09=09=09clock-names =3D "noc", "tl", "axi_mst0", "apb";
+=09=09=09resets =3D <0x1e 0x0b 0x1e 0x0c 0x1e 0x0d 0x1e 0x0e 0x1e 0x0f 0x1=
e 0x10>;
+=09=09=09reset-names =3D "mst0", "slv0", "slv", "brg", "core", "apb";
+=09=09=09status =3D "disabled";
+=09=09=09perst-gpios =3D <0x39 0x1a 0x01>;
+=09=09=09phys =3D <0x3a>;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x3b>;
+=09=09=09phandle =3D <0x6d>;
+
+=09=09=09interrupt-controller {
+=09=09=09=09#address-cells =3D <0x00>;
+=09=09=09=09#interrupt-cells =3D <0x01>;
+=09=09=09=09interrupt-controller;
+=09=09=09=09phandle =3D <0x38>;
+=09=09=09};
+=09=09};
+
+=09=09pcie@9c0000000 {
+=09=09=09compatible =3D "starfive,jh7110-pcie";
+=09=09=09reg =3D <0x09 0xc0000000 0x00 0x1000000 0x00 0x2c000000 0x00 0x10=
0000>;
+=09=09=09reg-names =3D "cfg", "apb";
+=09=09=09linux,pci-domain =3D <0x01>;
+=09=09=09#address-cells =3D <0x03>;
+=09=09=09#size-cells =3D <0x02>;
+=09=09=09#interrupt-cells =3D <0x01>;
+=09=09=09ranges =3D <0x82000000 0x00 0x38000000 0x00 0x38000000 0x00 0x800=
0000 0xc3000000 0x09 0x80000000 0x09 0x80000000 0x00 0x40000000>;
+=09=09=09interrupts =3D <0x39>;
+=09=09=09interrupt-map-mask =3D <0x00 0x00 0x00 0x07>;
+=09=09=09interrupt-map =3D <0x00 0x00 0x00 0x01 0x3c 0x01 0x00 0x00 0x00 0=
x02 0x3c 0x02 0x00 0x00 0x00 0x03 0x3c 0x03 0x00 0x00 0x00 0x04 0x3c 0x04>;
+=09=09=09msi-controller;
+=09=09=09device_type =3D "pci";
+=09=09=09starfive,stg-syscon =3D <0x1d>;
+=09=09=09bus-range =3D <0x00 0xff>;
+=09=09=09clocks =3D <0x03 0x60 0x1e 0x0d 0x1e 0x0b 0x1e 0x0c>;
+=09=09=09clock-names =3D "noc", "tl", "axi_mst0", "apb";
+=09=09=09resets =3D <0x1e 0x11 0x1e 0x12 0x1e 0x13 0x1e 0x14 0x1e 0x15 0x1=
e 0x16>;
+=09=09=09reset-names =3D "mst0", "slv0", "slv", "brg", "core", "apb";
+=09=09=09status =3D "disabled";
+=09=09=09perst-gpios =3D <0x39 0x1c 0x01>;
+=09=09=09phys =3D <0x3d>;
+=09=09=09pinctrl-names =3D "default";
+=09=09=09pinctrl-0 =3D <0x3e>;
+=09=09=09phandle =3D <0x6e>;
+
+=09=09=09interrupt-controller {
+=09=09=09=09#address-cells =3D <0x00>;
+=09=09=09=09#interrupt-cells =3D <0x01>;
+=09=09=09=09interrupt-controller;
+=09=09=09=09phandle =3D <0x3c>;
+=09=09=09};
+=09=09};
+=09};
+
+=09aliases {
+=09=09ethernet0 =3D "/soc/ethernet@16030000";
+=09=09i2c0 =3D "/soc/i2c@10030000";
+=09=09i2c2 =3D "/soc/i2c@10050000";
+=09=09i2c5 =3D "/soc/i2c@12050000";
+=09=09i2c6 =3D "/soc/i2c@12060000";
+=09=09mmc0 =3D "/soc/mmc@16010000";
+=09=09mmc1 =3D "/soc/mmc@16020000";
+=09=09serial0 =3D "/soc/serial@10000000";
+=09};
+
+=09chosen {
+=09=09stdout-path =3D "serial0:115200n8";
+=09};
+
+=09memory@40000000 {
+=09=09device_type =3D "memory";
+=09=09reg =3D <0x00 0x40000000 0x01 0x00>;
+=09=09bootph-pre-ram;
+=09};
+
+=09gpio-restart {
+=09=09compatible =3D "gpio-restart";
+=09=09gpios =3D <0x39 0x23 0x00>;
+=09=09priority =3D <0xe0>;
+=09};
+
+=09leds {
+=09=09compatible =3D "gpio-leds";
+
+=09=09led-0 {
+=09=09=09gpios =3D <0x3f 0x03 0x00>;
+=09=09=09phandle =3D <0x6f>;
+=09=09};
+=09};
+
+=09audio-codec {
+=09=09compatible =3D "linux,spdif-dit";
+=09=09#sound-dai-cells =3D <0x00>;
+=09=09phandle =3D <0x42>;
+=09};
+
+=09sound {
+=09=09compatible =3D "simple-audio-card";
+=09=09simple-audio-card,name =3D "StarFive-PWMDAC-Sound-Card";
+=09=09#address-cells =3D <0x01>;
+=09=09#size-cells =3D <0x00>;
+
+=09=09simple-audio-card,dai-link@0 {
+=09=09=09reg =3D <0x00>;
+=09=09=09format =3D "left_j";
+=09=09=09bitclock-master =3D <0x40>;
+=09=09=09frame-master =3D <0x40>;
+
+=09=09=09cpu {
+=09=09=09=09sound-dai =3D <0x41>;
+=09=09=09=09phandle =3D <0x40>;
+=09=09=09};
+
+=09=09=09codec {
+=09=09=09=09sound-dai =3D <0x42>;
+=09=09=09};
+=09=09};
+=09};
+
+=09__symbols__ {
+=09=09cpus =3D "/cpus";
+=09=09S7_0 =3D "/cpus/cpu@0";
+=09=09cpu0_intc =3D "/cpus/cpu@0/interrupt-controller";
+=09=09U74_1 =3D "/cpus/cpu@1";
+=09=09cpu1_intc =3D "/cpus/cpu@1/interrupt-controller";
+=09=09U74_2 =3D "/cpus/cpu@2";
+=09=09cpu2_intc =3D "/cpus/cpu@2/interrupt-controller";
+=09=09U74_3 =3D "/cpus/cpu@3";
+=09=09cpu3_intc =3D "/cpus/cpu@3/interrupt-controller";
+=09=09U74_4 =3D "/cpus/cpu@4";
+=09=09cpu4_intc =3D "/cpus/cpu@4/interrupt-controller";
+=09=09cpu_opp =3D "/opp-table-0";
+=09=09cpu_alert0 =3D "/thermal-zones/cpu-thermal/trips/cpu-alert0";
+=09=09dvp_clk =3D "/dvp-clock";
+=09=09gmac0_rgmii_rxin =3D "/gmac0-rgmii-rxin-clock";
+=09=09gmac0_rmii_refin =3D "/gmac0-rmii-refin-clock";
+=09=09gmac1_rgmii_rxin =3D "/gmac1-rgmii-rxin-clock";
+=09=09gmac1_rmii_refin =3D "/gmac1-rmii-refin-clock";
+=09=09hdmitx0_pixelclk =3D "/hdmitx0-pixel-clock";
+=09=09i2srx_bclk_ext =3D "/i2srx-bclk-ext-clock";
+=09=09i2srx_lrck_ext =3D "/i2srx-lrck-ext-clock";
+=09=09i2stx_bclk_ext =3D "/i2stx-bclk-ext-clock";
+=09=09i2stx_lrck_ext =3D "/i2stx-lrck-ext-clock";
+=09=09mclk_ext =3D "/mclk-ext-clock";
+=09=09osc =3D "/oscillator";
+=09=09rtc_osc =3D "/rtc-oscillator";
+=09=09stmmac_axi_setup =3D "/stmmac-axi-config";
+=09=09tdm_ext =3D "/tdm-ext-clock";
+=09=09clint =3D "/soc/timer@2000000";
+=09=09ccache =3D "/soc/cache-controller@2010000";
+=09=09plic =3D "/soc/interrupt-controller@c000000";
+=09=09uart0 =3D "/soc/serial@10000000";
+=09=09uart1 =3D "/soc/serial@10010000";
+=09=09uart2 =3D "/soc/serial@10020000";
+=09=09i2c0 =3D "/soc/i2c@10030000";
+=09=09i2c1 =3D "/soc/i2c@10040000";
+=09=09i2c2 =3D "/soc/i2c@10050000";
+=09=09spi0 =3D "/soc/spi@10060000";
+=09=09spi1 =3D "/soc/spi@10070000";
+=09=09spi2 =3D "/soc/spi@10080000";
+=09=09tdm =3D "/soc/tdm@10090000";
+=09=09i2srx =3D "/soc/i2s@100e0000";
+=09=09pwmdac =3D "/soc/pwmdac@100b0000";
+=09=09usb0 =3D "/soc/usb@10100000";
+=09=09usb_cdns3 =3D "/soc/usb@10100000/usb@0";
+=09=09usbphy0 =3D "/soc/phy@10200000";
+=09=09pciephy0 =3D "/soc/phy@10210000";
+=09=09pciephy1 =3D "/soc/phy@10220000";
+=09=09stgcrg =3D "/soc/clock-controller@10230000";
+=09=09stg_syscon =3D "/soc/syscon@10240000";
+=09=09uart3 =3D "/soc/serial@12000000";
+=09=09uart4 =3D "/soc/serial@12010000";
+=09=09uart5 =3D "/soc/serial@12020000";
+=09=09i2c3 =3D "/soc/i2c@12030000";
+=09=09i2c4 =3D "/soc/i2c@12040000";
+=09=09i2c5 =3D "/soc/i2c@12050000";
+=09=09axp15060 =3D "/soc/i2c@12050000/pmic@36";
+=09=09vcc_3v3 =3D "/soc/i2c@12050000/pmic@36/regulators/dcdc1";
+=09=09vdd_cpu =3D "/soc/i2c@12050000/pmic@36/regulators/dcdc2";
+=09=09emmc_vdd =3D "/soc/i2c@12050000/pmic@36/regulators/aldo4";
+=09=09i2c6 =3D "/soc/i2c@12060000";
+=09=09spi3 =3D "/soc/spi@12070000";
+=09=09spi4 =3D "/soc/spi@12080000";
+=09=09spi5 =3D "/soc/spi@12090000";
+=09=09spi6 =3D "/soc/spi@120a0000";
+=09=09i2stx0 =3D "/soc/i2s@120b0000";
+=09=09i2stx1 =3D "/soc/i2s@120c0000";
+=09=09pwm =3D "/soc/pwm@120d0000";
+=09=09sfctemp =3D "/soc/temperature-sensor@120e0000";
+=09=09qspi =3D "/soc/spi@13010000";
+=09=09nor_flash =3D "/soc/spi@13010000/flash@0";
+=09=09syscrg =3D "/soc/clock-controller@13020000";
+=09=09sys_syscon =3D "/soc/syscon@13030000";
+=09=09pllclk =3D "/soc/syscon@13030000/clock-controller";
+=09=09sysgpio =3D "/soc/pinctrl@13040000";
+=09=09i2c0_pins =3D "/soc/pinctrl@13040000/i2c0-0";
+=09=09i2c2_pins =3D "/soc/pinctrl@13040000/i2c2-0";
+=09=09i2c5_pins =3D "/soc/pinctrl@13040000/i2c5-0";
+=09=09i2c6_pins =3D "/soc/pinctrl@13040000/i2c6-0";
+=09=09mmc0_pins =3D "/soc/pinctrl@13040000/mmc0-0";
+=09=09mmc1_pins =3D "/soc/pinctrl@13040000/mmc1-0";
+=09=09pcie0_pins =3D "/soc/pinctrl@13040000/pcie0-0";
+=09=09pcie1_pins =3D "/soc/pinctrl@13040000/pcie1-0";
+=09=09pwmdac_pins =3D "/soc/pinctrl@13040000/pwmdac-0";
+=09=09pwm_pins =3D "/soc/pinctrl@13040000/pwm-0";
+=09=09spi0_pins =3D "/soc/pinctrl@13040000/spi0-0";
+=09=09uart0_pins =3D "/soc/pinctrl@13040000/uart0-0";
+=09=09crypto =3D "/soc/crypto@16000000";
+=09=09sdma =3D "/soc/dma-controller@16008000";
+=09=09rng =3D "/soc/rng@1600c000";
+=09=09mmc0 =3D "/soc/mmc@16010000";
+=09=09mmc1 =3D "/soc/mmc@16020000";
+=09=09gmac0 =3D "/soc/ethernet@16030000";
+=09=09phy0 =3D "/soc/ethernet@16030000/mdio/ethernet-phy@0";
+=09=09gmac1 =3D "/soc/ethernet@16040000";
+=09=09dma =3D "/soc/dma-controller@16050000";
+=09=09aoncrg =3D "/soc/clock-controller@17000000";
+=09=09aon_syscon =3D "/soc/syscon@17010000";
+=09=09aongpio =3D "/soc/pinctrl@17020000";
+=09=09pwrc =3D "/soc/power-controller@17030000";
+=09=09csi2rx =3D "/soc/csi@19800000";
+=09=09ispcrg =3D "/soc/clock-controller@19810000";
+=09=09csi_phy =3D "/soc/phy@19820000";
+=09=09voutcrg =3D "/soc/clock-controller@295c0000";
+=09=09pcie0 =3D "/soc/pcie@940000000";
+=09=09pcie_intc0 =3D "/soc/pcie@940000000/interrupt-controller";
+=09=09pcie1 =3D "/soc/pcie@9c0000000";
+=09=09pcie_intc1 =3D "/soc/pcie@9c0000000/interrupt-controller";
+=09=09led_status_power =3D "/leds/led-0";
+=09=09pwmdac_codec =3D "/audio-codec";
+=09=09sndcpu0 =3D "/sound/simple-audio-card,dai-link@0/cpu";
+=09};
+};
diff --git a/arch/riscv/dts/jh7110-pine64-pinetabv.dts b/arch/riscv/dts/jh7=
110-pine64-pinetabv.dts
new file mode 100644
index 00000000000..2baaca5eef8
--- /dev/null
+++ b/arch/riscv/dts/jh7110-pine64-pinetabv.dts
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2026 T Anoduck <anoduck@protonmail.com>
+ * Through the Graces of: E Shattow <e@freeshell.de>
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+#include "jh7110-pine64-pinetabv-u-boot.dtsi"
+
+/ {
+    compatible =3D "pine64,pinetabv", "starfive,jh7110";
+=09model =3D "Pine64 PinetabV";
+
+=09soc {
+    =09i2c@10030000 {
+    =09=09compatible =3D "snps,designware-i2c";
+    =09=09reg =3D <0x00 0x10030000 0x00 0x10000>;
+    =09=09clocks =3D <0x03 0x8a>;
+    =09=09clock-names =3D "ref";
+    =09=09resets =3D <0x03 0x4c>;
+    =09=09interrupts =3D <0x23>;
+    =09=09#address-cells =3D <0x01>;
+    =09=09#size-cells =3D <0x00>;
+    =09=09status =3D "okay";
+    =09=09clock-frequency =3D <0x186a0>;
+    =09=09i2c-sda-hold-time-ns =3D <0x12c>;
+    =09=09i2c-sda-falling-time-ns =3D <0x1fe>;
+    =09=09i2c-scl-falling-time-ns =3D <0x1fe>;
+    =09=09pinctrl-names =3D "default";
+    =09=09pinctrl-0 =3D <0x17>;
+
+    =09=09audio-codec@11 {
+    =09=09=09compatible =3D "everest,es8316";
+    =09=09=09reg =3D <0x11>;
+    =09=09=09clocks =3D <0x18>;
+    =09=09=09clock-names =3D "mclk";
+    =09=09=09#sound-dai-cells =3D <0x00>;
+    =09=09=09papower-gpio =3D <0x19 0x32 0x00>;
+    =09=09=09hp-det-gpio =3D <0x19 0x24 0x00>;
+    =09=09=09phandle =3D <0x64>;
+    =09=09};
+
+    =09=09accelerometer@18 {
+    =09=09=09compatible =3D "silan,sc7a20";
+    =09=09=09reg =3D <0x18>;
+    =09=09=09mount-matrix =3D "0", "0", "-1", "1", "0", "0", "0", "-1", "0=
";
+    =09=09};
+    =09};
+=09sd_vcc: sd-vcc {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "sd_vcc";
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+=09=09gpio =3D <0x19 0x23 0x00>;          /* TODO: Replace 0x?? with the E=
N GPIO from schematic page 7 =3D> GPIO35? */
+=09=09enable-active-low;               /* Change to enable-active-low if t=
he circuit uses active-low enable */
+=09=09regulator-boot-on;
+=09=09regulator-always-on;
+=09};
+
+    =09mmc@16010000 {
+    =09=09compatible =3D "starfive,jh7110-mmc";
+    =09=09reg =3D <0x00 0x16010000 0x00 0x10000>;
+    =09=09clocks =3D <0x03 0x5b 0x03 0x5d>;
+    =09=09clock-names =3D "biu", "ciu";
+    =09=09resets =3D <0x03 0x40>;
+    =09=09reset-names =3D "reset";
+    =09=09interrupts =3D <0x4a>;
+    =09=09fifo-depth =3D <0x20>;
+    =09=09fifo-watermark-aligned;
+    =09=09data-addr =3D <0x00>;
+    =09=09starfive,sysreg =3D <0x1f 0x14 0x1a 0x7c000000>;
+    =09=09status =3D "okay";
+    =09=09max-frequency =3D <0x5f5e100>;
+    =09=09assigned-clocks =3D <0x03 0x5d>;
+    =09=09vmmc-supply =3D <&sd_vcc>;
+    =09=09assigned-clock-rates =3D <0x2faf080>;
+    =09=09bus-width =3D <0x08>;
+    =09=09cap-mmc-highspeed;
+    =09=09mmc-ddr-1_8v;
+    =09=09mmc-hs200-1_8v;
+    =09=09non-removable;
+    =09=09cap-mmc-hw-reset;
+    =09=09post-power-on-delay-ms =3D <0xc8>;
+    =09=09pinctrl-names =3D "default";
+    =09=09pinctrl-0 =3D <0x3c>;
+    =09=09vqmmc-supply =3D <&sd_vcc>;
+    =09};
+
+    =09mmc@16020000 {
+    =09=09compatible =3D "starfive,jh7110-mmc";
+    =09=09reg =3D <0x00 0x16020000 0x00 0x10000>;
+    =09=09clocks =3D <0x03 0x5c 0x03 0x5e>;
+    =09=09clock-names =3D "biu", "ciu";
+    =09=09resets =3D <0x03 0x41>;
+    =09=09reset-names =3D "reset";
+    =09=09interrupts =3D <0x4b>;
+    =09=09fifo-depth =3D <0x20>;
+    =09=09fifo-watermark-aligned;
+    =09=09data-addr =3D <0x00>;
+    =09=09starfive,sysreg =3D <0x1f 0x9c 0x01 0x3e>;
+    =09=09status =3D "okay";
+    =09=09max-frequency =3D <0x5f5e100>;
+    =09=09assigned-clocks =3D <0x03 0x5e>;
+    =09=09assigned-clock-rates =3D <0x2faf080>;
+    =09=09bus-width =3D <0x04>;
+    =09=09no-sdio;
+    =09=09no-mmc;
+    =09=09cd-gpios =3D <0x19 0x29 0x01>; /* SD Card detect - active low */
+    =09=09cap-sd-highspeed;
+    =09=09post-power-on-delay-ms =3D <0xc8>;
+    =09=09pinctrl-names =3D "default";
+    =09=09pinctrl-0 =3D <0x3e>;
+    =09};
+    };
+};
diff --git a/dts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts b/d=
ts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts
deleted file mode 100644
index dd04d9be5a0..00000000000
--- a/dts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts
+++ /dev/null
@@ -1,115 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2026 T Anoduck <anoduck@protonmail.com>
- * Through the Graces of: E Shattow <e@freeshell.de>
- */
-
-/dts-v1/;
-#include "jh7110-common.dtsi"
-
-/ {
-=09compatible =3D "pine64,pinetabv", "starfive,jh7110";
-=09model =3D "Pine64 PinetabV";
-
-=09soc {
-=09=09i2c@10030000 {
-=09=09=09compatible =3D "snps,designware-i2c";
-=09=09=09reg =3D <0x00 0x10030000 0x00 0x10000>;
-=09=09=09clocks =3D <0x03 0x8a>;
-=09=09=09clock-names =3D "ref";
-=09=09=09resets =3D <0x03 0x4c>;
-=09=09=09interrupts =3D <0x23>;
-=09=09=09#address-cells =3D <0x01>;
-=09=09=09#size-cells =3D <0x00>;
-=09=09=09status =3D "okay";
-=09=09=09clock-frequency =3D <0x186a0>;
-=09=09=09i2c-sda-hold-time-ns =3D <0x12c>;
-=09=09=09i2c-sda-falling-time-ns =3D <0x1fe>;
-=09=09=09i2c-scl-falling-time-ns =3D <0x1fe>;
-=09=09=09pinctrl-names =3D "default";
-=09=09=09pinctrl-0 =3D <0x17>;
-
-=09=09=09audio-codec@11 {
-=09=09=09=09compatible =3D "everest,es8316";
-=09=09=09=09reg =3D <0x11>;
-=09=09=09=09clocks =3D <0x18>;
-=09=09=09=09clock-names =3D "mclk";
-=09=09=09=09#sound-dai-cells =3D <0x00>;
-=09=09=09=09papower-gpio =3D <0x19 0x32 0x00>;
-=09=09=09=09hp-det-gpio =3D <0x19 0x24 0x00>;
-=09=09=09=09phandle =3D <0x64>;
-=09=09=09};
-
-=09=09=09accelerometer@18 {
-=09=09=09=09compatible =3D "silan,sc7a20";
-=09=09=09=09reg =3D <0x18>;
-=09=09=09=09mount-matrix =3D "0", "0", "-1", "1", "0", "0", "0", "-1", "0"=
;
-=09=09=09};
-=09=09};
-=09sd_vcc: sd-vcc {
-=09=09compatible =3D "regulator-fixed";
-=09=09regulator-name =3D "sd_vcc";
-=09=09regulator-min-microvolt =3D <3300000>;
-=09=09regulator-max-microvolt =3D <3300000>;
-=09=09gpio =3D <0x19 0x23 0x00>;
-=09=09enable-active-low;
-=09=09regulator-boot-on;
-=09=09regulator-always-on;
-=09};
-
-=09=09mmc@16010000 {
-=09=09=09compatible =3D "starfive,jh7110-mmc";
-=09=09=09reg =3D <0x00 0x16010000 0x00 0x10000>;
-=09=09=09clocks =3D <0x03 0x5b 0x03 0x5d>;
-=09=09=09clock-names =3D "biu", "ciu";
-=09=09=09resets =3D <0x03 0x40>;
-=09=09=09reset-names =3D "reset";
-=09=09=09interrupts =3D <0x4a>;
-=09=09=09fifo-depth =3D <0x20>;
-=09=09=09fifo-watermark-aligned;
-=09=09=09data-addr =3D <0x00>;
-=09=09=09starfive,sysreg =3D <0x1f 0x14 0x1a 0x7c000000>;
-=09=09=09status =3D "okay";
-=09=09=09max-frequency =3D <0x5f5e100>;
-=09=09=09assigned-clocks =3D <0x03 0x5d>;
-=09=09=09vmmc-supply =3D <&sd_vcc>;
-=09=09=09assigned-clock-rates =3D <0x2faf080>;
-=09=09=09bus-width =3D <0x08>;
-=09=09=09cap-mmc-highspeed;
-=09=09=09mmc-ddr-1_8v;
-=09=09=09mmc-hs200-1_8v;
-=09=09=09non-removable;
-=09=09=09cap-mmc-hw-reset;
-=09=09=09post-power-on-delay-ms =3D <0xc8>;
-=09=09=09pinctrl-names =3D "default";
-=09=09=09pinctrl-0 =3D <0x3c>;
-=09=09=09vqmmc-supply =3D <&sd_vcc>;
-=09=09};
-
-=09=09mmc@16020000 {
-=09=09=09compatible =3D "starfive,jh7110-mmc";
-=09=09=09reg =3D <0x00 0x16020000 0x00 0x10000>;
-=09=09=09clocks =3D <0x03 0x5c 0x03 0x5e>;
-=09=09=09clock-names =3D "biu", "ciu";
-=09=09=09resets =3D <0x03 0x41>;
-=09=09=09reset-names =3D "reset";
-=09=09=09interrupts =3D <0x4b>;
-=09=09=09fifo-depth =3D <0x20>;
-=09=09=09fifo-watermark-aligned;
-=09=09=09data-addr =3D <0x00>;
-=09=09=09starfive,sysreg =3D <0x1f 0x9c 0x01 0x3e>;
-=09=09=09status =3D "okay";
-=09=09=09max-frequency =3D <0x5f5e100>;
-=09=09=09assigned-clocks =3D <0x03 0x5e>;
-=09=09=09assigned-clock-rates =3D <0x2faf080>;
-=09=09=09bus-width =3D <0x04>;
-=09=09=09no-sdio;
-=09=09=09no-mmc;
-=09=09=09cd-gpios =3D <0x19 0x29 0x01>;
-=09=09=09cap-sd-highspeed;
-=09=09=09post-power-on-delay-ms =3D <0xc8>;
-=09=09=09pinctrl-names =3D "default";
-=09=09=09pinctrl-0 =3D <0x3e>;
-=09=09};
-=09};
-};
diff --git a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-p=
inetab-v.dts b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2=
-pinetab-v.dts
deleted file mode 100644
index bbf42aa5063..00000000000
--- a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-pinetab-=
v.dts
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright (C) 2026 T Anoduck <anoduck@protonmail.com>
- */
-
-/dts-v1/;
-#include "jh7110-starfive-visionfive-2.dtsi"
-
-/ {
-=09model =3D "Pine64 Pinetab-V";
-=09compatible =3D "pine64,pinetab-v", "starfive,jh7110";
-};

--=20
2.53.0


