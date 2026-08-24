Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E32C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF1BF40698;
	Mon, 24 Aug 2026 08:51:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f712zMmJyoTr; Mon, 24 Aug 2026 08:51:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561490;
	bh=mQjAFkb0s9LXfw4ISz9WpspPyQqBS1k+JQmiq7crmrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VrFIiEK1zufHryAHc7KzhVqSQlAMNnqddL/6HIfM7MDuHVMNT8ZDa4i3FUHlWFD0l
	 wOEOVIpIBg5uzJ8kkYM2R8ycM87nEoGYNxPoyXmQjclb0zqXJRZV5PADMrkr/l455P
	 uHH0it6pTCY1dEXQG79gKzZQiW7ZwARaRM+YeHuUxexm8fQ42ClDHoHjsEyY7y666H
	 bBwV7OQOjYgqKmLHrj1Dx6pL5NaVUnH9107habtX4xOD2rVxSzEZM3+oApTJsOyhEF
	 UZWiOlg4R2v/yruAupAulkJTxQhE2o/lJvMEjN7hYPeQ1ttUaCTNZsg7DOvtjfK6Jm
	 7RTLLBjtZYV9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E56A2406E1;
	Mon, 24 Aug 2026 08:51:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 377E93AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34FEE60622
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bQOf12hamOPN for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:51:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=K8wFsDsc
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60AA1605F9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:27 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cedda2ce6fso18615765ad.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561487; x=1788166287;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mQjAFkb0s9LXfw4ISz9WpspPyQqBS1k+JQmiq7crmrI=;
 b=K8wFsDscpsN9MvL5OiGMr8bWR2GXaDMCbpzfDKOAlx5gDrNoCR1Cq3aYaFLjhHtMc6
 FO4voOFTOra67f9zafS1Y3WlkaPG8P1vIp09Px/hGUMbxXgHS5wzD5b30XGLQy6JymZE
 BdRiDS/gzCvBvsm7YZC39y/RaXoE+qAXN7LMsJqL64ICxZT9MOfk3lgEQFnVzmuV+62V
 D8uvV8Lh6a0O+EQt329GTIx4yOlbDXFhWzuUDJYZwsfjkpO5qD4H8GAF4pUcscwqLUmQ
 AWFd0STBOvhACWujinRSygZvAaemBaskSrX9WIzRfc1waoQPSoISWMcXU0V7fRjZOrpr
 c/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561487; x=1788166287;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mQjAFkb0s9LXfw4ISz9WpspPyQqBS1k+JQmiq7crmrI=;
 b=CbMTjQ/CSwhHfljUhI1f7JtjHZO8JcX7F/9HpyXLDAcaO6Qb5dD4zM3Nerhz8AqUdS
 ydjLsZmQXhJsO4ahIHm3vBVRH8LAXrIFs5OdkGvbdcICECAWaVdB5CnhKRRQgRpQbIEX
 h7zi5NA3j/YmCjkKdFjV+p6BsHylwYWf7FKQSuNHGLipl/RKVYpKApzm0eA2UxkQe/64
 5qrOkMuvBUwaBTED/s8c5yIOfGFJzEIleEv4CwSHhm2uKkLSfLq5Gyofl82jQmeu9j3v
 Px9OahCsybRCIzyi43f6ETe3Eg+BzL6huRMC9rzP3T265NQOm92fwkHqXKC5Gg04v/bj
 y1zA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDxMtLMTQ93cAo60/Dr7ScvDcTVRrbdKLM5FIddSbQyx8VQPQTCTRgQBIFa5OGPoC2dsNFKZo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mJu815ijJQzrvR3SauEBw4jFdlUoGAkUOmgIhSLW8O7EZE32Gm
 Wmkbt3G4CE2ytqCn2jcgAxA6D3R88JeUd3lDvegGX0oFmA9GbMEVpsjfOUoBnrcz7Jk=
X-Gm-Gg: AR+sD13Cou1Wc+7OXp0bjyCktewowaLQSGDFLpxqNvleVweigh3+l9DdyK/n4ObqQ6x
 uUSf20lvjt0y6tYkWZcJdct600vDlJ3upIKdlYONQXbLABcGdNS4kxw93fHtTcrgHy5SyUTPglU
 k0f8YF9gtf+rGi+5soEgFdL3fGYIkoAxRp/PJRs1MYo0oy70YvvQr4lR//tok0PE4gilQCOW8bu
 FrXR3KDC/XoZ0sSEUeZHZq1QPNntl4ZYmFtuf9ohVgk33LfaCCex0zOArim5aUm0V6GO7zOesy+
 M8rce5u059LZ5RnuU23jlGmLDf5SYiUYJlCyP8P5cGyrccn7L4MT8ke/4WU1RENJWbsREPERq5e
 ZcU+caEEvIBTqlqhLZhGXe+yMm6qq3SA36H3y3HRuCsBxw04dbTaeoOyXd0DD7TumlGD/F5zpU5
 ZpQO831vnceZqsiU56r91jI8dC3LDWFxAqRst9/Xdk+OnernCuo84L3SGUuD8Tu41XgK0brjrVM
 sE+wic9y+0kvToHH5g54wt3SC5rNVmE+Q0HdpxrPc5su4uu2CPz1+q28S4WWk/y/91W61dlYkLh
 THk7h1D/+1q2yz7nIpLFHABLlA==
X-Received: by 2002:a17:903:1a28:b0:2d0:401c:2ebb with SMTP id
 d9443c01a7336-2d64adc3f0amr470685065ad.4.1787561487256; 
 Mon, 24 Aug 2026 01:51:27 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:51:26 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:41 +0800
Subject: [PATCH v10 06/17] riscv: dts: spacemit: k1-musepi-pro: add PMIC
 and power infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-6-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
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

Enable i2c8 and add the connected SpacemiT P1 PMIC with its related
regulators for the board's power infrastructure and voltage regulation
support.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://patch.msgid.link/20260513071958.29574-2-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: e2dac7c7a3a8970feeeb758f782ce86b89625ebd ]

(cherry picked from commit 2fe09049336c15cc0fdddd900c846dcce99cb62e)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 134 ++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index 29e333b670cf..653e5a1bf41b 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -17,6 +17,7 @@
 	aliases {
 		ethernet0 = &eth0;
 		serial0 = &uart0;
+		i2c8 = &i2c8;
 	};
 
 	chosen {
@@ -33,6 +34,15 @@
 			default-state = "on";
 		};
 	};
+
+	reg_vcc_4v: regulator-vcc-4v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC4V0";
+		regulator-min-microvolt = <4000000>;
+		regulator-max-microvolt = <4000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &emmc {
@@ -72,6 +82,130 @@
 	status = "okay";
 };
 
+&i2c8 {
+	pinctrl-0 = <&i2c8_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pmic@41 {
+		compatible = "spacemit,p1";
+		reg = <0x41>;
+		interrupts = <64>;
+		vin1-supply = <&reg_vcc_4v>;
+		vin2-supply = <&reg_vcc_4v>;
+		vin3-supply = <&reg_vcc_4v>;
+		vin4-supply = <&reg_vcc_4v>;
+		vin5-supply = <&reg_vcc_4v>;
+		vin6-supply = <&reg_vcc_4v>;
+		aldoin-supply = <&reg_vcc_4v>;
+		dldoin1-supply = <&buck5>;
+		dldoin2-supply = <&buck5>;
+
+		regulators {
+			buck1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck3_1v8: buck3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck4_3v3: buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck5: buck5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			aldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			aldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			dldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+			};
+
+			dldo5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+			};
+
+			dldo7 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
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

