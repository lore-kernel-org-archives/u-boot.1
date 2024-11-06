Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323A2D59F70
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 20:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC1EC8909B;
	Wed,  6 Nov 2024 21:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="4DhtOLrf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g8NUjsWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9FA889020; Wed,  6 Nov 2024 17:34:44 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55DD891BC
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 17:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1730910881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TlQ2AeiJawAWHu1sPW0iNhnqDssmlN+lGohlLzNjKco=;
 b=4DhtOLrf421f5vG6K6UJIQOjQTx2Khz1jBZLHZcHShOH0+n0pI5jJxLV+K+tCx9BfVwOuQ
 NKHJbVdoFG0gL4f2XweS42A+HqGEPmTW6Ylb1p9zlh3wa7AMgCARmZIR2dv64LUfAagoRR
 wAF6pNaf0kB2/vT0znAzyPAnAKKAe5oXXypYWrASsisS1vsNWk3mTy/ruc8gGcWTi7wYJP
 u0Y98pR9N20s3yp+cwm8+qoNwN8OB6OP7RNA9uNJcOFPmI+Rfdrga42m37fzwd/SD3O6cj
 mci0RTY1dvJ/65lbmx0ooFyRiNB7dSFDGOLYGxn+v9Dj9JyU1AH893YSoYQ/Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1730910881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TlQ2AeiJawAWHu1sPW0iNhnqDssmlN+lGohlLzNjKco=;
 b=g8NUjsWe0qDDwyR8woJ/hL7dDSdAhGzaW1T9ETLJop2BK9+CEJ7eb7MTvuHxjXKNTsv3w1
 2CfwkKVEKkagD2Cg==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Nam Cao <namcao@linutronix.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>,
 u-boot@lists.denx.de
Subject: [PATCH 2/2] boot: extlinux: Fix unaligned buffer for reading data
 from file system
Date: Wed,  6 Nov 2024 17:34:32 +0100
Message-Id: <fc389bd029264da3ac37de28a1881cfb6fd95988.1730909884.git.namcao@linutronix.de>
In-Reply-To: <cover.1730909884.git.namcao@linutronix.de>
References: <cover.1730909884.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 06 Nov 2024 21:19:57 +0100
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

extlinux_read_bootflow() allocates a buffer to read from file system
without any alignment.

But for some block devices which transfer data via DMA, ARCH_DMA_MINALIGN
alignment is required. For example, due to misaligned buffer, the below
boot failure is observed.

=3D> boot
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
** Booting bootflow 'mmc@2194000.bootdev.part_1' with extlinux
Ignoring unknown command: =EF=BF=BDD=EF=BF=BD=EF=BF=BD=EF=BF=BDD=EF=BF=BD=
=EF=BF=BD
Boot failed (err=3D-14)

Change the alignment to default (which is ARCH_DMA_MINALIGN).

Fixes: 31aefaf89a5b ("bootstd: Add an implementation of distro boot")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Tested-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
---
 boot/bootmeth_extlinux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index ae0ad1d53e3..5424d179bf8 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -127,7 +127,7 @@ static int extlinux_read_bootflow(struct udevice *dev, =
struct bootflow *bflow)
 		return log_msg_ret("try", ret);
 	size =3D bflow->size;
=20
-	ret =3D bootmeth_alloc_file(bflow, 0x10000, 1);
+	ret =3D bootmeth_alloc_file(bflow, 0x10000, 0);
 	if (ret)
 		return log_msg_ret("read", ret);
=20
--=20
2.39.5

