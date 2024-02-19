Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE0AC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 16:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B4087F4F;
	Mon, 19 Feb 2024 17:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="F0knDODp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA7D87F3F; Mon, 19 Feb 2024 17:33:11 +0100 (CET)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCC487DE9
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 17:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3sILTZQYKBjkWVmiVnbjjbgZ.Xjhp-Wjjogdnon.YZis.YZ@flex--barnas.bounces.google.com
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dc6b269686aso6776915276.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 08:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708360368; x=1708965168; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=+Io/XkVO0aE6tyFm8S2xv8fYf7/3UUb5MxQd7q2MHD4=;
 b=F0knDODpyhYS8gNQYMGx+3EuO27ccgxR3L4FToXJbeB878Kyz2vSH17nsoT0M3w9cK
 SpWWuFb+rdubV0z9NB3byVhfmkIthMr6q+kYxeUUXeC7CY2lCeCWYxNxHuE7AwU/8ezc
 9dGxrxsBI2K9xuGB0+aub06frJMv+nFHEseN4arha2ondtof7dAR7MT4T50XqkNyJBka
 uNpAaVHJLH/QSIU4TqQ4CQKTZTV9dkqzEpj0RPq62ErXusXJHK1TfNRD5ZuxayEWe3oa
 0q9uzlQTv+RTAX6nkaMlK3mHtbH20THh8Z6eZ0cQIOd7Rz7JQ5WR14A/qTGdocc/uZMO
 C15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360368; x=1708965168;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+Io/XkVO0aE6tyFm8S2xv8fYf7/3UUb5MxQd7q2MHD4=;
 b=FiANYTgFWbJj53ATNVGOD5CwYGRgQU1PSm1lUYAEZJKzuU77NOk384O6AFARFBJcis
 oHwR0kCX4at3/0w8wFu/DX1O370RIZhS/H5lkQUIBc5O2f9v/sLvboZ1aevDtq/I2M6b
 ngi6UZnek3HoRhrv1Tmg60804gEfn2Wy7OYBYS1JykGGvSRWhRkG2ka+ypQeNTarRBUE
 6GKUENzDeEcKmOgTZAQ0IXu2TfjB3jFo/OZjAN4ukTR3Im5p3qde71D+d2DimLoVzZyE
 Unf81UEgjGiMm9MN8UXrfhl7QtR2s+50+6wNi44wwWRmPtq47Y/ftaK97HmHsuLp9Fe3
 MWfg==
X-Gm-Message-State: AOJu0Yxpr6JXtEfr1Tu5aU65hKNxAF+GC/tns/r7KzNXx4UCP0pe56gq
 lA9lPl2VOWk6ILDfDhqXlIsW2g8QRf5Tt7Yui3d5BjG2d034ELXoxaV7HCvbb0gZVhbWF0gAwG9
 TjTGtQKJXplsOOM/SyR7taerFW+ienaUD4IHkr6aj+LJ/G2uVPDYdZrKOSs16Ma0IqAKiz+2eL3
 MVdPrX/uRz7u68/gz5PBU+e2lWnuW6jw==
X-Google-Smtp-Source: AGHT+IGHTn9Vsf53EhS0k08RNXBinFE+r34EZUnAIJIwQnhcX/n78R6sFoc+BgQGUu3E9YM9cYTMirBzfSY=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with SMTP id
 w1-20020a056902100100b00dcc79abe522mr515142ybt.11.1708360368073; Mon, 19 Feb
 2024 08:32:48 -0800 (PST)
Date: Mon, 19 Feb 2024 16:32:04 +0000
In-Reply-To: <20240219163213.855667-1-barnas@google.com>
Mime-Version: 1.0
References: <20240219163213.855667-1-barnas@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219163213.855667-4-barnas@google.com>
Subject: [PATCH 3/3] misc: atsha204a: fix wakeup function
From: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>
To: u-boot@lists.denx.de
Cc: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 19 Feb 2024 17:35:44 +0100
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

