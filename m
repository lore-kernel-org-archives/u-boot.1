Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702C8CDB471
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 16:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F0B2849D2;
	Tue, 23 Jun 2026 18:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gOaYkqVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F1C849E5; Tue, 23 Jun 2026 18:21:13 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71BE1849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 18:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-447a81776e9so69945fac.0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782231670; x=1782836470; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xxJ3rH94FTigwUHHrBMSI3NFnRvApth7jeuBUGQvoGs=;
 b=gOaYkqVSGFhurstz+7kRjzKMgdJQwYoDo/9p9G1kSUwVRAQwwWX/PL9SsUu4FBZFU9
 GP9YFI0fvoixCHAc1LND++1hHkNVVju8a81F7rfbAzoIyMngKT6BGM3ELiVuinr92h0x
 p2ARBASyxASdynRLnO9HRUsOBKcDRp7Mrinv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782231670; x=1782836470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xxJ3rH94FTigwUHHrBMSI3NFnRvApth7jeuBUGQvoGs=;
 b=Kf317+WhDA/6v6+KTNfbwqABkjeF+7oyG57B2gaC47Sw3CqezIQKggFqLWlwROrGDG
 NCyd8aRqIs61BWz6KttugcN1ynrnobV5uD0yT2bIXCGaF1YvjxD8Dd0+ZAz5ceF/OW70
 FoRnMmvOny3et0A+UTj5+GdDrEaEmd9Hwpjnqqwp88Kmh/rnqstYJlQJhPd5qJ06oxuR
 RAlYsMThgCNBU1Xo2RTgFQmYT/O7r77W5ycfJuq+V2ormzT8UfMFvsWmxA7QpY7yCvSd
 izk8eemx96XGjfSt8qjPQqfgJp2APK9Qy4u/G++qmlgFte5NIOOldyMKvClSKoLMmVoL
 XgHw==
X-Gm-Message-State: AOJu0YzXcSgKsFLWOnl17T4kte1FeNd9X9VD0h4+9OEvYpCMW/ODilu5
 TwKnrSWezB85xuGROQEdGFelbhs+cdDRa8QMqa13a0NynUrBecoglLpp67jNh9+zfU8=
X-Gm-Gg: AfdE7ckrfGNeARpR4CTZdjd7CjkWVixfIWJZgOeQJY+5SMO6RsposLakEn7kZ5cwBzd
 nIqMOAi3XmOFkFmUe6/WVFyYSKFJ8E26TrKtXA5x1WSTgnfaazcDDQWTv8Dytw3ZAVeqB3izPGh
 LKkvGzHJRHfSzO2u3Vu1O+dmQ/AV6fkZpJKG5T6/uayd0hE8+7J2XTHp10Kh6kiPQdm0dvy4hQ7
 buNrj5OSyZxT2b4OUbIs15Vzd4BoY9fOiGvxecyt8sw+FCrxw6fyy4RQlfH46ryveO4Wq9vNCw1
 VNLSaFVxwURZ0NYraPEABODFS3PakrqE61V78xm6vlCJsD6WmjXnDg2+C5T3ja2HR8tTatM3M5D
 y3tTmXI3Ie5SR8mt79EiYDg2N2OF3DaCUiR7M9mBPhXlTB7dbdGq1Vcs0qxWwj9stCTOgItqCd1
 nLiB+7MQSY9R/SEViELCkqs3ToylrrFyTLzbLIn8F4bDmwJa/aF8W60a5VL80JvCYOKLYnAqXmf
 fonYFPT6oD4XaHItp3P8AmSov2WGGjx74U=
X-Received: by 2002:a05:6870:3184:b0:447:2e3c:69d4 with SMTP id
 586e51a60fabf-447b511a960mr2378439fac.7.1782231669839; 
 Tue, 23 Jun 2026 09:21:09 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-245.totalplay.net.
 [187.191.8.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472ecd3b51sm8726603fac.7.2026.06.23.09.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 09:21:08 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:21:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Strydom <qstrydom0@gmail.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 james.hilliard1@gmail.com, malysagreg@gmail.com,
 tien.fong.chee@altera.com, sughosh.ganu@arm.com, philip.molloy@analog.com
Subject: Re: [PATCH] spl: pad external DTB to _image_binary_end with separate
 BSS
Message-ID: <20260623162106.GH382693@bill-the-cat>
References: <20260619105529.50815-1-qstrydom0@gmail.com>
 <20260619200419.GW382693@bill-the-cat>
 <CAF28xv_-OmrqKQz2Wqm9Cz=_oHSqSp4qtGR7_bxkmM2QFt4wRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jBc9faG3z1e9UUGT"
Content-Disposition: inline
In-Reply-To: <CAF28xv_-OmrqKQz2Wqm9Cz=_oHSqSp4qtGR7_bxkmM2QFt4wRA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--jBc9faG3z1e9UUGT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2026 at 04:07:33PM +0100, Quentin Strydom wrote:

> Thanks, that makes sense.
>=20
> Just to clarify, I reproduced and tested this with QEMU=E2=80=99s ast2600=
-evb
> machine rather than physical AST2600 hardware.
>=20
> I checked the SPL section layout and I think you are right that the better
> fix is in the AST2600 SPL linker script rather than in scripts/Makefile.x=
pl.
>=20
> With the v1 Makefile fix reverted, the mismatch was:
>=20
> sizeof(spl/u-boot-spl-nodtb.bin) =3D 0xc92c
> _image_binary_end                =3D 0xc930
>=20
> The last emitted section was __u_boot_list, ending at 0xc92c, while
> _image_binary_end was advanced to 0xc930 by the alignment associated with
> .binman_sym_table. In this build .binman_sym_table did not contribute
> emitted contents, so objcopy -O binary did not include those alignment
> bytes in spl/u-boot-spl-nodtb.bin.
>=20
> I have tested a v2 which moves the 8-byte alignment into the emitted
> __u_boot_list section. With that change:
>=20
> sizeof(spl/u-boot-spl-nodtb.bin) =3D 0xc930
> _image_binary_end                =3D 0xc930
>=20
> The appended SPL DTB starts at 0xc930, and the external-DTB build boots
> successfully under QEMU with:
>=20
> qemu-system-arm -M ast2600-evb,execute-in-place=3Don,bmc-console=3Duart5 \
>   -drive file=3Dflash.img,format=3Draw,if=3Dmtd -nographic
>=20
> I have sent v2 with the linker-script fix.

Ah, so we've just been lucky in CI then, OK. Thanks for looking more at
this!

--=20
Tom

--jBc9faG3z1e9UUGT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajqybwAKCRAr4qD1Cr/k
CtEJAQCM0saaN7B/m+yp5APLV9fDyP/Y4JXnr7ZuluX8TeS6fwEAxOCNtA9O6EIC
XyST3I9bMl+r7y/2FRJf/JuiKj4R1wI=
=M8JV
-----END PGP SIGNATURE-----

--jBc9faG3z1e9UUGT--
