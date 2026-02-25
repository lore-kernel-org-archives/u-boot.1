Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580B3F357D5
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 07:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A538366F;
	Wed, 25 Feb 2026 08:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z5LwNhhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7E883DEA; Wed, 25 Feb 2026 08:10:12 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DEA582A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 924734022A; 
 Wed, 25 Feb 2026 07:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772003409;
 bh=oIvKpGtYKtpLb29sFm06zZbS3huEpB5YkXXoghIwFbM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Z5LwNhhpxzjTi2u6hKWA1EJ7UnGSZuMAcAsf3n9SAwAAiw3g8GYI0DSD08IL4svSI
 Gy3fa3iTJ1NcR5v6XpPMDp71T+EI8hz0MELoZRpLFkzXz+TgddpAiU3a7FJfgSmmAC
 2sNW/LqUQj5r/JszJzqjgQUzojT2dAY1icFiO3h1Ls1iH2LPyxhFiEST54hVPzO1pE
 niBIbJlmAH6xgDnuYF13yY0sEsDXCxurkOBCQDNfsr2YMqJWeKB0phxR5IRO28Gfg5
 TmYIBCT1j1bU+9XhV4oaWB61d+TBw+WGyFrEmpmpLkZpEIVtKLA/gDLaJy1jw8b6Ga
 7jbMmuZvSfVY2HJpqiOgF1TPo+qf5FUAKmZJgD3HDqapFut8cahZxu730L5WuK83jw
 rURId09F6Xf+S40Oj/hjw/muJ4skvDKPk19xXS8YP6e1JKpm/vJXzvXP7yZAi49d4b
 cokZmGU9VmjGnzmosL/kqF5y+j9QLHi8VS2DRx3GaVwMqFAWHGx6qCvo3GzfOKtkAI
 081BJ8dk1F8ttst0icw1Ng3KJoSofuVKwVa8ciQS8Mlv43CZOvQ+CK/FyxyTwRSgBy
 7Hh3iTG6pqLfdbXMQmgWv1zmm0Rve63iWTLHwDrS1Ook9AxPlJUGZxDV7BUzjj2HxW
 UfIqEFdbtojoGJCcivAohcXo=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>,
	Stefan Roese <sr@denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Michal Simek <michal.simek@amd.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Luca Weiss <luca.weiss@fairphone.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] serial: serial_octeon_bootcmd.c: use correct Kconfig
 symbol
Date: Wed, 25 Feb 2026 08:10:08 +0100
Message-ID: <20260225071008.49435-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

CONFIG_SYS_IS_IN_ENV does not exist.
CONFIG_SYS_CONSOLE_IS_IN_ENV seems to be needed here.

Fixes: f1054661e50f ("serial: serial_octeon_bootcmd.c: Add PCI remote console support")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index b84cb9ec781..3fb3492dcd0 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1022,7 +1022,7 @@ config OCTEON_SERIAL_BOOTCMD
 	bool "MIPS Octeon PCI remote bootcmd input"
 	depends on ARCH_OCTEON
 	depends on DM_SERIAL
-	select SYS_IS_IN_ENV
+	select SYS_CONSOLE_IS_IN_ENV
 	select CONSOLE_MUX
 	help
 	 This driver supports remote input over the PCIe bus from a host
-- 
2.51.0

