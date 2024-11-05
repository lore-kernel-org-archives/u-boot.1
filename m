Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFDAD40CEB
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 23:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D469688FD2;
	Wed,  6 Nov 2024 00:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730848080;
	bh=zLHDLFjOqtu2ZfzoxqbldhP7IGiuclBfgFWNwXtN80A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gZokWLd5QNBNuEzJZKjj4rvGcccGKXdC4URb0q3VnRXHuCNkOopd/xeLK5s+K73D2
	 mvT1fOR2AXifkd7FyOA/gtsOHRwpzDGMXSfWu5Df8FiT1EceuV+YRo4iLyIMyR2gmr
	 CoylRztSsmZjT5hAV2sl9nmGJwjdFr6VXKUFWofdrlLTn3nm9cs2kqz69mrqDG57q1
	 VKM2oxlm8gO/pXCtNEQ3fVc13JinVgfzYEnywMiUe2geIv3joIUIUpHkV/qDh8q1FL
	 PP7DIDtLOzKIVzsBizZrQ+rB2urStz1ccsZ0fDi7q/HuGEzxyP5jHBrJzUv9oasTNU
	 arRCh5dwC2IKg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0CE0288E3F;
 Wed,  6 Nov 2024 00:07:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730848079;
 bh=zLHDLFjOqtu2ZfzoxqbldhP7IGiuclBfgFWNwXtN80A=;
 h=From:To:Cc:Subject:Date:From;
 b=wh7f/uHrLqzNPUAfbdKw0jdKkqRtpXVIyxJoIRUyo/dC71p+awwyKvHsFGCCSNb3r
 s9D7HuaDjD5qdFlMCjaDkvQKJWxf61ymchgFG3aT2OOvrRDXZ7ZC9CKHMtHDVW8kMG
 dO48oOg6nSkg+2QSyR5AkJ+/g1Nredl92bOq5Mn29WsOHZ7p2sk8pADzLNwsIPje2v
 OudO6KOmORQudYnZbea2nk4HljJlqhDIUHWRGikX5jhDlHDqA10VGBXD4LRv1xAbjM
 f5a54GkCn/pL7toeZossQEUxqnF3g3E0i4jdZZ/KOFLLLVfLLHGbOBc/HYuuR0KIc5
 KGVnzM6XTjwLg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shawn Guo <shawnguo@kernel.org>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Fabio Estevam <festevam@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH 1/2] ARM: dts: imx6dl: Add support for i.MX6DL DHCOM SoM on
 PDK2 carrier board
Date: Wed,  6 Nov 2024 00:06:52 +0100
Message-ID: <20241105230724.159755-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
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

Add support for the DH electronics i.MX6DL DHCOM SoM and a PDK2 evaluation
board. The evaluation board features three serial ports, USB OTG, USB host
with an USB hub, Fast or Gigabit ethernet, eMMC, uSD, SD, analog audio,
PCIe and HDMI video output.

All of the aforementioned features except for mSATA are supported, mSATA
is not available on i.MX6DL and is only available on DHCOM populated with
i.MX6Q SoC which is already supported upstream.

Backport from linux-next commit
c3f5d76a6e03 ("ARM: dts: imx6dl: Add support for i.MX6DL DHCOM SoM on PDK2 carrier board")

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 .../src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 dts/upstream/src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts

diff --git a/dts/upstream/src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts b/dts/upstream/src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts
new file mode 100644
index 00000000000..38235925257
--- /dev/null
+++ b/dts/upstream/src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Marek Vasut <marex@denx.de>
+ *
+ * DHCOM iMX6 variant:
+ * DHCM-iMX6DL-C080-R102-F0819-E-SD-RTC-T-HS-I-01D2
+ * DHCOM PCB number: 493-400 or newer
+ * PDK2 PCB number: 516-400 or newer
+ */
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-dhcom-som.dtsi"
+#include "imx6qdl-dhcom-pdk2.dtsi"
+
+/ {
+	model = "DH electronics i.MX6DL DHCOM on Premium Developer Kit (2)";
+	compatible = "dh,imx6dl-dhcom-pdk2", "dh,imx6dl-dhcom-som",
+		     "fsl,imx6dl";
+};
-- 
2.45.2

