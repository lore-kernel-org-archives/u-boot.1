Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DCFC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FB9340603;
	Mon, 24 Aug 2026 08:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AsmtTGTzfDhv; Mon, 24 Aug 2026 08:51:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561509;
	bh=LE4xlra5gR8klWAk8DU2WgZHmoKJMD4TlCMeSM0UQbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iiTj6k1t01o/A6lGscIauYMlTPN/bwl+e+Uk0Hb0/Z6LxU+bVuIk4ROLYiPLwwz9l
	 u5atNkpy9KYuySs9jhTZRilCMN2owYOFL2rue7DGwtLOCz3WkQfvyk+MC9NiRKAG9x
	 FHkVwY1f0FJQWH54ztpe7fNroMcCGjAyPkUCOgjDOCHgSxbmP9xcgmq77u2RU30oxD
	 ArOcGEZjsfaWj7/TIv3/HFhjVdZ8t/+WQtIQtSqEDyxxfP1PgXYFwHDOL9QscU79U7
	 WRLuu/ig0USEHNEhphBGR/mvmPPHOjAQicIuf59Ta0ehPrAHUgQKWAKmMP9t1j9D+w
	 YQdbFkZ1RpS/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BF4440726;
	Mon, 24 Aug 2026 08:51:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 833D73AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A21E80E01
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5g4ywFVV4Wx3 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:51:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=eetLa4ZA
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9038C80DFE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:47 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38101f85591so3450539a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561506; x=1788166306;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LE4xlra5gR8klWAk8DU2WgZHmoKJMD4TlCMeSM0UQbw=;
 b=eetLa4ZAeMVMav5TZQ797p2IdeTGotqL4ki0QSl7+mGtfl26dF85bEEXSbBWXf7soH
 3iNNSirqYlnMUMP1C/ADxbz6NP42bzMMKHtF33h0hVWxVeRkdQPrhIAwGADABUAOKd8P
 T7txZWCSEt5EYuQC+nJAx1srutp1m4HXUPmY/N4yXNkEZER7hf4KZdfdLoY2D6R44vu7
 ZCYGo2V7ES1yeUKSiURfKRNeysg1rls0tzKE1tfsC3Ep0Rg0PGP1J9chjLSJ99yCRq9w
 ktW198q7UvGriCLOo9NuD/FAO4W6GcNbmQQmFn4pLI2UiZJCPx/b2QZBd4gcX2hSMjjQ
 FbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561506; x=1788166306;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LE4xlra5gR8klWAk8DU2WgZHmoKJMD4TlCMeSM0UQbw=;
 b=kjYfYL6/ee3WxsplTEtB+qhqZuVrxF9PGbC/lG5YCEjpRUrYAJqis8jrGb63pHmJja
 qLhTF3CgYGeouZ29O5LTAJ686fMKGQyA7o7typqzPzQ/VnRxktUY+tsprCFQtQw4luwu
 wNaEIJxGXTZBYJVEKEbHdLHLsvs6Nk9rNiRFduM7MEvRvTVR8XplEe6/xlouwKhsWLsc
 BVVE/k4hVoqIkYuWjElIGrGa33bzz3HGjYvL8uSLoMFpAWSf87RBW3TRXOsJZuGmZbs1
 pAldcjLe2XFV4Rus0DxLjfd72FLN01MS9CExEHiWQXm3zBMcIjARvDA5DvB3kBNIjb5d
 +afw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWnnlMTSZjLQkwUJ2pq/W8B8XLB4RWznbafWjjJRFdJujkMGBLmvHBOGFyzOouYA7utdg0G2E=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m4f36G+lf5fg9WFN28REy6cO1c37qpuHZXxCWghcnfClOptnES
 yktYj0ZbDMdw1eu4dkHPZvb72KC34xZTjK9fYbjpwRfY7saAsrSpQehmvuqd8twy84w=
X-Gm-Gg: AR+sD10Bfn9g7qFA5rr5tIS+ATba/BDV7WvYmSQ95rvnVKaKQWD263ZLDLc6MwB+juc
 VtnrgzJdwfw/S+MUnx7oQcEKoGBYyhD5Rnyz8LWeZAwXRPIaWvt+falUMTMaxbOvweI6JPN5JN+
 q52FgB8l1rZ6diWtLRbUe9OJus9ElkAP6ZJzt+XE4c4KI4RLZ4nC1/cX4MNMU7AK56KnMNsgLYq
 LsBeQo1XSQlSSs2Z9rHv4tYXfMTUP+37iIzOqrzX+Utmil8Iqe9q+XjLThz2f+2Yt3y6oi/Uu28
 XvgXybnik721iO0kbt894SllNBDcEiomkoU7UyQROJMq4/ISljfAHT94jDVozDYPNO/t1O2/gs9
 d04EYhLWRjmf95OI0q9iactEz0OdF2k1bc7iM0x80cNdWyW7vx2v20RCYQacue2BMgFZ329DCM5
 c4z8sbIl9YeXpNy+z+qrMVbLEpNqXAqCYQn9Ommrvwaa/Imxy8I00ZRosxSA5gfEgHqvGtFgRCJ
 0tAN/6ZBId3TKyEB92jwN+vLSZx1YO1KcgUXNDNu/8BQ1LAQT9AjlSy8yu1eatzE3vcxkRnVCe3
 UdjoX6o4DVswXL2NzqFBZ3bgShfdfuV3eEVT
X-Received: by 2002:a17:90b:2646:b0:369:7491:7b24 with SMTP id
 98e67ed59e1d1-395a04e6e66mr38909527a91.6.1787561506464; 
 Mon, 24 Aug 2026 01:51:46 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:51:44 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:44 +0800
Subject: [PATCH v10 09/17] riscv: dts: spacemit: k1-musepi-pro: enable USB
 3 ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-9-5e0adcb1edb9@riscstar.com>
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

