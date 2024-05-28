Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD3CC27C43
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 22:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32EE0885C7;
	Wed, 29 May 2024 00:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YM09jUrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E12C884DB; Tue, 28 May 2024 19:05:45 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDFAF8844E
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 19:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so9641195ad.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716915941; x=1717520741; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJpyztKIK8vF0S7eCHU5v8uNEEFqTTVPD34i9ho0PRY=;
 b=YM09jUrhAwLb1Wqg7eU1s08FcON4pqQqOp/Wt3ZV6OGeH1DruO33Db9en17TDaBaux
 jdyXO0ul+tA6VFd0tbRlcPcoIzGJxce6uJLhr9/zI3eRv4yWRuLbkmIqlTzRGnKSVNSA
 i1oaZPsTRQK87k3d6d/8WIX8SsC/oNIwjjePwbQma8hQwQtIEd2vapU2cLD7xRBKVGNt
 3n/3dR7JC54omUTclMA5qTB9bU8lVyH39V87KqDJEf2iJ1E7+vup0Wwq7DDMw4kuEqaQ
 vcqWxogcd7ajc/pU/SuyqNJqsqjeIcyr78Tzsh1J7lUZf3FajYPB3DXj7mHV4lQf6Bv3
 IAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716915941; x=1717520741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJpyztKIK8vF0S7eCHU5v8uNEEFqTTVPD34i9ho0PRY=;
 b=Uq8AKjnRbj5kgLj0HTGcKcfPibhP5nUsW5dvZAWrokg3pPkInqTZtXQhdTyJgj+nWw
 ddZ+H/5RnBsrX414iiiagB1xZf2miKdVd6zDOEko9WhGZonM1SZMMkxnhcgrZER5BMoB
 9sqtS8s693Yz/nPd2a3aGLHHbxMXeHr/U4LfPWM0nIhbigZRsql2C1QYstkDVggjjGR6
 lSTT2NwSykSeT0g32mr7ZyZUZXd84l3WBc9ej4neGuQKiYy7n/9Hl2mf+rqM0db7NaFo
 qeIiipQ0+lxj4yhrOFRLHX0LIAJk7XVs3unDES1ZLRVFc9/ApY4fRDjCPhjTrDM86B9Y
 +8PQ==
X-Gm-Message-State: AOJu0Yw0V4ChwwtH0aKJ72TFJOa8LiUa4887ulK8LQP5CSNOHCozKluv
 sRlThgkgPEFgr5UyPbAV5y7QXCeaskgrRUoFriPF15uC7QO356KTX0JtqY/BjK0yEg==
X-Google-Smtp-Source: AGHT+IFSHJuHtwnNuCACspJbag9yeCpD5tFmSfE9eU+EaviY6exNUqXuPQS6c9d1RZ7A25sNFkfoAA==
X-Received: by 2002:a17:902:ce84:b0:1f4:aa72:1c7 with SMTP id
 d9443c01a7336-1f4aa72038fmr61663365ad.26.1716915940801; 
 Tue, 28 May 2024 10:05:40 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f47efff203sm53037705ad.241.2024.05.28.10.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 10:05:40 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Jianfeng Liu <liujianfeng1994@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Kever Yang <kever.yang@rock-chips.com>, Niklas Cassel <cassel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 06/10] arm64: dts: rockchip: add USB3 DRD controllers on
 rk3588
Date: Wed, 29 May 2024 01:04:02 +0800
Message-Id: <20240528170406.353616-7-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528170406.353616-1-liujianfeng1994@gmail.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 May 2024 00:21:20 +0200
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

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Add both USB3 dual-role controllers to the RK3588 devicetree.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20240408225109.128953-8-sebastian.reichel@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 33f393a2a990e16f56931ca708295f31d2b44415 ]

(cherry picked from commit c7ed588e14f7dd04a92fb55f12680f94c7b14edf)
Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

(no changes since v1)

 dts/upstream/src/arm64/rockchip/rk3588.dtsi  | 20 ++++++++++++++++++
 dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 22 ++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588.dtsi b/dts/upstream/src/arm64/rockchip/rk3588.dtsi
index 4fdd047c9eb..5984016b5f9 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588.dtsi
@@ -7,6 +7,26 @@
 #include "rk3588-pinctrl.dtsi"
 
 / {
+	usb_host1_xhci: usb@fc400000 {
+		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
+		reg = <0x0 0xfc400000 0x0 0x400000>;
+		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru REF_CLK_USB3OTG1>, <&cru SUSPEND_CLK_USB3OTG1>,
+			 <&cru ACLK_USB3OTG1>;
+		clock-names = "ref_clk", "suspend_clk", "bus_clk";
+		dr_mode = "otg";
+		phys = <&u2phy1_otg>, <&usbdp_phy1 PHY_TYPE_USB3>;
+		phy-names = "usb2-phy", "usb3-phy";
+		phy_type = "utmi_wide";
+		power-domains = <&power RK3588_PD_USB>;
+		resets = <&cru SRST_A_USB3OTG1>;
+		snps,dis_enblslpm_quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
+		status = "disabled";
+	};
+
 	pcie30_phy_grf: syscon@fd5b8000 {
 		compatible = "rockchip,rk3588-pcie3-phy-grf", "syscon";
 		reg = <0x0 0xfd5b8000 0x0 0x10000>;
diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
index 9063c0bb0f0..b0a59ec5183 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
@@ -492,6 +492,28 @@
 		};
 	};
 
+	usb_host0_xhci: usb@fc000000 {
+		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
+		reg = <0x0 0xfc000000 0x0 0x400000>;
+		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru REF_CLK_USB3OTG0>, <&cru SUSPEND_CLK_USB3OTG0>,
+			 <&cru ACLK_USB3OTG0>;
+		clock-names = "ref_clk", "suspend_clk", "bus_clk";
+		dr_mode = "otg";
+		phys = <&u2phy0_otg>, <&usbdp_phy0 PHY_TYPE_USB3>;
+		phy-names = "usb2-phy", "usb3-phy";
+		phy_type = "utmi_wide";
+		power-domains = <&power RK3588_PD_USB>;
+		resets = <&cru SRST_A_USB3OTG0>;
+		snps,dis_enblslpm_quirk;
+		snps,dis-u1-entry-quirk;
+		snps,dis-u2-entry-quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb@fc800000 {
 		compatible = "rockchip,rk3588-ehci", "generic-ehci";
 		reg = <0x0 0xfc800000 0x0 0x40000>;
-- 
2.34.1

