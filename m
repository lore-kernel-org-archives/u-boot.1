Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8A6C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 13:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C3A38497A;
	Tue,  7 Jul 2026 15:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="aN/yE5jq";
	dkim=pass (1024-bit key) header.d=etu.esisar.grenoble-inp.fr header.i=@etu.esisar.grenoble-inp.fr header.b="aN/yE5jq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA5784852; Tue,  7 Jul 2026 14:33:46 +0200 (CEST)
Received: from mx1.esisar.grenoble-inp.fr (mx1.esisar.grenoble-inp.fr
 [195.220.36.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467618494B
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 14:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=etu.esisar.grenoble-inp.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=theodore.oviguian@etu.esisar.grenoble-inp.fr
Received: from mx1.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id EC25F223F02;
 Tue,  7 Jul 2026 14:33:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTP id E5C52223F0E;
 Tue,  7 Jul 2026 14:33:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx1.esisar.grenoble-inp.fr E5C52223F0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1783427623;
 bh=vR3K3HlocCsNV3KT8VblkhL5EwufmE3mrOZVzWYiJlE=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=aN/yE5jqgN8EJx9klnDVmpRN0OKeXUMzZVXPJ1BKlRs/aPI+uKAWJsMwkkXNRQxpO
 UAIYWxy3PKt8OFqHuMFmM2uHawo6HuWS/OCW6m0NMuyenDN0oHYaVLZqHV8gCIcdvk
 Sd0UZOOJZZwi3L2Kysqgtn5dN/OAZv+dKxqJFt3E=
Received: from mx1.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (mx1.esisar.grenoble-inp.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id GrWCs8p01tIQ; Tue,  7 Jul 2026 14:33:43 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (unknown [172.21.100.139])
 by mx1.esisar.grenoble-inp.fr (Postfix) with ESMTPS id C794B223F02;
 Tue,  7 Jul 2026 14:33:43 +0200 (CEST)
Received: from srv-zimbra.esisar.grenoble-inp.fr (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPS id BAEA76E02B5;
 Tue,  7 Jul 2026 14:33:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTP id B4BC26E0FE7;
 Tue,  7 Jul 2026 14:33:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 srv-zimbra.esisar.grenoble-inp.fr
 B4BC26E0FE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etu.esisar.grenoble-inp.fr;
 s=29808A28-1FE8-11E5-B58B-F10B7632C813; t=1783427623;
 bh=vR3K3HlocCsNV3KT8VblkhL5EwufmE3mrOZVzWYiJlE=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=aN/yE5jqgN8EJx9klnDVmpRN0OKeXUMzZVXPJ1BKlRs/aPI+uKAWJsMwkkXNRQxpO
 UAIYWxy3PKt8OFqHuMFmM2uHawo6HuWS/OCW6m0NMuyenDN0oHYaVLZqHV8gCIcdvk
 Sd0UZOOJZZwi3L2Kysqgtn5dN/OAZv+dKxqJFt3E=
Received: from srv-zimbra.esisar.grenoble-inp.fr ([127.0.0.1])
 by localhost (srv-zimbra.esisar.grenoble-inp.fr [127.0.0.1]) (amavis,
 port 10026)
 with ESMTP id imo1BDRFtenx; Tue,  7 Jul 2026 14:33:43 +0200 (CEST)
Received: from Ubuntu.eur.gad.schneider-electric.com
 (71.169.185.81.rev.sfr.net [81.185.169.71])
 by srv-zimbra.esisar.grenoble-inp.fr (Postfix) with ESMTPSA id E6BB96E02B5;
 Tue,  7 Jul 2026 14:33:42 +0200 (CEST)
From: theodore.oviguian@etu.esisar.grenoble-inp.fr
To: u-boot@lists.denx.de
Cc: Theodore Oviguian <theodore.oviguian@etu.esisar.grenoble-inp.fr>,
 Theodore Oviguian <theodore.oviguian@se.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 2/3] ti_pwm: Fix EHRPWM issue
Date: Tue,  7 Jul 2026 12:33:22 +0000
Message-ID: <20260707123325.639840-3-theodore.oviguian@etu.esisar.grenoble-inp.fr>
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

eHRPWM driver was disabling the module clock at every channel disable,
thats a bad idea because if the other chanel is enabled that froze it.

Signed-off-by: Theodore Oviguian <theodore.oviguian@se.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Neha Malcom Francis <n-francis@ti.com>
---

V2:
(Removed a trailing whitespace in the patch)

V3:
Remove a useless comment (sinc there an equivalent some lines before)
Remove a useless loop :
for (uint i =3D 0; i < TI_EHRPWM_NUM_CHANNELS; i++)
	priv->enabled[i] =3D false;
Since as remarked by Neha Malcom Francis alloc_priv
already use calloc or memset zero.

Thanks to Neha Malcom Francis for the quality and speed of the reviews

 drivers/pwm/pwm-ti-ehrpwm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-ti-ehrpwm.c b/drivers/pwm/pwm-ti-ehrpwm.c
index 135ea3b4321..a74d59a71df 100644
--- a/drivers/pwm/pwm-ti-ehrpwm.c
+++ b/drivers/pwm/pwm-ti-ehrpwm.c
@@ -101,6 +101,7 @@ struct ti_ehrpwm_priv {
 	struct clk tbclk;
 	unsigned long period_cycles[TI_EHRPWM_NUM_CHANNELS];
 	bool polarity_reversed[TI_EHRPWM_NUM_CHANNELS];
+	bool enabled[TI_EHRPWM_NUM_CHANNELS];
 };
=20
 static void ti_ehrpwm_modify(u16 val, u16 mask, fdt_addr_t reg)
@@ -333,7 +334,16 @@ static int ti_ehrpwm_disable(struct udevice *dev, ui=
nt channel)
 	ti_ehrpwm_modify(aqcsfrc_val, aqcsfrc_mask,
 			 priv->regs + TI_EHRPWM_AQCSFRC);
=20
-	/* Disabling TBCLK on PWM disable */
+	/*
+	 * Disabling TBCLK on PWM disable
+	 * Only if all channels are disabled
+	 */
+	priv->enabled[channel] =3D false;
+	for (uint i =3D 0; i < TI_EHRPWM_NUM_CHANNELS; i++) {
+		if (priv->enabled[i])
+			return 0;
+	}
+
 	err =3D clk_disable(&priv->tbclk);
 	if (err) {
 		dev_err(dev, "failed to disable tbclk\n");
@@ -377,7 +387,7 @@ static int ti_ehrpwm_enable(struct udevice *dev, uint=
 channel)
 		dev_err(dev, "failed to enable tbclk\n");
 		return err;
 	}
-
+	priv->enabled[channel] =3D true;
 	return 0;
 }
=20
@@ -399,7 +409,7 @@ static int ti_ehrpwm_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
=20
-	dev_dbg(dev, "regs=3D0x%08x\n", priv->regs);
+	dev_dbg(dev, "regs=3D0x%08llx\n", priv->regs);
 	return 0;
 }
=20
--=20
2.43.0

