Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DFAC5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 11:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 679454099D;
	Fri, 21 Aug 2026 11:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1JuyiRo2JCiw; Fri, 21 Aug 2026 11:55:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787313316;
	bh=MUMM2XgU4JiddEZXs5pSX69IlmpmCiezwnHmFWfs58A=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vuGRDr1/fyWDokY9rKPRUJBfPdElCPpa6C92ObDAt8GHRwqVqzrqBlmmhdBfGEtKO
	 TGDyq/UnaMHg7CLRkRwqWeIF/+e7dfGBHMBXku/3QXk2XHdEeImTDvfFe+RVKssCYy
	 f1XyE2GHQcSa7uYoNP5fgxrCqu4dbjfbUKUzW2DF/8IprZvDWub7SLTXZIJxHmATcX
	 lXf8J+WfSG5o6djf5EZu94btMLLKcCsmhLTKFVfPEYGEaRfe4F9CD4bdzKWcBHIDYD
	 2/WkT3muyE3TrBbCYhi49GVRp3gImq0JaKDkhCbjFSvfzAXL9JEutAcomfiTAXG8xF
	 rDzuez0HdNtWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8999D40996;
	Fri, 21 Aug 2026 11:55:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9319B334
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 11:55:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90F1D80F7C
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 11:55:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IMa0jWffI3Wj for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 11:55:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.22;
 helo=mail-4322.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=VCq8NR3A
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65DB480F64
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787313308; x=1787572508;
 bh=MUMM2XgU4JiddEZXs5pSX69IlmpmCiezwnHmFWfs58A=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=VCq8NR3AM55QhLbMv4pu0NGDSv5WWD1Cg7APKIDggfhEg1I8A2cQ/HNAG8MyhRTRx
 iWRmiFewC3tSLmrIz45gYdWQhq/MKVzE4JFRrOIrKOb3YgMO5Fx1O6/pznGZcVF/vJ
 9QUQotIXU16IJ8l2DNBr70PlUzhYzHNckXqtraHp3/kFhZdd42ns6uMnx/b3vmQ4BB
 +VUgqGCCYvvXRKeBflvroBtmb28WCI8XaGdxPudmgr8KGp+MEJzW/Zt7gANkDMZY1s
 wJKcZA7Po0MGXsubHSmaBkLeLc797MPbSxOtlcqTQdK5oxPKn0HOruDemIHsPhioCa
 3Z8ZQCreSKZJQ==
