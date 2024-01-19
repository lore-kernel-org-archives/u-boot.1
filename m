Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59795C47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ACAC87D0B;
	Fri, 19 Jan 2024 17:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705680508;
	bh=GlZLFmtrYlQfQyk0PTT0Gv8uYjg7c0klMLMUSNtm/j0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FcDoL/88h6T6e7iLReDEFam1jhBAOr0SQ7f00471VfgOfqurBhLsGnTVvWMxgQG8j
	 pQ3n6xSiws7nJcJUvSmeMtgJxHpDTaW0GNzyUdVHrFRR2CdYn3LR6Mnl+Ua6BIxPww
	 /wW2iXcEBxp2VtTqn5j2TWFstTSDe3zUBZg7sX8MtvM0h/0p1rocB+kipBYQ70DkFC
	 X9qRvNxUMdKi+wnu78v9mqQtf53vsmm82lUb5sY5EFzgmRfJNlDcagxYj5/kmVOkxK
	 DhT/tW1+yV1ZMBACrhIriYL4gbk0C4NCpQOtwURNim7idXsN7mNEX4CalHWO4SXpuy
	 kjaoT89RPwexw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 952B987CF0;
 Fri, 19 Jan 2024 17:08:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705680504;
 bh=GlZLFmtrYlQfQyk0PTT0Gv8uYjg7c0klMLMUSNtm/j0=;
 h=From:To:Cc:Subject:Date:From;
 b=OW30y3OcLBoaKcXRxh/xGVIngnAi7HN/kLg8gX/vdIbaAn55866sy1NBHQHOdW85h
 dy+oiX0cK1cmBaT8hoDoUYE0FqQW3BlwR/8LdAuTAW3gdaMgxwHtE/9SKjji7Vb5sN
 AG23MKMLAvt5tN8nUzEIjlxhnDX/c9QMYxy1MhQwVIUrryMiXSGnfybk4XkmVijBQG
 A/M4/thpek7En7rIyrEyY4nfaXnRabsdUDULMb/ebFvgYFgp+YmlBHONIKRJlx1wnl
 nNMPOBnFYQBOMSab7BbJM0Ly8+l+s7A00uVMwIc9DRaLKupUmlaOXXfvXvk1Ws4rC4
 Jy/u6eCv/w2lQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2] ARM: imx: Enable SPL_BOARD_INIT on DH i.MX8M Plus DHCOM
Date: Fri, 19 Jan 2024 17:07:54 +0100
Message-ID: <20240119160814.11387-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

The CONFIG_SPL_BOARD_INIT lets SPL common code call spl_board_init()
during the SPL start up. On this particular system, spl_board_init()
is used to reconfigure GIC clock parent to PLL2 500M, which is the
configuration expected by the Linux kernel. Enable SPL_BOARD_INIT .

Set GIC clock to 500 MHz for OD VDD_SOC. Kernel driver does not
allow to change it. Should set the clock after PMIC setting done.
Default is 400 MHz (system_pll1_800m with div = 2) set by ROM for
ND VDD_SOC.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@denx.de>
Cc: Stefano Babic <sbabic@denx.de>
---
V2: Duplicate code comment into commit message
---
 configs/imx8mp_dhcom_pdk2_defconfig | 1 +
 configs/imx8mp_dhcom_pdk3_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index dc482abad85..4f907ce00d0 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -54,6 +54,7 @@ CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x96fc00
 CONFIG_SPL_BSS_MAX_SIZE=0x400
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index 3442af6f00e..9972e2d96b6 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -55,6 +55,7 @@ CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x96fc00
 CONFIG_SPL_BSS_MAX_SIZE=0x400
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.43.0

