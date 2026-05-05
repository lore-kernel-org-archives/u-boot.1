Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E359CFF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 02:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3794584872;
	Tue,  5 May 2026 04:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="Y20gQbnY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 357CD84836; Tue,  5 May 2026 02:49:16 +0200 (CEST)
Received: from mxd-2-a03.seznam.cz (mxd-2-a03.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a03])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D8DA846F2
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 02:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-w7th8
 (smtpc-mxd-5f4d8d5f6f-w7th8 [2a02:598:64:8a00::1000:a03])
 id 3fabde0a64a58a633e021254; Tue, 05 May 2026 02:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1777942096; bh=LzUFm91lEtDUFrBGtn1WjB9eHzAi6zQwp2B3v1E+pyg=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=Y20gQbnYkWbknwC05g5XBSO/W4iHKP2hW30QKx8aRl3w4R8pTTXPRzLUfYt6Re7gd
 pWMkS9tgXqXYE+v7ulxA8h46fax6/C4djzVaJVYI3sNd3wGMMHq4NTYGdKgxUSLDwN
 nLM5oJRLPm0en5aqDG2tUQf+7vqoIVyMANnEb8Clj3GiHmeRkGZTywXlMGcjBjrfwh
 srr01FQyePfFhcWqtQxvAFP2axjRHXUyGj/BLlu1p1TTVCIpGj9A2ISg6phk9wEogl
 t3W3ijSnROkMLFk/aCembyPmb5QS3IygpUnGG/kBLP6J2N2w2A1bAE6VjBYY0Ftoo+
 oBdusHXOwgdWQ==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-7c7c659656-rb5ts (szn-email-smtpd/2.0.72) with ESMTPA
 id f149aa54-de23-446f-b5a6-517b5d1eefa0;
 Tue, 05 May 2026 02:48:13 +0200
From: michael.srba@seznam.cz
Date: Tue, 05 May 2026 02:47:49 +0200
Subject: [PATCH v5 03/11] drivers: allow clk_stub and spmi in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-qcom_spl-v5-3-11817415d664@seznam.cz>
References: <20260505-qcom_spl-v5-0-11817415d664@seznam.cz>
In-Reply-To: <20260505-qcom_spl-v5-0-11817415d664@seznam.cz>
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
X-Mailman-Approved-At: Tue, 05 May 2026 04:20:34 +0200
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

Only Makefile and Kconfig changes necessary.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/Makefile      |  2 +-
 drivers/clk/Kconfig   |  7 +++++++
 drivers/spmi/Kconfig  | 13 +++++++++++++
 drivers/spmi/Makefile |  4 ++--
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba33281..477718ce89a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)RAM) += ram/
 obj-$(CONFIG_$(PHASE_)RTC) += rtc/
 obj-$(CONFIG_$(PHASE_)SERIAL) += serial/
 obj-$(CONFIG_$(PHASE_)SPI) += spi/
+obj-$(CONFIG_$(PHASE_)SPMI) += spmi/
 obj-$(CONFIG_$(PHASE_)TIMER) += timer/
 obj-$(CONFIG_$(PHASE_)VIRTIO) += virtio/
 obj-$(CONFIG_$(PHASE_)DM_MAILBOX) += mailbox/
@@ -106,7 +107,6 @@ obj-$(CONFIG_DM_REBOOT_MODE) += reboot-mode/
 obj-y += rtc/
 obj-y += scsi/
 obj-y += sound/
-obj-y += spmi/
 obj-y += watchdog/
 obj-$(CONFIG_QE) += qe/
 obj-$(CONFIG_U_QE) += qe/
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c2da7b3938b..a50e0b89be7 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -114,6 +114,13 @@ config CLK_STUB
 	  Enable this to provide a stub clock driver for non-essential clock
 	  controllers.
 
+config SPL_CLK_STUB
+	bool "Stub clock driver"
+	depends on SPL_CLK
+	help
+	  Enable this to provide a stub clock driver in SPL for non-essential
+	  clock controllers
+
 config CLK_BCM6345
 	bool "Clock controller driver for BCM6345"
 	depends on CLK && ARCH_BMIPS
diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index ab4878ebae4..ace4a3be75b 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -8,12 +8,25 @@ config SPMI
 	  SPMI (System Power Management Interface) bus is used
 	  to connect PMIC devices on various SoCs.
 
+config SPL_SPMI
+	bool "Enable SPMI bus support in SPL"
+	depends on SPL_DM
+	help
+	  Select this to enable SPMI bus support in SPL
+
 config SPMI_MSM
 	bool "Support Qualcomm SPMI bus"
 	depends on SPMI
 	---help---
 	  Support SPMI bus implementation found on Qualcomm Snapdragon SoCs.
 
+config SPL_SPMI_MSM
+	bool "Support Qualcomm SPMI bus"
+	depends on SPL_SPMI
+	help
+	  Support SPMI bus implementation found on Qualcomm Snapdragon SoCs
+	  in SPL.
+
 config SPMI_SANDBOX
 	bool "Support for Sandbox SPMI bus"
 	depends on SPMI
diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 1b3d57f36a9..8cb93c820e0 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -2,6 +2,6 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
-obj-$(CONFIG_SPMI)  += spmi-uclass.o
-obj-$(CONFIG_SPMI_MSM) += spmi-msm.o
+obj-$(CONFIG_$(PHASE_)SPMI)  += spmi-uclass.o
+obj-$(CONFIG_$(PHASE_)SPMI_MSM) += spmi-msm.o
 obj-$(CONFIG_SPMI_SANDBOX) += spmi-sandbox.o

-- 
2.53.0

