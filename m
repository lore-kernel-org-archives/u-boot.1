Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B971C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 17:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D60C080F24;
	Thu, 20 Aug 2026 17:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AMsts43n4xWM; Thu, 20 Aug 2026 17:53:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787248435;
	bh=slH4RT+Bu2CKL6u2cmUPp9/+82Muffxa+JRQt4CLjEQ=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AHqzDHWPPwb8wXv2UC2nDWSsVvGSPYp8elDWlDkkbTWLnS9bz+9TTu/krVl3bG35V
	 MOmet0s0tT+MsBqLjBFP8yyOI1cMlzPoLeR89/MUYIpTupQXRnNOrqiBK9GWTzLia5
	 kSHTpQPpIP/j6XGbYJa8jinyssy0FmqBwztOpqzmfMnSUUyCaTJti1FTrY5X/sRti8
	 B4jVinaufcpd0nKEzH0etLtauXKdPp6Y6Oo5Yi+xF4li+Vm5oE/zCwlcAN/LKgSoTr
	 zI7v5n9FwqOlUWktawrrgXWCl0jhQ2Tndhbzs+YDpJeFcc2iAt2O08MitkoPYVb8+N
	 ZtQyXB3BuXvXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29DAE80F01;
	Thu, 20 Aug 2026 17:53:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FDF139E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CE6480EF8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tApLNhrtQOKn for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 17:53:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.16;
 helo=mail-4316.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=Cj5FMEgW
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D3BC80F0D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787248430; x=1787507630;
 bh=slH4RT+Bu2CKL6u2cmUPp9/+82Muffxa+JRQt4CLjEQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Cj5FMEgWbQo5XbtHfCYkLEbtne6Wu5cFWZSFa03Mvom90434qW7Drs8nKJgU3qkO7
 SedygNfHY4ePRQ626W1NyTNVsPzBCZvmIqQTalFj1V9XKieeGY+JYUNz5zw8iZAf7G
 7lnZADbhTWxrROHjAEKAiL/l7yDCNSlp43oct+QCfR8f+Qq+2RU7OUutH6m0u4edfu
 SE3F9w+WOmSSfCy74HQpSemwD3tnqQ+CnJrcFKupycGlnWiUjPZV3Y//wmfP/QhWWe
 paUp7qgvO/d136YEyxW0/tv9h19XL8WlC5S36Fhm/y54OHRhmAfH0yZmwQkoRyBR18
 spDqZ0FZ+H0YA==
Date: Thu, 20 Aug 2026 17:53:43 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v3 2/2] spi: rockchip: skip the unused FIFO direction on a
 one-wire device
Message-ID: <7b6704538e0e5fabfa2ef8a0f2264697669fad03.1787245113.git.Munzzyy1@proton.me>
In-Reply-To: <cover.1787245113.git.Munzzyy1@proton.me>
References: <cover.1787245113.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 3a37faf79ba2df0504976bd8f38645c56e994ac1
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
Tested-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v3: reworded the toread comment to name what the RX drain
was doing for the transmit path (pacing the loop against the wire),
per Quentin. Comment only; compile check rerun, exit 0.

 drivers/spi/rk_spi.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/rk_spi.c b/drivers/spi/rk_spi.c
index 2c3d70ba7159..82009e61202f 100644
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
@@ -329,8 +343,8 @@ static int rockchip_spi_claim_bus(struct udevice *dev)
 =09/* Frame Format */
 =09ctrlr0 |=3D FRF_SPI << FRF_SHIFT;
=20
-=09/* Tx and Rx mode */
-=09ctrlr0 |=3D TMOD_TR << TMOD_SHIFT;
+=09/* Configure RX/TX mode */
+=09ctrlr0 |=3D rkspi_base_tmod(priv) << TMOD_SHIFT;
=20
 =09writel(ctrlr0, &regs->ctrlr0);
=20
@@ -472,7 +486,14 @@ static int rockchip_spi_xfer(struct udevice *dev, unsi=
gned int bitlen,
 =09=09writel(todo - 1, &regs->ctrlr1);
 =09=09rkspi_enable_chip(regs, true);
=20
-=09=09toread =3D todo;
+=09=09/*
+=09=09 * When the RX wire is not routed, the RX FIFO never fills,
+=09=09 * so waiting on it would hang. Draining it was also what
+=09=09 * paced this loop against the wire, so the transmit-only
+=09=09 * path relies on the wait_till_not_busy() below for
+=09=09 * completion instead.
+=09=09 */
+=09=09toread =3D (priv->mode & SPI_NO_RX) ? 0 : todo;
 =09=09/* Only write if we have something to write */
 =09=09towrite =3D out ? todo : 0;
 =09=09while (toread || towrite) {
@@ -513,7 +534,7 @@ static int rockchip_spi_xfer(struct udevice *dev, unsig=
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


