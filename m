Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0425CC98324
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 13:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2DB140807;
	Sun, 27 Sep 2026 13:17:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Od4GlMa0sZtb; Sun, 27 Sep 2026 13:17:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ABFD940649
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790515047;
	b=so6pPyWcuONiumh5jpWRlj2rFX8cN7MmkmuZamF1ECP5JsW21whweteflnj68rPn7Dqs
	 muS2yz4W2vibw3Sg+jxO5Wdl5VXjDjrNXIA/Cmf+gZEpgTnBLOVOCVv4leBRbWUG5zExg
	 Tqf5elaZ2GZ0Bz6urhMERvhFbhVvXIyCZqYCK4/WLkAIvh8ebGheEi2HIyn6BiKg//sIO
	 QEXdSbsy4dllv6FHm3I+uhzQoK4dAt3B2xdF67u8RQwFQrqIIQOAwv2hMmubYURHnR42J
	 XSyETngAbfER2oqiHl9XGxQT8s/6j+HkRTfqeTV8OrI3KyIZamxt4LyiZjYWSFu2C1w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790515047;
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
	b=N0i62+0NEs8asJ7mbGvE3zdkMQecu2eSkj7HMMl+V6TEDSpKE5QOzN71KWQJCV0Meoaa
	 FyTJRf64dlPoQKR1wd5b2Y4RYbkE1ChkeoLUNtg+YSDqjuCT9po9gAEAYwGLQBUubniq5
	 48od8bmansGVFEaPRsAPZL7RV9lxDeG4or57dbb0kHXBj4Siy9m0L8KJD1pLS9HzWJ8lW
	 hM4sEC3DaGUwXwdfTOOMezme2qypn5a+K9npSrZHmlvqKyu3kAe2O1DfWuZa1nFJL7TcK
	 /YTpkXSAREKW9jfL7jA4CE1bV5eywJnaQDg9hYe9HZKlCTaMJFNnWQUEuCdxxnB3Gcw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790515047;
	bh=E8vU8h6HrjXYBhBigpYE3IK3omBzzbfZ5w79cm0rjI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LA4wEHSdFWeQNwzschBcLtV+WMDUdRf30GP+muzaqJF8P9aOgB2LOgEE7Nh34PaMt
	 wyesgLvA8e38DrNloYhVoBH55hVtEOR681ojR59UT0DNfc7vVrQvmeoF3vdYF0RohL
	 sQgZiiPJo9TieFygqpB+Vy/wN3oTeBknNinp9tBnjw439xozYBFsLBxGORjBBY2vyu
	 FTrcDD22eeSKqmPTY4zZjx9A9n9LxE1gTTNn11u/cjKoa0s8ZUcpEY2BaeZnIJkVH7
	 T/1mjlPTnwND4dg6Wyki2N4g91UG8Rc0GiSaJKp31hHeqOile1C6xAaN1g0NZBBSEM
	 1sTi64Nt6OVmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABFD940649;
	Sun, 27 Sep 2026 13:17:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 71C0F3D8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62FA06062A
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dh6YQV9bishr for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 12:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6C79460619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790511367;
 b=Q5LmhnqCGVlhaDWPsqeGUE6co/AJYyxOPBE+FIkbSzsh0DTlHJHe5sFgcEJl8jQyBK/c
 wRnLbec2c6b0S1jcY4OGzO0zniy++NGMHDA5pcTiH8bGnwAN+7SFVGjyhXvdqV5Dtgyl4
 vT0b5UtklfJuNPkjpJsMLYRyZPemeoRi76jL4Wy5YzmBGtOv2SKXHRNRCv3B3E8lPS2M6
 IAkJTOBP1kw1aVuwAy424HmYETwUHWKGs8ZAudbOmm5ldS8twHaO9IXgIU4N+tOdVU1pG
 l98D+hm0t51ZFSXG/4ig4yirQUSPLpE3eoBIJjYa6mcv95v2sj6t1fShGp551rdjKaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790511367;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=E8vU8h6HrjXYBhBigpYE3IK3omBzzbfZ5w79cm0rjI4=;
 b=e3QcwzRuBxSqeYtHDdJHqnHpBtyU8fngJjQyMlY3fnDVXWy65sWiwNsGw1Nt2ueIw5hO
 BYlVBp9OyS8PYYdrqcOSaUTqgWWqQGUT1SfJw8xHpWhVa6m7SqKVNgHRvbuBf9RborXd+
 gSm3HQQ+sCrGlVxvYBTfS4e2XVWZbPAIXxauZspj1SqLmdN0Pamwv+JZHBkdUjaNuq4R/
 VcZ8HYOXJs9CCqn4HnhIDBkZ9LS9N36q2XiHMA5MGcNE5Cl23kezlk8XBBOUOdFMr+rWa
 tfvFVUEVWWGUMZ4/fv5NW2pHKVj9YgaKcrnjf6xNn/mtIezcyH4nXepn368UFViwm4A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=AAzcqC5R; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=AAzcqC5R
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C79460619
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790511017; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Y0PPYLaRE+dQM3Zvn9eTne+Kwn+nUuWTzQdvMnlh6WaseXjl4MQNBlHEd4qOlv8ikjNeS0uMC2DZjB3+a4NKyocjYra5J5pXnMrypXUNqyDzmIls+mUFrNCWzSQjN/6I0xti3WgW1XHgGjtgQi4G4rppJpoT2nIK0JkYt6ptVNk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790511017;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=E8vU8h6HrjXYBhBigpYE3IK3omBzzbfZ5w79cm0rjI4=; 
 b=in8bnE+yO29J0Ezolof3PYQSfA6uFZ/wa5TkDH1A8mXF0cCnJ3uYd7Rt4CNjzCDvLwwAXjj7ZyijztmciVmPSL9uFsFXoEXoZaoF6tGdQtELr9IxQLYr8jIl/ChiXEDZmH+iISZR4DoOTSqxer7N23gtmWJvoOQOg8FMn8lB60g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790511017; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=E8vU8h6HrjXYBhBigpYE3IK3omBzzbfZ5w79cm0rjI4=;
 b=AAzcqC5R5N/8mLFisxUBVTu7jKjQzs0eR76NA+/pI+6HrcdPCpENNPPcDsVwF/5S
 BMrcagiomuCJnwG1HVovsHzb1sppmPWe3Qkqfa844c9xSwIlB4rtJC9qlfsury5twmI
 dYUfmvNGVUnlEKPBYNxuW9+830/waoFDusZVSCfA=
Received: by smtp.zohomail.com with SMTPS id 179051101552764.9309246408393;
 Sun, 27 Sep 2026 05:10:15 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sun, 27 Sep 2026 20:09:00 +0800
Subject: [PATCH v5 05/10] riscv: dts: sophgo: Add Milk-V Duo 256M board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-milkv-duo-upstream-dts-v5-5-7f64983e59e1@zohomail.com>
References: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
In-Reply-To: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
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
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227808ece44bd17495593fbbf9100009ee2bf2993e45a07b620eabc61b3924e42a87b37966757bcbe:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:17:14 +0000
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

