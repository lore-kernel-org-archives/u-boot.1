Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6FACAC592
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 00:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D2883335;
	Wed, 17 Sep 2025 02:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FCE783335; Wed, 17 Sep 2025 02:05:08 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FB0C8331F
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 02:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 54554B22088A;
 Wed, 17 Sep 2025 02:05:02 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 4/4] configs: starfive: Use visionfive2
 DEVICE_TREE_INCLUDES dtsi named similar to defconfig
Date: Tue, 16 Sep 2025 17:02:25 -0700
Message-ID: <20250917000254.1134031-5-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250917000254.1134031-1-e@freeshell.de>
References: <20250917000254.1134031-1-e@freeshell.de>
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

Add SYS_CPU automatic inclusion jh7110-u-boot.dtsi to item of config list
DEVICE_TREE_INCLUDES as starfive-visionfive2-u-boot.dtsi and rename file.

Signed-off-by: E Shattow <e@freeshell.de>
---
 .../dts/{jh7110-u-boot.dtsi => starfive-visionfive2-u-boot.dtsi} | 0
 configs/starfive_visionfive2_defconfig                           | 1 +
 2 files changed, 1 insertion(+)
 rename arch/riscv/dts/{jh7110-u-boot.dtsi => starfive-visionfive2-u-boot.dtsi} (100%)

diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/starfive-visionfive2-u-boot.dtsi
similarity index 100%
rename from arch/riscv/dts/jh7110-u-boot.dtsi
rename to arch/riscv/dts/starfive-visionfive2-u-boot.dtsi
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index bd1aacbad6a..34ebf3b605b 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -78,6 +78,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_WGET=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
+CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
 CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
-- 
2.50.0

