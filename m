Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79369FD0651
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB608407E;
	Wed, 11 Mar 2026 15:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="jw6LBUIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8EDA8404A; Wed, 11 Mar 2026 14:31:23 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7435184013
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 14:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so9857531f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1773235881; x=1773840681; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w7Bru08F3dX/wGCL6infh8paIvHaqovZAsFcld08CZ4=;
 b=jw6LBUIJ76/YowyZ96G9rZO0PpxTCy0PgEUHVohLjy5qxdvT2rT5lFmG17U7hktP5w
 0WBkd9LHO+XJJu4Ue9EqPk5AXWcfPBK32HU4Vd/85yQNKcTmRS21orLD6UhcTjWdK9uw
 XsL/1fcdehpZetbx/a/eU+c2gXxiWja/bWXJBpclEcenFJtsQfWHY5UUQ1MBrokDLTUc
 9aGs1LV+ZUq1L64bH8oCT+qPphROv5k36nVLBO6xZHo0PNffETUHboy1a5lPsMfg+lOu
 XAVSicFZRMh6Xe+UulfhafzMoXu8IhSFUdyQTnQdoDC9suhReyXV1TKYe6NnJH37ZUxG
 o6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773235881; x=1773840681;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w7Bru08F3dX/wGCL6infh8paIvHaqovZAsFcld08CZ4=;
 b=nDnVqU51ypkXdMqlczln62jrqzhFaU0IJHvYWbdLe/hPtRprnEMTgGwusItHIWrHiF
 7JDbVR/Q5NQrnHHRm7ZgbkOwKX272B73RixjNla0dV1LsbCtp4BVa5wQ8nsR7a04vjIW
 yBim7lMVrdpBw+K9cR0ZCksMLqAQ1H+r82aT6RCUOewu4VFDRT50kDdM5u26y6qy87Hz
 WtELkHtCwXCUPoyozp2wu0MxEb78373q/F54cb/dbUKLXmvj63DUpN+LwIRsDecyaeHR
 yF7BWA+4tbqlUZqDON03rt+nuKf09SGLTF18r5Lm8ClnHosuXV+o9fvapwy7cBQKwJTR
 qUqw==
X-Gm-Message-State: AOJu0YzFTgN9rHdiY+pqTToUBnNAOGum9BlIfgGOW8FUUBgg8ot55rVy
 OH1mxD0xasD810p05GH+7dXhbIif+ChNdUDAffEzrkSeORytxXEtScKot2fOOCGnwcs=
X-Gm-Gg: ATEYQzwb075bjVRmz29cJ5vcEWbBFb/RgiNaGQfU7IRSC+hWorbGi1bb7Qi3gcNbSIN
 Mj8qQk/0iEkoplhYo/tNsWs5V/ya7VhnUaM3V1VU+weysxEOlv7eluRc4651v8XiWkolF67qyDj
 Q0OWXKo0u2FjAzWRPZbn2SIjeGTwgWNocfSnlAfo1vanrZ/YLHhd4/yATGVUooo262NzJHhUPOf
 8l+vlqaoFgbUftxBBzvGnNaoxn2YHT9w8k0agKxIxX8MN5vD8dGEZO6PZTAte2M3Tb0D64y2Qco
 uoTHXklwfOXPymxG+QoYqqheOHqkOugGTptkQ4KiEtcxnGGzlMTMds1lG7Egiv6o7FV8qUP9Hxa
 Y20UsvaVjjCG2iSBvCSVjo8TBtLJ6HNP3ExXKI2zBVe/I3+gcZFzKlpArZawCd93wCk7+92dFno
 WrIf8LHQGnOeNJkr8ff4gDZJ1ZDmkBBkFELWh8eoVWHzD6f/siDA6H/fAEpTUAvqV+dePR+hD15
 wqj2A==
