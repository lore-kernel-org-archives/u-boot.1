Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DA1C624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B1DF810F8;
	Sat,  5 Sep 2026 09:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sKWQstAMzqwn; Sat,  5 Sep 2026 09:14:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1358981004
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599681;
	b=kEC0ftv7+N1FCrS4u4rkvHGCwf09zKPDZaBJ6FBNTO9f1bbooo31I+A4H8z34lTCGXyo
	 u0MU3RYavt18PApXRc31rYaEey0EhE3SspRv3kI3hQbkPgOt+JURfctpG6vDz1nbM2yf4
	 +FR7esZpIc+PPqzlNL2kOV9tW8HyvfOKwU7VvydgZ/CcvHxw1OpN6U5El3a+9iiS3Ipdr
	 XeVLJhuJd/l92KzH4n8S67Oe3CNpS/jA0JzbreqFvz8Eae5U9S/CkxCcrDK2WACLr6yOF
	 JETDJ8WxQI+NIxefG3kYnmSWtMGg2FRcgQF5AXPAaKKJdC97cEU8M22v+dncuNDGJvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LE4xlra5gR8klWAk8DU2WgZHmoKJMD4TlCMeSM0UQbw=;
	b=dvCoLkym3UcI1LCh9YT+JwA0PbXHuhsaIref8ebwP4BdYkPsqQ28rZV32zSZJcrjTxj6
	 /ExIsRMA8HbtyYFVzqXycgWJ6WUOaghO8O85j9BR4I1MNI9rFKpT5nj0pyNdZIshP+1/6
	 /vSw+LPqCn+EMHsfCGKbCgfMBaNbXjZ+g6LQhnkJXw2rpexKYhJtTS4DICi9FG7KMCiW4
	 OqZnzf8WpoAyIgI1vQViTsaCGkHaQq8ompLnF6HvPCc+Qc23LYScMFlhJuwFlaIP1GyEV
	 wckFBB7XKgjhndpRec3sRVANk2yrOddhFe9cIVXSMDQzXDgLPadssseF5w/hnps7CFw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=hCyr5ojC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599681;
	bh=LE4xlra5gR8klWAk8DU2WgZHmoKJMD4TlCMeSM0UQbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yUhrNcucb7Z3rSImxGmbW8wmLGb/tR/3qfh7xn/JeaH0m4c7d3+XuoxGVC2pqfmLR
	 zHYJYZGXGlEQyPoTT4jaVKU0u5F1Rx9VKxApQM8XM5B3PL1hjPeH/5TtwF3F5eJYUr
	 +qQBktI9t+7LhqV3aNWNmrFU8OY5DuSuXr8jpIOx9yRYJ6UIhe5bRXrNjOWbiykEXh
	 I02x4ElXBJ79czeqIIn7ipR0NrofGsrU/1A85KJfOEs38ERkHO4P2KS6w2P55g1KRF
	 QB6LlX+MfAVSn1FrQstDB6+MWsRX2C23pdzxSyhRNWoJW/uay+wj2PCioPR5ZZR9I+
	 0TdztKcfudxYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1358981004;
	Sat,  5 Sep 2026 09:14:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EE65105
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 339FE810CA
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cn4ggpJzJ5Lb for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:14:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3CF7881004
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599678;
 b=R9ZC8feS5h9YY+nYY/aWYH7AprDtSXnqRWKYqVwZKb7GIIkU3Fpwxk6TTcKO0HYgTGR8
 sFEmU86dGyM9PqOuaOW31u/vF47++awatbsZayzHmndnAiDrnFxYPo5DBaJl1VercIiKB
 lQiCVcgXWFkuNeDYRfV1Uj7OCyIPXj7pRIghL2V34RqDAp5xpbl2vxDfOn7YvLMWYZYGy
 Vg8yv9xzqRFn1GZ81lC4F8/BTc0uEZll36Y6BUoj4de2HybZnJ39vjBhTGTN7qi3nH+kT
 DvAMtJFSh9w1PhE+J5M8xVhY2UFqK4KTBrluehTutW0qDsOXufr/DhFf/urGFSVECzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599678;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=LE4xlra5gR8klWAk8DU2WgZHmoKJMD4TlCMeSM0UQbw=;
 b=R60luQoJ5QoYK6r/w+0Mw3eyqW//w2n7Wo6AZT9n4g+0A9xWnntWhw6xtSKcdDgneBIH
 9nXr8JSufuoZJBkQpv+7p9jnHIsTZ8zEjMxQJ5HxHvcH632YyAXGfsvjSjJd/yF67ZaHP
 FMvgBknDMXFX7nln+yO2Wa0+7NCInGK8TEpWX/WT9lpHaEHN5QnoVopz8GgKZDpB6WF6l
 QRpny/HLLzsWHnMA8oT5xSwaa4nqu8j8RQGwUw1M4Ia72DtIVxkZcHZDMohn5dCF/6yRx
 TqCF+waA80SYRBEYUfmFU3Oy8gY6y3buiNc2scK9q/rVAvv7iTU2fAEWrt3WJQSqaXQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=hCyr5ojC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=hCyr5ojC
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CF7881004
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:37 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so1620400b3a.1
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599676; x=1789204476;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LE4xlra5gR8klWAk8DU2WgZHmoKJMD4TlCMeSM0UQbw=;
 b=hCyr5ojCuBH5Re83boErLWK5cuVHdCHmIuGMq1UCQSvZLU6qpVAd8UpTkSoQTT+0Vf
 /eYLgc3vfrTbTDiH8EdBt0sNt1TMdga+ZE4269DSUMmhoc4PL8POG/aeaIk2gi0bcHw+
 JpBlCCZBN8Irh6s1IAx96PZ27Ooi0/qvbksAqnwSUFiecUjpEC4sdJnb9Ifi5hZvdsXp
 UAEm9Q4Pz+JZEuZ70wjpwywyHbUx6G1lCw6/hChEoaTK8oJrnnndNoMK0txMqT2G7iPY
 pCx5nYQ6OeB6jsHqI2azh2thVGMM5z6I0fVyn01i+dRaP3D/fQ6dnZGpnuItRheBUVtf
 smyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599676; x=1789204476;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LE4xlra5gR8klWAk8DU2WgZHmoKJMD4TlCMeSM0UQbw=;
 b=ksB6b7fmu32givDQXm8hPaIuv1LIY3NEUDl6OeOu+8L138hTr3BN/4U1dkkW5Zj7ae
 Nz69Kt1uL4B9THjPIvAttVoa8ot6BXMqnQJPipNUAV3iP9kXJHi+/O9VbyVQJ8gI/lyG
 xlHA1XHngAFFOv4zgA/74VuOfpRRpVtLQKIETqsCfe3Gpnk6XIez+jkJ8B+9ZnNo3BNt
 7i3b2z4zR/u1ATOfMn4h84gjrtHQZ+61fpuMRAH2Bwi2mOQjfSN07tFMkeo+LCouccW+
 ztRsVoUlJROt76F6dQFFVftDN9pGKhBNyv1M5oeJfJF2JU+y0KlCxuegUb41HV0jNwvE
 CKRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaUvHwR+qAjapDzBk0Bv4/jibqpRaE5ps857cy1JmM3um1xWcEgPCfY9+1Iv88iM0rV2TEypo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mYW4xxrebDLD5jN791QCnkK3eVhdW/0EHAovOv6h4Sn76DIDyt
 CA+1hRBExxmf6KsaDtla71S2Xz24ToiD1clOMPChhGOsA9323Jf3EyrM+GI1W2neJ0QJpuppfkq
 XPPdb
