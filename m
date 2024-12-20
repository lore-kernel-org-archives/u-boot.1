Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDB1E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 10:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 526948035E;
	Fri, 20 Dec 2024 11:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gASrACh8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84CD580087; Fri, 20 Dec 2024 11:38:08 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11AE48007D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 11:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 968F2A41895;
 Fri, 20 Dec 2024 10:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5B23C4CECD;
 Fri, 20 Dec 2024 10:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734691084;
 bh=qW4GQ3pkYGGiECzg5Ro1dOKBOLq139vgdvyYbx5Fq1c=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=gASrACh8VgDzImF346IBKpQg2uCBiLKmVXrMK9avB4ZcyFbmIIBKNVGhNchLlKZEa
 pu0isKv+vF50Fh1ihj9RQaMxa4BnMYqsmjZZPicWrkXVLwteqNjsUgVOtuigZXSlVJ
 5H08V01kQrxTp+VAchAFhqTI58XJoH26YT6YaMUUJsciPOGo4waGKNzOeTdWb3eWj+
 JiKZz0gRP4osaIkLwppztFOkj3YaVYc6o9YK/FotVs5/zpP81BNUfOpmIyGfn6FIT+
 j7rD+FIUEmEr1I37G5EfajO7KDpxtMsrhiPIa0goF51/ZxQPY6j9M8BB1418J1xhcp
 WOWS9mvqR+itg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB9FE77188;
 Fri, 20 Dec 2024 10:38:04 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v2 0/4] Misc. PowerPC MPC83xx fixes/cleanups
Date: Fri, 20 Dec 2024 11:37:50 +0100
Message-Id: <20241220-mpc83xx-misc-v2-0-ff4c17ee5fa4@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP5IZWcC/1XMQQ6DIBCF4auYWZcGEC111Xs0LggMdRaKAUJsj
 HcvNd10+b/kfTskjIQJhmaHiIUShaWGvDRgJ7O8kJGrDZJLJSTv2bxa3W4bmylZ5lWr/Q15p5y
 GelkjetpO7jnWnijlEN+nXsR3/UGi+4eKYJxp63pnDCp/bx9rSBnDdcEM43EcHzCGzEypAAAA
X-Change-ID: 20241206-mpc83xx-misc-f438f7e054d8
To: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>
Cc: Sinan Akman <sinan@writeme.com>, u-boot@lists.denx.de, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734691081; l=1030;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=qW4GQ3pkYGGiECzg5Ro1dOKBOLq139vgdvyYbx5Fq1c=;
 b=Vjmr2pgr/rIjIaR9YYnE30h1xwl4BNYdp8oqmmcvq9c1hXTTa1AFnwj3EkGy+uXO+JVTdit+E
 gexgSZG9TzmDIbBEMZQXoyeK7vXabgn5kosx74HUv0/nU6kkMMM+Dmf
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patchset contains a few small fixes/cleanups for the MPC83xx
platform.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v2:
- Address feedback from Sinan Akman by clarifying some commit messages
- Link to v1: https://lore.kernel.org/r/20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net

---
J. Neuschäfer (4):
      powerpc: mpc83xx: Fix timer value calculation
      powerpc: mpc83xx: Allow including initreg.h into multiple files
      powerpc: mpc83xx: Use defined constant for SPCR[TBEN]
      gpio: mpc8xxx: Preserve pre-init state of outputs

 arch/powerpc/cpu/mpc83xx/initreg/initreg.h |  8 ++++----
 arch/powerpc/cpu/mpc83xx/interrupts.c      |  3 ++-
 drivers/gpio/mpc8xxx_gpio.c                | 12 +++++++++++-
 drivers/timer/mpc83xx_timer.c              |  2 +-
 4 files changed, 18 insertions(+), 7 deletions(-)
---
base-commit: 337bfdce5aa52637b482b182db959b9bb058f4b7
change-id: 20241206-mpc83xx-misc-f438f7e054d8

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


