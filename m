Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53127C98307
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 15:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C03AF40D9A;
	Tue, 22 Sep 2026 15:15:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xDU0UsJF9F8u; Tue, 22 Sep 2026 15:15:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 450E840D88
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790090110;
	b=nzN7jc75m/1rVSjtcFLcWMYXg1nummMFe8q2g4aOlDHR4WO/H2WJwkpQo9MYHCHHLdpr
	 EmAdLDEIEWOulN9sJF1LTVcGqUGHsqhMBTqM8BOJvPWdI3+4ywUF110Hb7ITVJkoZS7Dv
	 l/K1fLXObn4RT2uhGgq7M910jObNY8W0ZtRRDs8htlceJqae+8znctT3zfeWH8qgg0KuW
	 r2tycPh35P/Ncgtt4FMaFe/PoyaoxJE/xc0/s9+gIXTLlYocfIG9nvTUUFDdPyrZjnQ9S
	 NnXK1KulgITe5Wn0gHqZlfYibyWAUGBCWqJzau5QUZS0eAwjXtzOesjJQ7WsNYHiF2A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790090110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=E8vU8h6HrjXYBhBigpYE3IK3omBzzbfZ5w79cm0rjI4=;
	b=kV+5pn0oY6tWMJSimKOpW769Nq9+eHI7gvm16xbJ6Lw+2AuerxpCu8mpXNSdDVUbXPld
	 yQm/5bHmvQaMJ4PO83UPkRFGEswrUVh+p1CsC3komULOEdmw6Tj2GbbJBvLzyho853ANG
	 Opf4FiNVZR1+ptkV3uw6GJ8Wb/ptAriKgqGEwii2PXT11to/Uasz+rSFKQxirc5NHTw/R
	 5avZgMu0FPnYvZGOPO4cnZ+NLsYXbkeyEWB9+a8U7aQasEx1t4aShH72HUhqsBX6JE1fK
	 FMlNQCHc/29l0tWGmZOCqfh0FIt51b7ow/C29dYviXGvxEJpn78dQdCBS9nXtqIIz7Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790090110;
	bh=E8vU8h6HrjXYBhBigpYE3IK3omBzzbfZ5w79cm0rjI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hhBqe4wXQO36H+Rzmhqbu+W9F1n+MiWCD5yrYmPmxbQM3CxDGmW2PBJVyFN8s38Zq
	 OByrcH10q+Jp9jBx2ChPKz1FaZ/HcW1jzhbBul7s42JC5LNgGNAYu/NreWmptVrDnW
	 FbjTfgr8N0zCKgjXRKwwVVsI4bu3982x3rd84A0R1T1ytwKdjNhc+AbFSil2yi7j3k
	 TrBi26aPFDc90wlpHSyMVsaIBa6tbcgmUQLf8pYRNBZKUE/kjUVUxMKanD0zDwZqIL
	 4CAiJsK8VdJiXD3fPqwCKA6v4+aTRcSh52vdas5Rx1A/JHn7o48M87P4LmcDYYNvOx
	 QCgfkyeWSUTxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 450E840D88;
	Tue, 22 Sep 2026 15:15:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7363012C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:07:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59491400E6
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:07:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XL_QrbBZ1NUI for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 15:07:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3C2D84009E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.92
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790089671;
 b=oNiWule54xBSUg9PxDEvVl2MkxUpa/5bH/Q8kbM5aqdO5K8aAsf0Q/F9zEWTyB2IpA3F
 RA8HU3uoHgEK8fRFkPH3Njlp8TUlugopnHNn8D2ILZRg/ANp0qBKKcH6y8K0tbp9AfYxP
 Q88XLrX6tlQWPCzQmPML8za9YkC7v/WOjqau+spB//Hl51/dXgqin65UKleTRuQiTX+6+
 vSIj7/R8L0xCK0CwrxK3Ae0HkumeQaQNObS5Au2LoqXxW41UMoKyZc37TOKtwXHRzfW97
 BsNxYpJ7Rx095DzdrGmKhZ5ykFdcDo/SpM4Y4npIJzwLnYTM7n1Io8KpYTjSCwRYqZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790089671;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=E8vU8h6HrjXYBhBigpYE3IK3omBzzbfZ5w79cm0rjI4=;
 b=i1R8MhvkbG7jr1qevEtWkHNFEkbTk7nrfc3gA3SiNQZCYQwwzqKB4TQ1LzhiJcrhwCx5
 l/3woprvVMVJa6GXh9T8P1zKOdiuvihvw0K8t9K2ZTblz0gLC1q2Uxf4BkK7f3YC0Jl3J
 wfrO31DwbEDkx5ssHnpyC3JZOxGjcI0NrdhM2VQ4px53IH1fvSXCll/YawaPY0rB26wQU
 Ll71nvMCJgJcyfd39vLsJhCrN35ll8yiYSW+MCcB5zjZ2gnecdVBm6aIeQrIPH0L3NzF8
 HcFQEplgaMNlSObICStbKmUfFSiiZ1BvczBwfEnByXkgX1HHU8peYR4lvVzeN5VIrnA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=FMQvudKG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.92
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.92;
 helo=sender6-pp-o92.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=FMQvudKG
