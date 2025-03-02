Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E92AC19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 08:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E7880079;
	Sun,  2 Mar 2025 09:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HeQrmkOo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A488058A; Sun,  2 Mar 2025 09:50:25 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A630C80050
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 09:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6F55F3F0EB; 
 Sun,  2 Mar 2025 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740905422;
 bh=r+ItYB1HUmhr7HcswEEPVJTjANCYmVTYPH0XlYmcWwU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HeQrmkOofQddlcm/Az2jc6FuWzT+XsH91nJQ4J0j6pbmukvyyw8Flh24NjgFELAgb
 zpflmet1eClBM/xcPYQFEoV2sWma7fwk6Q3W1PVppapV9zVcMOEOtWMqsThD2aFhhG
 99hD0/XwFeOvHmWnHyvnWx2Sn9pQ+X2kJ8KvcloAnpwx9zi9WI0qLzO9li/9Wae88u
 dciM3quUF4CUcclMqV5uBEbrgcsKEjpXvz7O5rOWoNg+WORc5efoOvTxHY/cpIDdJ4
 VsPCPqB7t9BS/p2nkh+UU5FTMik94hyC00vLRndon8qpIA+Ze9CYwL2p7gI26rum1T
 +oJbTAuOFcxXw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: qemu: imply CONFIG_RNG_RISCV_ZKR
Date: Sun,  2 Mar 2025 09:50:17 +0100
Message-ID: <20250302085017.22046-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

The zkr ISA extension can be used to generate random numbers. Since RVA22
zkr is an optional ISA extension. It can be emulated by QEMU. Our RNG
driver detects if the extension is usable during driver binding. Let's
enable it by default on QEMU.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/emulation/qemu-riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
index 012ac14a123..134dbfd7151 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -62,6 +62,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply VIDEO_SIMPLE
 	imply PCIE_ECAM_GENERIC
 	imply DM_RNG
+	imply RNG_RISCV_ZKR
 	imply DM_RTC
 	imply RTC_GOLDFISH
 	imply SCSI
-- 
2.48.1

