Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDEAF3C9AD
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727B783E88;
	Tue, 24 Feb 2026 17:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T9NFgEFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C86FD83E96; Tue, 24 Feb 2026 17:13:09 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AD3282BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4c3896e32so2330007a34.0
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 08:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771949586; x=1772554386; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ETDNC2W+phuuTiNZT4dq9BKWtdR252FQeg8hTNRD/lg=;
 b=T9NFgEFCxDuEnzjcIFGEO1uPMTTHgyEpy+4uZw9B9vHEGZhZfxDzcbD4bcWjq+T8/a
 tMs1l4yAqF9gzvmO9Pz5T+/aF7R5wJHtFXRhV1A9McOHDVC4e+ktSf1UkGxHWjxHywfd
 oYa23ogUP6AmY0t2FCSVBL6YwKmTnYKaf9IV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771949586; x=1772554386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETDNC2W+phuuTiNZT4dq9BKWtdR252FQeg8hTNRD/lg=;
 b=qtRJVOUHOQkV0/VHu2DN194yC8WWnp1EqwAVXLp57yI7DYrE7favHPLC2xsWaxhAV2
 A/LdTVhihPZ2/nv5HA5bh+O8MVyifYmRARNLO2/jowYtL2+MN9txa4HhaZuEyxrzK8AJ
 XtadfHKQlioh0KesEYFWYp1qIAibNXzwTtVrBZPKLMD/QqVKuAe6WndoB4pYiRG1wV+C
 aA2I4FWCteZYE62rzuus1kcM8fu2lmtBpsyCaKncpESPCtvYci/JLLklYd/cZtprKr7O
 Q3PBzu0ZtXU0gRewkTNjtBFI725Juc0HAcF5RdP86KBI3e0rWY9pAJRvZirug5/SHi76
 PkDg==
X-Gm-Message-State: AOJu0YyN3+R8yAVn6HAKS8nvfzD4YOfznj8BQt1Lz2uaJY0aKbwSnXta
 RrCkWeiv1AZxTXAZ5Sa8iBHDT0QSzs34uOUZOW6R8K8pZmNggv4tRoMVtSWUATfR4HI=
X-Gm-Gg: AZuq6aLZWe7twGnuoqa3lMHnfnFeDAJ2u92rsRUAoVo+ibUEIfko2Sb/9wrXr16GlDt
 p56fjTtPh+akRGW9ijCztc+WTPcFJtWOLNLvJHOI2GC4OqYM6nbOD3tmCKtu/auBI6KFMNIRTAj
 cdAd9QrhHd3ee3g8DIIHBrNRkGCZR9EV59ZbEAej4OAguQQUqN+DXau27Du2hSDgGMS1HVjcm/r
 TXE4NVdr4Z9bVaJyX/hSQpGH8VQlAQReVGWluliDupa6MT9EHJTPEtC7ruC/Mcdzn6kI2yHq7rK
 fCwKqD2yCY6+vuDcH/AFVIXYdzqycHFnVj9kpPJKZulEe5s238wFbYhDQyciOhBeas3QL2WNKdb
 Ir4kcezT1RZSY8kFj/yGHPWrT9XDSxirgLMfw2AoPPOizrp8EyVdTrXeHXueTXFy35QgMxhGk/4
 9cSb8lml761R5K4vinxipCutcm/rHppDUAcbVWGrd5i8M/DRLt2a9hs2Utdt+sqzzHpyUClibrI
 Cc26yp9AdyBxFS+UmDQNX8fZR7Om5+PEPZrDxvvGPpz51qt6NI=
X-Received: by 2002:a05:6830:7181:b0:7c7:65f4:1120 with SMTP id
 46e09a7af769-7d52c2af3c4mr7624664a34.23.1771949586029; 
 Tue, 24 Feb 2026 08:13:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52ce63069sm11021882a34.0.2026.02.24.08.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:13:05 -0800 (PST)
Date: Tue, 24 Feb 2026 10:13:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Bin Meng <bmeng.cn@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Guillaume Ranquet <ranquet.guillaume@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Leo <ycliang@andestech.com>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: Re: [PATCH v2 0/9] bootm: Clean up arch-specific, pre-OS clean-up
Message-ID: <20260224161302.GX3233182@bill-the-cat>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ii0hI5AYcoZUjGDN"
Content-Disposition: inline
In-Reply-To: <20260224142553.1608883-1-simon.glass@canonical.com>
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


--Ii0hI5AYcoZUjGDN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 07:25:42AM -0700, Simon Glass wrote:

> Each arch does something slightly different before booting the OS. Some
> archs even do different things depending on the CPU type.
>=20
> It is quite hard to know what actually happens in the final milliseconds
> before the OS boot.
>=20
> This series attempts to start cleaning up U-Boot in this area.
>=20
> The basic intent is to create a new bootm_final() function which can be
> called by all archs. It provides some flags for a couple of necessary
> variations but otherwise it is generic.
>=20
> RISC-V, x86 and ARM are converted over to use this new function. For
> consistency, EFI loader is converted as well.

Please include all architectures in v3, ARM is still not shown in this
series.

> A noteable change is that EFI_LOADER now does bootstage processing
> before boot, if enabled, thus producing a report.
>=20
> There is also a patch to drop EFI_GRUB_ARM32_WORKAROUND, as discussed
> recently on the mailing list.
>=20
> Future work could take this a little further:
> - Drop board_quiesce_devices() and rely on driver model for that

Potentially, but there's non-trivial uses that don't fit in driver model
today either.

> - Similarly with udc_disconnect()

Please look at mainline code again.

> - Look at converting EFI to use the same function

You said a few lines above EFI was converted? Please make sure your
cover letter is consistent and correct in v3.

> Also, the comment for cleanup_before_linux() could use more details as
> to what it is supposed to do, to reduce the number of arch-specific
> variations. It currently does different things on differents archs and
> is mostly uncommented (apart from an ARM-specific note in a README).
> Ideally it would be commented with exactly what it should do, ideally
> at a high level so it is not just arch-specific.
>=20
> While some of these arch-specific differences are necessary, some are
> just due to the changes to code over time.

This is due to the entry requirements for Linux being architecture
specific. This is more consistent than it was 15 years ago (especially
since RISC-V looked at arm64 and copy/pasted as much as they could,
which is a good thing!) but still an inherently architecture-specific
thing, so yes, we may only end up with limited overlap.

--=20
Tom

--Ii0hI5AYcoZUjGDN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3ODQAKCRAr4qD1Cr/k
CoI5AQCuVQV8mRnxmgX3ZyaS7wBtLbCAUpWF96tFuvHFM+etIwEAigrDl0ynEuP6
FpEvfGOBJLIX60Lu4eCqwCYLQt3cegk=
=k1bt
-----END PGP SIGNATURE-----

--Ii0hI5AYcoZUjGDN--
