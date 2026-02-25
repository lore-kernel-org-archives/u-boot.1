Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F659EF5862
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 06:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 785038366F;
	Wed, 25 Feb 2026 07:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="h1zCGatX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0FC982A9E; Wed, 25 Feb 2026 07:31:04 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D827182A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:31:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ED6F941776; 
 Wed, 25 Feb 2026 06:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772001062;
 bh=oeB4QAWsqJLi5MiZhsOA/O2Z6IT8oXoBmi1zVlUNFtY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=h1zCGatX68VlU/zaR4b1ERaYUEqGjGr5pW7kYPwvM+t5DNQ3A+FFQf23GnmpmkUyV
 deiGCP3myeDVVY6lim3o7r3Qb1MJuEn4umfgekIo7lZhzzqHH+rXmu0zufQ32pwodX
 C7tBB29G3VBeFQYkYICe7Dc6Q5E3KtKoi6tsJ93JH6hR+qqYyI0S3F96G54YdxqdJs
 YbeB+LFCjyd578TvzWJZJ1y0XrhkFr6ZdD0eYxh2+Gkz56lmyN/+wBUimtngrD6UbU
 cPpFs/bx3eRjsKo+EhtA5L7CHDYpl9/b984qZes5goBWpE+sVAewW3qDpjvRw55HYT
 BhhoGlrPSPqVYDQIJYS6GFEqBGBpUnTwEYMx4yGaS6fiGj4r7DdKXXTnJqdogjvAm/
 LhtueIx0IsulsyMWL1v4OTY8hPk8zEo7hbnqRTWRSuAtXTiEuDCxvxPzPGI++GxKGl
 Fa8JGHJ0Ptkr7RTOc+VkRoHGIR+qZAOdfmhBIUK0/L6p8+MAzcHlvzhV9t4p1qXJ/9
 Y9ek08TPZ7GGc7Bw+mkiqz+CesRFTdGkTjPSohWyoqcek5CgszLpgAXw30kw8OA3wq
 LirwXa3AjPWzpDqUn1caUbA1PC2EsJhT/h9ZG4gWf1Tt8sqERFwO6/hkO7pTLrCv/B
 SHCuGfRehYlYahgbPQzPnaMI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] ufs: don't select non-existent CONFIG_PHY_MTK_UFS
Date: Wed, 25 Feb 2026 07:31:00 +0100
Message-ID: <20260225063100.46962-1-heinrich.schuchardt@canonical.com>
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

Symbol CONFIG_PHY_MTK_UFS does not exist.
Don't select it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
CONFIG_PHY_MTK_TPHY seems to be the only Mediatek PHY driver symbol
in U-Boot.
---
 drivers/ufs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 6c75bb2a079..69a5d91d9d2 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -26,7 +26,6 @@ config UFS_CADENCE
 config UFS_MEDIATEK
 	tristate "MediaTek UFS Host Controller Driver"
 	depends on UFS && ARCH_MEDIATEK
-	select PHY_MTK_UFS
 	help
 	  This selects the MediaTek specific additions to UFSHCD platform driver.
 	  UFS host on Mediatek needs some vendor specific configuration before
-- 
2.51.0

