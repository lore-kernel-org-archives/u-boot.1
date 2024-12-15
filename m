Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F853E7717F
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 15:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EAD38005D;
	Sun, 15 Dec 2024 16:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eu8yKleW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 256B5800B2; Sun, 15 Dec 2024 16:18:30 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8FC580050
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 16:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B15D2A40A96;
 Sun, 15 Dec 2024 15:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 518D4C4CEE1;
 Sun, 15 Dec 2024 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734275904;
 bh=lWpwVGHuFjm3ps5PT63oQAcZik2sm0ZdOmV1UQ/kH5A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=eu8yKleWInLtaNfB1R+nm11SIQUQsw8sA/HvclS8y48Ab9f++/57SI5C6/EdAbQ0X
 Oio3KFEsMxi9lnYepyuyDg8p+XGZg38BOBDV9j9l/Ks/oWbUOmhuUybnOLKCnWcJlo
 DCNV6MYlVmUKCCL7GVkd2w3JJ6rl/2P1d3CzPGIQoeSEACM4hXJY05vYFJ9/4n6gWY
 cqtG4HHWTMJkFSIrtq6ra+xMViSSw+cVJQ+hyS+pHd9G8tDSeMBsh3M6W/Y2diRVuA
 2DMUP+KdNYt/OYEGXqlYKlnIq7cGLK86lw25iaPjeprafzspB20lW6WV1PilTpCvma
 lSt4ftALgthOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 45A9FE7716A;
 Sun, 15 Dec 2024 15:18:24 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 15 Dec 2024 16:18:16 +0100
Subject: [PATCH 4/4] gpio: mpc8xxx: Preserve pre-init state of outputs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-mpc83xx-misc-v1-4-8cd6daae4f93@posteo.net>
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
In-Reply-To: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
To: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734275902; l=1861;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=uNPDeRR/wgJc9S7kufpmSM2o4jamsal9x7rfTFEben8=;
 b=t8F1v86n93FoB8YQSEnT6rThhnWa/wVTcWTNLkGNp7Qe8CzbDfAhkcUpdFGCs2s12z7xqqx1G
 q9k22LyvGbXAI2xKOjb7YhR9iC4yONj1rIjfQK/rSYoTcrsZjoZkwx0
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

From: "J. Neuschäfer" <j.ne@posteo.net>

The mpc8xxx_gpio driver contains a workaround for certain chips
where the previously written state of outputs cannot be read back
from the GPIO data (GPDAT) register (MPC8572/MPC8536). This workaround
consists of tracking the state of GPDAT in a "shadow register" (i.e. a
software variable). The shadow register is initialized to zero.

This results in a problem w.r.t. outputs that are configured to a
high (1) state before U-Boot runs, but not touched by U-Boot itself:
Due to the zero-initialization, these GPIOs end up being set to zero,
the first time that any other output is set.

To avoid such issues initialize the GPDAT shadow register to the value
previously held by any outputs, if possible. On MPC8572/MPC8536 this
should make no difference, i.e. the shadow register should be
initialized to zero on these chips.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 drivers/gpio/mpc8xxx_gpio.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/mpc8xxx_gpio.c b/drivers/gpio/mpc8xxx_gpio.c
index e9bd38f162c10c76460bc63f93c03a711cb4d38e..709d04017d154ecae1e8d16d7c35ced521157c4d 100644
--- a/drivers/gpio/mpc8xxx_gpio.c
+++ b/drivers/gpio/mpc8xxx_gpio.c
@@ -204,7 +204,17 @@ static int mpc8xxx_gpio_plat_to_priv(struct udevice *dev)
 		return -ENOMEM;
 
 	priv->gpio_count = plat->ngpios;
-	priv->dat_shadow = 0;
+
+	/*
+	 * On platforms that do support reading back output values, we want to
+	 * try preserving them, so that we don't accidentally set unrelated
+	 * GPIOs to zero in mpc8xxx_gpio_set_value.
+	 */
+	if (priv->little_endian)
+		priv->dat_shadow = in_le32(&priv->base->gpdat) & in_le32(&priv->base->gpdir);
+	else
+		priv->dat_shadow = in_be32(&priv->base->gpdat) & in_be32(&priv->base->gpdir);
+
 
 	priv->type = driver_data;
 

-- 
2.45.2


