Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E555FC98302
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 15:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D281C407FE;
	Tue, 22 Sep 2026 15:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tn-KD4zdBZ2g; Tue, 22 Sep 2026 15:15:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9B8F240D4B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790090108;
	b=r7NYD/tKKF5ME0KsNC952eHhU1JIuFRrZyBGRQTxgU9HlF/pJol5uzK+neU9HaFEZ/S7
	 17lPEsXxCwOoCwrTKRYv9+u/fN57mVLPLUumAVkUHaEh4SkkUqUqo/OxmMid7c1fm+ojI
	 YQ8Zv3KEbkxYP9Yi+2RCiSBQqIaF3WsKF6g/wM9nbjY6BIJ49FIkTxjKf3Gd9m+XUqX6V
	 Ia6RDC4HjY5nLrf5ljzUr+DvQUjE5zEu+uraQGVRziUgkVWt7VC5NdU6wo3djg+40CNIs
	 8cvuhPN5boE5ERKN/yjKKXnhhiqkrYRAVmxYPRe9pCV2foI3A/uHGtnenb3oMKk7Z0A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790090108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=em7qNY0a+6k32A3CPmu8Jc9X2pJN3zcGlSps2EDtlf0=;
	b=GQErt9632K210XeQAk/H8rrp7cbd3OyRPyxaXLvcnnLajusYuN3vTGsaKYWzwdp5FY0+
	 /WEJYkQk3XbDH6+emNTvztqsw++OC3L67jjRIWbxTME3mZNnuxHVEWNoPIXWFcSYayc1a
	 rPtaSk2JHP6WGgg2Q/Z/ypRqlTkvhA9xEGDK4BcjOp7bNSKd83zVoyvwh0Tu/8RcFVIOy
	 stOxPmh0mdlNnp8u1/9PV7eMie8S4VMUU4uYa2UfCnqpkM7vSCwAndyssCrmxv8yS7j7J
	 XGl68jDffvtihUX2p4/Q+c8YywzeXBAjTakn7jtljPecCiT1r4V7KrM0CBBoksyt7TA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790090107;
	bh=em7qNY0a+6k32A3CPmu8Jc9X2pJN3zcGlSps2EDtlf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VpBBZ41gkElw+fd6cszzHNuQPulIjiyKbNGP8MTsGVOcpQMIbS4DuABtZLPPmYXe2
	 VanscEwYpUetONFRXwGn5upwG05UrYPynfiHHJDhIH+LmXLnB8PubDEjcvotdf+Cq4
	 Lv2z2jsYlqGmPphav9tUnRZwxPF5DkoZA8nxy1lLGIffVOiygMt8emQRzZPMNCj3zi
	 24O/oTgXS8VQzgr+/wbGtoyUEIUuTARhuMnfewk37ISj2DL2OJ7/Aj+3drgGfvXnig
	 gbVkC/mh6WLuQXQeZC0JqpiHWcnlHiAqwGpdOxgUIhj3yq/d1wG0/w6cPN7z/IGmIn
	 9pp5WUoEeLtIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B8F240D4B;
	Tue, 22 Sep 2026 15:15:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F76FD1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20BBC60766
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:06:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7johdwJLiT6j for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 15:06:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 41D5860674
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.92
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790089605;
 b=jv6PddryA6FuV2M/+9b+5PgkbN2owbZNlryVX0opCjQWts87Bux6RqnCVMImNDeYYueE
 fuMMnwDh0jMlgYNiHr7YVPaNF/muONuMbvPWP8GCMCbVijHF1Cxc2uO/68ZzITQmexKBG
 jJdsH4z042GrrTWMycguhC9LIlNemjI9nMd3shxECbWbSF9ksVSlI57UAVGwha0vEC2Lj
 Od0rU7pZSUMRKPTCxqHPUA9R6HPY+kEBZWAk0mG6T+B5Sj57BBryEqLUNNjF8KRlM+a3F
 dyOmcI0vcwNTEtoDKY/agj79v+ZbhZ+m2O6i0el8i36W/JQxxa81c57NTpQlV602s+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790089605;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=em7qNY0a+6k32A3CPmu8Jc9X2pJN3zcGlSps2EDtlf0=;
 b=klL9kE7Opm0yAMhXIa4hSz8zjcxLcKbUAkyr7HYNPQMMoIkItIYJaFeSsdFcDA1Kd1DK
 CCghyzlOiB0D6z5y1TkzV32upmiepEwaljcioTTw4llMTXs9ScMjuNknsOgFe3ELlHFTT
 kfcVle9nVizD0KxJ0ezRk1idPfD5lQxUv0CfaPOgVPQKoJnbW8JjyrrVhdvxA/snyO13n
 cqViD2NxdsL53brnSr3ZndHfkILJBj0HuFOT4eri9KbAHSEQ6yoT+OpSTwxBNTT/RA8yd
 Lhapb98FBWVbXmsEB6JBlubKcIQAFHhpqnoniGixQcSMu89cmEL4XVjhmxrF7NBxcEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=fKFzmcp4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.92
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.92;
 helo=sender5-pp-o92.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=fKFzmcp4
