Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5413FC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 23:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B180887DB;
	Sat, 13 Jul 2024 01:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="QsjvwQmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A782A88792; Fri, 12 Jul 2024 16:19:42 +0200 (CEST)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555FB88637
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 16:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=emil.kronborg@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1720793978; x=1721053178;
 bh=Trhb0GdswufVxTlvdjs78uQ+vZ8IAe2K7lhevuJN0t0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=QsjvwQmzMEnsVhv5ue4c+oDpFHHCYHu9U7Sih39nxpVkPvxSJ196mpTX0Fd+7RU0J
 9s+92fSzIw3LyF9UMZrhyw2wsloGj57GFWdka6HfXIZCZawwT+/LdnstdknzYX6iyZ
 8PuI5mTWxo03qGTRWKmUsTrLkfJvuBWljvnnLK8X7z1qL7IsRgQG63wuER4QuBNfee
 CmYyGeq+6U+gxOx0N8ymZQEZISRzI8v5nhIBet/NlDXn64sTUwRUs4uP8/JY3WbpD9
 zY7GnXsqKG2cTbzpJpR6TdFgBYshpxz7EqN7B0xL/mH34ZVH7u6NBDg2y/+f36xeyT
 Yd0V8LH4YnFSw==
Date: Fri, 12 Jul 2024 14:19:25 +0000
To: lukma@denx.de, seanga2@gmail.com
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: trini@konsulko.com, rasmus.villemoes@prevas.dk, u-boot@lists.denx.de
Subject: [PATCH] clk: imx6q: Add definition for IMX6QDL_CLK_PWM1
Message-ID: <20240712141922.27739-1-emil.kronborg@protonmail.com>
Feedback-ID: 20949900:user:proton
X-Pm-Message-ID: 4c7fe8178654265bf4a4acf37c022b81190a6b37
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 13 Jul 2024 01:10:01 +0200
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

Enabling CONFIG_CMD_PWM, and consequently CONFIG_DM_PWM, causes the pwm
command to fail due to a missing clock.

    =3D> pwm enable 0 0
    Enable clock-controller@20c4000 failed
    Failed to enable per_clk
    pwm: '0' not found
    Command 'pwm' failed: Error -2

Note that it is trivial to also add the clocks for PWM2, PWM3, and PWM4.
However, I only tested PWM1 and thus only added the clock for that
signal.

Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
---
 drivers/clk/imx/clk-imx6q.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index ba9923d8f6fa..b057b30c621e 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -128,6 +128,8 @@ static int imx6q_clk_probe(struct udevice *dev)
 =09       imx_clk_gate2("i2c1", "ipg_per", base + 0x70, 6));
 =09clk_dm(IMX6QDL_CLK_I2C2,
 =09       imx_clk_gate2("i2c2", "ipg_per", base + 0x70, 8));
+=09clk_dm(IMX6QDL_CLK_PWM1,
+=09       imx_clk_gate2("pwm1", "ipg_per", base + 0x78, 16));
=20
 =09clk_dm(IMX6QDL_CLK_ENET, imx_clk_gate2("enet", "ipg", base + 0x6c, 10))=
;
 =09clk_dm(IMX6QDL_CLK_ENET_REF,

base-commit: b4cbd1a257d4027038b4f997d73bdb0a066db045
--=20
2.45.2


