Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74496CD5BAB
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 02:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D5A84894;
	Fri, 22 May 2026 04:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="oIi8Krle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C845846FA; Thu, 21 May 2026 22:38:28 +0200 (CEST)
Received: from mxd-1-a07.seznam.cz (mxd-1-a07.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a07])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A0784713
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 22:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5757bcb9c-s9zn4
 (smtpc-mxd-5757bcb9c-s9zn4 [2a02:598:128:8a00::1000:a07])
 id 1968bc0c4266e86518c17052; Thu, 21 May 2026 22:37:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1779395862; bh=V2UZgj7y9W2vEUxKk3o8MF2t9tvaazirzdMe6roAgwA=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=oIi8KrleNzXEhLLrvy5S1QLDulF474KOIUFVYBM0X6H1h+a+pq4qG7LsjJ59sPzS9
 SumbJLkMyUYZdTaIlXSYyP7HE1fyxxR76SPuuwQCJgqjmt72SjEu9j+h/pyH+LMvWx
 639MnLZYRZCDB9sLqaaEF5VfHQzNCKm3idDJIKv+xGiEkib2RfKCrxRDmJXgD19JV2
 2qNEEXpPeI0eJCku3bqEvNoQJGMY6yS3cYDUxjpbJAiQiC0iM0jMULW/8tuR833HH6
 xyy3M7huolYqRX+XrQIcxcpvydLhkL+sRCAtW7SL+AiMl9tmsGCB/f4bZEnpxcwxsY
 v+qQdwTE5DT0A==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-74847c99f5-r6cjq (szn-email-smtpd/2.0.73) with ESMTPA
 id d46b9cec-464d-4a4e-b7dd-6e627d32468b;
 Thu, 21 May 2026 22:37:37 +0200
From: michael.srba@seznam.cz
Date: Thu, 21 May 2026 22:37:19 +0200
Subject: [PATCH v9 07/12] mach-snapdragon: Kconfig: changes / additions to
 support SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-qcom_spl-v9-7-c108ebe8ff4e@seznam.cz>
References: <20260521-qcom_spl-v9-0-c108ebe8ff4e@seznam.cz>
In-Reply-To: <20260521-qcom_spl-v9-0-c108ebe8ff4e@seznam.cz>
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
X-Mailman-Approved-At: Fri, 22 May 2026 04:13:03 +0200
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

Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI in SPL.
(SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else will.)

Also select (SPL_)OF_LIVE and (SPL_)EVENT, which are needed to fix up
upstream dt to make usb work, and in general don't make sense to
disable in SPL as long as we're not running out of SRAM.

Mirror u-boot proper selections like GPIO and pinctrl to ensure consistent
behavior, and select SPL_SPRINTF, SPL_LIBCOMMON_SUPPORT etc for similar
reasons.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/Kconfig                 | 33 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 850768282ce..65910d014ea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1139,6 +1139,7 @@ config ARCH_SNAPDRAGON
 	select DM_GPIO
 	select DM_SERIAL
 	select DM_RESET
+	select EVENT
 	select POWER_DOMAIN
 	select GPIO_EXTRA_HEADER
 	select OF_CONTROL
@@ -1149,9 +1150,39 @@ config ARCH_SNAPDRAGON
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI
+	select SYSRESET_PSCI if !SPL
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
+	select SUPPORT_SPL
+
+	select OF_LIVE
+	select SPL_OF_LIVE
+	select ARMV8_SPL_EXCEPTION_VECTORS if SPL
+	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
+	select SPL_DM if SPL
+	select SPL_DM_GPIO if SPL
+	select SPL_DM_PMIC if SPL
+	select SPL_DM_USB_GADGET if SPL
+	select SPL_ENV_SUPPORT if SPL
+	select SPL_EVENT
+	select SPL_GPIO if SPL
+	select SPL_HAS_BSS_LINKER_SECTION if SPL
+	select SPL_LIBCOMMON_SUPPORT if SPL
+	select SPL_LIBDISK_SUPPORT if SPL
+	select SPL_LIBGENERIC_SUPPORT if SPL
+	select SPL_OF_CONTROL if SPL
+	select SPL_PINCONF if SPL
+	select SPL_PINCTRL if SPL
+	select SPL_PINCTRL_FULL if SPL
+	select SPL_PINCTRL_GENERIC if SPL
+	select SPL_PINCONF_RECURSIVE if SPL
+	select SPL_PINMUX if SPL
+	select SPL_SPMI if SPL
+	select SPL_SPMI_MSM if SPL
+	select SPL_SPRINTF if SPL
+	select SPL_STRTO if SPL
+	select SPL_USB_GADGET if SPL
+	imply SPL_MMC if SPL
 	imply OF_UPSTREAM
 	imply CMD_DM
 	imply DM_USB_GADGET
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index c195d478512..a2228e217af 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -14,6 +14,9 @@ config SYS_VENDOR
 config SYS_MALLOC_F_LEN
 	default 0x2000
 
+config SPL_SYS_MALLOC_F
+	default y
+
 config SPL_SYS_MALLOC_F_LEN
 	default 0x2000
 
@@ -39,6 +42,13 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config SPL_SHARES_INIT_SP_ADDR
+	# override the default from common/spl/Kconfig
+	default n
+
+config SPL_HAVE_INIT_STACK
+	default y
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional

-- 
2.54.0

