Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08391C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 13:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACDC4849BA;
	Tue,  7 Jul 2026 15:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="ffsma1uc";
	dkim=pass (1024-bit key) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="ffsma1uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81BC8849B1; Tue,  7 Jul 2026 14:33:48 +0200 (CEST)
Received: from mx1.esisar.grenoble-inp.fr (mx1.esisar.grenoble-inp.fr
 [195.220.36.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2EF784994
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 14:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=theodore.oviguian@etu.esisar.grenoble-inp.fr
Received: from mx1.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 81A3A223F0E;
 Tue,  7 Jul 2026 14:33:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTP id 6E2DD223F10;
 Tue,  7 Jul 2026 14:33:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx1.esisar.grenoble-inp.fr 6E2DD223F10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1783427624;
 bh=LqYaYnrxpj+SuVaXx0cF95oqXWMP/ovL7ZOyvaXoZRI=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=ffsma1ucFnoY0bg7G3m6B63xPgmR9hRl7j3oz8soDHIWkx7Q9xKLtPvfluj6uqpaa
 uUccUYreh3dlMfCyk9HaEH/IuM7Hj3LXEDo9XWV2y6xjQftQKEv4C8O98fhZWaFe8g
 dr366sEZ3M5HhpuwZx+Y2cJfCQl2tmO3f3Mt7PjI=
Received: from mx1.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (mx1.esisar.grenoble-inp.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id btWC4XCXP3Pv; Tue,  7 Jul 2026 14:33:44 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (unknown [172.21.100.139])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 4E180223F0E;
 Tue,  7 Jul 2026 14:33:44 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 40BF06E0FE7;
 Tue,  7 Jul 2026 14:33:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTP id 3AF6A6E02B5;
 Tue,  7 Jul 2026 14:33:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 srv-zimbra.esisar.grenoble-inp.fr
 3AF6A6E02B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1783427624;
 bh=LqYaYnrxpj+SuVaXx0cF95oqXWMP/ovL7ZOyvaXoZRI=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=ffsma1ucFnoY0bg7G3m6B63xPgmR9hRl7j3oz8soDHIWkx7Q9xKLtPvfluj6uqpaa
 uUccUYreh3dlMfCyk9HaEH/IuM7Hj3LXEDo9XWV2y6xjQftQKEv4C8O98fhZWaFe8g
 dr366sEZ3M5HhpuwZx+Y2cJfCQl2tmO3f3Mt7PjI=
Received: from srv-zimbra.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (srv-zimbra.esisar.grenoble-inp.fr [127.0.0.1]) (amavis,
 port 10026)
 with ESMTP id lkX7RBbYfxoo; Tue,  7 Jul 2026 14:33:44 +0200 (CEST)
Received: from Ubuntu.eur.gad.schneider-electric.com
 (71.169.185.81.rev.sfr.net [81.185.169.71])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPSA id C585C6E0FE7;
 Tue,  7 Jul 2026 14:33:43 +0200 (CEST)
From: theodore.oviguian@etu.esisar.grenoble-inp.fr
To: u-boot@lists.denx.de
Cc: Theodore Oviguian <theodore.oviguian@etu.esisar.grenoble-inp.fr>,
 Theodore Oviguian <theodore.oviguian@se.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v3 3/3] ti_pwm: Add support for arch k3
Date: Tue,  7 Jul 2026 12:33:23 +0000
Message-ID: <20260707123325.639840-4-theodore.oviguian@etu.esisar.grenoble-inp.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707123325.639840-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
References: <20260707123325.639840-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 07 Jul 2026 15:05:06 +0200
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

Add support for arch k3 in the EHRPWM driver.

Signed-off-by: Theodore Oviguian <theodore.oviguian@se.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Neha Malcom Francis <n-francis@ti.com>
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

