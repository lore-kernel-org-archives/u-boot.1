Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD65C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9CE080E57;
	Wed, 19 Aug 2026 03:56:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OJsiSkAseCm7; Wed, 19 Aug 2026 03:56:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111802;
	bh=070g02ll6sMJTPvv+FTDb46uDhxkq6VKpOWuv1Gjd6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+jjNvNdLLThno5SCV0k5BdVmXLH7URfKTX6FdY0UklX3e2zItcaKAXRO5o2NFHYy
	 SBd1v09de20KB31QbIL7eaPrbPy5MjL13oxWkmWH1dU4c0EFc57GU3a1m3j3ca9zQy
	 7U142VqQT7CkCVOTpP/OVA/pYwr9f/tz1bQEtwD3+xbkaHmVkqvjoMerI++lVl/+pd
	 QNBd8spp3xJN3gBSXh9GzqBkLU55H8DY8UWPoAs7lMMPLvmTkYDn358/xbMMzvx68H
	 F5MEJA6/+0xpMVI0e7oFbM23d2owOJukxBDUuFAWHq0aLdHsu/QMilhyZePj1wWXTi
	 GW6HYDh1uMRaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F399780E02;
	Wed, 19 Aug 2026 03:56:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 229FE39E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 145B540666
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bc80Izk6OqpG for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:56:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=x1B/CK1k
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54E764069B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:39 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so670911b3a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111798; x=1787716598;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=070g02ll6sMJTPvv+FTDb46uDhxkq6VKpOWuv1Gjd6U=;
 b=x1B/CK1kBetfX0XZK3dTI5IC2dzucMRc/HSytu+0phUrL6inY/uTtjmqFlWoLPOTcL
 dsb3aNTIEQtjmOmlKipI/wmIkUa0CEntZVZxjL3Oe5daPoXqXcAt8OuQbbhbYzOSNjGE
 +djyyqWz5FhyAaB/pQoIWa0DoUUdY0YQHj+Cc/3sbJXdrk0Pr6ytvFzLVamGjE997myT
 wk7L382gRbd8fZv9Ypa3uB17xLXgbvlpxNIOMQGA8l2dzF9QzEigsIMrUm6pvcp00puA
 goc3vUUMkWa+375WWe6mPJughdvzdkYDkDLeWmmDN+qGnDQn2aXzKXK4vMAzig7RFOzC
 4lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111798; x=1787716598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=070g02ll6sMJTPvv+FTDb46uDhxkq6VKpOWuv1Gjd6U=;
 b=i4YBL7dKHuOIITqzIoOpQEiRHQpY26H6e1VVrJcE517xKGRuoQsht2Z3uSe2U/7fgJ
 7XAIFTHulrlCQzhcYpgXtgfkRI0u476JyUwPI4TTz7RgN1ST5wBqmq1nN0hboRoDGfUj
 oJQejQU8WasoSls8SdIbr1hldribDQt6C8OYdOzSEsUO5VRFRDEhd976JbxTgvV/OPyK
 j4Ez1QlA0xD4ZOQs7r0v95pdirymUsHnRJofDCQVITcQnj6H06Kg/DP/9yvf/rPtEYv7
 ofPfmu6679T8KMYIsO1/2dTLFKGf0R8i45VDTN5jaLOMx/SaY6hoH0+4NZ/DivZyAJk/
 zZ7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrpnyqm32bfewAYOxcblO64L0O5fmFKUYK2eqMb0opp2vV59eQIyG5tASOkZSAWQsLMsvXV3cc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzHilJMgalNWkUo6lit9/HBLy/WZSzOBIfuEShrxFwzjnQQ8MwU
 UcenyULrmBiKjQYjhk/iufM+QwaqWkIVeSeHReJkK6LDYPId7qFNwiSyLIWcNCA/E7E=
