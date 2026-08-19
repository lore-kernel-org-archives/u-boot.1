Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13419C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEC13406B3;
	Wed, 19 Aug 2026 03:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxhJZXCpM__J; Wed, 19 Aug 2026 03:56:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111793;
	bh=mQjAFkb0s9LXfw4ISz9WpspPyQqBS1k+JQmiq7crmrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sqAeCxR3naQ0aphPTiX0M1o/3GJLrYOEkZysDV+tZgSwG3gDtJmUcCTUr9PX454gE
	 Yz+z8Izz1ls3ps4GQ1RQxn4+UbhHu85fniAm3WOoQS6n5xlN1kpaAvfqlB/ChO7cw4
	 HhYBXt2sadN8Ab4jG604N+1eij5e/QYc/OZ4alVQ0WvPutQWZnN7hQ6MVAxpWqM8mM
	 8cqM5bHiqAIk5+MUW0LjSBEZCKG3enZ6wNTUQNWf9Z0l9Vj9gmJF8GkPkERtWeikJS
	 bQLHJ/MjQeX7gJcn/pB+TebcXdNfQn8MHxGmMy6z3Dtsb+6ms5Eky1G4O3VKKmBoLm
	 pMTUUBx0WNwJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D168A40664;
	Wed, 19 Aug 2026 03:56:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 91BA239E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 839DB80C43
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rffEEBoMitpr for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:56:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=tKRXRCL7
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9698C80B0A
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:56:31 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so572336a91.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111791; x=1787716591;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mQjAFkb0s9LXfw4ISz9WpspPyQqBS1k+JQmiq7crmrI=;
 b=tKRXRCL7YrPLXFWzQY1mYsfUUK1bjgDaZKOKTwh4uhL/pQAdmkpjy5Gou5D2xScUho
 WlkNSDX01tluq2gQtkO2k6ejTn/x+dEbM1wrJQbO7IaMpWde/BuqQpU0kjD7J2Qz25NX
 yHngnrdiitemWRqhTpO9HP3c++Ugt7eAygxpqjHp4oEag+FCh+b7lxen+me1J2Pr3Yy8
 u2uoCfh0l65nSQ78AP86qhSu4KaT7SIPxJsgvwWz6i92F83fn5GpU1XH0G+vWtTO2XMH
 CpvJeZBpgRhfX8nuueiqXfqA5FTU5/fYse5gE7hl69tdUY8DW5+xJY8fqY77S6swY1AS
 fvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111791; x=1787716591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mQjAFkb0s9LXfw4ISz9WpspPyQqBS1k+JQmiq7crmrI=;
 b=gPsQlwDf/VF2bG2NmnpEpC9a+wTKGncmS7ByPTdOSLmWo73YUnld8JHO3ASLMC/HHw
 EfauDkDBIo5upG2oYHj8ykcmQpAC6XRCPEcfRzSRtTrJ7nbC9JJMLeF4SyRapmyEbblb
 2y5fZVA76+Wt4mj6i+UM2GSp+9jNsQUT2dfFMA5PTePxoPu6V2M5XqQdiCgekHClCoBz
 nU9lMv/vsRSKBftN/r7neQ0vL5V4aEuwkn4A2Cj361VP0vMd687KAWFo8CB4QL/eHVDC
 ie9mA/o7Bm8iG7JaytEsU9YiHt51wIKSiW4OjcJu2Fsuf7uqjJmKXnIxuOFwhz3cDBOM
 dRyg==
X-Forwarded-Encrypted: i=1;
 AHgh+RozAwkQyuWyVQ28ZG4K4u58Q9PW0v9TXHQkuu+3o4LeJgnK2DgJ83wPWXz3EnKuAK4hIOGo9sI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz5C2IScC6mTsl+2OtYyxEKHmQgWndW6zi0SaTGzVa9HiLfOBnj
 LTkMXcxyDVXlMYp1Mct7aLFwhh/J5WV1bM4X2oJXkmEvnU/wqtNnmj3A8FO8lL6Nkak=
X-Gm-Gg: AR+sD10iseRfDvQvgs0BlnT+xBC6vY/b++tQC7k+QOlSlpWbBr5l427UsrY9fgf8S6A
 KKeglEjgzVm/8mjf8McIllzfhyqLDo0iC5/DCmdMWd9qxCoPPsjv9p84mPCXQRgLUOs29PCrmIZ
 SuIAKsX2bNQPmLMvwqWvvM2+FVPJg09GX6h/5gLm26ehRxc6x2SKRwcIDPfJbYu9oQ9CMfkikq7
 GBmHONX/KvuLEQf44mk7NWuFdLb3lpx6Ruw25VfgLrglLs2tWgqvrzDvRrEdM2b7FCQQTvUtnRV
 v+olMTgdC0iChRZ5A3tBiW76MHCfMREZmvOjgGY5kAEw9O3MLe+hztU50aeA6trEHxFvaWnCT13
 +hIKhizH6HY2uI8n+Rp0SMeA5kUxaFzZrhioNu2PhRoFiGwDj1Uu42QvHPeyK36j9Lrejj9Ohjn
 4uQy7pswfg4buTLq0czrOfF/ZvuS97jkvRV5VigWuwy91HRkKJ85aM6UB07aP98WRqkfVjnk0Lg
 k+zlRNzI39CzH5zm+EgZ06nEz807kM+9nUZwy28jaV8NUzG8Fnue2jmmdsuDoISXlC4oyZ9W5+k
 i5QKqC2iEQ4OGnqMYQrDoG3jxQ==
X-Received: by 2002:a17:90b:4d83:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-39580a91ad5mr3190210a91.2.1787111790668; 
 Tue, 18 Aug 2026 20:56:30 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:56:30 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:50 +0800
Subject: [PATCH v9 08/19] riscv: dts: spacemit: k1-musepi-pro: add PMIC and
 power infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-8-6e66016392b9@riscstar.com>
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

