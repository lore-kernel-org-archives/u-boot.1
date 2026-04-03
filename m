Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A9FE88D87
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 06:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE1E84101;
	Sat,  4 Apr 2026 08:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="v+06PoSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 031B884150; Sat,  4 Apr 2026 01:19:36 +0200 (CEST)
Received: from mxd-2-a16.seznam.cz (mxd-2-a16.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84B4580325
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 01:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-sbn6w
 (smtpc-mxd-7644845457-sbn6w [2a02:598:64:8a00::1000:a16])
 id 1678a6c14d76f2a817d16a9f; Sat, 04 Apr 2026 01:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775258330; bh=tIw3qLJFStFgwPCCaV8iHrGjThTXDgU+vzLASjnDWh4=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=v+06PoSwa7o0wqsBKjhEUXqEedd/gS1e8wOnrq4Ch7OFel4lpMQIu82eqOHxK0aJC
 9q+k585nF43r/qLL9dJlmpGXFKT2su5oHqmknTXfYvL1mHjnMLj2zh7WQeH9aKFwA+
 KYwt4Aul7lNsFkpcVY+LsdFg3IqndE16kuFC0VluMGDwJm2qe/rD+D7FSRJnZB+CLu
 vfg4LB6NoGKRDvBNiiUVPVh5XTuTzppwoRKwX1Gzh7KWdVjLjkxlLRrG6hL/6KWXry
 daHWhk/vKqBK8fXUfO/NInCx1jI4e2WUTslTGuGdo2gNrDfOBtVKGezFIgI8piktLq
 b9cNV09D0d1Lw==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-789d8dfb5c-z7n27 (szn-email-smtpd/2.0.71) with ESMTPA
 id 05ee8018-fc2e-444e-9ad7-3245cf751009;
 Sat, 04 Apr 2026 01:18:30 +0200
From: michael.srba@seznam.cz
Date: Sat, 04 Apr 2026 01:18:18 +0200
Subject: [PATCH 3/5] drivers: allow clk_stub and spmi in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260404-qcom_spl-v1-3-9e6c2ac66587@seznam.cz>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
In-Reply-To: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
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
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sat, 04 Apr 2026 08:31:19 +0200
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
---
 drivers/Makefile     | 2 +-
 drivers/clk/Kconfig  | 6 ++++++
 drivers/spmi/Kconfig | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index de993ae42ac..f76b38126e0 100644
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
@@ -105,7 +106,6 @@ obj-$(CONFIG_DM_REBOOT_MODE) += reboot-mode/
 obj-y += rtc/
 obj-y += scsi/
 obj-y += sound/
-obj-y += spmi/
 obj-y += watchdog/
 obj-$(CONFIG_QE) += qe/
 obj-$(CONFIG_U_QE) += qe/
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c88931c8ec4..fc2e152f975 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -114,6 +114,12 @@ config CLK_STUB
 	  Enable this to provide a stub clock driver for non-essential clock
 	  controllers.
 
+config SPL_CLK_STUB
+	bool "Stub clock driver"
+	depends on SPL_CLK
+	help
+	  Enablestub clock driver in SPL
+
 config CLK_BCM6345
 	bool "Clock controller driver for BCM6345"
 	depends on CLK && ARCH_BMIPS
diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index ab4878ebae4..4c94f2e0ff4 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -8,6 +8,12 @@ config SPMI
 	  SPMI (System Power Management Interface) bus is used
 	  to connect PMIC devices on various SoCs.
 
+config SPL_SPMI
+	bool "Enable SPMI bus support in SPL"
+	depends on SPL_DM
+	---help---
+	  Select this to SPMI bus support in SPL
+
 config SPMI_MSM
 	bool "Support Qualcomm SPMI bus"
 	depends on SPMI

-- 
2.53.0

