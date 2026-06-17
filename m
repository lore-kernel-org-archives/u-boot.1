Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D799CD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E90849CA;
	Wed, 17 Jun 2026 14:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thundersoft.com header.i=@thundersoft.com header.b="Zvxp/4il";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B51846B0; Wed, 17 Jun 2026 12:56:53 +0200 (CEST)
Received: from mail-m10219.netease.com (mail-m10219.netease.com
 [154.81.10.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7405D84833
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=thundersoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongyang.zhao@thundersoft.com
Received: from [127.0.1.1] (unknown [36.129.139.90])
 by smtp.qiye.163.com (Hmail) with ESMTP id 42c14b65a;
 Wed, 17 Jun 2026 18:56:45 +0800 (GMT+08:00)
From: Hongyang Zhao <hongyang.zhao@thundersoft.com>
Date: Wed, 17 Jun 2026 18:56:11 +0800
Subject: [PATCH 1/3] dts: qcs6490-rubikpi3: Add U-Boot dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-qcs6490-rubikpi3-v1-1-495f618a1e4c@thundersoft.com>
References: <20260617-qcs6490-rubikpi3-v1-0-495f618a1e4c@thundersoft.com>
In-Reply-To: <20260617-qcs6490-rubikpi3-v1-0-495f618a1e4c@thundersoft.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Hongyang Zhao <hongyang.zhao@thundersoft.com>, 
 Roger Shimizu <rosh@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781693803; l=1428;
 i=hongyang.zhao@thundersoft.com; s=20260127; h=from:subject:message-id;
 bh=ARKNP19o8JWEAngrvbHe+MGZff5TrlphobeT9+pTZGY=;
 b=nwTAs2lZXxOzH6XM+A1VdTW+qUHjZl6UbCX5AAON6Pnuhzj5Ek0BnbZL87nshqxaNRcSy+qhA
 jHGmDLpXi5XCuQKLJLut6nCQYLDcdVaQgwRAkdd3uGjdGNw5Sr68bNQ
X-Developer-Key: i=hongyang.zhao@thundersoft.com; a=ed25519;
 pk=D9yL5W9Zj0lPBDAq9gzY++1849VlXuTWAkROzZ88J/4=
X-HM-Tid: 0a9ed539f35409d5kunme9f1286a14f7bb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSk5CVklJS0NCSUwaShhPT1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKSUJVSkhCVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
 lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Zvxp/4ilfSsOLp7Sj3ZsxC3OfYLTeGVCXG2IDvhf9J68Gifavsin2R8v4BB128A+UopCFTLMuuLXVMuP8w8PNOHfMtchyUdMLw/QLBYXU7zc/2UVSgszM+zbCvdF0prdBByiWzpdVPwONpZh4sARJ2LcP7pp8lCFcMbcc7YYm8Q=;
 s=default; c=relaxed/relaxed; d=thundersoft.com; v=1; 
 bh=qGOgSh7Otil2ozLsMadSb6lGwQiTLiBewNiKxTOtg9k=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:21 +0200
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

Add the board-specific U-Boot device tree overrides for the
Thundercomm RUBIK Pi 3.

When U-Boot is loaded as the primary bootloader, no previous stage
provides the memory layout. Describe the 8 GiB LPDDR4x layout locally
so U-Boot can use the available DRAM.

Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
---
 .../arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi b/arch/arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi
new file mode 100644
index 00000000000..8518cd402d0
--- /dev/null
+++ b/arch/arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/ {
+	/*
+	 * When running as the primary bootloader there is no prior stage to
+	 * populate the memory layout for us. We should have multiple nodes
+	 * here, but ABL does not like that.
+	 */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x39700000>,
+		      <0 0xc0000000 0 0x01800000>,
+		      <0 0xc3400000 0 0xbcc00000>,
+		      <1 0x80000000 1 0x00000000>;
+	};
+};
+
+// RAM Entry 0 : Base 0x0080000000  Size 0x0039700000
+// RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
+// RAM Entry 2 : Base 0x00C3400000  Size 0x00BCC00000
+// RAM Entry 3 : Base 0x0180000000  Size 0x0100000000

-- 
2.43.0

