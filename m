Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB95606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oeNMOZW0;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=dkzgfF0/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA8C160638;
	Sat, 31 Oct 2026 16:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id On8HNvFKiHTi; Sat, 31 Oct 2026 16:41:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 85BF560618
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793464873;
	b=LgzCmUNSZt6fAxrOriRBq71/7zND4DpgRjXiBKlGuBjJtuW1wtd3VjaCOXhrRfRMoGxM
	 geXaioOTs842ceSpCkyiItyPGSBWu3/JCHeNrZoIHnhh4qW23qLz5dMZWWgwd5AafaBql
	 6z+dMhW64gjJh/KgT2V1fD3/kODJZ3pDx4hdzZXI1MCoKRTUHqNgHmf3MwUJ0wxVRZEH8
	 MA83Ka3TANk9PpPxO9Ze/eUS1RIYQliQIguyGUPCjNdAYoZH+6tIhbEGQqVk55WGGy5Ug
	 pkSeSOUkj7LHbdVU7pzLkcdOIYrDEeYRk65uifZ+wH3hy/jVZBuH3HMEOW8As/2TC0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793464873;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kvWuehMEKKhtlqSV6ruaVnQ2jW3NHIsbKsA9I3642KA=;
	b=hQ5YVi5iR/sheKgvwWzwfM2+OdwFpXHJdi7k/qtKuYfK/xzidny44pM849kQ0Kt8K439
	 s6/0GFMp3thqgZYd1dX46ORsWi3jPpvrwYcTe2vaqlPqKGwuYuutnQtOSJOTwW/euhM9k
	 A95oQimW9n3uu1mjOr0t7FYpMxlpxx0kROlIcxHGagJpxzrs2ARsYm29M5vuSllPqxGEj
	 ctmJ3Vyr6wmw6ld6oDKlTcAFH+z2HIu9pk6Bx8Hy6LRpwY2I/DAIYAHvoBipWwF+/oC1E
	 jPZ76siitaq0dfm/4mP5/wABB41fn1r6pUa1+H2HXz6e2kYlSZO8PBL4HkF780CaSvw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="dkzgfF0/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793464873;
	bh=kvWuehMEKKhtlqSV6ruaVnQ2jW3NHIsbKsA9I3642KA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oeNMOZW0+q5UNGT6yUlrZUnWPzREPCiPpLED4eOg3DPH20JgYoZ9FjRi35BcHz/z1
	 0F4KgBF6K5WkO6DF+CRyNQmwT6cSVen/Ib09Fwe/WScufznTiTkNWCKa0kkqEs0nNy
	 MYFSImO2GALZehZrDxvdgWq8ryjOzeEZ0Jycn2SEDiL9A+mSVYHCcieF6OoPiuF6op
	 /6bwkHlwuWSVeC0G5kbd9253sTv5Fu5cpmJnpPMLnbztw2yNTSH6s67OZmpjd09Z5W
	 VvtzVGoXSuHy8ZXtDNUcufBsiTsBvbwDdQ/JVr9TBySpSwWHoVaFzeIMsD41mlN882
	 m7W4cwCSuh5Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85BF560618;
	Sat, 31 Oct 2026 16:41:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EA94156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 16:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BBF860624
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 16:41:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lvzVFWT4Ppmg for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 16:41:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 29AA660618
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793464870;
 b=Zld1X6wJYiGLs1k+0CV/QywuBh9Oz7iAh8nNYJr3eI4Id4b1Stw0UE8ESBHh/ZWwivqF
 5Fa7Q83xdiiNSEwv8GhhS3XslZ2toNvVXej0B+FxVdKgQ2A7TSdXb6i4IwB7fqXvB/l5S
 ajD0/FXEsdGb7159lX63WiqzLwDMxGtuEAdTV97rBLM6alcfLM/tF63Z98gMNT008V2xE
 opfbM/5+5NwtXmZFY1yH6U2+eFyzCNdjbJyf9od7YAyPcL/BuIgLLGIHzYv+TGMG/GZAs
 FBzXXBe/y3CuKTvZt5KnL26i4MrrSbpVEb/TylB+Mg5AVLjOOrz9WgnR0WGEVlr7KDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793464870;
 h=Received-SPF:DKIM-Signature:Received:X-QQ-mid:Message-ID:
 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
 X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=kvWuehMEKKhtlqSV6ruaVnQ2jW3NHIsbKsA9I3642KA=;
 b=cUbRefAVn+V8xzgVryG+n6DABUWaIk7WXkaphlvrwueOZaU2EtU+SJrgLEcWhn+lOe0N
 1vfDXKZbp8Apn4+gejt4BvpSZmXqEFA7Cm7TfEDi2Ga6j7NOmvLViuOb3FlpampJpXEeM
 pUHU5B8xjjV0BLHrjQ1zkApqGFPmy3No1mK7Z8sssZ31OxEOajb7qOByifGum1RWrL/d/
 wWOIc3mpKhSV+VbkKcqhSv0rGy38w19tJhOtQQzfcZDa5C26RE8R5ntOeqVXYD/E5O4X7
 hyvPd0/1snf6h1xJZJnDJcqwgFHbX84JaFnbY7oWOGSLeZ25gGD15Ro/kuBkGYz+qtA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=qq.com;
 dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b="dkzgfF0/"; 
 arc=none smtp.remote-ip=162.62.57.252
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=162.62.57.252;
 helo=out162-62-57-252.mail.qq.com; envelope-from=3305708832@qq.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=dkzgfF0/
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com
 [162.62.57.252])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29AA660618
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1793464863; bh=kvWuehMEKKhtlqSV6ruaVnQ2jW3NHIsbKsA9I3642KA=;
 h=From:To:Cc:Subject:Date;
 b=dkzgfF0/GyKiK9RTPNjX+6c63N7YPGy2uAFtv36P3CR1jJaX+E6kjs6gynZrC/m7c
 6q9y1sCBcSI3bwDY7IhPdNcZSK6MDFDQzBKMvPN+Nl/ruyp/YJvOMylQ8it18py9+Y
 q3EBskuAcm7UQkZSikSXqMesCPk9jiThfX9/aVUc=
