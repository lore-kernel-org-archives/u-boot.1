Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548E0E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 739E7801CF;
	Thu, 12 Dec 2024 14:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=rwahl@gmx.de header.b="l/imgGtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1E1801E7; Wed, 11 Dec 2024 21:51:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA59A80087
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 21:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rwahl@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733950285; x=1734555085; i=rwahl@gmx.de;
 bh=T1BGRwTVMeL7C8Y0PH58EdVx9NaW8tVT7HZuOqK2tJA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=l/imgGtPrTgwADfuAISsUtlgSm+rZKLm6Uo3ch/nowzSSCfebcj5hkyVVUEh+SKa
 GY9nsHeCh7D/2si+PX1s5d3B66P9du1LH0dONMKHQDOeGpdPT24s1TR17iaqqxiPb
 EFiNRyY+6Cv7JQA2PUyoiVmzNQFgGu3OqZbZ+dNPOTwxpvhtb5k5HkUzUIZQaC05G
 ZJyys9lAGxLRGfMzbRfuKtPoO8z3OhLugq5ljHcR3R9uNHbzD1JjpPTda46VMmtoA
 bL0WO2oCk24efuM1gBB8UTslUKIaW+23Jio4WgYwqmjEgf1oMb9Tzuwuckz5dhr8P
 Ndkho41ST46TY2EisQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.157.89]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1u3Zjq0XwJ-00bJ0E; Wed, 11
 Dec 2024 21:51:25 +0100
From: Ronald Wahl <rwahl@gmx.de>
To: u-boot@lists.denx.de
Cc: Ronald Wahl <ronald.wahl@legrand.com>, Vignesh R <vigneshr@ti.com>,
 Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH] spi: cadence-quadspi: fix potential malfunction after ~49
 days uptime
Date: Wed, 11 Dec 2024 21:51:04 +0100
Message-ID: <20241211205104.16099-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wbob3GHZZHwxccxA/K/tuSezS0/sD2Yk9oZ987qjyqfq7n2U0Ij
 3qO9BbtYNs4Ro2BMSxGPQH/XmYg2XDF9+LUSPOWtP2rRMaIV9/jK1/rUuMyrhV22JwMlHmJ
 SonTOuLJxiW6JtIKHRr6DDg13useOxF/MVcD7o3H84ld1oO4CWF5lRAoZEPbvYOheugdUED
 U9qQMUxstnZTattOU5lpQ==
UI-OutboundReport: notjunk:1;M01:P0:he70emx6pUA=;tRQb3QtbUkpylM62aVejTGPQuBs
 F/pJuHuUe0lllQmcYoJPwhQlCozDZaB5Q0Iw+vVPnVh5EYhWnfxTFQ4eJ/OcCKUPe28KJD/PT
 7rhDn1uYRk2miro30Ju/ynTt4i9/YoFTvkVxgHtrdCtt8KsiE/AaQoyNw1wp9bLXzUYsKZH/9
 UeGfVqQbA7vr+K/QYhv0BKRdINIArkHW3FWQ8ytabs2q8TuQHVD9fKmkJycgozmyEHoPKb+To
 IHYU/YmrhmLZuqYQ8euB9Kd/cTwXvHzxYcvlLUVAstMsU/3YsF2QKJxGZNOlDECxvVn0IOUpx
 Eb2FP9H0GWAWK5G849cygmkJ+REzYOGNrUaXKVUZlTLYFzkWxlZOQr4D1pWMHEBvmhCkIe43Z
 gbeIX0Dyswq6ZyXBmb1LPwbqZQqHT5hudwwkG8u4AZTeQrma5Dc4K8lpSdVz9x52XjE4HB/xX
 f91c08DE2AylpnxBVk41T9ZhnCvC3YHnGv+3nntAPnp81Xwa5bsIxOnOWoFthdaOrq8qihLZi
 YN5TJ49GURgYtz04A7jGvztMCv6jyOvp7uzhY+e70VP+GoiUgKB7rtn/n+8FAk2Cpkx4KFlf3
 BB2J4tpY+PG7qi7HvkOQCXrD83T4MgIsShQdJ4Wh1GuDNBAcCgtLV9SOATrqDXCok5QWzTvPX
 JsXCksQwpkQDiNxE9zS9i3nZO1cnNq5VTmyNIP7wgZZ8G/OMpfLd2AeHV9RCni78ym9nu/Fli
 w20+F/iZMULFHGPjqsKWT4TZJNib0yAuY93pDAQLbHNuk75ELAlzThzhXJOtL6WFeuqxeD3jp
 wkZIqfxH9TeFKTk42jv74faaEPz844jQ6nRmvxXeMsUK6Rzur82BQFIeIY5OZ80DLLnnNrgu5
 W8o/XFO+Ijw8Exuy8kYJrbJJG36m3MptraseZ7G30NpBshpXyS8A3LoLIBRh7LC43wGNlnT5k
 A7xhXFv6f1RTD5bTU2jKHJbCE7+ZWeJlTsSx7XGQhwgysAI4ukz2WFrk3waDrxLylmjj4O6d+
 d1ffYV6JOGMvOi8qLxqX6Nqnanzz9+SvOGFT9wfbgHbMiAmORvH7CIdlg83sOC0ZN5o7wV9XS
 HEq0R77EuvwZgPSL4KPTTSiGaYUuPU
X-Mailman-Approved-At: Thu, 12 Dec 2024 14:14:07 +0100
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

From: Ronald Wahl <ronald.wahl@legrand.com>

The get_timer function returns an unsigned long which may be calculated
from the ARM system counter. This counter is reset only on a cold reset.
U-boot divides this counter down to a 1000 Hz counter that will cross
the 32bit barrier after a bit more than 49 days. Assigning the value to
an unsigned int will truncate it on 64bit systems.
Passing this truncated value back to the get_timer function will return
a very large value that is certainly larger than the timeout and so will
go down the error path and besides stopping U-Boot will lead to messages
like

    "SPI: QSPI is still busy after poll for 5000 ms."

Signed-off-by: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Vignesh R <vigneshr@ti.com>
Cc: Pratyush Yadav <p.yadav@ti.com>
=2D--
 drivers/spi/cadence_qspi_apb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb=
.c
index 93ab2b5635..f2f69cf9f1 100644
=2D-- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -151,9 +151,9 @@ static int cadence_qspi_set_protocol(struct cadence_sp=
i_priv *priv,
 /* Return 1 if idle, otherwise return 0 (busy). */
 static unsigned int cadence_qspi_wait_idle(void *reg_base)
 {
-	unsigned int start, count =3D 0;
+	unsigned long start, count =3D 0;
 	/* timeout in unit of ms */
-	unsigned int timeout =3D 5000;
+	unsigned long timeout =3D 5000;

 	start =3D get_timer(0);
 	for ( ; get_timer(start) < timeout ; ) {
@@ -170,7 +170,7 @@ static unsigned int cadence_qspi_wait_idle(void *reg_b=
ase)
 	}

 	/* Timeout, still in busy mode. */
-	printf("QSPI: QSPI is still busy after poll for %d ms.\n", timeout);
+	printf("QSPI: QSPI is still busy after poll for %lu ms.\n", timeout);
 	return 0;
 }

=2D-
2.47.1

