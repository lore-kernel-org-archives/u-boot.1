Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650ECC5B572
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 01:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACE6440891;
	Tue, 18 Aug 2026 01:15:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id do_ii4PcHDEs; Tue, 18 Aug 2026 01:15:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91A454082C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787015737;
	bh=dzyYt6bXZs787hL4IMjf848eRnuRzf6lucguESH3cH0=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cZRAbN9zVV0QFEoBXXI2ctYrt58DMy/3lZz7psXNUzPBLZqfXmK7BtExk6DzKl/F6
	 wzsAyUrR+/cbSwwDcVZZDqjHsjNCy9cfhjhCFEnn48zWtBlgZf15OGhrW37CabEK24
	 TB+Pa43+Pv0gnIb2eV7zavGSYz6fJACcefcvuGrD028KNFNqhOudVyQPsZRWtnViUE
	 8avzQ02czPhDJvBA5Hl2FkWF3myNQE+oixzavMRJtxvDl74ZLxrVr/TSDqX+p8a8bZ
	 lvug6ltezIdP4ms4glw0Vq2JNNzfFTU6gpaYK16+14zhItj2HzaMULIUsn+k1ijrfB
	 WpxyzPYfiyjzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91A454082C;
	Tue, 18 Aug 2026 01:15:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A0C8194
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 01:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFFFE606A9
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 01:15:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z5iq6Y4XwuRQ for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 01:15:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.109;
 helo=mail-106109.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DF3CF6061A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF3CF6061A
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=7lfujyosnveyrauzxrgumquaem.protonmail header.b=DGMrtdy1
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch
 [79.135.106.109])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF3CF6061A
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 01:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=7lfujyosnveyrauzxrgumquaem.protonmail; t=1787015722; x=1787274922;
 bh=dzyYt6bXZs787hL4IMjf848eRnuRzf6lucguESH3cH0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=DGMrtdy1UyI5NXbylOgC4GBAJ/bExcq2PggRBqzs4adhno52MQ8yFv923tXmHg4Ub
 6u267QYCj91ZQeoLDfoiQHKL8tdkL99Bj7bQXsm8hdSMgi7b5nciHUZVs+4XAFEWgG
 hvDwXnifPgdMqkOARWwQYgdMOXcsDVC5JeT7jgAQCvkaUDNIqHPh4OpYlTpnejSIEd
 SDYMAbPu92KmHIGzfIt9fDnCc8b2s7sjELTOCKTe0EBfxWy37nUWzCjCqYqMhM13UI
 Cd9vsb/iTmbkVVD42HjLNF8Hv4xwoB8nICghsEXSn6aYEuwnu8SW3XvWvlfLDaLmuO
 Mj7O5yYyUo4Jw==
Date: Tue, 18 Aug 2026 01:15:17 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
Subject: [PATCH] spi: Handle spi-{tx,rx}-bus-width 0 as SPI_NO_TX/SPI_NO_RX
Message-ID: <10e92a74c8a22cc2cd54f5dcccc31594016d4263.1787015208.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 401e00b6a0110d43f73566ba1e9001dcbf8e7c09
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

This comes up on devices with no MISO line at all, such as a
write-only SPI display described with spi-rx-bus-width =3D <0>.

Signed-off-by: Cole Munz <Munzzyy1@proton.me>
---
Raised as a boot-log warning on Flipper One, whose display has no MISO
line at all: that pin is reused as the end-of-frame GPIO. Reported at
flipperdevices/u-boot#33, and sent here rather than to the fork as
suggested on that issue.

Verified on sandbox at 527115ef6783, with spi-rx-bus-width =3D <0> added
to spi.bin@0 in arch/sandbox/dts/test.dts and CONFIG_LOG disabled, so
warn_non_xpl() reaches the console the way it does on the board.

Before:
 $ ./u-boot -T -c "sf probe"
 spi-rx-bus-width 0 not supported
 spi-rx-bus-width 0 not supported
 SF: Detected m25p16 with page size 256 Bytes, erase size 64 KiB, 2 MiB

After:
 $ ./u-boot -T -c "sf probe"
 SF: Detected m25p16 with page size 256 Bytes, erase size 64 KiB, 2 MiB

It warns twice in sandbox because both the pre- and post-reloc DM scans
run there; the board logs it once.

ut dm spi_flash, spi_xfer, spi_find, spi_claim_bus, spi_set_wordlen and
spi_flash_func all pass with the property in place. Nothing consumes the
new bits yet, matching d962608ce218 in Linux, where the consumers landed
later.

 drivers/spi/spi-uclass.c | 6 ++++++
 include/spi.h            | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 120565df1497..0f0d4b1384f2 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -229,6 +229,9 @@ static int spi_child_post_bind(struct udevice *dev)
 =09/* Device DUAL/QUAD mode */
 =09value =3D dev_read_u32_default(dev, "spi-tx-bus-width", 1);
 =09switch (value) {
+=09case 0:
+=09=09mode |=3D SPI_NO_TX;
+=09=09break;
 =09case 1:
 =09=09break;
 =09case 2:
@@ -247,6 +250,9 @@ static int spi_child_post_bind(struct udevice *dev)
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
--=20
2.55.0


