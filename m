Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C9AC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 09:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD67387481;
	Fri,  3 Nov 2023 10:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA8286F20; Fri,  3 Nov 2023 10:28:39 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDFF287481
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 10:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA628C000F;
 Fri,  3 Nov 2023 09:28:29 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, heiko@sntech.de
Subject: [PATCH v2 2/2] rockchip: ringneck-px30: enable SPL_BOARD_INIT
Date: Fri,  3 Nov 2023 10:28:13 +0100
Message-ID: <20231103-ringneck-stm32-reset-v2-2-a0e5559f89bf@theobroma-systems.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103-ringneck-stm32-reset-v2-0-a0e5559f89bf@theobroma-systems.com>
References: <20231103-ringneck-stm32-reset-v2-0-a0e5559f89bf@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: foss@0leil.net
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

Now that Ringneck requires some board-specific code (namely resetting
the MCU companion controller) to be run during SPL stage, let's enable
SPL_BOARD_INIT.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 configs/ringneck-px30_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index b4666d0e90f..420c9cd1e89 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -38,6 +38,7 @@ CONFIG_SPL_PAD_TO=0x0
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x4000000
 CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set

-- 
2.41.0

