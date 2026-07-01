Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181D8C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9096684B59;
	Wed,  1 Jul 2026 11:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ULLKQEI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A0A684B5D; Wed,  1 Jul 2026 11:11:33 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0AE84B45
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=+zUW0qimR5raGed7OOa12bxYXArw22L3mwhKcbt81EA=; b=ULLKQEI/LcAZ93U5XlsGpxlupA
 RW+0Ws1nLyLY6iHff5l1CiOm1h1o4MxXpDmdPigYcdlxOsoFWJ86n867uB40aMui+qkixW9OH5QfW
 0HSlkfphrh8UzrZYFch9gFhz7+L5SRtgwyRTvEf9PqFJ76AGIcSMafcDEIe/rcsQrJ4z+uHpMVtnU
 GOQ6w3SmtfqiEC2msdFxe1000whb0o61xQUZzYq9AyVgbv6kRdrChjeeig5ShVc7Wzffy8YU2XxTX
 OQN9PnE5G6gFCJwsx+07UzsH8VoOJZiwMVh+M0mkVh2yAdHwWyNCJH0Q88HlThy8xqM2nYZYhPIaF
 961g3yuA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1weqyf-000A4d-2Y; Wed, 01 Jul 2026 11:11:29 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1weqyg-0007Md-0l; Wed, 01 Jul 2026 11:11:29 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH 4/4] boards: tqma6ul: select TQ_COMMON_SYSINFO
Date: Wed,  1 Jul 2026 11:11:19 +0200
Message-ID: <20260701091122.1479350-5-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701091122.1479350-1-Max.Merchel@ew.tq-group.com>
References: <20260701091122.1479350-1-Max.Merchel@ew.tq-group.com>
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

Select TQ_COMMON_SYSINFO to use the tq_eeprom sysinfo driver
to read and print module EEPROM data.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/mach-imx/mx6/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 7ed4b24b751..2680eb8fa44 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -637,6 +637,7 @@ config TARGET_TQMA6UL
 	bool "TQ-Systems TQMa6UL[L]x"
 	depends on MX6UL || MX6ULL
 	select TQ_COMMON_SOM
+	select TQ_COMMON_SYSINFO
 	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	select OF_SYSTEM_SETUP
-- 
2.43.0

