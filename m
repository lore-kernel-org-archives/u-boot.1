Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DF1CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33B6486DC6;
	Mon, 16 Oct 2023 16:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JbOYn77R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC9F86BA6; Mon, 16 Oct 2023 16:14:30 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E30886484
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6DD22000C;
 Mon, 16 Oct 2023 14:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697465666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DC84mpvvDDfUM9MGRNHuWKp8Fa28+FWHka88pMHmR3M=;
 b=JbOYn77RwKcG3PiJzb6DbU8Gk0fp9WlP8gKSld5MmzZ/o6taPAmIpXA4S7+V5Q3C397pjc
 cZO79C3XDXbatJv5OgoaVcWHdQ0Q2HhGSm8hvHOvXNHFQ6U/yepG+9QKhx56IQOajyzZGL
 8/jBebHHiedPfUSsgrmTyxW8K+oHk9d3e2mW++cs5awLjNM4OOwsEAM13k/YCU6ZgK80FL
 IlII3+icxWGIDji2HawEyig4A8yh4VYq2OPbZFfR8Lka0PFX6vtJ2SIeJ+S62np7tiWayp
 0s+UhEcRM07yRD/2GL9Uhz26MxkPwHPEIH2vez8/1yI3XdHs+qrcHgWXi20u/Q==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: [PATCH 3/9] configs: j7200_evm_r5: Move address used for allocation
 in the reserved space
Date: Mon, 16 Oct 2023 16:11:29 +0200
Message-Id: <20231016141135.325698-4-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016141135.325698-1-thomas.richard@bootlin.com>
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Mailman-Approved-At: Mon, 16 Oct 2023 16:15:29 +0200
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

Else it could corrupt the memory of Linux when exiting suspend to ram.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---

 configs/j7200_evm_r5_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 7450529d66..1e7daf9b4a 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -39,7 +39,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SYS_SPL_MALLOC=y
 CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
-CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x84000000
+CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xa5400000
 CONFIG_SYS_SPL_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
-- 
2.39.2

