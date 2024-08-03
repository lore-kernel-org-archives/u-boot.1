Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E333C49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 13:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0894788C8C;
	Sat,  3 Aug 2024 15:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B7AC88BFF; Sat,  3 Aug 2024 15:55:52 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8AB88C7B
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 15:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1saFEZ-000691-Nh; Sat, 03 Aug 2024 15:55:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: u-boot@lists.denx.de
Cc: heiko@sntech.de,
	ukleinek@debian.org
Subject: [PATCH 03/15] DONOTMERGE: arm64: dts: rockchip: enable uart0 on
 Qnap-TS433
Date: Sat,  3 Aug 2024 15:55:30 +0200
Message-Id: <20240803135542.3124517-4-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240803135542.3124517-1-heiko@sntech.de>
References: <20240803135542.3124517-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Uart0 is connected to an MCU on the board that handles system control
like the fan-speed. So far no driver for it is available though.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240723195538.1133436-4-heiko@sntech.de

[this needs to be replaced, once the patch hits the devicetree-rebasing repo]

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
index 9bf9c3b65ca..bc26f2e98c1 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
@@ -104,6 +104,14 @@
 	status = "okay";
 };
 
+/*
+ * Connected to an MCU, that provides access to more LEDs,
+ * buzzer, fan control and more.
+ */
+&uart0 {
+	status = "okay";
+};
+
 /*
  * Pins available on CN3 connector at TTL voltage level (3V3).
  * ,_  _.
-- 
2.39.2

