Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3366FC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 16:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF698753F;
	Tue,  7 Nov 2023 17:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="BtDrqvnY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE7587535; Tue,  7 Nov 2023 17:18:50 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16FD887518
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 17:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93A5C1C0008;
 Tue,  7 Nov 2023 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1699373928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRqs4/Dce0wqhMNNywQKbAQejd69Uv7p+lDNkqVUCxc=;
 b=BtDrqvnYE4cgBUay7k13IguXVFQnln0NVRWi9I0QkKEZ0Glb8FoZ4acOlkHXerO2vcJY05
 6HHU3uP/uPR5+PGXIflETzXqAgm1jpcZKqaYDOLr1ZrV3VIJ/+vv6muzqD+Mom584KrUf1
 zwu8ZtIstJd6RKTCeIxqIVaTg7ZL9mdTI46NLAvTdofbznL1osA6ghrnF6yFmv7z9u5yLJ
 RPuGjJJQyO2spE8jULm6dgHAyeMIPf//J3+QF2rBYwqc8dpvC1SqqjdYr2VrwOOs69a+hC
 XDKeODLpqkqgGSifPVkrybVHy8r0BPWwkIDjE4KL58L48EwxVTJTa51KfYi/IA==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.richard@bootlin.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: [PATCH v2 3/8] configs: j7200_evm_r5: Move address used for
 allocation in the reserved space
Date: Tue,  7 Nov 2023 17:17:57 +0100
Message-Id: <20231107161802.855154-4-thomas.richard@bootlin.com>
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

