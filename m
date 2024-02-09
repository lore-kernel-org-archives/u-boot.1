Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB66C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC8E87ED2;
	Fri,  9 Feb 2024 10:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BE987E7C; Fri,  9 Feb 2024 10:50:38 +0100 (CET)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [84.16.66.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1880287EB8
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TWTcS6BCkzMpvhp;
 Fri,  9 Feb 2024 10:50:32 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TWTcR40H0zMpnPh; Fri,  9 Feb 2024 10:50:31 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 09 Feb 2024 10:50:11 +0100
Subject: [PATCH v2 15/20] rockchip: rk3588: bind MMC controllers in U-Boot
 proper pre-reloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-jaguar-v2-15-6c9ffe09b924@theobroma-systems.com>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
In-Reply-To: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.12.4
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node as
pre-reloc after relocation"), bootph-pre-ram doesn't make U-Boot proper
bind the device before relocation.

While this is usually not much of an issue, it is when there's a lookup
for devices by code running before the relocation. Such is the case of
env_init() which calls env_driver_lookup() which calls
env_get_location() which is a weak symbol and may call
arch_env_get_location() also a weak symbol. Those are two functions that
may traverse UCLASS to find some devices (e.g.
board/theobroma-systems/common/common.c:arch_env_get_location()).

This allows something in the env_init() call stack to be able to use
uclasses for SD and eMMC controller on RK3588S/RK3588. This aligns the
behavior with what seems to be all SoCs except RK356x family.

Additionally, if any other env function (e.g. env_load) were to be used
before relocation, this is also required as otherwise it wouldn't be
able to find the MMC device(s).

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/dts/rk3588s-u-boot.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index bf3b1ea8a3c..3f194e8ffbd 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -187,12 +187,12 @@
 };
 
 &sdmmc {
-	bootph-pre-ram;
+	bootph-all;
 	u-boot,spl-fifo-mode;
 };
 
 &sdhci {
-	bootph-pre-ram;
+	bootph-all;
 	u-boot,spl-fifo-mode;
 };
 

-- 
2.43.0

