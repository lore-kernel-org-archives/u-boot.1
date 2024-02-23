Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10162C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 14:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B86878A1;
	Fri, 23 Feb 2024 15:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="iBm7ghQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C20948573F; Fri, 23 Feb 2024 15:08:00 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F50F87CAC
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 15:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ThBdl6Bdlz9sp1;
 Fri, 23 Feb 2024 15:06:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1708697211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yvh2qhAkdatPkPvcJgpIX+/WSc5ymXVaamkw5OkrwcM=;
 b=iBm7ghQZpPT5s/CvxYHwFcNgmRZe246h79Pzi6oNNAeiu4GjO7uXtlRpYtrT1TMu/NnZkO
 NlHPVKAZNt78LPpY154Fhez0Gby96gMNsYPOQrNEhu4qyeXlt5DPZE7lx6ncBEG+Hgjd6H
 4xi2Y4qCTeLyHh7WhGPzzVdB4CgbBxzzequFnEQ10T9rHxJ5Uc5T2ef/MyVaPFkxC8+NGM
 6dG7OihfFgn/BirhLuV/q4UufUN7CeJRIQX1a9Hd+08+dQdIbCKCQalMAadmtIXM+g7sxT
 67nHSR2YsPoek3k+CwcEuJfrmGlWdJBhi3I2Qc98jVhvnK0XmjycJXKtd2wvyg==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] mmc: zynq_sdhci: disable OTAPDLYENA
Date: Fri, 23 Feb 2024 15:06:12 +0100
Message-Id: <20240223140613.1240570-4-lists@steffen.cc>
In-Reply-To: <20240223140613.1240570-1-lists@steffen.cc>
References: <20240223140613.1240570-1-lists@steffen.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ThBdl6Bdlz9sp1
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
The ITAPDLYENA change is in another commit.

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

 drivers/mmc/zynq_sdhci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 79bb8ba66d9..06b782eb79a 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -45,6 +45,7 @@
 #define SD1_TAP_OFFSET			16
 #define SD0_ITAPCHGWIN			BIT(9)
 #define SD0_ITAPDLYENA			BIT(8)
+#define SD0_OTAPDLYENA			BIT(6)
 #define SD0_ITAPDLYSEL_MASK		GENMASK(7, 0)
 #define SD0_OTAPDLYSEL_MASK		GENMASK(5, 0)
 
@@ -316,6 +317,7 @@ static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
 
 static inline int arasan_zynqmp_set_out_tapdelay(u32 node_id, u32 otap_delay)
 {
+	int ret;
 	u32 shift;
 
 	if (node_id == NODE_SD_0)
@@ -326,6 +328,12 @@ static inline int arasan_zynqmp_set_out_tapdelay(u32 node_id, u32 otap_delay)
 		return -EINVAL;
 
 	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
+		ret = zynqmp_mmio_write(SD_OTAP_DLY,
+					SD0_OTAPDLYENA << shift,
+					0);
+		if (ret)
+			return ret;
+
 		return zynqmp_mmio_write(SD_OTAP_DLY,
 						SD0_OTAPDLYSEL_MASK << shift,
 						otap_delay << shift);
-- 
2.39.2

