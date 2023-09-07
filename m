Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50ADEC872A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 13:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB7F186494;
	Thu,  7 Sep 2023 15:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tCGXbsnd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C31863F9; Thu,  7 Sep 2023 15:53:51 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7555386722
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 15:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7FC573F6B3; 
 Thu,  7 Sep 2023 13:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694094827;
 bh=YJ/FLUoXYcZn9BCwVQfp0bPFNHPM4gc4fIyr2dwqNc8=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=tCGXbsndvQkjqGAzdKfyaKz4xauPFgNgk3e4zeLOc0xAUma396aMP2t8QbLuHJYfU
 O45EIuO0P1JKR5IryCxjq9qb0Td01ROVA8kfCM34TinQQ+CfciQWUMH6kA+ibA16a+
 ilTg9Jh+w6y9xCOSL5KT5xnwpWlzXf8OeWJWGpf/6Jpwq+jggA7CYWBHyf0v+75b4A
 ZVxy/+1L4CXXrCnvVMQfTGM+uBdyAiLf2qhOWmtO1KICKYKtj09dfFRC4w90xr18/+
 7HqLtSey8j/KhGqrmAl5ssNC/00LFroaZ5R0ucLOOtjzLDc2jtoI4+juvJyXQ4PqZS
 lm22d1UmQGnYg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Shengyu Qu <wiagn233@outlook.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: NVMe/USB target boot devices on VisionFive 2
Date: Thu,  7 Sep 2023 15:53:36 +0200
Message-Id: <20230907135336.364877-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Make NVMe and USB target boot devices on the StarFive VisionFive 2 board.
The boot devices are sorted by decreasing device speed.

CONFIG_PCI_INIT_R=y is set via [1]. 'start usb' is added to CONFIG_PREBOOT
by the same patch.

[1] [PATCH v1 1/2] configs: starfive: Enable PCIE auto enum and NVME/USB stuff for Starfive Visionfive 2
    https://lore.kernel.org/u-boot/TY3P286MB2611C9AD6E5BB3756A959E89981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/configs/starfive-visionfive2.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/starfive-visionfive2.h b/include/configs/starfive-visionfive2.h
index 4ee02b8420..6fa7f16ddc 100644
--- a/include/configs/starfive-visionfive2.h
+++ b/include/configs/starfive-visionfive2.h
@@ -18,6 +18,8 @@
 /* Environment options */
 
 #define BOOT_TARGET_DEVICES(func) \
+	func(NVME, nvme, 0) \
+	func(USB, usb, 0) \
 	func(MMC, mmc, 1) \
 	func(DHCP, dhcp, na)
 
-- 
2.40.1

