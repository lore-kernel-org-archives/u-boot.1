Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEC9E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 10:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04DBC803AB;
	Fri, 20 Dec 2024 11:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k+z2zroj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C05380328; Fri, 20 Dec 2024 11:38:10 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C0088032B
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 11:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id DA23BA418E5;
 Fri, 20 Dec 2024 10:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05B21C4CEDD;
 Fri, 20 Dec 2024 10:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734691085;
 bh=Nu66tKx2WikTlhwGdbgkVMZQMObgXei+Xtt2FLVxCS4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=k+z2zrojonAuKgkKdJ1PWGazFWCq3JvJ66zBZYVlXiAdwaHFPnJN5H61GGxJNX7vV
 Q6QlQTzJ8Vmq5J76HXhqgTMdkff2biiS7QN/bl9vElR9wGXjLQhtLZ6JiFcllumbgM
 lTzWMohmP3mbJY1Cb8cl0DxZebbSUUjXMHm/VnLjRHv8HlmV7UjO3738clOAVxeXFI
 AXgY/qYqFyMUsUjQD3YpBHiGq3zZmS2v8I9LpYMYjBX+v0AlKUF0zfQelIWdJYPwUC
 haEBcVi0P8jiltmRPNy3STs1NRsfvCIXDX2m2oM0PncHUMp6UafS/wTsEVsaJHrOEV
 fSgp+KThRYLBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id EF101E7718A;
 Fri, 20 Dec 2024 10:38:04 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 20 Dec 2024 11:37:54 +0100
Subject: [PATCH v2 4/4] gpio: mpc8xxx: Preserve pre-init state of outputs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241220-mpc83xx-misc-v2-4-ff4c17ee5fa4@posteo.net>
References: <20241220-mpc83xx-misc-v2-0-ff4c17ee5fa4@posteo.net>
In-Reply-To: <20241220-mpc83xx-misc-v2-0-ff4c17ee5fa4@posteo.net>
To: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>
Cc: Sinan Akman <sinan@writeme.com>, u-boot@lists.denx.de, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734691081; l=2017;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=3OOJ1gFlOUtLdlbIMEpQp2gBYtM4bC2L3oBPBpICZwE=;
 b=CUY4EeyCZnhTAJVh8ZGfJXjBCo4QrmZ9Rk5v4rmy7uFZHR+4L25bpnFsOsYsvyPtXoGXWhsh8
 sVMNiQvUZBaDnRnqEUZ/WJMCGNpUrkZodMS5HEoF+XAOuE16mYkwZQk
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

This patch has been tested on a MPC8314E-based board.

Reviewed-by: Sinan Akman <sinan@writeme.com>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- Clarify how the patch has been tested
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


