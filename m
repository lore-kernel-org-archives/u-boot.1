Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665FB1125839
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81D05840BE;
	Wed, 11 Mar 2026 15:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="uUsH6Tu0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00BFF8404A; Wed, 11 Mar 2026 14:31:28 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7209084013
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 14:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439c4bde55cso5715062f8f.1
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1773235885; x=1773840685; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pAVouB8aZczz3XrpjzGf0Nk0Tsv4eyGvDHqgswmXV8A=;
 b=uUsH6Tu0hk8Es6QWNDJgtxBw+nns9HTtah70Y2PbPfo108J0u73xjNB9xsUtd87zlR
 rgVVuVY7YTbuQw/OFsSkd/ifmZF2Rm/uP4ZYbfjJLGe4q/HsEbzJFiM+YNtZNdHQS/hO
 oKHlm1YqPvM5sbu8Zz+wQhYpc6+/w5k+EEcDpxFcyaGBs8f4Z7qUks02vx1FGxxjYrrA
 SfARWbAoOcqgmb7HClEWrDTR2zIzpV0f9X0TWN/6Ic0nAjSfmvGL15beouMRdvRDHvO9
 mixH1P0GOepp8YJgNs+SGxA/+2peVtVUbP8QgyTCE8k2xk3K5LD9cfkO4GKHMms+jJqH
 RNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773235885; x=1773840685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pAVouB8aZczz3XrpjzGf0Nk0Tsv4eyGvDHqgswmXV8A=;
 b=nLZrkthtm26WyfKGxPKDmSmtoV9rqU87TkeCMQYlnKdpxeSZeQU0+HxfhKYvFD4clD
 ph9/AHjrLmx59ciipFyJ6wadrHz5nGtkz+p0YLCH/GgZihi076cLpQkikxXBX2vk3dSU
 NaGZhf74120mhdeymfGanL7w/oggPyugoTo8rv9FAX6ER7eZ9s549ZN6xd5sAOvy3vut
 pokpQzRDV6Fb/nXsy/Njwwr3FKYMZns2U/q1Iz82YDw1oz+pQ2lgQuqNFB0+BrzyfqM4
 BK6PLkG8ZHGOF92xFEEVdpAZHkTUSQwC95AehrjEBN/7yYGqNxJi0dK62V20OUEHYsAW
 XsqQ==
X-Gm-Message-State: AOJu0YzvFJqN1mfEhkgBbSbW+HRrR3WoFZUr6HeaTDOWr38HrnVh4i1+
 byc/gbcGikhJacOx2F2ZKTe7dbZHlIVECo7i09saAf9S6U3dSO5Zo8xA4yOJuG0DNQc=
X-Gm-Gg: ATEYQzzOMCwpTrvHclJrHjRcImEh/H+i9wRPp1b0OUCvGzHqClG89rsWKRpHVd9LY8S
 GLe4M10UUORZqnJ0Bd0GLfBy1kaccpgAkmExzs1yGkNi5zlQCGAioSEPpNqE+fR3SrcRsXJdj/T
 AUNRdStjeTGeqADrIc7JkRBIAuby1DWEpg05Zf7P3W0nIhLXxpwgN9ayCaSxRT+3reBQJzXP8D0
 t8+Of7s5ybZMoY7rhiQEZv8cmJt7hvnOeOgNAOr4sCdPh8khAB6dvxmuJDzMEnZAcbjnG+3fyEM
 Q2mnoS1wrIMqVuDYMip9INDwp0q3lyw/d9tz7iGDpK6ipxus5cc+vEBZhQ5ON8C8Z1NfhMcTPkp
 FC3gzIRk2kWcGubYHFs8fbgGl9YDh7vv34f0sNcXylTTIXM/YuMd6FfrcijpcoBajTRqpjfWGSf
 kCmU+9smgKsjbr4g1WX6Z7F9+LgTOjwQrBax7U6hkHw1hGRe1iH8aLW7QKHQ7mBE0actsbgOJQo
 1pVow==
X-Received: by 2002:a05:6000:1788:b0:439:c799:dbf2 with SMTP id
 ffacd0b85a97d-439f81f3d9dmr5337139f8f.9.1773235884791; 
 Wed, 11 Mar 2026 06:31:24 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae.
 [86.98.192.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81a9e25sm5903038f8f.15.2026.03.11.06.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 06:31:24 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 17:30:57 +0400
Subject: [PATCH v6 2/6] arm64: dts: rockchip: enable UFS controller on
 FriendlyElec NanoPi M5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-rk3576-ufs-v6-2-c7c353739242@flipper.net>
References: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
In-Reply-To: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Dhruva Gole <d-gole@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Qkkxr0v7FLv8rA/lVvtmaq0Vb+2sCZ1KYFGOtd25kxI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRuzFvQdenU04sZwSI7mhadcrZ8xKn7sr3uSZhlSp2IE
 OdehTuVHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEz1bVZGhtUzH0s3s8+5uO9TZe8kpbXyk10jZ818IDBbZH7A1fpnhxMZGXrfdB4
 9P+eM/fdDxVO5rvk89H8f83KyYN6PDrMD1eZFnEwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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

From: Alexey Charkov <alchark@gmail.com>

The NanoPi M5 board supports pluggable UFS modules using the UFSHC
inside its Rockchip RK3576 SoC.

Enable the respective devicetree node and add its supply regulators.

Link: https://wiki.friendlyelec.com/wiki/images/9/97/NanoPi_M5_LP5_2411_SCH.pdf
Signed-off-by: Alexey Charkov <alchark@gmail.com>
Link: https://patch.msgid.link/20251230-nanopi-m5-ufs-v3-1-ed188ae34fdb@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: cd50298ffc5f98872ddf0ac05c51a014003a34b7 ]

(cherry picked from commit d9f2b91a7b6cc955e272c31a4bcb03a1c564efad)
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 .../src/arm64/rockchip/rk3576-nanopi-m5.dts        | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3576-nanopi-m5.dts b/dts/upstream/src/arm64/rockchip/rk3576-nanopi-m5.dts
index bb2cc2814b83..5c6e6c7a213a 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576-nanopi-m5.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3576-nanopi-m5.dts
@@ -110,6 +110,22 @@
 		regulator-name = "vcc12v_dcin";
 	};
 
+	vcc1v2_ufs_vccq: regulator-vcc1v2-ufs-vccq {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-name = "vcc1v2_ufs_vccq";
+		vin-supply = <&vcc5v0_sys_s5>;
+	};
+
+	vcc1v8_ufs_vccq2: regulator-vcc1v8-ufs-vccq2 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-name = "vcc1v8_ufs_vccq2";
+		vin-supply = <&vcc_1v8_s3>;
+	};
+
 	vcc3v3_m2_keym: regulator-vcc3v3-m2-keym {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -910,6 +926,14 @@
 	status = "okay";
 };
 
+&ufshc {
+	vcc-supply = <&vcc_3v3_s3>;
+	vccq-supply = <&vcc1v2_ufs_vccq>;
+	vccq2-supply = <&vcc1v8_ufs_vccq2>;
+	vdd-hba-supply = <&vdda_1v2_s0>;
+	status = "okay";
+};
+
 &usbdp_phy {
 	status = "okay";
 };

-- 
2.52.0

