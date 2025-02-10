Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8ADC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92CD980548;
	Mon, 10 Feb 2025 21:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB48805D7; Mon, 10 Feb 2025 21:23:31 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A708043C
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 18858B4C01D1;
 Mon, 10 Feb 2025 21:23:27 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
	Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>,
	u-boot@lists.denx.de
Subject: [PATCH v1] configs: starfive: use LwIP network stack and enable wget
 command
Date: Mon, 10 Feb 2025 12:22:08 -0800
Message-ID: <20250210202216.295853-1-e@freeshell.de>
X-Mailer: git-send-email 2.47.2
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

Use LwIP network stack and enable wget HTTP command. The tftpput command
is not currently supported by LwIP network stack so remove it.

Signed-off-by: E Shattow <e@freeshell.de>
---
 configs/starfive_visionfive2_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index c3f2142ae1b..1e0a99ed17b 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -77,3 +77,3 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
-CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_BOOTSTAGE=y
@@ -86,2 +86,3 @@ CONFIG_ENV_SECT_SIZE_AUTO=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_LWIP=y
 CONFIG_SPL_DM_SEQ_ALIAS=y

base-commit: cfdf18b31b0f5aa4b1ffdac28a4e823e8bf31159
-- 
2.47.2