The ATSHA204A chip requires SDA line to go low for at least 60us to
wake up the chip. Previous implementation did not meet this requirement
due to the NAK received on bus and not sending the zeroes.
The function to ignore the NAK and send bytes regardless is not
supported in the u-boot making it impossible to wake up the chip
this way.
Instead, the bus speed, if needed, is set to lowest value and the
message is sent to the address 0x0. This way, the address of zero
makes the SDA line go low for about 80us, meeting the required time
to wake up the chip. The zero length packet is not sent by the i2c,
so the one byte is sent to the transfer function, but only the address
is sent anyway.
After sending the zero address, the bus speed is restored to the
previous value if it was slowed down to wake up the chip.

Signed-off-by: Micha=C5=82 Barna=C5=9B <barnas@google.com>
---

 drivers/misc/atsha204a-i2c.c | 49 ++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/atsha204a-i2c.c b/drivers/misc/atsha204a-i2c.c
index 29daefb2a5..707daa90bd 100644
--- a/drivers/misc/atsha204a-i2c.c
+++ b/drivers/misc/atsha204a-i2c.c
@@ -21,7 +21,6 @@
 #include <linux/bitrev.h>
 #include <u-boot/crc.h>
=20
-#define ATSHA204A_TWLO_US		60
 #define ATSHA204A_TWHI_US		2500
 #define ATSHA204A_TRANSACTION_TIMEOUT	100000
 #define ATSHA204A_TRANSACTION_RETRY	5
@@ -34,6 +33,48 @@ static inline u16 atsha204a_crc16(const u8 *buffer, size=
_t len)
 	return bitrev16(crc16(0, buffer, len));
 }
=20
+static int atsha204a_ping_bus(struct udevice *dev)
+{
+	struct udevice *bus =3D dev_get_parent(dev);
+	struct i2c_msg msg;
+	int speed;
+	int res;
+	u8 val =3D 0;
+
+	speed =3D dm_i2c_get_bus_speed(bus);
+	if (speed !=3D I2C_SPEED_STANDARD_RATE) {
+		int rv;
+
+		rv =3D dm_i2c_set_bus_speed(bus, I2C_SPEED_STANDARD_RATE);
+		if (rv)
+			debug("Couldn't change the I2C bus speed\n");
+	}
+
+	/*
+	 * The I2C drivers don't support sending messages when NAK is received.
+	 * This chip requires wake up low signal on SDA for >=3D 60us.
+	 * To achieve this, we slow the bus to 100kHz and send an empty
+	 * message to address 0. This will hold the SDA line low for the
+	 * required time to wake up the chip.
+	 */
+	msg.addr =3D 0;
+	msg.flags =3D I2C_M_STOP;
+	msg.len =3D sizeof(val);
+	msg.buf =3D &val;
+
+	res =3D dm_i2c_xfer(dev, &msg, 1);
+
+	if (speed !=3D I2C_SPEED_STANDARD_RATE) {
+		int rv;
+
+		rv =3D dm_i2c_set_bus_speed(bus, speed);
+		if (rv)
+			debug("Couldn't restore the I2C bus speed\n");
+	}
+
+	return res;
+}
+
 static int atsha204a_send(struct udevice *dev, const u8 *buf, u8 len)
 {
 	fdt_addr_t *priv =3D dev_get_priv(dev);
@@ -94,7 +135,6 @@ static int atsha204a_recv_resp(struct udevice *dev,
=20
 int atsha204a_wakeup(struct udevice *dev)
 {
-	u8 req[4];
 	struct atsha204a_resp resp;
 	int res;
=20
@@ -105,10 +145,9 @@ int atsha204a_wakeup(struct udevice *dev)
 	 * when the device is idle, asleep or during waking up.
 	 * Don't check for error when waking up the device.
 	 */
-	memset(req, 0, 4);
-	atsha204a_send(dev, req, 4);
+	atsha204a_ping_bus(dev);
=20
-	udelay(ATSHA204A_TWLO_US + ATSHA204A_TWHI_US);
+	udelay(ATSHA204A_TWHI_US);
=20
 	res =3D atsha204a_recv_resp(dev, &resp);
 	if (res) {
--=20
2.44.0.rc0.258.g7320e95886-goog

