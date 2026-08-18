Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B85EC5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 09:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F25340762;
	Tue, 18 Aug 2026 09:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5dWMohu-QSMY; Tue, 18 Aug 2026 09:34:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3741940660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787045647;
	bh=p8ErtJlJ/g13XRRnFgpKEGRc3M32mMEkB1OHE05XJHA=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gKKlWwJU3SK0uOg2XzHm47XNXFpRy4BHo8fZ/fEWhBxZI1Nqidlp+rnC4ODjfH80K
	 PMQhyDw1NONyiIZZGoqB3ynWZDhpC1t5qMA0GOOaARzYGkwSJAPqI78mSSCQtI8WCf
	 ai1ccfeBo7ZZtT/smCZQaz9sd2jM66/7oolJtHfs2+VzHm/73vdIoLB1kmnnyVIR30
	 QuutPrrJCxyrPkah355wwCT37JJkJKRvvl8xs04kb4EgLwFbcBy3vALV0KCRsjkQJ6
	 Cj4MQBJ3CHF5WXUrzM2OfbVz+fj5IftI0VWOw4L7Ej4Pn3E0hqEdCqDbN7IhOdL50c
	 p9Nm5XExjNQ7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3741940660;
	Tue, 18 Aug 2026 09:34:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 632DA230
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54F2940660
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EtrAC9ZFpu14 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 09:34:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.29;
 helo=mail-10629.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BB7F440608
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB7F440608
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=INuYhjqP
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch
 [79.135.106.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB7F440608
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787045641; x=1787304841;
 bh=p8ErtJlJ/g13XRRnFgpKEGRc3M32mMEkB1OHE05XJHA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=INuYhjqPel+Kt2VccN5WzgCE8VwjWrN2Ec31wqf0D/JgqWkgUGVzRXjO2N6EIyph0
 BZzF3tC+3Vzx+zj6qjnco+S+eJVyamAkM4RBgTt/+KQ9piNW2Lqs1i4vNyFSojnlE0
 6qbSvbWelJmg0PiGBszlh3AYXA3wyGS73+D8VNp2647X5J6I3LGg4uXPXJPIc6LmTw
 IbkhwbqRjW+GOgAM17HSmqx3MpGIiPkyz0QT1T1uPf0pNyejr9L4NKCo5WjeOc5MGw
 eEW0KwvseWRYoojPL22RsmLcdWARnj6oQO7BfuBwZ//cZZ0MufGLvPNhKbjfk12Q0F
 bgDAZx6mpKUuA==
Date: Tue, 18 Aug 2026 09:33:55 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH] spi: rockchip: skip the unused FIFO direction on a one-wire
 device
Message-ID: <69c35eba7ee1a353107459b8f8032e92506a3fb1.1787045568.git.Munzzyy1@proton.me>
In-Reply-To: <CAKTNdwHMga0XG1zfgLYirMbVK8iVpWgjyr9x49sQ2ofPNu+w3Q@mail.gmail.com>
References: <10e92a74c8a22cc2cd54f5dcccc31594016d4263.1787015208.git.Munzzyy1@proton.me>
 <CAKTNdwHMga0XG1zfgLYirMbVK8iVpWgjyr9x49sQ2ofPNu+w3Q@mail.gmail.com>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 225b042fe154a3a2f7f36c1fca997ca07f3f4389
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The controller has a transfer-mode field that can run transmit-only or
receive-only instead of both, which leaves the unused FIFO out of the
transfer entirely. The driver never used it for that: claim_bus always
programmed TMOD_TR, and the only other mode came from an opportunistic
switch to TMOD_RO for read-only transfers.

A device described with spi-{tx,rx}-bus-width =3D <0> has no wire in that
direction at all, so now that the width reaches plat->mode as
SPI_NO_TX/SPI_NO_RX, pick the transfer mode from it. A write-only
display stops clocking receive bytes nobody reads.

The transmit-only case needs one more change. The 8-bit loop paces
itself on the receive FIFO and sets toread unconditionally, so with no
receive path it would wait on a FIFO that stays empty forever. Leave
toread at zero there and let the existing wait_till_not_busy() at the
end of the chunk handle completion, which is the same thing that
already covers a transmit component today.

The restore at the end of a read-only transfer went back to a hardcoded
TMOD_TR, which would undo the device's own mode. Restore what the mode
asks for instead.

