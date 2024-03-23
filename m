Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62073C54E58
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B957D878AA;
	Sat, 23 Mar 2024 19:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LN8Q/iGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 418A4879DC; Sat, 23 Mar 2024 19:30:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BA9875FA
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711218622; x=1711823422; i=xypron.glpk@gmx.de;
 bh=s+gYaGX7upCS0Yg8oevUtApN5Y1p0xpypatZ22cQvlI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=LN8Q/iGln1qXwJXAgmEcoyKtFgdtgi1s1Vetsi/16wwUsiFfUgPA7k9ADi6sDoey
 CLvSNmcercb3VS/9nhxUhtmCllpVQhParkYgYAVVulsLlfS3E7TxPA9zV+F5WQ4ZN
 /1AFYoVIwG/o7vIjel8WXTaekBZoIzLMQ31v0SP7dR/gF0dnYrSAXaS3g4LLE0vMo
 ydp1lCJXhfAfjsA2ofsRrly3HmOwduTdnydW1YPE44IDqACa40n6U+dK0c6rOQcXh
 WnuteQVDkFc/ziKYnWn5IJb1hmcUa9JdrjOo3YlkRzjW93PqGJHxa3cBDT1Geenkm
 +H6KDsLQoywh8oE8iQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([176.1.138.104]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKu0-1rLauk0Nnk-00SjLf; Sat, 23
 Mar 2024 19:30:22 +0100
Date: Sat, 23 Mar 2024 19:30:20 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH u-boot-mvebu v2 16/18] cmd: rng: Print "Abort" on -EINTR
User-Agent: K-9 Mail for Android
In-Reply-To: <20240323180711.5498-17-kabel@kernel.org>
References: <20240323180711.5498-1-kabel@kernel.org>
 <20240323180711.5498-17-kabel@kernel.org>
Message-ID: <6DA3EF0E-5083-4A27-B20A-BDE297C74687@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0A6PHwF3FGpPhmJY0kNyHUwJ4mQ8HjMlCicBkcfFMvK7VZk4u3c
 1DivPf4Qt2S7mkip4o0rAwhjHdCroZfTfcdO68+n8QjnxCFzxM2NmXhF3GUf0refaE8f2Xc
 DkNUqbPoTlUsfdhTSsvkxADt+nR6HaWn21lJOAeWCcad7Z+Aj+yaL14Ok6iCqR9xFmrqoYA
 T5rnQwu6Z9LEB1MfZoQSQ==
UI-OutboundReport: notjunk:1;M01:P0:dKS9FcmL22M=;g5IKw6C5CAXa2qps5ECgV/VypM4
 1NQdxZu5JwOXvhqxoFBRR09VwEgVBIqnUggFzuUQwRt5jElNHnukriMH7HF+sZzc67KUBuWWx
 quLxFidKsswetQyxqMXaNOO3b//Vf0cHvx/S7Pw6+5UHfRQRbXyb6LBBrr+f8CwkYdTic/+e6
 L7zptOO0Z14cm9kwvMvACsuLJEzEQgvjcYWVuJwsKXU7QgECBgAEZ7BItAFXHb0YcxhczBuiS
 +ZOJ8FuY2GK9bDsF0L1UhDWpnZuwPsl6pjrD6z01byqLlzrJ22WoaEuN/EARYf1vedlSG8tvh
 PET6JQM0GPltEp2h8OzJOIc7hAJAgxhgmr9QowSOOc5M1dyI3kLnTJ0qOs+WETbsFtKGurry3
 rEKIQIA1C3aVorf+O05kqzZygUxtdmu2aTAF2DpgJqPtfoI8J73/nQdy9JnvIQGA8xDFRYK+5
 zH/vbuMNAth47A1EJfNtIyA7qwv6mgDbSX2bHiJhkwXycJSRqn8a1VUNaVhza6ez2bRjAgI46
 Otv52lSFQr2QTyZ3CYvRcjkyWkMfGDpi4R+EHt3ZSGaRjOWBXKfxFj+BRN0RVWsIJAD989Vfr
 yNshtiNXy/hufqfji9Xixj/GblnEvF0XOasBoE3AyNnU2d1ERgDpvbz1FRgOGM7x4j2QjXXkw
 0zGoM7ELui3MnRxwlDdRDtwB6IE48jNGjl5RqvuB2tB4lRhsrrr4yHr1L/ozT+A9DdYEDywSq
 ugQnJPZb3oBWhK5QYHp4L1sSqEvhw7o1R+8WKOWbxW/nyRJfA65xh6EtgYIW2a8aijJiDfBUZ
 i45e0PN1AqBj6b9g+mSZp/Emml8z0HF2SMGWp3RTkrvE0=
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



Am 23=2E M=C3=A4rz 2024 19:07:09 MEZ schrieb "Marek Beh=C3=BAn" <kabel@ker=
nel=2Eorg>:
>In the rng command, print
>  Abort
>instead of
>  Reading RNG failed
>if the error number is -EINTR=2E


It is unclear what would be the user benefit=2E

'Abort' relates to a user pressing CTRL-C?

Best regards

Heinrich


>
>Signed-off-by: Marek Beh=C3=BAn <kabel@kernel=2Eorg>
>---
> cmd/rng=2Ec | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/cmd/rng=2Ec b/cmd/rng=2Ec
>index 52f722c7af=2E=2E48ba67061b 100644
>--- a/cmd/rng=2Ec
>+++ b/cmd/rng=2Ec
>@@ -17,7 +17,7 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int =
argc, char *const argv[])
> 	u8 buf[64];
> 	int devnum;
> 	struct udevice *dev;
>-	int ret =3D CMD_RET_SUCCESS;
>+	int ret =3D CMD_RET_SUCCESS, err;
>=20
> 	switch (argc) {
> 	case 1:
>@@ -46,8 +46,9 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int =
argc, char *const argv[])
>=20
> 	n =3D min(n, sizeof(buf));
>=20
>-	if (dm_rng_read(dev, buf, n)) {
>-		printf("Reading RNG failed\n");
>+	err =3D dm_rng_read(dev, buf, n);
>+	if (err) {
>+		puts(err =3D=3D -EINTR ? "Abort\n" : "Reading RNG failed\n");
> 		ret =3D CMD_RET_FAILURE;
> 	} else {
> 		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buf, n);
