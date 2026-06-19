Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44C5CD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 16:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1909849A4;
	Fri, 19 Jun 2026 18:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="j7xrJ5DO";
	dkim=pass (1024-bit key) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="j7xrJ5DO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26351849C5; Fri, 19 Jun 2026 10:33:45 +0200 (CEST)
Received: from mx1.esisar.grenoble-inp.fr (mx1.esisar.grenoble-inp.fr
 [195.220.36.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C470846E1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 10:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=theodore.oviguian@etu.esisar.grenoble-inp.fr
Received: from mx1.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 76B5722404E;
 Fri, 19 Jun 2026 10:33:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTP id 5EBBC224055;
 Fri, 19 Jun 2026 10:33:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx1.esisar.grenoble-inp.fr 5EBBC224055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1781858016;
 bh=WkKJI9H96S0IYjXzHQbcwr71Xyf7rNHOVU0fphfgLvg=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=j7xrJ5DOXd+LPVlaphX92IQEy0KjlPgh5X5m0WURuPT971zJmkdXnCoZVRe+DVGq3
 yOT6Xlw8n6h+uAWiP2Dx4nFklCDdhaD9Ff74cpg0e9u7uEeRax3IZ8vyg0P7oGKvHh
 V9RDiJidbb5XoRveZXcBt79LQifrXWRPAy/X76C4=
Received: from mx1.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (mx1.esisar.grenoble-inp.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id G2wZGQ8QSuFx; Fri, 19 Jun 2026 10:33:36 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (unknown [172.21.100.139])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 3149022404E;
 Fri, 19 Jun 2026 10:33:36 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 206716E15D9;
 Fri, 19 Jun 2026 10:33:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTP id 0AD4B6E1600;
 Fri, 19 Jun 2026 10:33:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 srv-zimbra.esisar.grenoble-inp.fr
 0AD4B6E1600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1781858016;
 bh=WkKJI9H96S0IYjXzHQbcwr71Xyf7rNHOVU0fphfgLvg=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=j7xrJ5DOXd+LPVlaphX92IQEy0KjlPgh5X5m0WURuPT971zJmkdXnCoZVRe+DVGq3
 yOT6Xlw8n6h+uAWiP2Dx4nFklCDdhaD9Ff74cpg0e9u7uEeRax3IZ8vyg0P7oGKvHh
 V9RDiJidbb5XoRveZXcBt79LQifrXWRPAy/X76C4=
Received: from srv-zimbra.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (srv-zimbra.esisar.grenoble-inp.fr [127.0.0.1]) (amavis,
 port 10026)
 with ESMTP id XLS85s7Uojzm; Fri, 19 Jun 2026 10:33:36 +0200 (CEST)
Received: from Ubuntu.eur.gad.schneider-electric.com
 (81.168.185.81.rev.sfr.net [81.185.168.81])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPSA id ACA026E15D9;
 Fri, 19 Jun 2026 10:33:35 +0200 (CEST)
From: theodore.oviguian@etu.esisar.grenoble-inp.fr
To: u-boot@lists.denx.de
Cc: Theodore Oviguian <theodore.oviguian@etu.esisar.grenoble-inp.fr>,
 Theodore Oviguian <theodore.oviguian@se.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 0/3] Fix TI AM64X ERHPWM 
Date: Fri, 19 Jun 2026 08:32:10 +0000
Message-ID: <20260619083217.12930-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
X-Mailer: git-send-email 2.43.0
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

This patch serie fix the TI AM64X eHRPWM.=20

Hello to everyone thank you for your implication in a great software,
The goal of this patch serie is the to fix "failed to get tbclk
clock" error who appair when you probe (patch 1) ti pwm driver=20
and to fix a following error who sometime froze pwm (patch 2)
The code was build and tested on a TI AM64X board with U-Boot next

Signed-off-by: Theodore Oviguian <theodore.oviguian@se.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>

Theodore Oviguian (3):
  ti_pwm: Add EHRPWM TBCLK clock driver
  ti_pwm: Fix EHRPWM issue
  ti_pwm: Add support for arch k3

 drivers/clk/ti/Kconfig        |  7 ++++
 drivers/clk/ti/Makefile       |  1 +
 drivers/clk/ti/ehrpwm-tbclk.c | 69 +++++++++++++++++++++++++++++++++++
 drivers/pwm/Kconfig           |  2 +-
 drivers/pwm/pwm-ti-ehrpwm.c   | 17 ++++++++-
 5 files changed, 93 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/ti/ehrpwm-tbclk.c

--=20
2.43.0

