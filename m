Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878BCC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5048A4069D;
	Wed, 19 Aug 2026 03:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fTH33ahTOksY; Wed, 19 Aug 2026 03:56:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111815;
	bh=LE4xlra5gR8klWAk8DU2WgZHmoKJMD4TlCMeSM0UQbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tBP5O6KHPVnTvn24iV01Yu221fQoN3+WQwPvye7cLTY9b40pxBbhjQDHj2NuNdhI6
	 V+Obo4I8FxEu3Jtqg5FthtqSIUn5jl4cKzytwfe6NRlvhsOOLCBpqMjDqakxb0FOJR
	 cc4kGrLtj9eRRsgDMtfzE8aRSKV4OIGzVTUtqIbs5w0D4tMBQc2qMQx27b9Eq1cKad
	 ZPinyjK4+kjz6HOnpbFz5Lo2hEv5kkeTRrRY2sc50vEX3IQyX9yviU9QAXpYcOm8MF
	 2ER4vIRbEfe/carVRK1z+rcmQma8HEoNCuzACVVshOuxwJcErntdjzuVjKG5I0DLLV
	 zMc7Z2phfxYuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E0E340666;
	Wed, 19 Aug 2026 03:56:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C351423F
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0F3740666
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X2KhjZpYm3gz for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:56:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=kpmLSzPI
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D385040664
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:53 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so587578a91.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111813; x=1787716613;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LE4xlra5gR8klWAk8DU2WgZHmoKJMD4TlCMeSM0UQbw=;
 b=kpmLSzPIL/NDnN8nRQsaEmoGI09mbAdicsmPt6y8rKTpEyqvSB7La8BcGdfhBgVIqt
 Md5ST47b62BK9V2dGaQj6KxXZDKQUa7Xt7TC63uxDvXnKTHS91lRHUdwN8tiFdOPcZ0L
 zvtUhGRfstspzV/2OhcU+hJk8ch3wKKQ7Y9GEAaZxyD/+PGf4BWXvXU30cg9Dg1P0MTA
 uxeHgqCrqClxns/EcQeR9G+lbXH9pqmmMFrsHxDchZjcHUyMO1b+8zFreZ+eTTDocbmX
 dcS5uTC/2rKondeh6z2bU4eoodSuMDm5+9c1QkuOvLKIwMZ2CV6hWUAFtNRsCx2Ps7nA
 7iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111813; x=1787716613;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LE4xlra5gR8klWAk8DU2WgZHmoKJMD4TlCMeSM0UQbw=;
 b=oCpvhCDTvh6Xb2tvCn5kCzfElwHTt2dH+tbnvnjO8bjeaievoK9rZ+FgAD91o2yUml
 IjbjKlEfuiAy8qpTJK77+I1SyGZbBdoWBCqY5qDOnOqIe/F35YcZbjjJbYiHX1d2Ay78
 7M7N620O4uAajwkPEyxgSp1LyDyS2f7+LXCGxaolZd0YG6lsI0JFwANA3OC6c4y7+U1D
 RzB12VP3OlspHFuHHRnnSKeq3UGska8Zo1ouJA36g87Pdt5+cJJqL1TONKsxqPWTG6i6
 GBKHNIAHbxTCyxq06cquVBw7h+z/mQR6QYkXB/9CBdtXK78P83myoRQj1A8APtJTwzDX
 FtDA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9Pg1e6edZYe1g+3hukDCZkdi/oW8enRvbsDkc6uK5sbhAQ4yGr52bZhX49hKpZBkqfrf6WkY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwuNFMMmm4mkr6TW9LJFZ+CuttCIqhkrksgQ2SxH6DHR77wBzsR
 TzlqGhj42kqTfdiQ0srGqDwBka0MJhD3gYYWf4lM6tX6ql4t9PMr4zgMdKJteBaNfZk=
