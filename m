Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90254C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 12:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19C0B88961;
	Fri,  5 Jul 2024 14:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="A0KSni9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E798896C; Fri,  5 Jul 2024 14:11:33 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5E138893E
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 14:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720181491; x=1722773491;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EciUPp1LnL+/LoDxP64Z0uvpgxuQ7ZJiBgAgEzeMLtg=;
 b=A0KSni9JeUEL/MOssCVOmAmx48SL7fiHNp7dailj468CTSfDSsDEyiwU/N9J2aqS
 /eHchrdQYefAhvMrnblP+hFTIdLIK5kzyLT3fcqJfyyAD1Dh4zu8T+rUa5M8T7y+
 opuj+bX3r7uqKjvGGDWwkWUm3HevX0KREzPdnHXw1jA=;
X-AuditID: ac14000a-03251700000021bc-9a-6687e2f35364
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 36.FC.08636.3F2E7866;
 Fri,  5 Jul 2024 14:11:31 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 5 Jul 2024
 14:11:31 +0200
From: Leonard Anderweit <l.anderweit@phytec.de>
To: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, Leonard Anderweit <l.anderweit@phytec.de>,
 Fabio Estevam <festevam@gmail.com>, Yannic Moog <y.moog@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH] configs: phycore-imx8mp_defconfig: Initialize caam
Date: Fri, 5 Jul 2024 14:11:21 +0200
Message-ID: <20240705121121.3829244-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWyRpKBR/fzo/Y0g1+HlSweXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBlnFz1i63g
 FU/F0W3TmBsY13J3MXJySAiYSMy+soSli5GLQ0hgCZPEp3UXmUASQgKPGCUebc4EsdkE9CVW
 vlwEViQicItRou3OK+YuRg4OZgEziQmfk0FMYQFniU3PdEDKWQRUJJ49b2cDsXkFbCT2LZ3B
 CrFLXmLmpe/sEHFBiZMzn7CA2MxA8eats5khbAmJgy9eMEOcoCRx59QvNpjeaedeM0PYoRJH
 Nq1mmsAoMAvJqFlIRs1CMmoBI/MqRqHczOTs1KLMbL2CjMqS1GS9lNRNjKCQFWHg2sHYN8fj
 ECMTB+MhRgkOZiURXqn3zWlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVd3BKcKCaQnlqRmp6YW
 pBbBZJk4OKUaGEX71HQ97sns37W4JeOY9Zy0U8xLpmr/U5toyab+6dhR1sAqJabr+sWrVOat
 bbjHMnVug+3JQIcNC6rvvl36f/abV4VbVhyOS7y04oQdm9oVuboANcNt7AkvvH8ZaM0y3sTm
 52S/VHS5blhW2Vsj7xn/lNcyXmpIEahI2ibN+kTkTmAPv4ibqxJLcUaioRZzUXEiADcI+FdH
 AgAA
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

Initialize the Cryptographic Accelerator and Assurance Module.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index e84d761aeb8c..74d381058190 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -33,6 +33,7 @@ CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
+CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_BOARD_INIT=y
@@ -45,6 +46,7 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
+# CONFIG_SPL_CRYPTO is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
@@ -87,6 +89,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_IMX8MP=y
+CONFIG_FSL_CAAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
 CONFIG_FASTBOOT_BUF_SIZE=0x13000000
@@ -102,7 +105,6 @@ CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 # CONFIG_SPL_DM_I2C is not set
 CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x51
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -152,3 +154,4 @@ CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_IMX_WATCHDOG=y
+# CONFIG_SPL_SHA_HW_ACCEL is not set
-- 
2.25.1

