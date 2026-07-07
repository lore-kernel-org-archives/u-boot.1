Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA21C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 13:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202FC84942;
	Tue,  7 Jul 2026 15:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="DIt+dFiw";
	dkim=pass (1024-bit key) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="DIt+dFiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9236C849B1; Tue,  7 Jul 2026 14:33:46 +0200 (CEST)
Received: from mx1.esisar.grenoble-inp.fr (mx1.esisar.grenoble-inp.fr
 [195.220.36.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD97E84852
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 14:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=theodore.oviguian@etu.esisar.grenoble-inp.fr
Received: from mx1.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 8A9012238DA;
 Tue,  7 Jul 2026 14:33:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTP id 71174223EFC;
 Tue,  7 Jul 2026 14:33:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx1.esisar.grenoble-inp.fr 71174223EFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1783427622;
 bh=opetoWxbta3aCePR18GuAepJlw+O1FE6qDE7idYHnxY=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=DIt+dFiwY9DoId+C7WarB8JekW9TssWP5x/8uwq4MQyMAD1AD8l/PICxmQXGajfvd
 zJnBFT+qr6IXY/x0H24pJlL3VHPygkuxrhE+CYK+o7r/ele/ky2QwjrVlic9iT6BFt
 rhQ2HmZcxI/wVhmpqx7EDxQyZRu+UtKLrCpwqwg0=
Received: from mx1.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (mx1.esisar.grenoble-inp.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5Mg9KrLUoA35; Tue,  7 Jul 2026 14:33:42 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (unknown [172.21.100.139])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 41C5C2238DA;
 Tue,  7 Jul 2026 14:33:42 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPS id 2DDC16E02B5;
 Tue,  7 Jul 2026 14:33:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTP id 186E36E0FE7;
 Tue,  7 Jul 2026 14:33:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 srv-zimbra.esisar.grenoble-inp.fr
 186E36E0FE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1783427622;
 bh=opetoWxbta3aCePR18GuAepJlw+O1FE6qDE7idYHnxY=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=DIt+dFiwY9DoId+C7WarB8JekW9TssWP5x/8uwq4MQyMAD1AD8l/PICxmQXGajfvd
 zJnBFT+qr6IXY/x0H24pJlL3VHPygkuxrhE+CYK+o7r/ele/ky2QwjrVlic9iT6BFt
 rhQ2HmZcxI/wVhmpqx7EDxQyZRu+UtKLrCpwqwg0=
Received: from srv-zimbra.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (srv-zimbra.esisar.grenoble-inp.fr [127.0.0.1]) (amavis,
 port 10026)
 with ESMTP id dxPGc-OuGKBp; Tue,  7 Jul 2026 14:33:42 +0200 (CEST)
Received: from Ubuntu.eur.gad.schneider-electric.com
 (71.169.185.81.rev.sfr.net [81.185.169.71])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPSA id 80D5D6E02B5;
 Tue,  7 Jul 2026 14:33:41 +0200 (CEST)
From: theodore.oviguian@etu.esisar.grenoble-inp.fr
To: u-boot@lists.denx.de
Cc: Theodore Oviguian <theodore.oviguian@etu.esisar.grenoble-inp.fr>,
 Theodore Oviguian <theodore.oviguian@se.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v3 0/3] Fix TI AM64X ERHPWM 
Date: Tue,  7 Jul 2026 12:33:20 +0000
Message-ID: <20260707123325.639840-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
X-Mailer: git-send-email 2.43.0
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

This patch serie fix the TI AM64X eHRPWM.=20

Hello to everyone thank you for your implication in a great software,
The goal of this patch serie is the to fix "failed to get tbclk
clock" error who appair when you probe (patch 1) ti pwm driver=20
and to fix a following error who sometime froze pwm (patch 2)
The code was build and tested on a TI AM64X board with U-Boot next

Signed-off-by: Theodore Oviguian <theodore.oviguian@se.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Neha Malcom Francis <n-francis@ti.com>

Theodore Oviguian (3):
  ti_pwm: Add EHRPWM TBCLK clock driver
  ti_pwm: Fix EHRPWM issue
  ti_pwm: Add support for arch k3

 drivers/clk/ti/Kconfig        |  7 ++++
 drivers/clk/ti/Makefile       |  1 +
 drivers/clk/ti/ehrpwm-tbclk.c | 65 +++++++++++++++++++++++++++++++++++
 drivers/pwm/Kconfig           |  2 +-
 drivers/pwm/pwm-ti-ehrpwm.c   | 16 +++++++--
 5 files changed, 87 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/ti/ehrpwm-tbclk.c

--=20
2.43.0