Signed-off-by: Cole Munz <Munzzyy1@proton.me>
---
Alexey, this is the FIFO wiring you asked about. It applies on top of
"spi: Handle spi-{tx,rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX", since it
needs those bits to exist.

You are right that the first patch is a no-op on its own. With this one
the Flipper One display bus stops running the receive FIFO at all: the
MISO pin is the end-of-frame GPIO, so every byte the controller clocked
in was discarded by the loop anyway.

The part that is not just a mode select is the 8-bit loop. It sets
toread =3D todo whether or not the caller passed a din, and drains the
receive FIFO to pace itself. In TMOD_TO that FIFO never fills, so it
would spin forever. Leaving toread at zero and letting the existing
rkspi_wait_till_not_busy() close out the chunk keeps the timing the same
for the transmit case, which already relied on that call.

Verification, and its limits. I have no Rockchip board, so this is
compile-tested and reasoned from the driver, not run:

 $ make jaguar-rk3588_defconfig
 $ make CROSS_COMPILE=3Daarch64-linux-gnu- drivers/spi/rk_spi.o
 CC      drivers/spi/rk_spi.o     (exit 0)

checkpatch --strict is 0/0/0. A full board build stops in binman for want
of BL31 and tee.bin, identically with and without this patch, so that one
is my missing blobs rather than the change.

What I cannot check here is the hardware behaviour: that TMOD_TO really
does leave the receive FIFO idle on a real part, and that a write-only
display still clocks out correctly. If you have a board in front of you,
that is the bit worth a look.

 drivers/spi/rk_spi.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/rk_spi.c b/drivers/spi/rk_spi.c
index 2c3d70ba7159..6c2ed3a90bf9 100644
--- a/drivers/spi/rk_spi.c
+++ b/drivers/spi/rk_spi.c
@@ -283,6 +283,20 @@ static int rockchip_spi_probe(struct udevice *bus)
 =09return 0;
 }
=20
+/*
+ * A device that declares spi-{tx,rx}-bus-width =3D <0> has no wire in tha=
t
+ * direction, so the controller can drop the matching FIFO entirely instea=
d
+ * of clocking bytes nobody reads.
+ */
+static u32 rkspi_base_tmod(struct rockchip_spi_priv *priv)
+{
+=09if (priv->mode & SPI_NO_RX)
+=09=09return TMOD_TO;
+=09if (priv->mode & SPI_NO_TX)
+=09=09return TMOD_RO;
+=09return TMOD_TR;
+}
+
 static int rockchip_spi_claim_bus(struct udevice *dev)
 {
 =09struct udevice *bus =3D dev->parent;
@@ -330,7 +344,7 @@ static int rockchip_spi_claim_bus(struct udevice *dev)
 =09ctrlr0 |=3D FRF_SPI << FRF_SHIFT;
=20
 =09/* Tx and Rx mode */
-=09ctrlr0 |=3D TMOD_TR << TMOD_SHIFT;
+=09ctrlr0 |=3D rkspi_base_tmod(priv) << TMOD_SHIFT;
=20
 =09writel(ctrlr0, &regs->ctrlr0);
=20
@@ -472,7 +486,12 @@ static int rockchip_spi_xfer(struct udevice *dev, unsi=
gned int bitlen,
 =09=09writel(todo - 1, &regs->ctrlr1);
 =09=09rkspi_enable_chip(regs, true);
=20
-=09=09toread =3D todo;
+=09=09/*
+=09=09 * In transmit-only mode the RX FIFO never fills, so waiting
+=09=09 * on it would hang. Completion is handled by the
+=09=09 * wait_till_not_busy() below instead.
+=09=09 */
+=09=09toread =3D (priv->mode & SPI_NO_RX) ? 0 : todo;
 =09=09/* Only write if we have something to write */
 =09=09towrite =3D out ? todo : 0;
 =09=09while (toread || towrite) {
@@ -513,7 +532,7 @@ static int rockchip_spi_xfer(struct udevice *dev, unsig=
ned int bitlen,
 =09if (!out)
 =09=09clrsetbits_le32(&regs->ctrlr0,
 =09=09=09=09TMOD_MASK << TMOD_SHIFT,
-=09=09=09=09TMOD_TR << TMOD_SHIFT);
+=09=09=09=09rkspi_base_tmod(priv) << TMOD_SHIFT);
=20
 =09return ret;
 }
--=20
2.55.0


