Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6809E9B25A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 05:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 372E18366F;
	Wed, 25 Feb 2026 06:43:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y+1Et88A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6591983946; Wed, 25 Feb 2026 06:43:44 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6869782A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ABD7140375; 
 Wed, 25 Feb 2026 05:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1771998222;
 bh=FMeQm6vUwKYAOZvZiKqN+M9y5JaTyb9H1Yz8RKt1Ofg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Y+1Et88A7yD9tR+UwQpVr0470z63fXSYBIiggpzm6MffEoS1eeRbAou0pEHLpyEgm
 iZpwMdBYgO3SbhqHuWO3ctCyYdc80pi4kvZTmMutyA55bsQHOFka6cWRMlz+2SIpkc
 0/iKQ9JLRrInhLZcufYQFrkZz7HkWCt+neh5u1ZEFP0cD75eoEDHO2aGZ8zqczHpcU
 zePs+M4hubftgI8NDYqX6hhtYTLY07sMmoTZOB97+Ih3xOT4aD++TxmrEDVrQxlp87
 KyQjIhKL/mDLJI927ppDO3RRA+dE+LseW8IGPGRi6pD5L+Me/8caVpVjdhX9enazdA
 dkxYa3+nIENXGHxeeLQkj6sNpytbOiUA6/yBeJXcYkiH9NLqk/zCqfY38lnAJs24Nu
 1DCtsOStypB6cNPFxy5wHaUJXhJikbDbNoyBDcvVQ2Uu33vjc6s6fbQc3ntJJmt7XN
 Wzg/jHc+zrbALvYVkBxJkPmrH1A8SFLjRcgoqYkEX1FgkfT38ZyrzhgS4jjKFnW7sM
 MoZCLvam5NLi2gaqDir3cCQ3yqIkaZaQQy97xE44eHHqOtJa/7/lL4giiqj17jGIly
 4JB/QWdrZvDHPkwiVCXpsHVcxiqeq8kdVR+OEHbEzZxCkffOenbZynk1fOgf6pYbZi
 1jifmNHyOScLPxKRAXhbs0Ek=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: lixinde <lixinde@phytium.com.cn>,
 weichangzheng <weichangzheng@phytium.com.cn>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] arm: don't select non-existent CONFIG_DM_PCI
Date: Wed, 25 Feb 2026 06:43:37 +0100
Message-ID: <20260225054337.12488-1-heinrich.schuchardt@canonical.com>
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

We removed configuration symbol CONFIG_DM_PCI with
commit 3232bdf0b30b ("pci: Drop DM_PCI").

Don't select it for TARGET_POMELO.

Fixes: b9d0f00a9d3f ("arm: add initial support for the Phytium Pomelo Board")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5508fce796a..0012808663b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2154,7 +2154,6 @@ config TARGET_POMELO
 	select SCSI_AHCI
 	select AHCI_PCI
 	select PCI
-	select DM_PCI
 	select SCSI
 	select DM_SERIAL
 	imply CMD_PCI
-- 
2.51.0

