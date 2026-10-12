Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CFCCA9EBD
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 02:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5C44405F8;
	Mon, 12 Oct 2026 02:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQ-cAHW7nlsn; Mon, 12 Oct 2026 02:01:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B5EB405E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791770504;
	b=GKvVESMHcM7w/uAk7GztGUFvkWxS9psQ+Tn2udMvKC9tELXDKPblZn5EDrj44j9N2Bsw
	 MnmU8c6HnqhN5DJkrBR9hsNWMUttr2nryoFCqr8xVoVQePvX2SKZ4++bU/6kk9jkJaiXA
	 FLplV4UibMCvi/U/Lm51F79DDPdp2NecRmnjjiePSxZPTKlKC+3E63tf0q9pZzcVdt4sz
	 BB+Kp80tGDO6Y6XpWMHZwCs8KygEOZVvz32lmx6x5x8YuPv4mE8vKkTlxo+7Ao6+zyPE3
	 A4rKNeveO7SpVqn5Yb7GdN3eshtoVsvjoeBOCanV2/NprO7TjuaTn5DC8SLDQZBbEoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791770504;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:X-Relaying-Domain:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VOCUXqM1xsVb+/AG/kBWDIpivwpKolhtgoQwx2vHqFQ=;
	b=m6uq+UzUy0WK0XMbSqL6AbBDrT4pR68Sij91P2V2ayxk55EHXxK6Q3AyxXDOwI+aQ6Z8
	 QrUDo6ahYbgccDE8R0Vb/qcd/Yhr22xjy2tvTQtx1exvg14q3Yx/3H5cvanNH/bYJAfxx
	 4xvvd6tW7saFQgDq8amfmLh5j1LUQZr18+b2mZy52CPBdPlvRw6IS1lcdNKw7JmBt4nve
	 MNFGu/DYqSTeU5L8bfVWToppvgOCST3ZIMbhkLEFm9it/ZhQN/uD1Su0QdbJzXW25/eYh
	 jLfIYehrdedibc9sOqKm8zs0ZknWW34BQjFGfzuQUDkPmLIvivsfeXWLCzrJw4m5KPw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=ausil.us;
	dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256 header.s=google header.b=i7PVeffq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791770504;
	bh=VOCUXqM1xsVb+/AG/kBWDIpivwpKolhtgoQwx2vHqFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ePoJ6nF7IkrklFF+Q06zjcR8Ya0oKykfJ/Pa6QT8zEr5N0rK5Lx/y0Q+gWoPfRvkU
	 LrO6IGNuIGRNlxcMw34D3pcGqkPPPMF2AZqnNyFXI/o/xXfATuNvr/yqgiElkZ9Yfy
	 WrS3HflO6l6puX/87JX5ec7kCRDLkNL7/d+I+EJUk+/92jS0s9ixbfFORynSpNOQD3
	 v5nbBoPdNA/tYihbmP9jQlBGJt2lh8J+SJC4eneu3jlYJrJ+M01YGksHM/Pn4UgODC
	 VbFZp/K2tmOoPu9Jbh6dOyDIJ3r9xf8FSAIr4FAOOz+rgPovlfNbamHU2GNXb9vYzh
	 uuICG6LzvaS8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B5EB405E0;
	Mon, 12 Oct 2026 02:01:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B7A8194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8DD9B405E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l1CCH_VScef5 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 02:01:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4CA540573
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::661"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791770500;
 b=gL+5T+VO1kSTEQg2iaI0aOnH8jGeFYQyPRMH2wMxmzCLhwqvSJFAIc87gCFfxHrqSmhY
 h1j2B1k4nvJtYR3TEUpBeNEZr//nU1TSICYJUkAH8955D7Z1Rc7YV0hs5WeVB796NgYD9
 jj2VPboeWmNeGbIWTxzKprsd2U6A9vfUGLtYeJzDyetPZKhBsqQA7gT+jaRwdyq7MGRgw
 S5fp0k2/syWxqZ2xU1ceV786KlRDNIQLsHB4fbxDSVVhLmL1FhCZ3fMgaIpl2CRFbzeDH
 h4eTF3WU91ONJw/Uazwps0BdAnxbZLShsk1MKxAm0RbNH0TaqZ60+iN9eOkPnhuPZ7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791770500;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=VOCUXqM1xsVb+/AG/kBWDIpivwpKolhtgoQwx2vHqFQ=;
 b=LliAkCPpOf13/T7WEcXXgI2bp3N/E3bqk1Hbh4fAkgnQW3B1GYXyieh6zXWPBgEhsLMj
 DhmMa+z/1n5E65LjqBQcr1z2/jLHNv5gbYm9e893vwnVT3M7reNeiek6ociZiejZ67yvh
 HlqOH0zZ14jTqpBnuIMrJKRr9jqdlLdwbFT5GyWOk4hkFPD2/1AdAhdquDyeEsnCm4oKk
 /4aAAA52637WpQEKOehh17LQAfUPNdj/H78GCrJ9ZSCkH/N3V+8nqAbep99tY/GWJsrhz
 XPgdTdj+d3OpJqQNjKqSrivE6WOmq7sg7cyVlJ4taxxpkzpam1lh9sjPfyLPfbm0BTQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ausil.us;
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=i7PVeffq; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::661"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::661; helo=mail-pl1-x661.google.com;
 envelope-from=dennis@ausil.us; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ausil.us
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ausil.us header.i=@ausil.us
 header.a=rsa-sha256 header.s=google header.b=i7PVeffq
