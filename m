Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEA1C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5259F884D5;
	Sat,  8 Jun 2024 00:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K0di5aLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC725884D5; Sat,  8 Jun 2024 00:06:25 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E4987EF6
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457M6LJH074159;
 Fri, 7 Jun 2024 17:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717797981;
 bh=DphOaK0p7um9wD1Jc2WbLzjwSnea0WBXz+Jn1RZXaso=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=K0di5aLsn6xHqFOwf2VNtiE1tahVrBa7AyT+q51LzIZJIn7Ml0VmApls6GZxrp+PW
 +fUPj4vpahX64Hc4aJvXoI040Pcislu0ZOTloY578klcYi9kT+3StYyzB6b+Ctp18E
 88R8L2um92yGKbAB9DoU7Qg2i84kwk5udiqC04jw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457M6Lrb023667
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Jun 2024 17:06:21 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 17:06:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 17:06:21 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457M6L5X039231;
 Fri, 7 Jun 2024 17:06:21 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 7 Jun 2024 17:06:13 -0500
Subject: [PATCH v4 2/2] configs: add defconfigs for the am625-lp-sk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-am62q-wip-v4-2-3900cdf25721@ti.com>
References: <20240607-am62q-wip-v4-0-3900cdf25721@ti.com>
In-Reply-To: <20240607-am62q-wip-v4-0-3900cdf25721@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>, Dhruva Gole
 <d-gole@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=bb@ti.com;
 h=from:subject:message-id; bh=WqVeTvoDQpRpjKfyG3zCMHYPb6vMQtd8E5OkuNBEnY4=;
 b=owNCWmg5MUFZJlNZQHl3UgAAZ/////f/2vPgG5zrHkX/vV+rH+27e29rf/473f3a7ltqx/awA
 RkAxRoGgDTRpppoABoyDQGg0aDQaAaDJoyNMjQGIDI0ZDQ0NAYIyMTTZQ9TJsogyYjINNGmgxND
 TTTINGTCYCNNGTQaMIZNGg0GgAyDCNGgxBkAMRpo0NA00w6D00ho2pkGmgAxNDQyNABkGmmAjQA
 Gg0yDT1GTRkyMgGIGjCMIMj1NAA0AAWo24hAp9sXJ0MMdKUwgsExTyASHgQqAgwg5iVFWHYKVz8
 Yrc/ipIC466QmJFX3rXh35wual1OzAY1dliLRBtdAQIjk2TL7y0saQAVqo+b8t9cYTwmOGJodqJ
 BLOTEPUthjjDHZPZz6i3KNUtz304kMahN471cYoxAWsuFpWQBufat4jgzgCCohc4DPp67jeTu3W
 auRyAqvALsOpM1A40DZe/neWjMQWjwdhEYYk1HCXYD3wqB8AMinpUOHeHBDZYxCQ2R31+1focFc
 qT7YzmBMR4a8zQ2CR8dJkAfHf2DQrg1CmxXUyEe+HGLRLXfupKKIFIT6FbdJQpYWKeXEm8J6g7d
 IiGEk8vh8XyCqwQGD4giXX6q9IJVArUCCfy8FKsjB6P+ZjFO87eliWW/C3fxMNAFGFFf8V+Cubj
 AHwzaIKx/xdyRThQkEB5d1I
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The am62x-lp-sk is a package and reference board spin of the am62x-sk to
showcase the low-power features of the am62x SoC family. Because it so
closely resembles the am62x-sk board, use the preprocessor to inherit
its configuration making the needed changes for this board where
necessary.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62x/MAINTAINERS       | 4 +++-
 configs/am62x_lpsk_a53_defconfig | 8 ++++++++
 configs/am62x_lpsk_r5_defconfig  | 7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/board/ti/am62x/MAINTAINERS b/board/ti/am62x/MAINTAINERS
index 105e741995ed9..562a5c676690d 100644
--- a/board/ti/am62x/MAINTAINERS
+++ b/board/ti/am62x/MAINTAINERS
@@ -1,8 +1,10 @@
 AM62x BOARD
-M:	Dave Gerlach <d-gerlach@ti.com>
+M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am62x/
 F:	include/configs/am62x_evm.h
 F:	configs/am62x_evm_r5_defconfig
 F:	configs/am62x_evm_a53_defconfig
+F:	configs/am62x_lpsk_r5_defconfig
+F:	configs/am62x_lpsk_a53_defconfig
diff --git a/configs/am62x_lpsk_a53_defconfig b/configs/am62x_lpsk_a53_defconfig
new file mode 100644
index 0000000000000..a86bfb5a761bf
--- /dev/null
+++ b/configs/am62x_lpsk_a53_defconfig
@@ -0,0 +1,8 @@
+#include <configs/am62x_evm_a53_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62-lp-sk"
+CONFIG_OF_UPSTREAM=y
+CONFIG_SOC_K3_AM625=y
+CONFIG_TARGET_AM625_A53_EVM=y
diff --git a/configs/am62x_lpsk_r5_defconfig b/configs/am62x_lpsk_r5_defconfig
new file mode 100644
index 0000000000000..9112bc2cba7cc
--- /dev/null
+++ b/configs/am62x_lpsk_r5_defconfig
@@ -0,0 +1,7 @@
+#include <configs/am62x_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-lp-sk"
+CONFIG_SOC_K3_AM625=y
+CONFIG_TARGET_AM625_R5_EVM=y

-- 
2.45.1

