Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D07CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD1286B0A;
	Sun, 17 Sep 2023 16:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vRWXz8LT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RTF3F4re";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1C886B27; Sun, 17 Sep 2023 16:14:04 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3BB686B54
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVKP54XJz9sWf
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3SD3UzEhLPgyNpVPU2f1oGNn3+MaE23vJmUFQ2yq7aw=;
 b=vRWXz8LTLbWN9cOd1gSdGaG75wnfyih9ItuyoNwn3AfnTmc9lmAg32Bw+byKskB5Qrszs0
 2ZOohArWHj4EsMgINlG3vFf3lDP5W7G6XsSyF8pM5u00Tb9tYsw4MwRGhPi2ix6L14Q0SC
 LxxA3H2pGVNWM/Amc76FxYiUD/mXiFPf/RaYCKvv7LXUWKlI+tvD50mUY/chAH1rvIt4ZT
 Z2BPWmbO85czLQMGYsgaBycws2ZOWSHsv1vHT0W9opnzsP5he4b3zkB527AUBfRvZhsFHB
 XgMFfusU4PnzTSSj3oXtGSLjuy7UsTQfVOlNdeu0o+QFIGenGMe1bFa/eAggHQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3SD3UzEhLPgyNpVPU2f1oGNn3+MaE23vJmUFQ2yq7aw=;
 b=RTF3F4rev9f6zAN8AIgHgTTt62kULu2IA+92RacCuw8oUND2ocdAFFVgBQAgJWtzSMUIfV
 HhHwtan2OuVkwjekLAO2nCmWx5VLf9VM/+KTiSHRvfPmw28+A4avcr1XIDyqvr3WVtG5C5
 zcoe43bNJnxnsBQWeiAqGZxZPWnGkoQVDc3ZOp5Ay3MJLR4cMQtXG5BhIvro4khl2rEgjG
 ZgKdUkNZTWhx3lgpUlO8lGlwiUBUe+0zGm9G8hpb/Vz+xmbucBpXHGdRGKIl+3Y4hqIvNB
 1fBKmEVhGJ8TH3Gme44/XXFNcLFRVPin+foNox9Vi4mz6ZEPst725oaTIvxwQw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 19/19] ARM: renesas: Align env eMMC device number with Linux
 6.5.3 DT changes on R-Car Gen3 Salvator-X
Date: Sun, 17 Sep 2023 16:13:19 +0200
Message-Id: <20230917141319.379939-19-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 778587fced83136b397
X-MBO-RS-META: wz7dmxxoro3jeoshgwr8x4cshozwraa9
X-Rspamd-Queue-Id: 4RpVKP54XJz9sWf
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

Set U-Boot environment storage eMMC device number to 0, to match
the new additions to DT /aliases node pulled in alongside Linux
6.5.3 DT synchronization.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 configs/rcar3_salvator-x_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 6aaf24e0126..02924244c7a 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -58,7 +58,6 @@ CONFIG_OF_REMOVE_PROPS="dmas dma-names interrupt-parent interrupts interrupts-ex
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_VERSION_VARIABLE=y
 CONFIG_REGMAP=y
-- 
2.40.1