Received: from kongchen-VMware-Virtual-Platform ([39.144.83.15])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 96A8A0CC; Sun, 01 Nov 2026 00:37:42 +0800
X-QQ-mid: xmsmtpt1793464662tlxmrbped
Message-ID: <tencent_3B62428BD3AA1A925C6D6F63D2E1190B9E08@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoecX1Id9Vrq+Qfo6NK5bYCr982CxLbYnsGPs9hIViDkIwhosvZ2Y
 VmQqAb1Up1Xi4nx5YlpewwHw6wSK97fcyxF+nT6tne/aLR5HKavuwxGCKl/x3LDdQkGHzTXNJSEG
 O/tUDMTY7K9lYdIYbw8AqXCW3+OmGlJIEKBA+eJjWqyLrrniygmAEn7Rhw0XDjuC0TzyJtoPJpsT
 xJKv9uOR6QSOUZnwk8FKsaJ2KWmkPZTSqcQskKA/tF+CO0vaf5eE1Pidy+7Xy2L7bOvyEHnyQVuu
 JNsx4zeqUvRfklXKnDlAgKNIxpQnrUWSAOnOtppDCq18bcp0e6+wIjUv5lXdbkWBffwRgNLcoTMt
 9q1/NIrIHycm9bv0938y7eBTp4NsiZTBOcHz3DSlSmSkSj7QdyTeH05cKP3TDBfanNbxG+iAmBn0
 CfO0wjP73Tgch3VdqV/QN0X52jxnOIHr5r0fFBN/SOJCLWgbEnYrhqbHoMhMR/RYsGRuke7G72HZ
 5ddPPNXhyXa+HdgczQ+TnOR2oavs919pCmJwzl/IXcXMpbessYjxzRNjIIkFPC4Q2haEKE/Exg2q
 sHrkgicFV+7F7Mb6dmyO7x19HKS96rMzkMe9/QohO5r5rHyrD3Oi6UatcoqzUE2D41PDJWovzR66
 8PxlisPVNY0nTGfn3cAqxp8aGp8fyhz8y0Qa0dcHmCDkZh5DaCZFZkpesm1NHRvBZ7/YhX1bSNRe
 k/gQJhOVOcANjwVIlprKTc9DAyE6O6ErQhZhumeINQbqh++7lZYXWCTToVE4vDVYpVp3HA1CfakE
 YdNISAXyTsmKcJTkuLiONXdN2gotZ5SxlX5HiP0IplDatc+vRhsoZ3sHBrZL1nj8RmjjEQemF+t9
 h+Tt4VYbbOQp1l52E8BFgMohZc4pj/zxmceJegyZ2QijdXjv5VOPcayS31sdY56ztfcZc2AvMkph
 pE9SeFS7BQleVdI0GzSHk4e/KCN8cVyUml3N5wrxSok+cqvDmPKtIPUypTGVC5RAl05s4xfUsKmY
 L+vKnBEVDwMfAlYh2ark9y9TPlDQ4=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Yuming Chen <3305708832@qq.com>
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, chenjh@rock-chips.com,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] rockchip: board: Add support for KICKPI K1
Date: Sun,  1 Nov 2026 00:37:42 +0800
X-OQ-MSGID: <20261031163742.61014-1-3305708832@qq.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HELO_STATIC_HOST,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The KICKPI K1 is a RK3568B2-based single board computer with eMMC,
microSD card slot, dual Gigabit Ethernet (Maxio MAE0621A PHYs with
on-board crystals) and a 1500000 baud serial console on UART2.

