Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B2BC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1685F80EA2;
	Wed, 19 Aug 2026 03:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9pUQlY7Iq9r; Wed, 19 Aug 2026 03:56:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111809;
	bh=OLKYRoMiXKWGmP88S7wo5+XrL3qD4A+ckBwywH4yGLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nf5xvJS46/YoNJALB23JFDLxbH9yCbQCbofSFBAto/lLg18xyBcdjL/5rOXSdZ+mF
	 apS5G1YBYwmsRvNgcNRWVCutPKWhERBWfk0n0RFg59IwFOM3K2LjGmN6y6EqewRa2A
	 vvF41rv9vyR6ECf69NzkXyX+k8UblbXNbcBFCaL83yx8sY/oVItJ82QEKRcMzXm/E+
	 2zJPHvNciGMRnL7VfGNzBQosOx2bWwIMVWo8kTP6y5Fo3JX4CL7fxVAnwpZ3nCj1fz
	 STfQcYrHz7vSrB32xftWYkZqevtsfIjKoWDWjrHmEXtiJDynbId3t7/BJS7TS7UxXl
	 puJMk1CvzOsLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3670480E72;
	Wed, 19 Aug 2026 03:56:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 86A5A23F
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D0FD60656
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xsL4kKTCTG3p for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:56:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=HRWtwJAU
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7FCA26061F
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:46 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso6192605ad.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111806; x=1787716606;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OLKYRoMiXKWGmP88S7wo5+XrL3qD4A+ckBwywH4yGLA=;
 b=HRWtwJAUgSyJhmwxwVL+hWezQunwkCny2ptuggkAedKvT7kISlMf5DP+VYPU3g07nT
 wRSTEJV03HR51fr3DNhui6CO5Yvb8QVIw6Nry/uDRNNoo9zpsN3aFPN0caSl4Tsva5Ej
 FlH2meDXoJr7GiIbE5fjEdG4Vp360+a3viseoCKxIXpmRyNKbzz4N1RnYxsG905CF2K1
 INzMO543AWRtuKFhL9bES6xh96DbT7YkEo8PbCioLl0T5MiAqTigEMQOWZ1V9o2qBh8g
 fqIr5lOh00mBpTmVBiB0EVdxqtt9xF2E5hIPBkzYB0hLwd0BJ430BCqkCHk2RS0XrSTm
 AP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111806; x=1787716606;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OLKYRoMiXKWGmP88S7wo5+XrL3qD4A+ckBwywH4yGLA=;
 b=QOq48IRJMKWab2rNFdzspgG3Iu/daqaHNUnfu9EXyW09T2ohklUrHp8Us1o58ThRoK
 FQ7C9Bj62P4u8HLlevIk6QfbSRsOo8yiZIomdKIlm32nthuAGNLyF1zEsyHgbz4T0ygC
 S5AxvA67sZzKkYNfvOwN4/SAqJwpj/b9HNCLLS8OEsjEp3THSqlBP7EzcWWVg6M9bhtS
 2QJjVbdl5WpStONVKuk23HMOp5/teun3TTvMBaNr5p+4h9K2CU9lJNfbBe1vobNESrZA
 LXIZ7xC+mrdvRfJERDE5Z1ZJWMxXfE9JrD2zLRy4B4hPY81MlL7z5XimsIktPu3waREY
 rL5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqADGfjTkjem9AU29ATawEn3BwCm6US6PJs/Vq4d32Wt3s/40QgokkZ+18180IfNOXbeo84dpQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyYIMiLF8ETy9k7Ecxjop4QxvcEWFfdMV0FmHmHzAq7llr6jA4o
 XAlEOVuXjI8drFrtH34zH3ou30VpQyWYVAb35MvP88cjAk3oBgKUCKMWyyyEv7C5W3s=
X-Gm-Gg: AR+sD12bRAJxGY3jVOTI9odLsQeZ72crX6nADtMiAvZGAUqYf8H4Y0aEBqOcxSpvqgI
 LQMKzJaMMrwJ34AQc2XN3+unXtYBRFJYtnYANhc2jW6syi54iGTW34zvEnic1woekUeh0SEsdxE
 QExj1PX9eKmWEn+/oeMQYSnW4VrROYORi8rYdwfs+bAQfrxfjpg/Us3gC/XBNmfezdKrsNdgCIf
 kwjN8/E3mJ7JyLznmT5YihcdeeXMzVEKVHs7bAEmnAOVd0bYsZ8krOszIdnAv7W8Lt/aqjcVtH+
 yOAE9tz/c+RSAApbZWHw87wkLXrt+o3FRlXOsKtzL6XhNH/0UY4msOFubF0d/4eA35Y6rLpKjPp
 lfNi8GpfcestQsl4pwglTdlahNDa06/ZsRne19kyBdRGBPJgEBmxp/HXkQ9PIzZ/IRV1gc/YGTq
 D5CkupKcF3jyHXbTN7O2FTKJIi2SleY8WN3/l/G1ywrgvpibpvYZmk+LlbHqJia7TjzQ6Ev36WV
 HtAhlyVtD4yyN4VmURkvFX9PFzbsOzhUovlrfoAKMO4KINzFfjm495gEZ8Iqr6UdZwaB9ts2Z0E
 30gcs4mPRlzqyn+ZV9wBPLWzvvYP6ULsJWu+JQ==
X-Received: by 2002:a17:90b:3c46:b0:38f:23d6:b4ad with SMTP id
 98e67ed59e1d1-39580aa420cmr3323317a91.8.1787111805694; 
 Tue, 18 Aug 2026 20:56:45 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:56:45 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:52 +0800
Subject: [PATCH v9 10/19] riscv: dts: spacemit: k1-musepi-pro: enable QSPI
 and add SPI NOR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-10-6e66016392b9@riscstar.com>
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

Add the QSPI controller node and describe the attached SPI NOR flash
(Winbond W25Q64FWSSAQ).

Add a corresponding vendor flash partition layout.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://patch.msgid.link/20260513071958.29574-4-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 735b1b205d07bf7bfa55b1f50f5485b9cc42a251 ]

(cherry picked from commit 30ccfd225cc1aa971a0748faefa14e735e49807c)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index b8e73eed8e62..74841cffd5f5 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -44,6 +44,15 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	reg_qspi_vcc1v833: regulator-qspi-vcc1v833 {
+		compatible = "regulator-fixed";
+		regulator-name = "QSPI_VCC1833";
+		regulator-min-microvolt = <1833000>;
+		regulator-max-microvolt = <1833000>;
+		regulator-always-on;
+		vin-supply = <&buck4_3v3>;
+	};
 };
 
 &emmc {
@@ -239,6 +248,47 @@
 	};
 };
 
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_cfg>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <26500000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		vcc-supply = <&reg_qspi_vcc1v833>;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			bootinfo@0 {
+				reg = <0x0 0x10000>;
+			};
+			private@10000 {
+				reg = <0x10000 0x10000>;
+			};
+			fsbl@20000 {
+				reg = <0x20000 0x40000>;
+			};
+			env@60000 {
+				reg = <0x60000 0x10000>;
+			};
+			opensbi@70000 {
+				reg = <0x70000 0x30000>;
+			};
+			uboot@a0000 {
+				reg = <0xa0000 0x760000>;
+			};
+		};
+	};
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	pinctrl-names = "default";

-- 
2.51.0