Received: from mail-pl1-x661.google.com (mail-pl1-x661.google.com
 [IPv6:2607:f8b0:4864:20::661])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4CA540573
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:40 +0000 (UTC)
Received: by mail-pl1-x661.google.com with SMTP id
 d9443c01a7336-2e4af975346so8701725ad.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1791770500; x=1792375300; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VOCUXqM1xsVb+/AG/kBWDIpivwpKolhtgoQwx2vHqFQ=;
 b=i7PVeffqrrzAFtI5xYFEyGnQA0Z9HoEgQgsSYXAYy5eXk/sMv3qi+CAPkT4Xa0imOM
 fFTfN+kpTTyz2yum1jtDeVGBxLn1hAzgBQ9Td8VPPZ+ElhAeS996Q3XgjULATks75WYZ
 g8s1oc3G0W3FitEXUDzM9amEpRLRi/Jtu8CzqB3C69vaag8C1Itwm3JvpbAI0gymr5tj
 AItQh0v1vj8CqNkiKg4xM/QsyjmidkF54tbI13KHGl1oSRvtzDlSkhAD/yTS2aycLQ8j
 5qNdC7siJ/UDk/afxIKLebuFmw7gaO17oFR3Yh6oHlGuantPs3CrpMzHAiIBX/BG0Cfx
 o5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791770500; x=1792375300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VOCUXqM1xsVb+/AG/kBWDIpivwpKolhtgoQwx2vHqFQ=;
 b=PqLukrpBVXgTensWdf9vljqAfsyGQ1FmlLYBAfDKOf/Z8M/4F9R4/dv2X88KtfQaqj
 RCV2BCh6U3hHMCBYxxMCLnRp6hnnPJ1pBvDn5tNwCCof6UhMcdzwqYWmo4ycELoKGVXq
 FTIcxF164oxR/tad3H9vs2GPOvaQOuMH7LlyyEA5pHnPG3WjfoIrlMrw/4ROoKi2yC5O
 VUdwkgtzaOJlvUXzlnDOsjx+P+YxroEPRyfxX53Vdn2yHESOIRoDbsFuY7nd2DWPZk6j
 TbnpdO9YnA6kzZFcJRw3G7YJTiX9Ei9Ggw7ugakCJ0/u+qBsyX5TD6/gfX+k9Qb3o89Z
 5Vqg==
X-Gm-Message-State: AFq9FYIq2ESTdgmOYCv+FK2GepEofUJzMlrim+2s9iAV7nxCHVVxb70x
 NPGD2oLKt/3dNneiteSu60PQyF3Tof7z4jbziI1ip4x8zOgBAl6Kb6q0Nz/x9xl9LtI3Afzu43S
 IvYNVXeoR4iOy2ONafagh7Wg7sGs4mP21w9CfM1TzVACU
X-Gm-Gg: AYBFou1AyFZ5brXVFduPwrXnAzoBOT9pFpUk710BT+/oGDzS6LpsMPBcvQaQqIqZO1Z
 apNzgdslYZjv3QAWtvWvoFSMHSWBzCH/x8hzkeIkO/+G2o0ywGxL7KC49/Gbu6DVbbheeuwzz+E
 h11fFtcJPMYmPDNYApI9vsCfB313E/XpI5QJYa+vexicrariitZqvdJLc9slrrxOv2eez5bw6qJ
 pkVOAxMNbTfqv+V0xcFGuGkjNGPs1apwMPM+J1Nxtn4x0EWpks6gtN4dJPKuah8phx7ZBCT92Tp
 N8f1Fqj2VX3Pj5V98ELKOCDqvvz0OiRq/yu1yoOu0Ae6dvHGiyfU/6+RhlX+08JJgNsP0QHZNt2
 7YeZDgWOWprYi6SpoiA+U1poq
