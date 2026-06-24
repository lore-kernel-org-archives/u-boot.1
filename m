Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49A6CDB471
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 12:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81809849D1;
	Wed, 24 Jun 2026 14:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thundersoft.com header.i=@thundersoft.com header.b="lbNj7ctI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508E9849D1; Wed, 24 Jun 2026 14:45:25 +0200 (CEST)
Received: from mail-m103131191114.xmail.ntesmail.com
 (mail-m103131191114.xmail.ntesmail.com [103.131.191.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0280847C8
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 14:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=thundersoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongyang.zhao@thundersoft.com
Received: from [127.0.1.1] (unknown [36.129.139.90])
 by smtp.qiye.163.com (Hmail) with ESMTP id 439ac6896;
 Wed, 24 Jun 2026 20:45:17 +0800 (GMT+08:00)
From: Hongyang Zhao <hongyang.zhao@thundersoft.com>
Date: Wed, 24 Jun 2026 20:45:05 +0800
Subject: [PATCH v2 2/3] configs: Add qcom_qcs6490_rubikpi3_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-qcs6490-rubikpi3-v2-2-829dad7e6dd6@thundersoft.com>
References: <20260624-qcs6490-rubikpi3-v2-0-829dad7e6dd6@thundersoft.com>
In-Reply-To: <20260624-qcs6490-rubikpi3-v2-0-829dad7e6dd6@thundersoft.com>
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
 Roger Shimizu <rosh@debian.org>, 
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782305113; l=822;
 i=hongyang.zhao@thundersoft.com; s=20260127; h=from:subject:message-id;
 bh=FyNgHidS+ooZCG8bpe9Q452jpII78y6JXDL2V45467w=;
 b=i6lixbJ7AAP49I9PZH5EN6v1Vl5Orj+XtuiExpww4J6ORdmlXnHKtqE4mnBdCVuBpPKtL+Qte
 8vfA66xSt8YBRib/2qZuoWRexPJ+PGgOobUsmgxrpXl8CgTfByqflaC
X-Developer-Key: i=hongyang.zhao@thundersoft.com; a=ed25519;
 pk=D9yL5W9Zj0lPBDAq9gzY++1849VlXuTWAkROzZ88J/4=
X-HM-Tid: 0a9ef9a9d4a009d5kunm227b613b9d6a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaShpLVkMYSBpNHU0aQ05DHlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKSUJVSkhCVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
 lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=lbNj7ctItV9V3oY15LuPLtEMWPQDtWb6UJ2WJXSJvOYcm8KOL87brLdffhE7rfX/LO7u6DYZV/cMksG8f6mJO3nRZbH9+8Zcu/inNAMZkIqJ8XOGPPRMB+4e3X+Wfb6AMIk63OFgW3XpF2ig0Wz3/b1VQ72CU6mWsiN9CaebqnE=;
 c=relaxed/relaxed; s=default; d=thundersoft.com; v=1; 
 bh=pc/RTDxfpMvsl1tuqB1FEiL0XgHRTh+lihd0MAzBli4=;
 h=date:mime-version:subject:message-id:from;
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
RUBIK Pi 3 device tree.

Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
---
 configs/qcom_qcs6490_rubikpi3_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/qcom_qcs6490_rubikpi3_defconfig b/configs/qcom_qcs6490_rubikpi3_defconfig
new file mode 100644
index 00000000000..1d56659c0c5
--- /dev/null
+++ b/configs/qcom_qcs6490_rubikpi3_defconfig
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

