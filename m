Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BF4C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4B7A82E36;
	Fri, 13 Jun 2025 15:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MrgzV/qn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1C6B82D18; Fri, 13 Jun 2025 15:22:08 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA4C082C30
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-605b9488c28so4044709a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820926; x=1750425726;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6H9CuxWdlmzJkhdA2JO8EKexK6zKHD7kEQrPErAWKpM=;
 b=MrgzV/qn3c/0ZDdhdSTmsZkph2k3eMEohTY8E0j/G5HnRp0CD6iwVp8Ohd+8UxzbDp
 fVRF/TohSIMvnXptTExq+/fWGUFYiNFJO3J4ZMwW1tlDWnXCfYDaFz/ZTSp/qGoB4DJS
 W3tbuOKXEUdThEDFiZDDPaCvU9DNkOuKVJY+lXf9ZIvSWg+5e2yfs/4VK/vd+Wqojwqs
 N3Sf0qBt6PfrzaCUPbhBpiNwaShbIbDAZvPXt33XH/WYaGetMzBKP7IBIj94qjzFNlus
 Y4ScdA40C6iZZZ2veqbJNdHH34d1+MV/KyT9CU0wiiiPuECsxbh9L2S3avoi8gA+irB4
 tvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820926; x=1750425726;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6H9CuxWdlmzJkhdA2JO8EKexK6zKHD7kEQrPErAWKpM=;
 b=pdjCRK1J+0voDTAxaqJ1+S/SMn65K9exeZdLCSR5pLa7H+GbuqWOfYSeS2pu+ffoyL
 TKcXyrmBhTJxjMtRgZchTj3b24JzU3HpJQsUWN2747UwKN8A7LvHCKXAblmYR1ILS16v
 BqgiAq1MXF7EPR1RgowFmXlEsP/gphFBzQvr0R05a05ZiX9kLvSIJWRnl3pGgUSIfA37
 or4mfyC5/ahNiaB9JKR+DBl6mRWfBhC88J5oZ3454CVYbk+qjYIZNd7TzIlzVhE5X0nV
 rA8Kh70hLDJ64v0uBsGZ7PMi0Uo9IhX1T7WLLEQK72qp6xUnIA7kVssgRzMwElF/YOql
 6tCg==
X-Gm-Message-State: AOJu0Yzs6/pDIFVZVahXqeFV5oo3O6qD+TXWCZCkAZZ98bX+tnKg7sLD
 ebIetix7i5LwEXd3UQbcjOCyTLioQ/1w9Bgz+t/1Ne23Uol5dSZzPpo1Ze/ThVfyRp8ARx4vGo4
 MOl/8
X-Gm-Gg: ASbGncvAix61hcx8MM61g0oMd0Bd/rcoEGvNIm49pH/Xoo303oyYNiU7EcJ5M2vfe6t
 Uvty9OAnfQY5H5SRsAgFPdep1SI5nn+ow2GtJKOl9S0esZfS+dNXhfcXq21FaISw8TZdsyNko7P
 fbwcqqexEFKFTrTZxMIthxVohKLS9PCObi9gzWmpEJKHQi73N7zq+hiGQXtrmQgR2uRFBw1r9w3
 IorOjnw/jvUsiDdTrc6qCdxnFgGGgEQXohGYkcgKh8Ola363QoJ7ysOav48d9x7s6l8Nf3w2587
 9oUBd4SQY1YRLLI8OF97yuomJI0o1yPnV2XKA7aY1BxKX8CJg/9K8aaZaCk=
X-Google-Smtp-Source: AGHT+IGgh9Ay+v3njj05kRltDcB+LCEXHnDL/8433AwJv8eNQ/wivRlWc3hSO/5ILaZl6S6y44eZXA==
X-Received: by 2002:a17:907:86ab:b0:ade:f72:435 with SMTP id
 a640c23a62f3a-adec5cb5a0cmr292510166b.36.1749820925991; 
 Fri, 13 Jun 2025 06:22:05 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec88ff430sm127588966b.105.2025.06.13.06.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:05 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:31 +0200
Subject: [PATCH v2 11/22] arm64: dts: ti: k3-am6*: Add boot phase flag to
 support MMC boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-11-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2804; i=msp@baylibre.com;
 h=from:subject:message-id; bh=NcZcYBYrQvdQ6LTTGn8XgXpk6Hl0VLAtIHLR+fBjbtw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1U3x8wQjZ4t/YS+vLk7792WBLI+pXLLG/Ynr79/8c
 nHtgUsPO0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiEy4z/I+ZzePRwDjZ5m/i
 oanTDk85OelzjBXfmXeHCuxqSh/tE3Vg+KehLbQ//9jnZ+wzX6wz2rlp1vxp3qKPtex1PjJ9fRL
 96RQ7AA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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

From: Judith Mendez <jm@ti.com>

The bootph-all flag was introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across
different boot phases.

For eMMC and SD boot modes, voltage regulator nodes, io-expander
nodes, gpio nodes, and MMC nodes need to be present in all boot
stages, so add missing bootph-all phase flag to these nodes to
support SD boot and eMMC boot.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://lore.kernel.org/r/20250429151454.4160506-2-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: db3cd905b8c8cd40f15a34e30a225704bb8a2fcb ]

(cherry picked from commit efc9013586bda11485bbc190592bd25d83d0c1bc)
---
 dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts | 12 ++++++++++++
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts  |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts b/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts
index 8e9fc00a6b3c7459a360f9e1d6bbb60e68c460ab..aafdb90c0eb700b554c6c308be6c1732d0459a8c 100644
--- a/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts
@@ -69,6 +69,7 @@
 		gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
+		bootph-all;
 	};
 };
 
@@ -77,12 +78,14 @@
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
 		>;
+		bootph-all;
 	};
 
 	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (C13) UART0_RTSn.GPIO1_23 */
 		>;
+		bootph-all;
 	};
 
 	pmic_irq_pins_default: pmic-irq-default-pins {
@@ -118,6 +121,7 @@
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
+		bootph-all;
 	};
 
 	exp2: gpio@23 {
@@ -229,6 +233,14 @@
 	DVDD-supply = <&buck2_reg>;
 };
 
+&main_gpio0 {
+	bootph-all;
+};
+
+&main_gpio1 {
+	bootph-all;
+};
+
 &gpmc0 {
 	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
 };
diff --git a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
index a9557ee73b8311087db9ce9cd9596efb8bb8975d..22be41d46eb519917516fba5f2439bdb492c46f4 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
@@ -313,6 +313,7 @@
 			AM62AX_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
 			AM62AX_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
 		>;
+		bootph-all;
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
@@ -634,6 +635,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
 	disable-wp;
+	bootph-all;
 };
 
 &sdhci1 {

-- 
2.49.0