Received: from sender6-pp-o92.zoho.com (sender6-pp-o92.zoho.com
 [165.173.180.92])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C2D84009E
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790089225; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aLfxu+WzkCzc1WhosWs8AjQ9dvWr7cPwTimE2X1g42bQlVx9qLC99lZ1dStjjMLbW5xANE45UyMoFgqiLYlt935yxKYipVyQJSvjyXzGhKPpve2hDBOI9qxtgl9Bitipk2WGje6LnoI1FQ+sL/i3M7aW5uPa2FgUZC/VfiGdplo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790089225;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=E8vU8h6HrjXYBhBigpYE3IK3omBzzbfZ5w79cm0rjI4=; 
 b=NySEWg3/NyvAJqWK3cOufrzNxfb8Lul3Ld1G6u8mCvHgkpDqZy+mGxTFvSdlJBeC7POFU/B9NA9wjCxhvlsy+br/+cJkuopbdv/vDKKby2E/Vgus1X/cZrc5hPoLXB5XjeZGn7MhcrP3xIc1sXOVlpqtIX5hbG66ZZHEsacUEy0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790089225; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=E8vU8h6HrjXYBhBigpYE3IK3omBzzbfZ5w79cm0rjI4=;
 b=FMQvudKGVQNXbjM1vwextyDJE0eScb0HKJ4owwArldiJ0IMaRr+J7FBcyjq+6LCX
 zmSwuxx85sqxR7CTygUwEdSYBbNgZjeC8obiy7Xl3C3SB1Xwj6i+m+yElCsnvslYJ8+
 Gy0jv/v/CG+Bzimobjc6OHYdDPtj2DgO2pPq8SV0=
Received: by smtp.zohomail.com with SMTPS id 1790089223975811.918426761778;
 Tue, 22 Sep 2026 08:00:23 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 22 Sep 2026 22:59:12 +0800
Subject: [PATCH v4 05/11] riscv: dts: sophgo: Add Milk-V Duo 256M board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-milkv-duo-upstream-dts-v4-5-d45b74dfad36@zohomail.com>
References: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
In-Reply-To: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>, Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Guodong Xu <guodong@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112271b9d4fc7204b7426712bb7060000cc28780a21dbea308a584bcbee997b7daf1cfc0bb41f9e8d20:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 22 Sep 2026 15:15:02 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Chen-Yu Yeh <chenyou910331@gmail.com>

The Milk-V Duo 256M is a small form factor development board based on
the Sophgo SG2002 SoC.

This patch adds basic device tree support for the board, including:
- UART console
- SD/MMC controller
- USB host
- Onboard blue status LED (connected to PWR_GPIO[2] / porte 2)

Tested on actual Milk-V Duo 256M hardware, verified boot to shell and
heartbeat LED functionality.

Signed-off-by: Chen-Yu Yeh <chenyou910331@gmail.com>
Link: https://patch.msgid.link/20260725175346.139173-4-chenyou910331@gmail.com
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Chen Wang <chen.wang@linux.dev>

[ upstream commit: 59c682ffc76ebda27ecbbbd1423e23ec482d61b9 ]

(cherry picked from commit ed2cfe3354c657cd7b6ed1b678169edd0f146f2f)
---
 .../src/riscv/sophgo/sg2002-milkv-duo256m.dts      | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/dts/upstream/src/riscv/sophgo/sg2002-milkv-duo256m.dts b/dts/upstream/src/riscv/sophgo/sg2002-milkv-duo256m.dts
new file mode 100644
index 00000000000..a2797c0bd76
--- /dev/null
+++ b/dts/upstream/src/riscv/sophgo/sg2002-milkv-duo256m.dts
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2026 Chen-Yu Yeh <chenyou910331@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sg2002.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Milk-V Duo 256M";
+	compatible = "milkv,duo256m", "sophgo,sg2002";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			gpios = <&porte 2 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		coprocessor_rtos: region@8fe00000 {
+			reg = <0x8fe00000 0x200000>;
+			no-map;
+		};
+	};
+};
+
+&osc {
+	clock-frequency = <25000000>;
+};
+
+&pinctrl {
+	uart0_cfg: uart0-cfg {
+		uart0-pins {
+			pinmux = <PINMUX(PIN_UART0_TX, 0)>,
+				 <PINMUX(PIN_UART0_RX, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+	};
+
+	sdhci0_cfg: sdhci0-cfg {
+		sdhci0-clk-pins {
+			pinmux = <PINMUX(PIN_SD0_CLK, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <16100>;
+			power-source = <3300>;
+		};
+
+		sdhci0-cmd-pins {
+			pinmux = <PINMUX(PIN_SD0_CMD, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+
+		sdhci0-data-pins {
+			pinmux = <PINMUX(PIN_SD0_D0, 0)>,
+				 <PINMUX(PIN_SD0_D1, 0)>,
+				 <PINMUX(PIN_SD0_D2, 0)>,
+				 <PINMUX(PIN_SD0_D3, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+
+		sdhci0-cd-pins {
+			pinmux = <PINMUX(PIN_SD0_CD, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+	};
+};
+
+&sdhci0 {
+	pinctrl-0 = <&sdhci0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb {
+	dr_mode = "host";
+	status = "okay";
+};

-- 
2.55.0

