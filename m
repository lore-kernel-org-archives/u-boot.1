Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D9BCA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 08:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E064480FA1;
	Wed, 20 Aug 2025 10:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="EDyUB7pr";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="FP0oijWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD9B82B07; Wed, 20 Aug 2025 10:18:29 +0200 (CEST)
Received: from out-ip0051.fra.mailhop.org (out-ip0051.fra.mailhop.org
 [18.193.30.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E80F8006D
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 10:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=kyezR6wqyX7SQGYVlT9mh26tXX6CW1XvOPJe5+F+yJE=;
 b=EDyUB7pry5BTrgPmuT/10pUzzWgCOWDbMp02rwrNWXBcxC0AKsb042uawxG8SZ1DT1q8EBxI8U+k0
 VyrbDVJOzsQ7j5UVBMD7XkQ7t8lKbk25XYt+p1tGBsqg7//6ia1mijsIXeIN7vQgf8leHItAWV8wnH
 0cZCZSILo866QVFc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=kyezR6wqyX7SQGYVlT9mh26tXX6CW1XvOPJe5+F+yJE=;
 b=FP0oijWZuTbiDzYeLz8uNZlGEdaAFnW/4UJbxpTOgVxUlOfJVB8c2/YeCIIiHHN4jIepC01se7NDM
 5HaZ/M2oeYzLBQde7bcWaCmPyNcwxwsrVQVfV0ncqR9EcFY+oZTZkbFQzfO1y6dmIOSBR2sbh++HHQ
 FZmsru9u38ZFPCqIMd9ZCGwULd8eCb1An9AmKMNJurAlJKNioSjs+zAtrlQFlvZ4PwPHt0UCnVcIIB
 pIc3+KQku57rA8SPyEaJzVPDF02UiYzvnp8ABKMMRdup5SfUEOiAGO2PWtveORLKegRX11Ml8USQEa
 8aRb5+E/tEduJU1hr4dJcVbHf29rKqg==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 3d0dbbbb-7d9e-11f0-b6f4-878ee10b8a33
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 3d0dbbbb-7d9e-11f0-b6f4-878ee10b8a33:5
CFBL-Address: prvs=032799ccf3=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000534.corp.hitachi-powergrids.com (unknown
 [20.62.140.138]) by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 3d0dbbbb-7d9e-11f0-b6f4-878ee10b8a33;
 Wed, 20 Aug 2025 08:18:24 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000534.corp.hitachi-powergrids.com (Postfix) with SMTP id
 4C1C5402505; Wed, 20 Aug 2025 08:18:22 +0000 (UTC)
Received: from chbrn3-p-dev026.keymile.net (chbrn3-p-dev026.keymile.net
 [172.31.41.203])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id 7AC9560B7D47;
 Wed, 20 Aug 2025 10:18:18 +0200 (CEST)
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: vladimir.oltean@nxp.com, trini@konsulko.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: [PATCH] fsl_dspi: set scaler values for CS-SCK and SCK-CS delays
Date: Wed, 20 Aug 2025 10:17:19 +0200
Message-ID: <20250820081719.2351982-1-tomas.alvarez-vanoli@hitachienergy.com>
X-Mailer: git-send-email 2.43.0
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

These values were calculated but not set.
They are required for the calculation of the delays, as stated in the
"QorIQ LS1043A Reference Manual, Rev. 6, 07/2020" page 2172.

The delays are calculated as (1/freq)*PCSSCK*CSSCK and
(1/freq)*PASC*ASC.

Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.c=
om>
---
 drivers/spi/fsl_dspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
index 545561ad116..412993ad377 100644
--- a/drivers/spi/fsl_dspi.c
+++ b/drivers/spi/fsl_dspi.c
@@ -473,7 +473,9 @@ static int fsl_dspi_child_pre_probe(struct udevice *d=
ev)
=20
 	priv->ctar_val[slave_plat->cs[0]] =3D DSPI_CTAR_DEFAULT_VALUE |
 					 DSPI_CTAR_PCSSCK(pcssck) |
-					 DSPI_CTAR_PASC(pasc);
+					 DSPI_CTAR_CSSCK(cssck) |
+					 DSPI_CTAR_PASC(pasc) |
+					 DSPI_CTAR_ASC(asc);
=20
 	debug("DSPI pre_probe slave device on CS %u, max_hz %u, mode 0x%x.\n",
 	      slave_plat->cs[0], slave_plat->max_hz, slave_plat->mode);
--=20
2.43.0

