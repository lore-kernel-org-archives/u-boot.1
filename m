Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D65C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B44A587D33;
	Tue, 23 Jan 2024 15:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867E487D3C; Tue, 23 Jan 2024 15:49:53 +0100 (CET)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 078E487D42
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TK93d4jMqzMs5F7;
 Tue, 23 Jan 2024 15:49:49 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TK93c2Jq6zVJG; Tue, 23 Jan 2024 15:49:48 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Andy Yan <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 01/18] rockchip: rk3588: use mainline pmu-grf compatible
Date: Tue, 23 Jan 2024 15:49:09 +0100
Message-ID: <20240123-jaguar-v1-1-1eec1c34953c@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The compatible for the pmugrf in the mainline kernel is dfferent from the
one currently used in u-boot. Adapt the -u-boot.dtsi and syscon driver
to use the correct compatible.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/dts/rk3588s-u-boot.dtsi              | 2 +-
 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index c0fd16c4022..9a5ffec926e 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -66,7 +66,7 @@
 
 	pmu1_grf: syscon@fd58a000 {
 		bootph-all;
-		compatible = "rockchip,rk3588-pmu1-grf", "syscon";
+		compatible = "rockchip,rk3588-pmugrf", "syscon";
 		reg = <0x0 0xfd58a000 0x0 0x2000>;
 	};
 
diff --git a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c b/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
index e8772d3a382..7b2cf37d9da 100644
--- a/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
@@ -10,7 +10,7 @@
 
 static const struct udevice_id rk3588_syscon_ids[] = {
 	{ .compatible = "rockchip,rk3588-sys-grf", .data = ROCKCHIP_SYSCON_GRF },
-	{ .compatible = "rockchip,rk3588-pmu1-grf", .data = ROCKCHIP_SYSCON_PMUGRF },
+	{ .compatible = "rockchip,rk3588-pmugrf",  .data = ROCKCHIP_SYSCON_PMUGRF },
 	{ .compatible = "rockchip,rk3588-vop-grf", .data = ROCKCHIP_SYSCON_VOP_GRF },
 	{ .compatible = "rockchip,rk3588-vo-grf",  .data = ROCKCHIP_SYSCON_VO_GRF },
 	{ .compatible = "rockchip,pcie30-phy-grf", .data = ROCKCHIP_SYSCON_PCIE30_PHY_GRF },

-- 
2.43.0

