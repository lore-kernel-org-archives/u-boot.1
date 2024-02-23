Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34595C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 14:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166F987D15;
	Fri, 23 Feb 2024 15:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="silyEF2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0415875FA; Fri, 23 Feb 2024 15:08:41 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C77687C61
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 15:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ThBdk162Bz9sp4;
 Fri, 23 Feb 2024 15:06:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1708697210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OOp+ENu1pg5HFcKC4D0rRSe4Bd0mZZ6Rl1Jy3+6HFQ=;
 b=silyEF2JniorUNbZxFzorgHGo1dRnpuJBx6nG4ENIlFAKHO3VKWPYbDtAqbJtuiep3FgBb
 i+Ibw55Ngr41mAvvBjlsM4tGVPblPP5+9fGKHE2JH8RP+hTxNQ7NP0h1uahx7tr4MgXFyQ
 +q9aOJoMs082l6H5gu2Y4C1eBD6CwOsE44FdKHwY8dSmkbkfEsx0cCMSEf2p5lR5ToHQPI
 op/exDli8KPYQrRpWOmV0KOO+GqveNQi3eVzd9EHOCvi9zziG5QfqxhPQ/FtfHgnF8elkI
 GRYFoWNjFCLlX0U7fyDpTvf6sh2E60vgyzpMMm/Snji4XBPtml9RnDOW6PsGcw==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] mmc: zynq_sdhci: disable ITAPDLYENA for zero itap_delay
Date: Fri, 23 Feb 2024 15:06:11 +0100
Message-Id: <20240223140613.1240570-3-lists@steffen.cc>
In-Reply-To: <20240223140613.1240570-1-lists@steffen.cc>
References: <20240223140613.1240570-1-lists@steffen.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ThBdk162Bz9sp4
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

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

This ports a change from arm-trusted-firmware:
commit: fe1fa205fca4d1dd4a1b1755942956dbca65d573 in arm-trusted-firmware
(https://github.com/ARM-software/arm-trusted-firmware/commit/fe1fa205fca4d1dd4a1b1755942956dbca65d573)
The OTAPDLYENA change from there will be in another commit.

We shouldn't have different behavior for u-boot-SPL and u-boot so let's
use the same logic here.

Message from arm-trusted-firmware:
plat: zynqmp: Disable ITAPDLYENA bit for zero ITAP delay

This patch disable the ITAPDLYENA bit for ITAP delay value zero.
As per IP design, it is recommended to disable the ITAPDLYENA bit
before auto-tuning.
Also disable OTAPDLYENA bit always as there is one issue in RTL
where SD0_OTAPDLYENA has been wrongly connected to both SD0 and SD1
controllers. Hence it is recommended to disable OTAPDLYENA bit always
for both the controllers.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---

 drivers/mmc/zynq_sdhci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index d4845245b2a..79bb8ba66d9 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -287,8 +287,13 @@ static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
 		if (ret)
 			return ret;
 
-		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPDLYENA << shift,
-					SD0_ITAPDLYENA << shift);
+		if (itap_delay == 0)
+			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPDLYENA << shift,
+						0);
+		else
+			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPDLYENA << shift,
+						SD0_ITAPDLYENA << shift);
+
 		if (ret)
 			return ret;
 
-- 
2.39.2