X-Gm-Gg: AYBFou3A+JoB+01IUT+o1+6P3Pb3xhj3tiIFc3P50KIBvmkgp3qJKL/CYdqkziAqqBF
 TTJLKgQv+JO9WMS29zTxmiy3UpdII1svUwmvY1MBhk3YqcCI7PU6MsQME+r/oT9X0YWgfqkfQx3
 D7faNrSSpMk5jXbdgUWipYC3YXfYBrlTAQEOejSb1al+eIETpkc8gyVVXl+E8uDBTj6MaWPnueQ
 vidnoEOY2OoY4HEDSG4m+L9Gjrc3bFxELB4jgQ+ZWx/Hg5sNjYGOhO59BSiDB4qNyuOdsxdrNmr
 3HbA144oRPFcOVdS96222GeO8OqZKfk1uFeJRjKmVOvZEAcqvzNCWIdjK+RKT15ogqpe8QGMCiz
 H3JcW1xJw9g4H1wJ2q9x2KhtdnEUA1BNBtWZvlEwlezgE9dUpsKsMzi9JRSC6APm3y9dKl3cTIr
 FtWDG+uY5eOT2ijE30eedW+1ooZWHfn0PNEA0MOIWpESvUntDMFKRgzFYO/R8oc3zYMzfDAovwe
 TKooRLLX1BdDCjxyUzLo7Bwi80cEZi9kb9LUGsTh1aCrYO6Scxzg85g9SjAJLWcPEv+w+2JcFCo
 hd4Ku13i0Q7FrD7e9aGEVhNoWA==
X-Received: by 2002:a05:6a21:9d84:b0:3d3:af85:eb98 with SMTP id
 adf61e73a8af0-3da3a16a579mr18402588637.26.1788599676466; 
 Sat, 05 Sep 2026 02:14:36 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:14:35 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:22 +0800
Subject: [PATCH v11 09/17] riscv: dts: spacemit: k1-musepi-pro: enable USB
 3 ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-9-235eacd94fe0@riscstar.com>
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

