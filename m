Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B86C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 11:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A3F782AC4;
	Mon, 14 Jul 2025 13:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="PzIGVhuE";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="BxG4okdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B62E82B07; Mon, 14 Jul 2025 13:56:24 +0200 (CEST)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B1C805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 13:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=2CtFxTYmZwaS8oxzWpyU2YwmRqCY/DLbIuJ/rhqlpV0=;
 b=PzIGVhuEp2CaLPWDBVlG6Wc+wMQmoQirgc0d5VY4GUS42ckpqIPQCOpmQ7GyhjxqyUja4u1fvG6/g
 7lJIWw9Hyw2FXcJVBZeoKQ0jDiE4Fnp6A2loXvqSzaepa8DKhTKjNICllp/tFZoXieHiCWmnMSoWIQ
 dxb/gce2xwJ3NFng=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=2CtFxTYmZwaS8oxzWpyU2YwmRqCY/DLbIuJ/rhqlpV0=;
 b=BxG4okdyf4tgpPkOhCJ0srWkEQGag3SS8fNGR2MK/P870z2U5a1wPk2cb6Cwe9rnrWJDKmwx39GfX
 xvAZgZNnTswGLKe3heyo1oPgnz6iV3u11cSuWTdkprtJsebc3rub5IDU+2QZKpVV7/NzhZ3RNFDz07
 CPlfZ9E7JZy492JpQOh6zED3LAKbM3JcNew6mB7sQQhBcbOuLsV+eJaUsVQfiY/aEfWKMGv5c5q3Bh
 KYEKSSW0rq3MEnPsyHigUDjV4TpwfpiYvOKak0TsEwBDHDrsWNx/hVQ1YAFnap56CrPQmWghkYHLhg
 qlAFj6DItUOJfNoWzrtcMpmGcoKaLWA==
X-Originating-IP: 20.86.212.242
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 8e4731ac-60a9-11f0-be19-eb1d40c36193
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 8e4731ac-60a9-11f0-be19-eb1d40c36193:5
CFBL-Address: prvs=02909799d7=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown
 [20.86.212.242]) by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 8e4731ac-60a9-11f0-be19-eb1d40c36193;
 Mon, 14 Jul 2025 11:56:20 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with SMTP id
 F13D9805264; Mon, 14 Jul 2025 11:56:19 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net
 [172.31.41.201])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id C2BCB60B7D47;
 Mon, 14 Jul 2025 13:56:19 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH] cmd: i2c: fix build when CFG_SYS_I2C_NOPROBES defined with
 DM_I2C
Date: Mon, 14 Jul 2025 13:56:08 +0200
Message-ID: <20250714115608.2457884-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

When DM_I2C is enabled and CFG_SYS_I2C_NOPROBES is defined, the
building is broken due to already existing 'bus' local variable.
Rename udevice 'bus' to 'cur_bus' to fix this.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 cmd/i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/i2c.c b/cmd/i2c.c
index 7246c4fa3e7..f0aae93073f 100644
--- a/cmd/i2c.c
+++ b/cmd/i2c.c
@@ -917,9 +917,9 @@ static int do_i2c_probe(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
 #endif	/* NOPROBES */
 	int ret;
 #if CONFIG_IS_ENABLED(DM_I2C)
-	struct udevice *bus, *dev;
+	struct udevice *cur_bus, *dev;
=20
-	if (i2c_get_cur_bus(&bus))
+	if (i2c_get_cur_bus(&cur_bus))
 		return CMD_RET_FAILURE;
 #endif
=20
@@ -943,7 +943,7 @@ static int do_i2c_probe(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
 			continue;
 #endif
 #if CONFIG_IS_ENABLED(DM_I2C)
-		ret =3D dm_i2c_probe(bus, j, 0, &dev);
+		ret =3D dm_i2c_probe(cur_bus, j, 0, &dev);
 #else
 		ret =3D i2c_probe(j);
 #endif
--=20
2.49.0

