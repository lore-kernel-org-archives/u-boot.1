Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3DFC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4618607DE;
	Thu, 20 Aug 2026 15:26:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wuae--gh__Ls; Thu, 20 Aug 2026 15:26:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787239582;
	bh=f+u0018pEmJ4YI/rAkcbCI6BP8oDhdsE14GViRWxajQ=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rAaTDjiWx7LgYfP2NHWD4PGX5BM6dj4qQhWaX3fqMK9VvPuXrwO1HQWH3hOaCQzyd
	 orNf4Tt2mDP/aRnwbQmb8NSpBJfBA6xKAoyw1gtHg00HGWHce/j2pTv9jPced2Os29
	 oQYmtQ/8KOEqCRp8cZ3ZCbIDknK16XuLeQ02MQ0Vfx12RxWvAy7G0PpcR7CEB6hufQ
	 cpIAcmafQQJ7nQqkb9mmSsS6IQ1XQ4o9S+XxEzXeGx4qLROmlsZ4CrxbzQfzren81E
	 YAFWRYnF9KisYyDrKCkkpJ+dc7+OlQPcDBs8IqeOnUglm3Ol7ZdVVS3SVKTS3cfzCZ
	 txbKGMr60y0SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3BB96065F;
	Thu, 20 Aug 2026 15:26:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D0E30323
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6E1480DA8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gZVV7BPIxNVn for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:26:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.22;
 helo=mail-4322.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=JRiFIzKK
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBF3F80D9E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787239576; x=1787498776;
 bh=f+u0018pEmJ4YI/rAkcbCI6BP8oDhdsE14GViRWxajQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=JRiFIzKKbHijcJ+4VyfiNuk1C1HTefV0GvONsu4MPGikjADQO9SCume0twudSk+1R
 w9KIWHWW5iBjlJKqxj+3bB5Cm281jIrkuXJ/CpRzAmo4JKFEjGLC0neHco1SIFlEpa
 f0PzbjVIphvVpCvLrCZ1ZGGLWE9M3t1bR7Cc13Eb2nS1yIxvwgyTEK/0kkpqeobL46
 I5HWutPgBoDod4HqGPyF/Heqfh6TDaDaj9ylskDoET4mPPbWgOAUiMJ9V54tq4AIJ4
 MVJavg35wglccAP4N+oml4hH7CQSxOFERuGIqkNruBl158YH5DRx6u0Zes8ib4cGno
 PfKKg7SptXQqw==
Date: Thu, 20 Aug 2026 15:26:12 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 1/2] spi: Handle spi-{tx,
 rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX
Message-ID: <47d4692da2501e61daf9e6ad13959430d8334f85.1787238071.git.Munzzyy1@proton.me>
In-Reply-To: <cover.1787238071.git.Munzzyy1@proton.me>
References: <cover.1787238071.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 328ad20a3deb8f0394f86a0d9c7453ad0e78d427
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
test covers both rejections and the accepted case.

This comes up on devices with no MISO line at all, such as a
write-only SPI display described with spi-rx-bus-width =3D <0>.

Signed-off-by: Cole Munz <Munzzyy1@proton.me>
---
Changes in v2: added the dm_spi_xfer() validation and the sandbox
test. Rerun on this branch:

  $ ./u-boot -T -c "ut dm dm_test_spi_xfer_no_rx_tx"   failures: 0
  (spi_xfer, spi_flash, spi_find, spi_claim_bus, spi_set_wordlen
  also all failures: 0)

With the dm_spi_xfer() hunk reverted the new test fails both -EINVAL
assertions, so it does test the right thing.

checkpatch flags the #if CONFIG_IS_ENABLED(DM_SPI_FLASH) guard and the
DM_TEST-after-brace placement in the test; both copy the idiom the
existing tests in test/dm/spi.c use, so I kept them consistent.

 drivers/spi/spi-uclass.c | 16 ++++++++++++++++
 include/spi.h            |  2 ++
 test/dm/spi.c            | 41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

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
index a89ba06274fc..cb8f88713a9e 100644
--- a/test/dm/spi.c
+++ b/test/dm/spi.c
@@ -216,3 +216,44 @@ static int dm_test_spi_xfer(struct unit_test_state *ut=
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
+=09ut_assertok(spi_xfer(slave, 40, dout, din,
+=09=09=09     SPI_XFER_BEGIN | SPI_XFER_END));
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