Add a minimal device tree enabling eMMC, SD-card, UART2, USB OTG
and both GMACs, together with a defconfig to boot from eMMC or
SD-card.

Signed-off-by: Yuming Chen <3305708832@qq.com>
---
 arch/arm/dts/rk3568-kickpi-k1-u-boot.dtsi |   3 +
 arch/arm/dts/rk3568-kickpi-k1.dts         | 226 ++++++++++++++++++++++
 board/rockchip/evb_rk3568/MAINTAINERS     |   6 +
 configs/kickpi-k1-rk3568_defconfig        |  62 ++++++
 doc/board/rockchip/rockchip.rst           |   1 +
 5 files changed, 298 insertions(+)
 create mode 100644 arch/arm/dts/rk3568-kickpi-k1-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3568-kickpi-k1.dts
 create mode 100644 configs/kickpi-k1-rk3568_defconfig

diff --git a/arch/arm/dts/rk3568-kickpi-k1-u-boot.dtsi b/arch/arm/dts/rk3568-kickpi-k1-u-boot.dtsi
new file mode 100644
index 00000000000..6e8307e3bdf
--- /dev/null
+++ b/arch/arm/dts/rk3568-kickpi-k1-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk356x-u-boot.dtsi"
diff --git a/arch/arm/dts/rk3568-kickpi-k1.dts b/arch/arm/dts/rk3568-kickpi-k1.dts
new file mode 100644
index 00000000000..798a275e6cf
--- /dev/null
+++ b/arch/arm/dts/rk3568-kickpi-k1.dts
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * KickPi K1 (RK3568) minimal U-Boot device tree.
+ * Boot essentials only: eMMC, SD-card, UART2 console and USB OTG,
+ * modeled after rk3568-generic.dts.
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rk3568.dtsi"
+
+/ {
+	model = "KICKPI K1";
+	compatible = "rockchip,rk3568-kickpi-k1a", "rockchip,rk3568";
+
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	/*
+	 * IO-domain rails as routed on the K1A board (vendor kernel
+	 * rk3568-kickpi-evb.dtsi). Rails are RK809 outputs already up at
+	 * reset; U-Boot only needs their voltage to program the PMU GRF
+	 * VSEL bits. GMAC0 pads live in VCCIO4 and GMAC1 pads in VCCIO6,
+	 * both 1.8V -- leaving these unset selects the 3.3V class and the
+	 * RGMII pads never work.
+	 */
+	vcc3v3_pmu: regulator-vcc3v3-pmu {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pmu";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vccio_acodec: regulator-vccio-acodec {
+		compatible = "regulator-fixed";
+		regulator-name = "vccio_acodec";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-always-on;
+	};
+
+	vccio_sd: regulator-vccio-sd {
+		compatible = "regulator-fixed";
+		regulator-name = "vccio_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vcc_1v8: regulator-vcc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
+	status = "okay";
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+/* Rail map identical to vendor kernel rk3568-kickpi-evb.dtsi */
+&pmu_io_domains {
+	status = "okay";
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vccio_acodec>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_1v8>;
+	vccio7-supply = <&vcc_3v3>;
+};
+
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	extcon = <&usb2phy0>;
+	maximum-speed = "high-speed";
+	phys = <&usb2phy0_otg>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	status = "okay";
+};
+
+/* Dual GbE, Maxio MAE0621A PHYs with on-board crystals, RGMII with SoC-side
+ * delays (clock/pinctrl config per SDK eth dtsi, identical to mainline BPI-R2
+ * Pro). The MAE0621A needs its vendor driver (drivers/net/phy/maxio.c) before
+ * its RGMII RX clock runs.
+ */
+
+&gmac0 {
+	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
+	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
+	assigned-clock-rates = <0>, <125000000>;
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy0>;
+	/* RGMII delays are provided by the SoC via the tx_delay/rx_delay GRF
+	 * registers below, not by the PHY or PCB traces
+	 */
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_miim
+		     &gmac0_tx_bus2
+		     &gmac0_rx_bus2
+		     &gmac0_rgmii_clk
+		     &gmac0_rgmii_bus>;
+	snps,reset-gpio = <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset timing per vendor SDK dtsi (generic PHY reset delays) */
+	snps,reset-delays-us = <0 20000 100000>;
+	tx_delay = <0x21>;
+	rx_delay = <0x3c>;
+	status = "okay";
+};
+
+&mdio0 {
+	rgmii_phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+	};
+};
+
+&gmac1 {
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
+	assigned-clock-rates = <0>, <125000000>;
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy1>;
+	/* RGMII delays are provided by the SoC via the tx_delay/rx_delay GRF
+	 * registers below, not by the PHY or PCB traces
+	 */
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m1_miim
+		     &gmac1m1_tx_bus2
+		     &gmac1m1_rx_bus2
+		     &gmac1m1_rgmii_clk
+		     &gmac1m1_rgmii_bus>;
+	snps,reset-gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset timing per vendor SDK dtsi (generic PHY reset delays) */
+	snps,reset-delays-us = <0 20000 100000>;
+	tx_delay = <0x2f>;
+	rx_delay = <0x39>;
+	status = "okay";
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+	};
+};
+
+/*
+ * RK809 PMIC on i2c0 (same bus as vendor kernel dts). Binding it here lets
+ * U-Boot enable boot-on rails: without vdd_npu up before the kernel starts,
+ * powering the NPU power domain never gets a PMU ack and the vendor kernel
+ * panics (pm_domains.c panic_on_set_idle).
+ */
+&i2c0 {
+	status = "okay";
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+
+		regulators {
+			vdd_npu: DCDC_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdd_npu";
+			};
+		};
+	};
+};
diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index 3a655a817f4..375b649ad2e 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -40,6 +40,12 @@ M:	Coia Prant <coiaprant@gmail.com>
 S:	Maintained
 F:	configs/graperain-g3568-v2-rk3568_defconfig
 
