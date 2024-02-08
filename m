Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDA1C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5042087E40;
	Thu,  8 Feb 2024 13:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="PcfQuhH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCBF987E01; Thu,  8 Feb 2024 10:45:50 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE74A87DFB
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 10:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rY0yX-0003pb-IC; Thu, 08 Feb 2024 04:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=cpoIPFh596R9NJkDwPxjTNABNxWB0rY2XorzgiXqNZM=; b=PcfQuhH2hUNM/0scZUxP
 zyb6UrmQaHMPfRHIzMA1aBDEyQ2OYVtPObr7KYDgOzkOdIqrlQXVnviuYq78NKiYP8bzD4C3+Srrp
 IgQtsYTbGY+pRvdBwP1I9Yu32UmcwLFeh1NqbZjBaYZNjEqQ2Mk6OI2qDPmOD07xtyQz0cdY73YGP
 OArW+S+qqX9dk5RhTl2BBaI9dWAzlnbYkElrTXwSq4NTJjSm21KlQC9qCQ5j8c0h0F14gMJF+3GnP
 Y8Il6nHXZp5dVyLOqDab4qypbXdms9ZlAWuZp9fcVS9e+44Cf0eff6nu/OiYAw66x8FAz0KL9e0P3
 m6deqyoYT6Ry6g==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 2/2] configs: imx93_var_som: Enable AHAB support
Date: Thu,  8 Feb 2024 10:45:18 +0100
Message-ID: <20240208094518.391-3-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208094518.391-1-othacehe@gnu.org>
References: <20240208094518.391-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Feb 2024 13:10:31 +0100
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

Enable AHAB support in the imx93_var_som configuration.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 configs/imx93_var_som_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx93_var_som_defconfig b/configs/imx93_var_som_defconfig
index cc0c5a79bc1..14922f2a3e2 100644
--- a/configs/imx93_var_som_defconfig
+++ b/configs/imx93_var_som_defconfig
@@ -12,6 +12,7 @@ CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx93-var-som-symphony"
 CONFIG_SPL_TEXT_BASE=0x2049A000
+CONFIG_AHAB_BOOT=y
 CONFIG_TARGET_IMX93_VAR_SOM=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SPL_SERIAL=y
-- 
2.41.0

