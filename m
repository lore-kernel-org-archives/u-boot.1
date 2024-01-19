Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8465C47422
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 00:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2026D87BB6;
	Fri, 19 Jan 2024 01:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705625234;
	bh=lgBd3rMCObRdXK4yn8zqn1PATY2aJfxxb0UnaoPW79I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Pwwe74/UaaBGHndTL0KIdErWqafS6pCF3TJwc3QjnIqB/eCsldc1CdbjehHoYW4+3
	 ccT66qIEAHdEyZxvNqB8dyZWNtYH2qZDk9XNVLo55yppvUKSzJd87G/GEjAtfop6qe
	 VAhsXFjKHVYJYrOItrDNI93BTE991M00VQcBxqwmnArF83ATMf3JoPoWb2Oi9rVj1U
	 2Ty8KPhawsOihoHxbojLVKNSubZV46LbxtcDNOk9vhpnCe8ZVe0KdPa3cVbNbCPqug
	 0XI4EKznFk2aKU+hz6f9BZgrpqG8+zuRw4kIUrkLREtPZH26smIwbAFRIRejaPEHOZ
	 rych6xbc+hbOA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BFCDA876C8;
 Fri, 19 Jan 2024 01:47:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705625233;
 bh=lgBd3rMCObRdXK4yn8zqn1PATY2aJfxxb0UnaoPW79I=;
 h=From:To:Cc:Subject:Date:From;
 b=nV+0KcHY8zR02x+5tMUKt427BLyXDR/Amhe1x058VpUpnaFMEiCcUMXezMm5bZvDz
 2q7U6SkkLxFjVdtsNvqWe+0jivdD0gneDznTz3zKj2xayo2o4+b/KigYZFQxu359I3
 sh1gGMp4g8odvHfZ6ARL9rGmVcw7R16jUpA6W17bLsYFOYnKSuyQ/JJGTlgMiVm/mY
 T56RsRTjNN1Xrqme7mS5BCaEaL8ZJFKKDUDh9ayduOkxt03Vo87+Nz/bTR5YGqKOZN
 nVdF4jhK9jbuTR54QEW5o5A5VuhLze5xiqhhHDMfgtsMemhoswlHpdUKzjDqrFGVWj
 /9L91vcYoiyCg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: Configure GIC clock parent on Data Modul i.MX8M
 Plus eDM SBC
Date: Fri, 19 Jan 2024 01:46:36 +0100
Message-ID: <20240119004656.264825-1-marex@denx.de>
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
configuration expected by the Linux kernel. Enable SPL_BOARD_INIT
and fill in the GIC clock configuration code.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@denx.de>
Cc: Stefano Babic <sbabic@denx.de>
---
 board/data_modul/imx8mp_edm_sbc/spl.c       | 13 +++++++++++++
 configs/imx8mp_data_modul_edm_sbc_defconfig |  1 +
 2 files changed, 14 insertions(+)

diff --git a/board/data_modul/imx8mp_edm_sbc/spl.c b/board/data_modul/imx8mp_edm_sbc/spl.c
index a3600c8568a..cc2d253e391 100644
--- a/board/data_modul/imx8mp_edm_sbc/spl.c
+++ b/board/data_modul/imx8mp_edm_sbc/spl.c
@@ -80,6 +80,19 @@ int data_modul_imx_edm_sbc_board_power_init(void)
 	return 0;
 }
 
+void spl_board_init(void)
+{
+	/*
+	 * Set GIC clock to 500 MHz for OD VDD_SOC. Kernel driver does not
+	 * allow to change it. Should set the clock after PMIC setting done.
+	 * Default is 400 MHz (system_pll1_800m with div = 2) set by ROM for
+	 * ND VDD_SOC.
+	 */
+	clock_enable(CCGR_GIC, 0);
+	clock_set_target_val(GIC_CLK_ROOT, CLK_ROOT_ON | CLK_ROOT_SOURCE_SEL(5));
+	clock_enable(CCGR_GIC, 1);
+}
+
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	if (boot_dev_spl == SPI_NOR_BOOT)	/* SPI NOR */
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index a55630c1a6d..d29bc986267 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -56,6 +56,7 @@ CONFIG_SPL_MAX_SIZE=0x25000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x96fc00
 CONFIG_SPL_BSS_MAX_SIZE=0x400
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.43.0

