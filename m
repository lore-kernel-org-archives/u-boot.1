Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283CFCCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 00:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2524C83B22;
	Wed, 12 Nov 2025 01:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="RcfYarTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ADD583B83; Wed, 12 Nov 2025 01:55:43 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C3B083AB4
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 01:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1762908925;
 bh=R0D2Wxk/0Bt2EpekGGVCjfBewUdynye5G1+6TXSgfVg=;
 h=From:To:Cc:Subject:Date:From;
 b=RcfYarTLklN1SRAc3DVG6RZiS9Pm+30NGGVSBEgSvSpmHQMJUA+UUMepAgLJV8GTQ
 +sP0XeH28j8DDhpRIUdGeihtz0UD2EZVr2qsh2yDtB3fUi+w6j9OJNQQQuXJoeQ4wL
 z2LcAOvgnKR5I3Adt79tK/cErUe/YhoT46xHO/EOlRFffg9EW0s7ZEQKAG6WidwnQo
 nggdYpu9BQaonjLb99HIEbqKh3YwKHHY+ufGOGZWfJ3yiNQXJM55H08EozGYRTMggr
 RaXN0VIuIVx2kvERiQbFXeKxM2lxTCncOZm76iBylTf34q2NvmkLN/G+cGABZ8Kkrt
 s0oXtfX2l7bzA==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4EF8EB22133F;
 Wed, 12 Nov 2025 01:55:24 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH] configs: starfive: enable wget https
Date: Tue, 11 Nov 2025 16:54:42 -0800
Message-ID: <20251112005451.41285-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Enable WGET_HTTPS (no CA verification; also enables dependency MBEDTLS_LIB)

Signed-off-by: E Shattow <e@freeshell.de>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index fa83ecfa10f..a754134a313 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -76,6 +76,7 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_WGET=y
+CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
 CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
@@ -154,3 +155,4 @@ CONFIG_USB_GADGET=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_STARFIVE=y
+CONFIG_MBEDTLS_LIB=y

base-commit: caa740df9cae5ddc74b18b88a4fea43e27b2fdf6
-- 
2.50.0

