Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F19C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD6280F9E;
	Thu, 20 Feb 2025 14:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ogtywd/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E1F380F53; Thu, 20 Feb 2025 11:02:50 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B14C480C98
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 11:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51KA2jIp566427
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 04:02:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740045766;
 bh=LoLWWZ/fgOcZNGnxr/tZkvm5i3wUHJMQtM5COjECqzo=;
 h=From:To:CC:Subject:Date;
 b=Ogtywd/+YdK+0D1kwtuFn41vgrHV/EpDBtNoq6nLtT+xVIiGsciXIhd3vUoUhDr4w
 MN290aQ8nKLJLruQOfzFee1H7p/3e28cX1v+rdubKIIz9rxrznMdXCmaqKgVT9Wtfl
 1d6s4DAfnL5XJIcjorG3MoLeCTdoMrrqU09O2Elo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51KA2jgS092534;
 Thu, 20 Feb 2025 04:02:45 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Feb 2025 04:02:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Feb 2025 04:02:45 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51KA2ftY129602;
 Thu, 20 Feb 2025 04:02:42 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>, <s-k6@ti.com>, <kamlesh@ti.com>, 
 <a-shenai@ti.com>
CC: <u-boot@lists.denx.de>, <s-vadapalli@ti.com>, <h-salunke@ti.com>,
 <danishanwar@ti.com>, <srk@ti.com>
Subject: [PATCH] configs: am65x_evm_r5_usbdfu_defconfig: Fix USB DFU boot
Date: Thu, 20 Feb 2025 15:32:41 +0530
Message-ID: <20250220100241.1170993-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 20 Feb 2025 14:50:09 +0100
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

Increase the size of malloc region allocated before relocation, as
current size is insufficient for dfu boot causing it to overflow and
corrupt the stack.

Enable the fixed regulator configs required by vtt_supply which is used
by "am654_ddrss" driver. Without it during DFU boot DDRSS initialization
is failing. These configs are enabled in "am65x_evm_r5_defconfig" but
are missing from "am65x_evm_r5_usbdfu_defconfig".

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
This patch is based on following commit in master branch
7a45cb4ffe fs/erofs: fix an integer overflow in symlink resolution

 configs/am65x_evm_r5_usbdfu_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index 0b5eaeb363..672346b332 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_LEN=0x2000000
-CONFIG_SYS_MALLOC_F_LEN=0x55000
+CONFIG_SYS_MALLOC_F_LEN=0x57000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
@@ -98,6 +98,8 @@ CONFIG_POWER_DOMAIN=y
 CONFIG_TI_SCI_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_TPS62360=y
-- 
2.34.1

