Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF31CD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 16:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E15B0849BF;
	Fri, 19 Jun 2026 18:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="inTjIyTB";
	dkim=pass (1024-bit key) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="inTjIyTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F88846E1; Fri, 19 Jun 2026 10:33:46 +0200 (CEST)
Received: from mx1.esisar.grenoble-inp.fr (mx1.esisar.grenoble-inp.fr
 [195.220.36.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 262FA849A4
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 10:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=theodore.oviguian@etu.esisar.grenoble-inp.fr
Received: from mx1.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 796EC224057;
 Fri, 19 Jun 2026 10:33:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTP id 713A1224059;
 Fri, 19 Jun 2026 10:33:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx1.esisar.grenoble-inp.fr 713A1224059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1781858017;
 bh=dAyavrHL6qxSDYQCiB6VjIG54AIWaNdq6kmDHZuOS1E=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=inTjIyTBZaZSEUvOJpzlnOY/5u5yrWlTA4AtVXFmMIq3TPHU8p1RMm471fMHH+nRI
 GRevVcyVZbLTqsoeK90LeYuLMfhrAdkFOpFXxNBeHH1qmNI3XlInMZ9zHafjHR8kQB
 jYsY1oPAN/0HD69WsL8DzY8EZRdio78savGxmTeU=
Received: from mx1.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (mx1.esisar.grenoble-inp.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id tvptgp3Bodl6; Fri, 19 Jun 2026 10:33:37 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (unknown [172.21.100.139])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 54599224057;
 Fri, 19 Jun 2026 10:33:37 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 48EDD6E1600;
 Fri, 19 Jun 2026 10:33:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTP id 445046E15D9;
 Fri, 19 Jun 2026 10:33:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 srv-zimbra.esisar.grenoble-inp.fr
 445046E15D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1781858017;
 bh=dAyavrHL6qxSDYQCiB6VjIG54AIWaNdq6kmDHZuOS1E=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=inTjIyTBZaZSEUvOJpzlnOY/5u5yrWlTA4AtVXFmMIq3TPHU8p1RMm471fMHH+nRI
 GRevVcyVZbLTqsoeK90LeYuLMfhrAdkFOpFXxNBeHH1qmNI3XlInMZ9zHafjHR8kQB
 jYsY1oPAN/0HD69WsL8DzY8EZRdio78savGxmTeU=
Received: from srv-zimbra.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (srv-zimbra.esisar.grenoble-inp.fr [127.0.0.1]) (amavis,
 port 10026)
 with ESMTP id PbI8V46zHxJV; Fri, 19 Jun 2026 10:33:37 +0200 (CEST)
Received: from Ubuntu.eur.gad.schneider-electric.com
 (81.168.185.81.rev.sfr.net [81.185.168.81])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPSA id E738A6E1628;
 Fri, 19 Jun 2026 10:33:36 +0200 (CEST)
From: theodore.oviguian@etu.esisar.grenoble-inp.fr
To: u-boot@lists.denx.de
Cc: Theodore Oviguian <theodore.oviguian@etu.esisar.grenoble-inp.fr>,
 Theodore Oviguian <theodore.oviguian@se.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 3/3] ti_pwm: Add support for arch k3
Date: Fri, 19 Jun 2026 08:32:13 +0000
Message-ID: <20260619083217.12930-4-theodore.oviguian@etu.esisar.grenoble-inp.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619083217.12930-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
References: <20260619083217.12930-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 19 Jun 2026 18:31:25 +0200
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

From: Theodore Oviguian <theodore.oviguian@etu.esisar.grenoble-inp.fr>

Signed-off-by: Theodore Oviguian <theodore.oviguian@se.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>

---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a69fe37caff..c406274387c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -122,7 +122,7 @@ config PWM_SUNXI
=20
 config PWM_TI_EHRPWM
 	bool "Enable support for EHRPWM PWM"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS || ARCH_K3
 	default y
 	help
 	  PWM driver support for the EHRPWM controller found on TI SOCs.
--=20
2.43.0

