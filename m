Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E89D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 15:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A42A8440A;
	Thu, 27 Nov 2025 16:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mDYA+Vh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F4808440B; Thu, 27 Nov 2025 16:27:01 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2392A84409
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 16:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C44244240;
 Thu, 27 Nov 2025 15:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F446C116C6;
 Thu, 27 Nov 2025 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764257217;
 bh=N0EJ1Gug07yaTV3d1oefmkmcDZqoGdBXmhXklCnPpXw=;
 h=From:To:Cc:Subject:Date:From;
 b=mDYA+Vh4PftwDZPS0rtfFkDj0DqJO408Awruq875N5usyIwXylBlIR2NklJHUiRVa
 FZ/c4T7IMo2ortyhLD/VIDgmNF7NgUFCVisk+iiTkCRGgv5DgjpIP/KKs/6jFvVP9V
 up/qndT3WPvln1Bt6wZQYb7lFj73W1iYUJYBDEzaEZJRdLgDqJ7oNDt3Ju1n1ZoMLg
 uhsc/om34BwHiNQTIKAbVuLX5HdrJyLv5oXn8uMNFAOvtuI5ZBiVBUXo3BIFqkZW4D
 2l4ikVXYJYVOewFCYdOKOTLjXEmD7EwdeaRDIWTwCURCdWYWkJKug3kLMCrjkbM3PH
 AClogGORUo2pg==
From: Michael Walle <mwalle@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH] net: phy: broadcom: fix RGMII delays for BCM54210E
Date: Thu, 27 Nov 2025 16:25:27 +0100
Message-ID: <20251127152646.3283967-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
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

bcm54210e_config() configures the RGMII delays and then calls
bcm5461_config(). But the latter will do a PHY soft reset and thus
resets the delay settings again. Call bcm5461_config() first to fix it.

Fixes: cba79a1b2e11 ("net: phy: broadcom: add support for BCM54210E")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
Our board has rgmii-id set as PHY mode. Before commit 4b10bcfdef9c
("net: ethernet: ti: am65-cpsw: fix up PHY mode for fixed RGMII TX
delay") the delay on the MAC side would be disabled and masked the
actual error. After that commit, the MAC side will always enable the TX
delay, but that then uncovered the wrong behavior of the PHY driver.
---
 drivers/net/phy/broadcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 1c02e3efedc..2d93ce0c966 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -176,11 +176,11 @@ static int bcm54210e_config(struct phy_device *phydev)
 {
 	int ret;
 
-	ret = bcm54xx_config_clock_delay(phydev);
+	ret = bcm5461_config(phydev);
 	if (ret < 0)
 		return ret;
 
-	ret = bcm5461_config(phydev);
+	ret = bcm54xx_config_clock_delay(phydev);
 	if (ret < 0)
 		return ret;
 
-- 
2.47.3