Date: Fri, 21 Aug 2026 11:55:02 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v4 1/2] spi: Handle spi-{tx,
 rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX
Message-ID: <ae6a85d6f985b63c8f5a3fe8deeab89d79757b14.1787309754.git.Munzzyy1@proton.me>
In-Reply-To: <cover.1787309754.git.Munzzyy1@proton.me>
References: <cover.1787309754.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: fe8b298f3f2a0ba4cb1b83b0acc727b39e1dbd82
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

The spi-peripheral-props binding shipped in dts/upstream allows a bus
width of 0, meaning no RX or TX is possible on this device. The
switches in spi_slave_of_to_plat() only handle 1/2/4/8, so a width of
0 falls through to the default case and warns "spi-rx-bus-width 0 not
supported" on every boot, even though the devicetree is valid per the
binding. The fact that the wire is missing is then dropped from
plat->mode.

Map 0 to new SPI_NO_TX/SPI_NO_RX mode bits, as Linux has done since
v5.12 ("spi: Add SPI_NO_TX/RX support", mainline d962608ce218).
Bits 16 and 17 are the first free mode bits.

Mapping the bits is not enough on its own, as Quentin pointed out:
nothing would stop a caller from asking for a transfer in a direction
that has no wire, and every controller driver would need its own
guard. Validate centrally in dm_spi_xfer() instead, matching Linux's
__spi_validate(): a din on a SPI_NO_RX device or a dout on a SPI_NO_TX
device fails with -EINVAL before it reaches the driver. A new sandbox
test covers both rejections.

This comes up on devices with no MISO line at all, such as a
write-only SPI display described with spi-rx-bus-width =3D <0>.

Signed-off-by: Cole Munz <Munzzyy1@proton.me>
Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v4: none.

 drivers/spi/spi-uclass.c | 16 ++++++++++++++++
 include/spi.h            |  2 ++
 test/dm/spi.c            | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 120565df1497..dd1843ffac19 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -105,6 +105,7 @@ int dm_spi_set_wordlen(struct udevice *dev, unsigned in=
t wordlen)
 int dm_spi_xfer(struct udevice *dev, unsigned int bitlen,
 =09=09const void *dout, void *din, unsigned long flags)
 {
+=09struct dm_spi_slave_plat *slave_plat =3D dev_get_parent_plat(dev);
 =09struct udevice *bus =3D dev->parent;
 =09struct dm_spi_ops *ops =3D spi_get_ops(bus);
=20
@@ -113,6 +114,15 @@ int dm_spi_xfer(struct udevice *dev, unsigned int bitl=
en,
 =09if (!ops->xfer)
 =09=09return -ENOSYS;
=20
+=09/*
+=09 * A device with no wire in one direction cannot transfer in it,
+=09 * so reject the request here rather than in every driver.
+=09 */
+=09if (din && (slave_plat->mode & SPI_NO_RX))
+=09=09return -EINVAL;
+=09if (dout && (slave_plat->mode & SPI_NO_TX))
+=09=09return -EINVAL;
+
 =09return ops->xfer(dev, bitlen, dout, din, flags);
 }
=20
@@ -229,6 +239,9 @@ static int spi_child_post_bind(struct udevice *dev)
 =09/* Device DUAL/QUAD mode */
 =09value =3D dev_read_u32_default(dev, "spi-tx-bus-width", 1);
 =09switch (value) {
+=09case 0:
+=09=09mode |=3D SPI_NO_TX;
+=09=09break;
 =09case 1:
 =09=09break;
 =09case 2:
@@ -247,6 +260,9 @@ static int spi_child_post_bind(struct udevice *dev)
=20
 =09value =3D dev_read_u32_default(dev, "spi-rx-bus-width", 1);
 =09switch (value) {
+=09case 0:
+=09=09mode |=3D SPI_NO_RX;
+=09=09break;
 =09case 1:
 =09=09break;
 =09case 2:
diff --git a/include/spi.h b/include/spi.h
index 97096a775262..f477763bdc60 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -34,6 +34,8 @@ struct spinand_info;
 #define SPI_RX_QUAD=09BIT(13)=09=09=09/* receive with 4 wires */
 #define SPI_TX_OCTAL=09BIT(14)=09=09=09/* transmit with 8 wires */
 #define SPI_RX_OCTAL=09BIT(15)=09=09=09/* receive with 8 wires */
+#define SPI_NO_TX=09BIT(16)=09=09=09/* no transmit wire */
+#define SPI_NO_RX=09BIT(17)=09=09=09/* no receive wire */
=20
 /* Header byte that marks the start of the message */
 #define SPI_PREAMBLE_END_BYTE=090xec
diff --git a/test/dm/spi.c b/test/dm/spi.c
index a89ba06274fc..a0da12ab6bc0 100644
--- a/test/dm/spi.c
+++ b/test/dm/spi.c
@@ -216,3 +216,42 @@ static int dm_test_spi_xfer(struct unit_test_state *ut=
s)
 =09return 0;
 }
 DM_TEST(dm_test_spi_xfer, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* Test that a transfer is rejected when the device has no wire for it */
+static int dm_test_spi_xfer_no_rx_tx(struct unit_test_state *uts)
+{
+=09struct dm_spi_slave_plat *plat;
+=09struct spi_slave *slave;
+=09struct udevice *bus;
+=09const int busnum =3D 0, cs =3D 0;
+=09const char dout[5] =3D {0x9f};
+=09unsigned char din[5];
+=09uint saved_mode;
+
+=09ut_assertok(spi_get_bus_and_cs(busnum, cs, &bus, &slave));
+=09ut_assertok(spi_claim_bus(slave));
+=09plat =3D dev_get_parent_plat(slave->dev);
+=09saved_mode =3D plat->mode;
+
+=09plat->mode |=3D SPI_NO_RX;
+=09ut_asserteq(-EINVAL, spi_xfer(slave, 40, dout, din,
+=09=09=09=09      SPI_XFER_BEGIN | SPI_XFER_END));
+
+=09plat->mode =3D saved_mode | SPI_NO_TX;
+=09ut_asserteq(-EINVAL, spi_xfer(slave, 40, dout, din,
+=09=09=09=09      SPI_XFER_BEGIN | SPI_XFER_END));
+
+=09plat->mode =3D saved_mode;
+=09spi_release_bus(slave);
+
+=09/*
+=09 * Since we are about to destroy all devices, we must tell sandbox
+=09 * to forget the emulation device
+=09 */
+#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
+=09sandbox_sf_unbind_emul(state_get_current(), busnum, cs);
+#endif
+
+=09return 0;
+}
+DM_TEST(dm_test_spi_xfer_no_rx_tx, UTF_SCAN_PDATA | UTF_SCAN_FDT);
--=20
2.55.0


