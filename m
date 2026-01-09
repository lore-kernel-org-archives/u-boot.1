Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49469D16812
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E83483CB1;
	Fri,  9 Jan 2026 12:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D3583CDF; Fri,  9 Jan 2026 12:18:00 +0100 (CET)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D7A683C51
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dnfQG0DDHzcWB;
 Fri,  9 Jan 2026 12:17:58 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dnfQF1k8dzxXX; Fri,  9 Jan 2026 12:17:57 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 09 Jan 2026 12:17:48 +0100
Subject: [PATCH] rockchip: tiger-rk3588: disable HS400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-tiger-no-hs400-v1-1-94c0c17076d5@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBuYxKS6SrSQHGs2FhoRiHdPW
 r7F/wUyJ+EMsyqQ+JEsZ2zoOwXb4eLOKL4ZNGlLPY14y84J44lHNkRozODDZJx11kOLrsRB3n+
 4rLV+Nu8roGAAAAA=
X-Change-ID: 20260108-tiger-no-hs400-445df94a6a6d
To: u-boot@lists.denx.de
Cc: Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Tiger suffers from eMMC signal integrity issues which means we can only
run it at HS200 max.

The Device Tree has these properties removed since v6.18 (commit
baa18d577cd4 ("arm64: dts: rockchip: disable HS400 on RK3588 Tiger")),
which has now merged in U-Boot.

Since the controller side doesn't support HS400 anymore, let's not
confuse users as to why HS400 is enabled in the config but not working
as we know it cannot work (and won't be used anyway since the controller
doesn't advertise support for it in the Device Tree).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/tiger-rk3588_defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
index 50a3b553a11..a545ec714b5 100644
--- a/configs/tiger-rk3588_defconfig
+++ b/configs/tiger-rk3588_defconfig
@@ -76,10 +76,6 @@ CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_SPL_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_ES_SUPPORT=y
-CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y

---
base-commit: 141be72e2a9d43aa4e3d1a6a6e0ab8f9eb8784c6
change-id: 20260108-tiger-no-hs400-445df94a6a6d

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

