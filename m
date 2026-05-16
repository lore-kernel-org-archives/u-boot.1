Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B16CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 03:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155FA84807;
	Sun, 17 May 2026 05:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="t2zba1Ww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15B208465A; Sat, 16 May 2026 20:21:38 +0200 (CEST)
Received: from mxd-3-706.seznam.cz (mxd-3-706.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2497C84686
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 20:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-85fb448c55-l247v
 (smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
 id 73537e27285d2a4e72fab279; Sat, 16 May 2026 20:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778955667; bh=GwxyOhlD2XpG2XnMo5fBTDo1G8Q0ci6gkhAmcwDEz+g=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=t2zba1WweWEe5C7QhZ3s+lrUqSPpSnMh1tU74NRrNbVsMMlznjo38bMNSjXtWFL+N
 yipz6hqN0/K+RYiHXkb0IXZyqDUbpmI4X26HdXfPGiOnSb75MV45uK5sYpwFinGAUG
 Trmc2fVvi/2J2VrGpmXjH4/UKHPnSkxwkoMcxM8kCMrqWpR4ThXOkufls+C2kxcjC1
 tv5WfxpnHCIpbT9xBagbGMS2Xnpyi8kNT3fZ72t0dtP1uHU+4c4Q8h1Eunmt0gXGyo
 XXfQom5Skj6t2sPgXMJD9kakj5OtsLfdQ5DYc/TlpdYpynNp9PzxbLu3OT6z8/IDvh
 TlP7hI1ZtcvQA==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-745c4d9bbb-4gnxc (szn-email-smtpd/2.0.73) with ESMTPA
 id b0b1f2ca-85cc-46a9-82cf-118286504a34;
 Sat, 16 May 2026 20:20:37 +0200
From: michael.srba@seznam.cz
Date: Sat, 16 May 2026 20:20:01 +0200
Subject: [PATCH v8 12/12] dts: add u-boot specific sdm845 .dtsi and a .dtsi
 for shift-axolotl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-qcom_spl-v8-12-69b55c9abffe@seznam.cz>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
In-Reply-To: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
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
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 17 May 2026 05:15:41 +0200
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
2.54.0

