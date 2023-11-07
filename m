Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECC4C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 16:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D578B87534;
	Tue,  7 Nov 2023 17:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NOJ+0KZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA32B87508; Tue,  7 Nov 2023 17:18:49 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2758751B
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 17:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8150B1C0002;
 Tue,  7 Nov 2023 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1699373927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UnjXEVnQYyie2JWwVQ4gSmHGi9QOVTvhU54k9n79VQ=;
 b=NOJ+0KZR0PpenUbFB9/8X35UCbb286gOL3JyaWHcIgrVf+c0BqxcTBr4q74wGfagKmqIqb
 21r4RtAmBe18R1ITOdeTXjGAV7b2Qkxlv55IwtbFoRI+YNfTitw/PwwaJ357EU7JZCeOdI
 /YBzr8Tx0a6rcM/bi2Dsc9Y5de4oGN6vrrmGTsvdr/JuHfiexHQ/N4paKNMmmXjLnKXEzo
 XFg0xzr5n+uMRFEi+4Hhzyn8HfVBnu4SdZqNvTyA4lLofmycPWmX/DgMOJkUgcPxCAP9F4
 4o60brwdBUahiThzMc0rZe/uARsuiu2cdDnf0y2KDs+HNg+k+434Vpp/umUkhg==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.richard@bootlin.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: [PATCH v2 2/8] configs: j7200_evm_r5: Used reserved memory in DDR for
 stack
Date: Tue,  7 Nov 2023 17:17:56 +0100
Message-Id: <20231107161802.855154-3-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107161802.855154-1-thomas.richard@bootlin.com>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
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

From: Gregory CLEMENT <gregory.clement@bootlin.com>

When resuming from suspend to ram, we load again the DM firmware.
However, we have to be sure to not modify the memory used by
Linux.

Currently the SPL stack in DDR was in place that could be used by
Linux. Instead of it use a memory address that is located in a
reserved location that won't be used by Linux.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---

(no changes since v1)

 configs/j7200_evm_r5_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index c4dd33627b..7450529d66 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -20,7 +20,7 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_STACK_R_ADDR=0xa5300000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
-- 
2.39.2

