Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19DAC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 16:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64FF87A9F;
	Mon,  8 Jan 2024 17:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="U63AEXxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2276387A9F; Mon,  8 Jan 2024 17:58:16 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250C387463
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 17:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C66EDFF811;
 Mon,  8 Jan 2024 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1704733093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRqs4/Dce0wqhMNNywQKbAQejd69Uv7p+lDNkqVUCxc=;
 b=U63AEXxh17XTzWZ/X0rstKqhQrsxVZWMhMII2miG2NnYkQiDrJ+JEwbzDo2uvkNPzRWBS7
 goxEwcaxZFHeNkiWlQAhDIlnNNlyKv22AKoV2TdneodQ7gIwdw4PYw8BmOGmYexm6Noc/O
 34mWivth0GlMDfgbFh9mct8xn7bbhoQprh+KGwg+gNp/zR9pbIkhxaCTr9Mi34DlgS6nZF
 0ZRjZLYuZoiYXDG8omlVhu7lRsrDtU/JXSHov9uxraf5X5S7qM2lXidMKZ0H+y2EFs1pye
 n51zDPTvw8WeGmgHE74RFoUzk1whdr14pcA7Xq1CPSzFdNrDLkHa7Tne3zYYKQ==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com, nm@ti.com,
 u-kumar1@ti.com, gregory.clement@bootlin.com
Subject: [PATCH v3 3/8] configs: j7200_evm_r5: Move address used for
 allocation in the reserved space
Date: Mon,  8 Jan 2024 17:56:23 +0100
Message-Id: <20240108165628.3935756-4-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108165628.3935756-1-thomas.richard@bootlin.com>
References: <20240108165628.3935756-1-thomas.richard@bootlin.com>
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

Else it could corrupt the memory of Linux when exiting suspend to ram.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---

(no changes since v1)

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