+KICKPI-K1
+M:	Yuming Chen <3305708832@qq.com>
+S:	Maintained
+F:	configs/kickpi-k1-rk3568_defconfig
+F:	arch/arm/dts/rk3568-kickpi-k1*
+
 LUBANCAT-2
 M:	Andy Yan <andyshrk@163.com>
 S:	Maintained
diff --git a/configs/kickpi-k1-rk3568_defconfig b/configs/kickpi-k1-rk3568_defconfig
new file mode 100644
index 00000000000..2e4012609d5
--- /dev/null
+++ b/configs/kickpi-k1-rk3568_defconfig
@@ -0,0 +1,62 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rk3568-kickpi-k1"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-kickpi-k1.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_MAXIO=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index e22c2d6c575..4e0d3a78f88 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -137,6 +137,7 @@ List of mainline supported Rockchip boards:
      - Generic RK3566/RK3568 (generic-rk3568)
      - Graperain G3568 v2 (graperain-g3568-v2-rk3568)
      - Hardkernel ODROID-M1 (odroid-m1-rk3568)
+     - KICKPI K1 (kickpi-k1-rk3568)
      - LinkEase EasePi R1 (easepi-r1-rk3568)
      - Lunzn FastRhino R66S (fastrhino-r66s-rk3568)
      - QNAP TS-433 (qnap-ts433-rk3568)
-- 
2.55.0

