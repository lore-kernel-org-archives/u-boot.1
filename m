Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D86C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2345980E05;
	Thu, 20 Aug 2026 15:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y_yuF6oQq_4R; Thu, 20 Aug 2026 15:26:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787239591;
	bh=PW4RqR3QiQg8NVnbblddsDKxQ+slvJMAnJBVP7gi9Ug=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YF/mfDXMhJPGC/jrjC9Qy25KmrbxxGIyofsyxgnk1/rHq2uSgfYN2V/FEbcv1QZ+1
	 9UJeLL13WpdGpstYOcmluQX3e+Qr4SD/tJ/C7p8hcBeybyNXN0u9nroOT+LFv2h8m+
	 bT0XHzBgGyIvwEQmnl763iO/q9F9fOyNHlVtEmDV9R773oiMFta0GvHpwGoIhcH1Qn
	 nj5pKJtMO1oQUTj0CkkKSh1P5EpsoQNxMFbEmafJ38sgrwWVCNrZerGuvxAw+DfZTL
	 zWq07duroXsii7WeulXXjn4TMbtw9e5KwICP1nan8zZBWKJT8CStkUz9ecHRSqZXlR
	 AaaSKSRCZcTkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E05E80DF4;
	Thu, 20 Aug 2026 15:26:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EAFD29D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6557640093
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GPqGPC_BocK7 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:26:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=f6AIQRe6
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 770854002B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787239581; x=1787498781;
 bh=PW4RqR3QiQg8NVnbblddsDKxQ+slvJMAnJBVP7gi9Ug=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=f6AIQRe6VohtEBiXZNZt6eM/7us3zF9WEnkDTKowwU+ITE4eQhPc3lcwXCaiySRGx
 j6OFaGJX3wzYIod8VJdsgp72QkIbBJbLAVywHodarQjBAL3A6pIxO7gYeNUP2Ij0Bc
 PfABoDm1Ep4bJw0eO/3lk3wdKIDXIu5zymtTDiOmPGCbkA2uuSeZZ2QO45rwGQ5yu3
 rA68nUJjDtPaz7F18G+hSCcHLsq5rXckBVxqdoB+MngzzOMkKLHZzWRJ69tXOX9ywb
 TKyu2IahMj21YzOqG45gqXLuTQ0iQBKD/UDbKHwrOr6zv7A+QVcY8sqwD6qUknPN3e
 Zar5LXD8C6aCA==
Date: Thu, 20 Aug 2026 15:26:16 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 2/2] spi: rockchip: skip the unused FIFO direction on a
 one-wire device
Message-ID: <9ddf5b446d236c42e39aef5c7dae9bc359dff694.1787238071.git.Munzzyy1@proton.me>
In-Reply-To: <cover.1787238071.git.Munzzyy1@proton.me>
References: <cover.1787238071.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 6011cad493438222c13f79965784e847c6bfd22b
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
Changes in v2: reworded the transfer mode comment in claim_bus, picked
up the Tested-by. No functional change since v1; compile check rerun:

  $ make jaguar-rk3588_defconfig
  $ make CROSS_COMPILE=3Daarch64-linux-gnu- drivers/spi/rk_spi.o
  CC      drivers/spi/rk_spi.o     (exit 0)

 drivers/spi/rk_spi.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/rk_spi.c b/drivers/spi/rk_spi.c
index 2c3d70ba7159..81785b5e949f 100644
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


