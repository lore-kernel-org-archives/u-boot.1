Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46ADC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 22:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E915885AE;
	Wed, 29 May 2024 00:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mHdjQBFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFE5884DB; Tue, 28 May 2024 19:05:32 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159208844E
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 19:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f69422c090so890657b3a.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716915928; x=1717520728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNYpzyzhwN53DQ+Ve+aWRwDU8zrfBcpiLfX6HvQdw8Q=;
 b=mHdjQBFI/M6qe6J60PP6jNdHTjnzp5wFENJUt5o2aEugBzV0wOUwEW79gnpD92GK7d
 Xzd94PaCrw+0o2WBFlmbjENQepWILE4V/k3PK1V31Pr08ueIrHyLa5uXc4LrX1E5XuPd
 wcdJwjYGhsL9d+cPGbnsGxKjT8tF1ePHj5/bAZzUp9pG0OREmUu69DcqJRu4bNYhNt1t
 RBln9yfH3/k2+VJn5vrx5TdS42OlMRxQZg/TrkuiuTnoPSv6lvZu6EU34rBSInVjN0iW
 BIaPwZMGckQ67u3mp6uh08+3wIoXaQVH/IB0mt/njfTqqW4xqcTJ8NtaLlj5myRp6F35
 tcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716915928; x=1717520728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNYpzyzhwN53DQ+Ve+aWRwDU8zrfBcpiLfX6HvQdw8Q=;
 b=jg8IAoeHbce98pk3HoXKQX6Vpqe/Oas5OyUr59UWL4e37yrIDGp3vt8OROx79YXwy7
 AAI8pqxTeg/vd1oPCitQe3GQG3S82On2+0vf89GbfzQBB9iIZxmGCuCaLsS71M/UBLCN
 0kZCCSiODFvmox++JXDD8Kdph2X9+eJDlHXn3Timxlr1ipyIUH/BFBboEO3FExtjIYDQ
 CNR5IQ5UV7lf5rjs1MS7kUXyh3UhQCKTT0+lHry5pJnlbYe861CkftrmNfsp+d8FUl9I
 MUQuy0NAJNYnQvYeBQyCuIcsii+YYGmStROagkfeea8wOlbWICs/RIPa0q6s3R+0z9yg
 wSZg==
X-Gm-Message-State: AOJu0Yzyb/gal5vdpTG9iz8KDkjrjh7ss0OEYTWDILpiYIz5ZsCUW6eC
 lspH01Oppb2J7L7SKykJS+WxlZ8no4wFqwF0+Vj2gAAPjzIA9xTOHiriXdZ6P2ba2w==
X-Google-Smtp-Source: AGHT+IFYd5BUVLn6rj1I8MCYI6TpRqtQ84+AFcFhCQu0VI+LH7qWBDVvx/YGlwvhTIFqv3a1M3ueIA==
X-Received: by 2002:a17:902:e743:b0:1f4:5da0:815e with SMTP id
 d9443c01a7336-1f45da08448mr115657225ad.54.1716915928182; 
 Tue, 28 May 2024 10:05:28 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f47efff203sm53037705ad.241.2024.05.28.10.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 10:05:27 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Jianfeng Liu <liujianfeng1994@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Kever Yang <kever.yang@rock-chips.com>, Niklas Cassel <cassel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 04/10] arm64: dts: rockchip: reorder usb2phy properties for
 rk3588
Date: Wed, 29 May 2024 01:04:00 +0800
Message-Id: <20240528170406.353616-5-liujianfeng1994@gmail.com>
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

Reorder common DT properties alphabetically for usb2phy, according
to latest DT style rules.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20240408225109.128953-6-sebastian.reichel@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: abe68e0ca71dddce0e5419e35507cb464d61870d ]

(cherry picked from commit f6835a60a8a28ff14ffb3dd80c99ce1c137d06c5)
Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

(no changes since v1)

 dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
index 87df0902273..58d12969b7e 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
@@ -602,13 +602,13 @@
 		u2phy2: usb2phy@8000 {
 			compatible = "rockchip,rk3588-usb2phy";
 			reg = <0x8000 0x10>;
-			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
-			resets = <&cru SRST_OTGPHY_U2_0>, <&cru SRST_P_USB2PHY_U2_0_GRF0>;
-			reset-names = "phy", "apb";
+			#clock-cells = <0>;
 			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
 			clock-names = "phyclk";
 			clock-output-names = "usb480m_phy2";
-			#clock-cells = <0>;
+			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U2_0>, <&cru SRST_P_USB2PHY_U2_0_GRF0>;
+			reset-names = "phy", "apb";
 			status = "disabled";
 
 			u2phy2_host: host-port {
@@ -627,13 +627,13 @@
 		u2phy3: usb2phy@c000 {
 			compatible = "rockchip,rk3588-usb2phy";
 			reg = <0xc000 0x10>;
-			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
-			resets = <&cru SRST_OTGPHY_U2_1>, <&cru SRST_P_USB2PHY_U2_1_GRF0>;
-			reset-names = "phy", "apb";
+			#clock-cells = <0>;
 			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
 			clock-names = "phyclk";
 			clock-output-names = "usb480m_phy3";
-			#clock-cells = <0>;
+			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U2_1>, <&cru SRST_P_USB2PHY_U2_1_GRF0>;
+			reset-names = "phy", "apb";
 			status = "disabled";
 
 			u2phy3_host: host-port {
-- 
2.34.1

