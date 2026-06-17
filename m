Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3108CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA949849D2;
	Wed, 17 Jun 2026 14:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thundersoft.com header.i=@thundersoft.com header.b="KHWAxi63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E578499C; Wed, 17 Jun 2026 12:56:55 +0200 (CEST)
Received: from mail-m83135.xmail.ntesmail.com (mail-m83135.xmail.ntesmail.com
 [156.224.83.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1DE5848D8
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=thundersoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongyang.zhao@thundersoft.com
Received: from [127.0.1.1] (unknown [36.129.139.90])
 by smtp.qiye.163.com (Hmail) with ESMTP id 42c14b663;
 Wed, 17 Jun 2026 18:56:47 +0800 (GMT+08:00)
From: Hongyang Zhao <hongyang.zhao@thundersoft.com>
Date: Wed, 17 Jun 2026 18:56:12 +0800
Subject: [PATCH 2/3] configs: Add qcs6490_rubikpi3_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-qcs6490-rubikpi3-v1-2-495f618a1e4c@thundersoft.com>
References: <20260617-qcs6490-rubikpi3-v1-0-495f618a1e4c@thundersoft.com>
In-Reply-To: <20260617-qcs6490-rubikpi3-v1-0-495f618a1e4c@thundersoft.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Hongyang Zhao <hongyang.zhao@thundersoft.com>, 
 Roger Shimizu <rosh@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781693803; l=1349;
 i=hongyang.zhao@thundersoft.com; s=20260127; h=from:subject:message-id;
 bh=oIuOOmfRrTeKaX3UDZo/lNMtSIioNqglTOirM8hyNIQ=;
 b=G6MUN5adiHt25ljvLhCjUIfN+W1jczevOFtkFXqhvigWxGjVX7TduLoFsbcoJElFxonWvoBVq
 2+9g00Ud9SQDjzTdDaQuzPSdPVZ5bEc6g300SnRqI4eHhDSromIRDft
X-Developer-Key: i=hongyang.zhao@thundersoft.com; a=ed25519;
 pk=D9yL5W9Zj0lPBDAq9gzY++1849VlXuTWAkROzZ88J/4=
X-HM-Tid: 0a9ed539fa8809d5kunme9f1286a14f7c9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaS01DVk9KH0tMGh4ZGB1JTVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKSUJVSkhCVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
 lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=KHWAxi63I8cHzepuVysUrPxhW6B/O9oT5497dezp50i2VzpoM3Uqa1mBgYSFjCntKdho+v1I/fVFJ4Qds2Hy7BKMLEns5N+hNj2Iac8LwAt4mPcE+FL/weQ9o+BqGFVokJD2Qn8cvK0T3aJFIj/JSmAXWzYkCvCtxDSdQvZFkiw=;
 s=default; c=relaxed/relaxed; d=thundersoft.com; v=1; 
 bh=FnTZMTRyPRREkdIuUVVInfyGMk/Fq2856I+ZE4A4bLI=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:21 +0200
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

Add a defconfig for building U-Boot for the Thundercomm RUBIK Pi 3.

The board reuses the existing QCM6490 configuration and selects the
RUBIK Pi 3 device tree. Add the defconfig to MAINTAINERS so the
Snapdragon maintainers are copied for future changes.

Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
---
 MAINTAINERS                        | 1 +
 configs/qcs6490_rubikpi3_defconfig | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f9c5fa0bdd..6a23cffcf13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -681,6 +681,7 @@ L:	u-boot-qcom@groups.io
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
 F:	configs/qcm6490_defconfig
+F:	configs/qcs6490_rubikpi3_defconfig
 F:	configs/qcs9100_defconfig
 F:	drivers/*/*/pm8???-*
 F:	drivers/gpio/msm_gpio.c
diff --git a/configs/qcs6490_rubikpi3_defconfig b/configs/qcs6490_rubikpi3_defconfig
new file mode 100644
index 00000000000..1d56659c0c5
--- /dev/null
+++ b/configs/qcs6490_rubikpi3_defconfig
@@ -0,0 +1,7 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of Thundercomm RUBIK Pi 3
+# with the "Linux Embedded" partition layout.
+
+#include "qcm6490_defconfig"
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-thundercomm-rubikpi3"

-- 
2.43.0

