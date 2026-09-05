Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF21C624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A78C60BFC;
	Sat,  5 Sep 2026 09:14:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NYjseqKQBKwO; Sat,  5 Sep 2026 09:14:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5F1A96061F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599661;
	b=CtomegcpBzoIv2SNowHLoj2vzmRODW1PsV8MO8Hpd64NkLk68HZwlC6BE50UX8vj30hE
	 DxMC+URg29UrTXBPAP3bHwP6byJ7Ep2jbrdsg9442otf6sEnvZZtUkvgx3Fuv64I1tFPZ
	 YPDOdADOkkRGxFeCLFwCg+rtl5sY8poRCYuvyIOddLtbuPMyT0zxKTwnGVsPuMr7x6vls
	 gWnWmSnr3qPNynHOeK9fVo4d81jP6mNW2plkPDrz+8DUjNlfwiTrCo6rph4PlCy4Zffbf
	 C6D0f91VxypjyWL/rK3Nj3/hK9FszLUVHBqPcXxGA93tImrpQuQ4C1d2Ro3ENHAwhEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mQjAFkb0s9LXfw4ISz9WpspPyQqBS1k+JQmiq7crmrI=;
	b=tLBY3oZ2hsqcf4u7JymIwfMbuTc09jnu2mNGSsjgHKwOF1i4mcXzr6S/qNe4Vt23CXyY
	 i153nv8azmpIg3bsuZj7SHcVJqDAeGBG+g/70NoCPotUXOGJNjiv4GsArsEVHcc+YRHFC
	 pDUMVDlkIQO4qCoie88cG0Hk7qpViOUhfTqjxRncbSqcATlkmsUiQ/FP11ikP+J070x1S
	 TNxcU4leltAMt1iDNllnHFHmMXOx78V8WlB/RGTgpEfqPyx8MSl9+wjqOCCQXpB/IGmD0
	 wwFwfT7LXjTEfg1NT0RRkpm7jthPq3aih7PHz/htDw9hhZr7+idUziuX8jeb0QUHlxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599661;
	bh=mQjAFkb0s9LXfw4ISz9WpspPyQqBS1k+JQmiq7crmrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p8nc1xw0i9CLmsaaL0o9v+rGmhc9+LjGUPyJAQIJYeCQNdqqLPYAfLbUbHtTaV6FC
	 qbdugJrivb1fQHnz3TUxFuEV1U/mOto9yeU6p7OeJ3RYqYUGsI20m/u75InETzNRpb
	 uNdn7++eZEIhIZO0UPXTUQ0qkrhqVEh6HoUobugFX5hzcO1N7v1xLY8Jl8tFz5PkeJ
	 fqhnlUARUq9bu5MAB0KfPYkN6ODmnfbsczDpSkK5ZLpnbRtHXX+iBz6HzZ/P8NTOQB
	 1z8MMdCbOCi7ffTZPw0szL3OnSpLucAn/hCF1KLQVyPt5Ai/CJ7anBACWXPL6rBque
	 2ozPgRJXgefzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F1A96061F;
	Sat,  5 Sep 2026 09:14:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CD5B49D
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6B9981111
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vipl_2-JtDq7 for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:14:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 10C2680FA4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599659;
 b=snZ3LwQdW9HOKmUdpmh70NJgPEr8ixIb7KUX5X59rfcbwAQVbXIF0gSe5GHssZksE3FJ
 sbxKvXaAZIyRiEGop61BOQ/fpZ7HtshyxojiTy2VfDwA+tkTq7B+cFgl3YeQuQypP6BmI
 5Fe0YWQEVQOEMxkdFFS86ERX99unfWttKdEukvFmFmH2g718cUwsDtFR7iXj+QSrI47bk
 yC5lHPl8SV9ifXx1ReSzk4/kCLo09dtS07bcjqw20ZX1z2SSKh4YFf66apY/8ygHXQfbW
 lHkIc/HkrBDRsBWjZ/pB9RiohWUOTFh3AqW1zsxOhpfJhWs884CPjaJM35fayrkvQQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599659;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=mQjAFkb0s9LXfw4ISz9WpspPyQqBS1k+JQmiq7crmrI=;
 b=HK6nUzIRuSuWpgtiGwyPlROpvmWaKP07bmH14bIhqtldteXiN3auI4bl3YeKupEP8acv
 P8DRK9OY7b43XxoZdusSkV/zZTF87zcOIQ4KXnsvN82mWVzLw1dAJiGDteU7YWf4vGTSp
 v8NwysmAUSZRLSVvYpYvfmG0o/dv2HnJcbHK6UU6ofhmJj5e4diItGVA8OwSc9H04NbuN
 ms5Em8WCnZkG5t69TngQmemQUy1gJRIWksWPsW7gHge8BD92KFqhzldazhu08A7kIDI5k
 faBHJVZDBnw3KxkeXAG0FL6CksStYUUitgp/vSlsL3jDuykp4twAvEIJuOQu5nZeGjw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b="HEZ/JcWq"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=HEZ/JcWq
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10C2680FA4
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:18 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc1bcdb3c4cso1358865a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599658; x=1789204458;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mQjAFkb0s9LXfw4ISz9WpspPyQqBS1k+JQmiq7crmrI=;
 b=HEZ/JcWqU13VO6VxRyp+M6XWPsUifG4/4aiM9DG96Fi2BEfidx3ZE6oY3UHjfH62n1
 Y4Ogfuz5FRK7/eQurxhNQOPEWRODS8+dU81bZ3M2vFEWD7HcrtlmUvHW4sYu07aewJYF
 ud8pd5IgGFcl+DyBH/BWucn/Ka8e6ZecXWrgJ0Xw+p4hA/WLxQBOeObfdyHyY2bJL6PX
 9aV1DcQkgscRHgDqzyMJBWLK59KCTtk9OrrOwRCPZBFpSdJ99u++gJPmS6+DI9ybISar
 wjY3fNSlymICjlzeWtXN26lOglhrHSGtcvBeKawSy1uZ594i67hLj3Jvc2o6N+vL6lhT
 03WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599658; x=1789204458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mQjAFkb0s9LXfw4ISz9WpspPyQqBS1k+JQmiq7crmrI=;
 b=Y2QuIXKeqnt9Z+cJjh+hTkAbN2eTcniIJDyeqMoBl80F96JfmnHn66eb05KUoy53Yo
 CsHTEHyijjyTgwMDgL0B+ca15jGBKM3U5GdDRMPjdtooLKtm4bdbcrVVoLwk7hSMdjKI
 ehywGJNxRFqJJtjtzrlLHiSlcNDlC+k4k/aPKUu1INe9zwXSMBUD52/tBheVrXq5mawQ
 o03fy932qit9wAQqSAjHRM/2oHriFshAPUHK74uMscfeGiFVyew49YYBcUHybPdt8LQy
 7BoPijugHZ0zautMf13Ri6wafI3Mon/atZvERoZRsTrip+hOPuH1S/HPRte1F4oycNNT
 KtzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhFxPGWr8UniOowBaOTrHQYvQaNxQ5tzXxj4JEjSRNzl+vR9E5ESoTpF3zir4ti4UIXZGRRqg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++laQAEm0b5MFuV5LY+LUpJhQN+FZwh7yII/tXUml1oFHpyDO1+F
 olzlZG26owRrqj+xn77EuRkg2SEropZ/wliY9Kdz6sWeDOWPhytDMlYmHkjDIHC3D7U=
