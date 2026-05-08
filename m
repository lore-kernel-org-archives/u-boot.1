Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383A7CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 04:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9025E84BD1;
	Fri,  8 May 2026 06:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="JwTXrF9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE6884C06; Fri,  8 May 2026 02:34:36 +0200 (CEST)
Received: from mxd-3-701.seznam.cz (mxd-3-701.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE73984B42
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 02:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-gj4cr
 (smtpc-mxd-5f4d8d5f6f-gj4cr [2a02:598:96:8a00::1200:701])
 id 4f9f3ca3149168ca4e36f0fd; Fri, 08 May 2026 02:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778200432; bh=DDA7rWY6uiVaHcUKNCnkd0n3f3qAbapNWaHF3o4J1yc=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=JwTXrF9L1oDw+pOat+2mUmPVsvW48/Sb51PZr6mbMeZsbMS0FqtoRE7td+CX1hV33
 U9N6NC6Wd9nVJrZzSshG2fhFB6l+dAtsJKO08QKJQCHJqS3lSkBuP28JFInDde/0Kj
 uO6ZwJdfAxyk0nvLvAPBmllW3OMyGWVhNLiAWE9bWMNscDR9+DppklBu6ELxa9pjri
 GXekRR9NeyIH213sft6eAzAB5oW1Jjv0zkP1YvF75IYx5PuPIQdABfnFsYaNK0EuBw
 CaewCyw3WzKgvMnDcG0GaM0OeVh3X5ZUUkDEyZFK0Z/heGCUHWfFLczhUP7av5Hd0/
 nNaNOBZXx4Kkg==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-6597cc8696-xddnz (szn-email-smtpd/2.0.72) with ESMTPA
 id b91ce0e4-2bab-4dde-a116-4c1526828646;
 Fri, 08 May 2026 02:33:42 +0200
From: michael.srba@seznam.cz
Date: Fri, 08 May 2026 02:33:33 +0200
Subject: [PATCH v6 11/11] dts: add u-boot specific sdm845 .dtsi and a .dtsi
 for shift-axolotl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-qcom_spl-v6-11-aaac1ab17b50@seznam.cz>
References: <20260508-qcom_spl-v6-0-aaac1ab17b50@seznam.cz>
In-Reply-To: <20260508-qcom_spl-v6-0-aaac1ab17b50@seznam.cz>
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
X-Mailman-Approved-At: Fri, 08 May 2026 06:08:16 +0200
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