X-Received: by 2002:a05:6000:250a:b0:439:b791:f91b with SMTP id
 ffacd0b85a97d-439f81bf3b0mr5245585f8f.13.1773235880720; 
 Wed, 11 Mar 2026 06:31:20 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae.
 [86.98.192.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81a9e25sm5903038f8f.15.2026.03.11.06.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 06:31:20 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 17:30:56 +0400
Subject: [PATCH v6 1/6] arm64: dts: rockchip: Explicitly request UFS reset
 pin on RK3576
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-rk3576-ufs-v6-1-c7c353739242@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3654; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Z9/5OuIo1D9EuPgTcjS1dQssZlNEiaiJi8T2SAU4IVQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRuzFsgYdho9mi21OeKQxca4uSqzzsZypa8nS/3TD128
 6Qfqc3TOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 Q0MdYx0jBi5OAZjqU4cY/vD2XqyoVVzjvzW+081L4Ynr9Dzfys/VHvuT92cUd4rUODAyHHmyyT7
 USlXwf5ur/To105KHTrriEgVbN/OalWVcmFXLCgA=
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

Rockchip RK3576 UFS controller uses a dedicated pin to reset the connected
UFS device, which can operate either in a hardware controlled mode or as a
GPIO pin.

Power-on default is GPIO mode, but the boot ROM reconfigures it to a
hardware controlled mode if it uses UFS to load the next boot stage.

Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
device reset, request the required pin config explicitly.

The pin is requested with pull-down enabled, which is in line with the
SoC power-on default and helps ensure that the attached UFS chip stays
in reset until the driver takes over the control of the respective
GPIO line.

This doesn't appear to affect Linux, but it does affect U-boot:

Before:
=> md.l 0x2604b398
2604b398: 00000011 00000000 00000000 00000000  ................
< ... snip ... >
=> ufs init
ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
=> md.l 0x2604b398
2604b398: 00000011 00000000 00000000 00000000  ................

After:
=> md.l 0x2604b398
2604b398: 00000011 00000000 00000000 00000000  ................
< ... snip ...>
=> ufs init
ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
=> md.l 0x2604b398
2604b398: 00000010 00000000 00000000 00000000  ................

(0x2604b398 is the respective pin mux register, with its BIT0 driving the
mode of UFS_RST: unset = GPIO, set = hardware controlled UFS_RST)

This helps ensure that GPIO-driven device reset actually fires when the
system requests it, not when whatever black box magic inside the UFSHC
decides to reset the flash chip.

Fixes: c75e5e010fef ("scsi: arm64: dts: rockchip: Add UFS support for RK3576 SoC")
Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
Link: https://patch.msgid.link/20260121-ufs-rst-v3-1-35839bcb4ca7@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 79a3286e61829fc43abdd6e3beb31b24930c7af6 ]

(cherry picked from commit 438f1fe833e0d2f004e12579899dd322994c23d7)
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 dts/upstream/src/arm64/rockchip/rk3576-pinctrl.dtsi | 7 +++++++
 dts/upstream/src/arm64/rockchip/rk3576.dtsi         | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3576-pinctrl.dtsi b/dts/upstream/src/arm64/rockchip/rk3576-pinctrl.dtsi
index 0b0851a7e4ea..98c9f8013158 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3576-pinctrl.dtsi
@@ -5228,6 +5228,13 @@
 				/* ufs_rstn */
 				<4 RK_PD0 1 &pcfg_pull_none>;
 		};
+
+		/omit-if-no-ref/
+		ufs_rstgpio: ufs-rstgpio {
+			rockchip,pins =
+				/* ufs_rstn */
+				<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
 	};
 
 	ufs_testdata0 {
diff --git a/dts/upstream/src/arm64/rockchip/rk3576.dtsi b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
index c72343e7a045..70e67d4dccb8 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3576.dtsi
@@ -1826,7 +1826,7 @@
 			assigned-clock-parents = <&cru CLK_REF_MPHY_26M>;
 			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&power RK3576_PD_USB>;
-			pinctrl-0 = <&ufs_refclk>;
+			pinctrl-0 = <&ufs_refclk &ufs_rstgpio>;
 			pinctrl-names = "default";
 			resets = <&cru SRST_A_UFS_BIU>, <&cru SRST_A_UFS_SYS>,
 				 <&cru SRST_A_UFS>, <&cru SRST_P_UFS_GRF>;

-- 
2.52.0

