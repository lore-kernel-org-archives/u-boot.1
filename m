Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD257C5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 11:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8150380F64;
	Fri, 21 Aug 2026 11:55:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3zEN76x25LF0; Fri, 21 Aug 2026 11:55:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787313315;
	bh=4nUpgEaqeehDzsY00SVFICZBLcg2VDxXHRvwyyHHQ0E=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tMeF0ffwwVAQ5r0SaRTMbz5Gpm/rw5OnNRKlqNDwqy5QOcbFekkSKjn2lsMMMYr6l
	 1UfP98tHc/e7ZKD+k5QaRikTkaV9IYNh8OXRktJClzOBYyFdzgdwY5jHjy38ttuDVD
	 S3B0FJcz8dUxlTlLEFdWBu3EnThj7nQW8bjyQ3gLbX0tmi0De5I1cQ16dq/FhuBNLh
	 H03A4dJRDeKpMf4aMK0afN9vSAM1vIK7fBjhFoK9+b3ULK7CU/mUITLQl/qZn2P+DJ
	 2XksKX052tMrlrhYFMA3eOeRPjQ5BkJT0opnjFdUZRnrilHQ2gW2QpuMY9XMpRArip
	 7xfYtb/VgUwmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AFFD80F7C;
	Fri, 21 Aug 2026 11:55:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6885B334
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 11:55:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4ED7280F7E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 11:55:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZO0IIrJR994 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 11:55:12 +0000 (UTC)
X-Greylist: delayed 73729 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 21 Aug 2026 11:55:12 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=HpXs4rrx
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.17;
 helo=mail-24417.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch
 [109.224.244.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8274E80F7C
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 11:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787313310; x=1787572510;
 bh=4nUpgEaqeehDzsY00SVFICZBLcg2VDxXHRvwyyHHQ0E=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=HpXs4rrx6VPpzFl9PSMrTSiE4hgKFP1JR+VmOTBzAsDkx6OGSp0tx6m77yWhBQAxA
 HB98O/uFEKizlaxrzpneYMcgrI5k3J4amYxmfRlzZCQkXtjTj05vH63zBH+OkimEU8
 17mcS2SpvVEhMyEz+55kYOFjtgJVfwzORijWY2joO5eiFvXXo0Mz2VQBfozKB2u+8K
 cwqeS3KSj10vf/kJShlXpOwcRTtrrec7pQqtOsQSg3hZ8fH4seu8CZ0Ez89TiRbe8b
 KeqNwupZB4dkrjFhpPAw1EgA0RIP1T98XBM8LhTLE0fvV8YcPwAPx++fFoTN+kVKiV
 KmazbPO9UJwhQ==
Date: Fri, 21 Aug 2026 11:55:06 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v4 2/2] spi: rockchip: skip the unused FIFO direction on a
 one-wire device
Message-ID: <3cf8dc75d461caf6076c35275021bbcdc0943de1.1787309754.git.Munzzyy1@proton.me>
In-Reply-To: <cover.1787309754.git.Munzzyy1@proton.me>
References: <cover.1787309754.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 74033812ba15dc2e86e69b38c17a5e87e4f56f9d
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
Changes in v4: comment rewords only, per the thread with Quentin. No
code change; compile check rerun, exit 0.

 drivers/spi/rk_spi.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/rk_spi.c b/drivers/spi/rk_spi.c
index 2c3d70ba7159..54befd54b099 100644
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
@@ -472,7 +486,11 @@ static int rockchip_spi_xfer(struct udevice *dev, unsi=
gned int bitlen,
 =09=09writel(todo - 1, &regs->ctrlr1);
 =09=09rkspi_enable_chip(regs, true);
=20
-=09=09toread =3D todo;
+=09=09/*
+=09=09 * When the RX wire is not routed, the RX FIFO never fills,
+=09=09 * so waiting on it would hang.
+=09=09 */
+=09=09toread =3D (priv->mode & SPI_NO_RX) ? 0 : todo;
 =09=09/* Only write if we have something to write */
 =09=09towrite =3D out ? todo : 0;
 =09=09while (toread || towrite) {
@@ -492,9 +510,10 @@ static int rockchip_spi_xfer(struct udevice *dev, unsi=
gned int bitlen,
 =09=09}
=20
 =09=09/*
-=09=09 * In case that there's a transmit-component, we need to wait
-=09=09 * until the control goes idle before we can disable the SPI
-=09=09 * control logic (as this will implicitly flush the FIFOs).
+=09=09 * With a transmit component the TX FIFO can still hold data
+=09=09 * that has not been shifted onto the wire. Wait until the
+=09=09 * controller goes idle before disabling it, as disabling
+=09=09 * clears the FIFOs.
 =09=09 */
 =09=09if (out) {
 =09=09=09ret =3D rkspi_wait_till_not_busy(regs);
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