X-Gm-Gg: AR+sD100nM7gpa2Oth3EXv8aPJ/MWvzaX1xAEUTL/ARlEdwYLLN1CgpeTf73CdltgB/
 wbMKgQIt6get63vINX7X4zcH+UDxcRKiO8uVtc2vlusgnvkEDQibxH3wIy/e9VOkk4HoY6odija
 lWKDtwwHQ4MnzekSBi7wNJcmrbGirKzkCPbSFzXKVlhvaAHPgXS7heWK577M6zeYvQRKWmkUn9I
 Hom1Rd3msfGmK1xS/O0ZveMc8XusqT1Lwaq4+QPeNeDb4w9D9zo2MBCVkmRvKPJ27wQR43wvSqs
 l0xHBn1S0aMb1UHvHoj5RKDG6fg0imCEN5KtSF9qIwB+D64f7sDZcpjB+sL0YzsFn3QXSm28RIJ
 Kb+EEVXj5L+LWrj1pGiTYC7WFXboiPOG+/sQe/SYqpQX67hqEaJ2LGSZLoHeT89hM+FvdYzyIfl
 BRCy0C0sz3dfC3sIOAtNuDJQXZ6il9rnKasWM5g2J0o6dMMFzFmJiwRJ1fC1GCHi0j21l6n7b/E
 KU2I0gbjwV7+FFi4yBXLV7/21apuw6aeECHwKb5BO2gnZeB0pnwI3ta6L7aXcSs0eZK8dW9lpUn
 C0M5aViYCOwgCYdrmvF0XNpAzg==
X-Received: by 2002:a05:6a20:d48f:b0:3c4:1c9f:d7e with SMTP id
 adf61e73a8af0-3cd0164c45dmr3742267637.6.1787111798319; 
 Tue, 18 Aug 2026 20:56:38 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:56:37 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:51 +0800
Subject: [PATCH v9 09/19] riscv: dts: spacemit: k1-musepi-pro: add 24c02 eeprom
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-9-6e66016392b9@riscstar.com>
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

Enable i2c2 and add the connected GT24C02B EEPROM.

It contains an ONIE TLV table:
=> tlv_eeprom
TLV: 0
[  12.162] TlvInfo Header:
[  12.162]    Id String:    TlvInfo
[  12.165]    Version:      1
[  12.168]    Total Length: 58
[  12.171] TLV Name             Code Len Value
[  12.175] -------------------- ---- --- -----
[  12.179] Product Name         0x21  16 k1-x_MUSE-Pi-Pro
[  12.184] Serial Number        0x23  17 BPMIMXXXXXXXXXXXX
[  12.189] Unknown              0x41   1  0x02
[  12.194] Base MAC Address     0x24   6 FE:FE:FE:XX:XX:XX
[  12.199] MAC Addresses        0x2A   2 2
[  12.203] CRC-32               0xFE   4 0x395ECD34
[  12.207] Checksum is valid.

(With 0x41 as TLV_CODE_DDR_CSNUM)

Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://patch.msgid.link/20260513071958.29574-3-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 6bc75cfa56e885c2eab80e215f0a610075505846 ]

(cherry picked from commit 53114539cb9edac100d8804ba4386ea8a8b37ced)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index 653e5a1bf41b..b8e73eed8e62 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -17,6 +17,7 @@
 	aliases {
 		ethernet0 = &eth0;
 		serial0 = &uart0;
+		i2c2 = &i2c2;
 		i2c8 = &i2c8;
 	};
 
@@ -82,6 +83,38 @@
 	status = "okay";
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		vcc-supply = <&buck3_1v8>; /* EEPROM_VCC1V8 */
+		pagesize = <8>;
+		read-only;
+		size = <256>;
+
+		nvmem-layout {
+			compatible = "onie,tlv-layout";
+
+			product-name {
+			};
+
+			serial-number {
+			};
+
+			mac-address {
+				#nvmem-cell-cells = <1>;
+			};
+
+			num-macs {
+			};
+		};
+	};
+};
+
 &i2c8 {
 	pinctrl-0 = <&i2c8_cfg>;
 	pinctrl-names = "default";

-- 
2.51.0