X-Received: by 2002:a17:903:a90:b0:2e2:e5b2:6455 with SMTP id
 d9443c01a7336-2e842f3389bmr74200505ad.53.1791770499749; 
 Sun, 11 Oct 2026 19:01:39 -0700 (PDT)
Received: from tomin.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2e84131a272sm3254325ad.0.2026.10.11.19.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 19:01:39 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/5] arm64: dts: rockchip: rename PLDO regulator labels to
 match schematic on rk3588s-orangepi-5
Date: Sun, 11 Oct 2026 21:01:31 -0500
Message-ID: <20261012020134.621305-3-dennis@ausil.us>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012020134.621305-1-dennis@ausil.us>
References: <20261012020134.621305-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Orange Pi 5, 5B and 5 Pro schematics label the RK806 PLDO outputs
using the pattern VCC_*_S0 / VCCA_*_S0 / VDDA_*_S0. Rename the base
dtsi regulator labels (and the es8388 supply references) to match:

  pldo-reg1: avcc_1v8_s0 -> vcc_1v8_s0
  pldo-reg2: vcc_1v8_s0  -> vcca_1v8_s0
  pldo-reg3: avdd_1v2_s0 -> vdda_1v2_s0
  pldo-reg4: vcc_3v3_s0  -> vcca_3v3_s0

Also update the saradc vref-supply reference to track the pldo-reg1
rename. No functional change.

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Link: https://patch.msgid.link/20260511025352.106126-3-dennis@ausil.us
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: e3132dc1f4ebc9dd28ef9108f2aac84e5d4c5a15 ]

(cherry picked from commit eae11c5c68fda07dca1c855c129c5630408c1aa5)
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v2:
- Add Reviewed-by from Quentin

 .../arm64/rockchip/rk3588s-orangepi-5.dtsi    | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi
index dafad29f985..fd5c6a025cd 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dtsi
@@ -274,10 +274,10 @@
 		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x10>;
 		clocks = <&cru I2S1_8CH_MCLKOUT>;
-		AVDD-supply = <&vcc_3v3_s0>;
-		DVDD-supply = <&vcc_1v8_s0>;
-		HPVDD-supply = <&vcc_3v3_s0>;
-		PVDD-supply = <&vcc_3v3_s0>;
+		AVDD-supply = <&vcca_3v3_s0>;
+		DVDD-supply = <&vcca_1v8_s0>;
+		HPVDD-supply = <&vcca_3v3_s0>;
+		PVDD-supply = <&vcca_3v3_s0>;
 		assigned-clocks = <&cru I2S1_8CH_MCLKOUT>;
 		assigned-clock-rates = <12288000>;
 		#sound-dai-cells = <0>;
@@ -441,7 +441,7 @@
 };
 
 &saradc {
-	vref-supply = <&avcc_1v8_s0>;
+	vref-supply = <&vcc_1v8_s0>;
 	status = "okay";
 };
 
@@ -666,8 +666,8 @@
 				};
 			};
 
-			avcc_1v8_s0: pldo-reg1 {
-				regulator-name = "avcc_1v8_s0";
+			vcc_1v8_s0: pldo-reg1 {
+				regulator-name = "vcc_1v8_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -678,8 +678,8 @@
 				};
 			};
 
-			vcc_1v8_s0: pldo-reg2 {
-				regulator-name = "vcc_1v8_s0";
+			vcca_1v8_s0: pldo-reg2 {
+				regulator-name = "vcca_1v8_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -691,8 +691,8 @@
 				};
 			};
 
-			avdd_1v2_s0: pldo-reg3 {
-				regulator-name = "avdd_1v2_s0";
+			vdda_1v2_s0: pldo-reg3 {
+				regulator-name = "vdda_1v2_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1200000>;
@@ -703,8 +703,8 @@
 				};
 			};
 
-			vcc_3v3_s0: pldo-reg4 {
-				regulator-name = "vcc_3v3_s0";
+			vcca_3v3_s0: pldo-reg4 {
+				regulator-name = "vcca_3v3_s0";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <3300000>;
-- 
2.56.0

