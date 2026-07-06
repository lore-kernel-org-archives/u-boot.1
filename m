Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4F9C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 13:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73F884997;
	Mon,  6 Jul 2026 15:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="x5dnsCWZ";
	dkim=pass (1024-bit key) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="vdHJrr9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E00E846F8; Mon,  6 Jul 2026 10:35:38 +0200 (CEST)
Received: from mx1.esisar.grenoble-inp.fr (mx1.esisar.grenoble-inp.fr
 [195.220.36.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B84846FD
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 10:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=theodore.oviguian@etu.esisar.grenoble-inp.fr
Received: from mx1.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 25BF92240F8;
 Mon,  6 Jul 2026 10:35:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTP id 1DF2A2240FB;
 Mon,  6 Jul 2026 10:35:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx1.esisar.grenoble-inp.fr 1DF2A2240FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1783326934;
 bh=rLXDGAgUMrpY0K4A0iHHC74foMNZ4OpBsiwfFSYdS/I=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=x5dnsCWZUMa+/UI+L1RFGNJ1yoPWh8hQEdY/N1+0+j9qd4KiAo1w4NCFBfjOxPZKu
 20Td00x2FsnF1qtOL1twJo3fai5P9PHH27cyg8c/wm45Yt/KVYfrmY8WUyMqdLx2PE
 E4CJ05KyG66fWir3NN6QqPnGPXYUYMDr88TGHkJI=
Received: from mx1.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (mx1.esisar.grenoble-inp.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 0vHr7LnWygN2; Mon,  6 Jul 2026 10:35:34 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (unknown [172.21.100.139])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id E07352240F8;
 Mon,  6 Jul 2026 10:35:33 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPS id D2BA66E0B25;
 Mon,  6 Jul 2026 10:35:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTP id C00B06E1029;
 Mon,  6 Jul 2026 10:35:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 srv-zimbra.esisar.grenoble-inp.fr
 C00B06E1029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1783326933;
 bh=rLXDGAgUMrpY0K4A0iHHC74foMNZ4OpBsiwfFSYdS/I=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=vdHJrr9fRfTpN14g5NYBCrcFpYnOE3I6ra/DgurLdlMgMpfuBTCsN0Tq2yhoHMaLr
 bQ6ex7bsNnZ3j++t7gokDimJDbQtucK4M5ekhmU8FBIGmp76Ff75UWqXrTmcgdHqaA
 YZZkVwQWT9wYlGS+sGTZnOhlfMh0o38MzraRhbkY=
Received: from srv-zimbra.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (srv-zimbra.esisar.grenoble-inp.fr [127.0.0.1]) (amavis,
 port 10026)
 with ESMTP id OLohrgU93Vgq; Mon,  6 Jul 2026 10:35:33 +0200 (CEST)
Received: from Ubuntu.eur.gad.schneider-electric.com
 (96.169.185.81.rev.sfr.net [81.185.169.96])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPSA id 68EA86E0B25;
 Mon,  6 Jul 2026 10:35:33 +0200 (CEST)
From: theodore.oviguian@etu.esisar.grenoble-inp.fr
To: u-boot@lists.denx.de
Cc: Theodore Oviguian <theodore.oviguian@etu.esisar.grenoble-inp.fr>,
 Theodore Oviguian <theodore.oviguian@se.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v2 3/3] ti_pwm: Add support for arch k3
Date: Mon,  6 Jul 2026 08:35:02 +0000
Message-ID: <20260706083507.18386-4-theodore.oviguian@etu.esisar.grenoble-inp.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706083507.18386-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
References: <20260706083507.18386-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 06 Jul 2026 15:04:38 +0200
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

(No change since v1)

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