X-Gm-Gg: AR+sD11qUfozgnuTt99M5R4Z7QL/HGK8GZa4DOS2Fh0f8wW24V4As3CF+REMj3b7R4P
 WE8e6OioyxrlC7R3XSa1p3m8v+Iim/ULoATVoUPNoqIzeo7+YK3duQ1zdAEDCsUZIoDea5JBB9g
 QVF67I07Fqew4Uc+U3ci9Y9Gm2lWjTfzXBvUPqh5ROMzT8tYzEkefKRK/USphI6URR5sndKKPdC
 3vPwRJ2K57kt1JOcWzP9LGA/zTSQLmUzjaDllPGznAkWjUuJiDAdhXyB1b3axtnbjf4xCR06EOV
 GageRxTmfChb7ikeUiq+MEwRaBGy7xgubrbVbe9OS8SoIUVc+69b9VbnOb0UHR80dIy4ctpcT4Z
 l+ICN8kYABvW5CsFtGxqry/a6VvpWgQZZXbtSkqfFce9xvjckMzb6y7j5vhH+kGN17cHDVqrBxT
 0NHgfSpYmmC4IDQimJrg75MwQgj5qhEY508kk2kuDzqDUN8terrKUQoCB2W26xz0KW9vAjnSBSL
 cTu/+lITMr0s8/fKIBQBwNc19IgxP2W0saxBaV3XfiZMT3jONP7PQoYFY6LYBcnVFyGLQ0vkyUM
 ws9k3PniRjrArjZ2ywWdQ65ayg==
X-Received: by 2002:a17:90b:5105:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-39581070da4mr3354947a91.15.1787111812935; 
 Tue, 18 Aug 2026 20:56:52 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:56:52 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:53 +0800
Subject: [PATCH v9 11/19] riscv: dts: spacemit: k1-musepi-pro: enable USB 3
 ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-11-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.2
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

From: Andre Heider <a.heider@gmail.com>

Enable the DWC3 USB 3.0 controller, its associated combo_phy (USB 3 PHY)
and usbphy2 (USB 2 PHY) on the MusePi Pro board.

The board uses a VLI VL817 hub, providing four ports.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://patch.msgid.link/20260513071958.29574-5-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 83c658c7a82304a2bc944cdd4a5b4f98d19322f0 ]

(cherry picked from commit 73f4ea03fac73bdeeaf3ed5c84de7f38ecea1c36)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 52 +++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index 74841cffd5f5..b284bf416880 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -53,6 +53,26 @@
 		regulator-always-on;
 		vin-supply = <&buck4_3v3>;
 	};
+
+	reg_5v_vbus: regulator-5v-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "5V_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		gpio = <&gpio K1_GPIO(79) GPIO_ACTIVE_HIGH>; /* USB3_PWREN */
+		enable-active-high;
+	};
+
+	reg_vcc5v_hub: regulator-vcc5v-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC5V0_HUB";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		gpio = <&gpio K1_GPIO(127) GPIO_ACTIVE_HIGH>; /* HUB_PWREN */
+		enable-active-high;
+	};
 };
 
 &emmc {
@@ -65,6 +85,10 @@
 	status = "okay";
 };
 
+&combo_phy {
+	status = "okay";
+};
+
 &eth0 {
 	phy-handle = <&rgmii0>;
 	phy-mode = "rgmii-id";
@@ -294,3 +318,31 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&usbphy2 {
+	status = "okay";
+};
+
+&usb_dwc3 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	vbus-supply = <&reg_5v_vbus>;
+	status = "okay";
+
+	hub_2_0: hub@1 {
+		compatible = "usb2109,2817";
+		reg = <0x1>;
+		vdd-supply = <&reg_vcc5v_hub>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio K1_GPIO(123) GPIO_ACTIVE_LOW>; /* HUB_RST */
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb2109,817";
+		reg = <0x2>;
+		vdd-supply = <&reg_vcc5v_hub>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio K1_GPIO(123) GPIO_ACTIVE_LOW>; /* HUB_RST */
+	};
+};

-- 
2.51.0