X-Gm-Gg: AYBFou1pB74289//eH/n1RWEdN0Io/aQzcIpf7n6jw4QyOT88NlYEZ+eJB3FWWXyfma
 sRS96Kqlt6hMx9iV8AlyQdooInMlaRExC4+AHmCp1g/Zd/SFetvphZE8NAnaOh3XtEsTttSm72d
 BwMmcXylV6nWVI1RZM6QfgykBHnG64raCCUnABbQuAUSAtYuHlVGbxN7yY8LyHZs5w0sGwQ4SE4
 LNY4FS4WVUzTO5UsJLIqF47WmxD1QfqDdcz0Ym4qqc1aS4yOyrfv7MdR6/6oTpbLAx2gAYqJTNc
 vwU6CGCB16co3UsfhL9iNmaokGA4wwSIdSTGDM3JDm4MCxpRdD2jIt05neQf+vipNnKneaJz1uy
 Wo8MrVEjKvue7DvFQx6oMPuM/FnZ95G7o7oq7Hth8Lbv8ybV0XjbAaC5eoY1p+ZLNS0hh2iq1aD
 VPcIHwLxalcWTECh/fLB2ovG1qHqOk3IEZyLQ8++K94UwpV4WPOCddJZCDvYkhU29IRKwhUAyRg
 hmX3N5uhRfbTjF28FgHt9fWQUvI1cE+HTDgzsRxFKq/W8wHRQdV2sqAymbxbGclDsbseepf4Cf6
 87tSmUnsquVpoRlMmDHD2Sq8dw==
X-Received: by 2002:a17:90b:33c9:b0:398:c16e:69d3 with SMTP id
 98e67ed59e1d1-39b26122fbamr16056520a91.1.1788599658087; 
 Sat, 05 Sep 2026 02:14:18 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:14:17 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:19 +0800
Subject: [PATCH v11 06/17] riscv: dts: spacemit: k1-musepi-pro: add PMIC
 and power infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-6-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
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