Received: from sender5-pp-o92.zoho.com (sender5-pp-o92.zoho.com
 [165.173.182.92])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41D5860674
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790089216; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OQg+Ai7SkVbk5sFRxCrG1b8Kpba6fZFWsYvgaZ5kqyOfPF8gtEemCHUYiXghwqFrHFGeKrKRBDIZg3BSt5KYDi+WndmehfPwC2054ImZSVYF/dixH+ma8mF/n3qpGfk+ntC5DRapIt006Sh2plXEZ5GYa7PvTswJNi1kT3jmFBE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790089216;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=em7qNY0a+6k32A3CPmu8Jc9X2pJN3zcGlSps2EDtlf0=; 
 b=LYD+khU/xN3bIPtj8kfQSwBjd4Rk2Xoz4nzcYL+zbuVayazlc1sWlXG4Q3V0ra3CLQNGwG4a0/upnq7rPijWfyGxBzN1ylfrfk5zHJ9TVkYlMgnDT/NlSqsSz/ar9cKsS1zEqxDAgOMYuYAj12AkdMYWqEJP77kzYGiM4bXbMRU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790089216; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=em7qNY0a+6k32A3CPmu8Jc9X2pJN3zcGlSps2EDtlf0=;
 b=fKFzmcp4E7k1pEzQhh8DXogmI8MMRMhkHUyvtUQScqCwvQ2mwfRf+cyj3zeM8WcL
 zsU7kP7S8QpIT06nhl/if2xO1lwWCORKA56TeXDx7swEBtcKMwMfYAE0mPlsN5Xy8DI
 b2OXuSN1RqBbnXzmdPnosxiMGlT2KzD9ZINCrFfo=
Received: by smtp.zohomail.com with SMTPS id 179008921189137.28866630608957;
 Tue, 22 Sep 2026 08:00:11 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 22 Sep 2026 22:59:11 +0800
Subject: [PATCH v4 04/11] riscv: dts: sophgo: cv180x: Add PWR_GPIO controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-milkv-duo-upstream-dts-v4-4-d45b74dfad36@zohomail.com>
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
Feedback-ID: zu08011227baba12a1602ed0d4522929b900007839ebbccd2aec9113822c981e7114b5d31a58455bba58fe5c:ZohoMail
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

The CV180x/CV181x family has an additional DesignWare APB GPIO
controller (PWR_GPIO) located in the always-on power domain at
0x5021000. Add the node so that boards can reference GPIOs in this
bank, such as status LEDs.

Signed-off-by: Chen-Yu Yeh <chenyou910331@gmail.com>
Link: https://patch.msgid.link/20260725175346.139173-3-chenyou910331@gmail.com
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Chen Wang <chen.wang@linux.dev>

[ upstream commit: 76237a509a0e91665c4d9c96b72a78ec66ea3fe4 ]

(cherry picked from commit dc28678310443c294191632f6ec175a62d53e767)
---
 dts/upstream/src/riscv/sophgo/cv180x.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/dts/upstream/src/riscv/sophgo/cv180x.dtsi b/dts/upstream/src/riscv/sophgo/cv180x.dtsi
index 06b0ce5a2db..8bf67ee4eca 100644
--- a/dts/upstream/src/riscv/sophgo/cv180x.dtsi
+++ b/dts/upstream/src/riscv/sophgo/cv180x.dtsi
@@ -448,6 +448,24 @@
 			status = "disabled";
 		};
 
+		gpio4: gpio@5021000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x5021000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porte: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <SOC_PERIPHERAL_IRQ(54) IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		rtc@5025000 {
 			compatible = "sophgo,cv1800b-rtc", "syscon";
 			reg = <0x5025000 0x2000>;

-- 
2.55.0

