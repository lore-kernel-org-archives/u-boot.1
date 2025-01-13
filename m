Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3691FC02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 21:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F45805E9;
	Mon, 13 Jan 2025 22:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="RoUypNmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 313488060C; Mon, 13 Jan 2025 22:15:29 +0100 (CET)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE0B805DA
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 22:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202501132115269d7fb1fa93c87de6ae for <u-boot@lists.denx.de>;
 Mon, 13 Jan 2025 22:15:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=RoTAbiENR11/CJ523NzFxAyrBvNKL2m6pcRCx68c3r0=;
 b=RoUypNmf4dri25O4neNmT1/27WnXLuZ8HiNZI8YxJK7xgWNoU8jInW7F9PIJlB8OiFeRSa
 4mnGos6ZmyStLYUiPFYFGHJ328A8kVW74lBAsCE6iTJD+G5guzVaK/jalDEx1X2jIKXr5sFR
 gAcTuHlbdAGrV+shYLMGodNVtCI0k07tbZwSI//RjxLjmAUH1oY1rOzh5kf+nCaUCPZ8h27X
 n8P7gcwoiKfnlJYKlbU+X8ja6Gk3R7Tf4DclFUybv7sN7RoVXE5YlOLh+Hq+g0FXu235HQSl
 TO+LDkOdnpNhnflHs5Rkaly3zK1wyo+Du4nD0XC1R/K3coNhTBErGPig==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Heiko Schocher <hs@denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] configs: capricorn_cxg3: Enable CMD_WDT
Date: Mon, 13 Jan 2025 22:15:15 +0100
Message-ID: <20250113211518.1276899-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Capricorn boards have WDT (WDT_SIEMENS_PMIC) and U-Boot is not configured
to trigger the WDT. Enable the "wdt" command to be able to stop the WDT
from the command line.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 configs/capricorn_cxg3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/capricorn_cxg3_defconfig b/configs/capricorn_cxg3_defconfig
index 276445528a9..fa1c279ef94 100644
--- a/configs/capricorn_cxg3_defconfig
+++ b/configs/capricorn_cxg3_defconfig
@@ -76,6 +76,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_READ=y
+CONFIG_CMD_WDT=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
-- 
2.47.1

