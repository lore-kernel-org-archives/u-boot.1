Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6F3F357D5
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 06:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44B0B8366F;
	Wed, 25 Feb 2026 07:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="syKg1J3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80EFE83E36; Wed, 25 Feb 2026 07:57:20 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A07282A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B072040A21; 
 Wed, 25 Feb 2026 06:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772002638;
 bh=32d6DLEHELDCDozh8to85wIt1vRJFuHogkDVK57pOsU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=syKg1J3RX9MMYlXXqGiyiND9E6liuv+MGsupNLHWpEOtz4hYeZdZ5wV/tLOxvxtY5
 4Rdgm8X79JEG6iJJfQQTuekdkjVFZWuyB7nDNd9HkJCFxGLZnZYiOIz1XHWg8u47Z0
 OeiqCvaqQ/jEBxaaQvWFDRvl1KD3gq1nR5HDpEZgeMFgL43px3kMS/0C8ypdxn+0Uj
 vfq1+yA7v+oCBl+k/+e5bly8/mkjjAIhLab6CmHM6ZqLP9qE4PLGvIdRHOz1oA6Yyz
 7WgbxfikhYjcQmF1mSo9FYe2s0W1ewupK988/RDhwiKmvmT9UhJrj87I64Z34CJy9L
 tWjvMviErquas9SzoZpDqQbCsdvkNoQ7AxrPMrHed0xmgRZHC/mIn0pK90pdISxBhE
 n0q/Jpzj/xykneNk30rhGEfUtAdMH2S29d0i0TuTel/By2b3hhX7MMd6jF5MviCMq0
 1V65qgW1vccIvQD2xA0Bvm9i/5AyxK83GnIt04qLbSAys2LA1cgShcIkH5N0IJ6SOO
 OBd7+LTIfhlocBguaDQPapfXa+lcg7BblI+pNkgPjj7qXs+amnSrqNCB0G9Jta9tth
 +xbHj1viRKb1ECpIMoz+Elqoe0M6nV4S5NLcJSLXrb/Xn4Z2iJF02dBuvAX5skwqI8
 ePwQ+kthZMKqq/WgZfGUNkC4=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] drivers/power/regulator: add SPL_DM_REGULATOR_FAN53555
Date: Wed, 25 Feb 2026 07:57:14 +0100
Message-ID: <20260225065714.48562-1-heinrich.schuchardt@canonical.com>
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

Symbol CONFIG_SPL_DM_REGULATOR_FAN53555 is selected by
SPL_DM_PMIC_FAN53555 and used in a Makefile. But the
symbol definition is missing.

Add the missing configuration symbol.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/power/regulator/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index bd9ccd26981..26ba53ceb8f 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -191,6 +191,14 @@ config DM_REGULATOR_FAN53555
 	  or switching the mode is not supported by this driver (at
 	  this time).
 
+config SPL_DM_REGULATOR_FAN53555
+	bool "Enable Driver Model for REGULATOR FAN53555 in SPL"
+	depends on SPL_DM_PMIC_FAN53555
+	help
+	  This configuration setting enables the implementation of the
+	  driver-model regulator uclass features for the FAN53555
+	  regulator in SPL.
+
 config DM_REGULATOR_COMMON
 	bool
 	depends on DM_REGULATOR
-- 
2.51.0

