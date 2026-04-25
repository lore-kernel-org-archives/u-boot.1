Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59641FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 23:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E16840CB;
	Sun, 26 Apr 2026 01:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="P2R5zGe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62443841F2; Sun, 26 Apr 2026 01:27:50 +0200 (CEST)
Received: from mxd-2-a06.seznam.cz (mxd-2-a06.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a06])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 756A78407E
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 01:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-68df9c878f-wmttj
 (smtpc-mxd-68df9c878f-wmttj [2a02:598:64:8a00::1000:a06])
 id 51b2c4020abc906b501b085c; Sun, 26 Apr 2026 01:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1777159624; bh=DDA7rWY6uiVaHcUKNCnkd0n3f3qAbapNWaHF3o4J1yc=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=P2R5zGe8rRjcQ8DXQU1Y0JCYetTJAJ43MwiIg2UV35BDJc+YuIT5GG5QeFZs/fkHt
 hZlnIeLBJI8pnrVDiv/Gjj5xZxwEcAe49z9cLH6/HGVnDQ/B/htMu8jDipyxrEI6Yr
 JYDPOuuP4hoL9m1/WseVobzDZec8fi6ims64+ph7SzFMIQ5D3QrDpRjUPuvORRH7aO
 0bO26cuOmGknTBEs+b0RP6IFT5iUuW2lf+YUCPfe0op2uYv9lKAhTnSIpd5kDAxBlE
 dcymXzs6gx6/ijqAp4b3N8Ixp0+XrwJ36gvRnNk5fz7iWbAwxUZs5SdSogHK3Fvfki
 +a+gQTLVz1Kig==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-7c7c659656-cskk5 (szn-email-smtpd/2.0.72) with ESMTPA
 id a88c2161-bb95-46d9-85c6-bf6f366b65c8;
 Sun, 26 Apr 2026 01:26:59 +0200
From: michael.srba@seznam.cz
Date: Sun, 26 Apr 2026 01:26:13 +0200
Subject: [PATCH v4 11/11] dts: add u-boot specific sdm845 .dtsi and a .dtsi
 for shift-axolotl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-qcom_spl-v4-11-8cf4133ff883@seznam.cz>
References: <20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz>
In-Reply-To: <20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sun, 26 Apr 2026 01:47:27 +0200
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

From: Michael Srba <Michael.Srba@seznam.cz>

The board .dtsi just includes the SoC-specific .dtsi, which
adds bootph-all markings to upstream dts nodes which are
needed in SPL.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi |  2 ++
 arch/arm/dts/sdm845-u-boot.dtsi               | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi b/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi
new file mode 100644
index 00000000000..d41210ab23a
--- /dev/null
+++ b/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "sdm845-u-boot.dtsi"
diff --git a/arch/arm/dts/sdm845-u-boot.dtsi b/arch/arm/dts/sdm845-u-boot.dtsi
new file mode 100644
index 00000000000..b029264555b
--- /dev/null
+++ b/arch/arm/dts/sdm845-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+&gcc {
+	bootph-all;
+};
+
+&usb_1_hsphy {
+	bootph-all;
+};
+
+&usb_1_dwc3 {
+	bootph-all;
+};
+
+&rpmhcc {
+	bootph-all;
+};

-- 
2.53.0

