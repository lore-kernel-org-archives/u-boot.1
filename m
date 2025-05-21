Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC163C54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 19:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E67EE82E26;
	Wed, 21 May 2025 21:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gHYyvjtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E0A82E28; Wed, 21 May 2025 21:03:54 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8C782E0A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 21:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7352da8fde3so888296a34.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747854231; x=1748459031; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hId9RuMiwxmpWMJZlGrNAr/AavJSTeVOVGuxlzm5rFg=;
 b=gHYyvjtRPW9tma6zZvEKRDfxA8516Oz3ZsZrAzlDiyez3TmCpubCle7uYvcKlvqViQ
 lR7rwGk7dPUfQ4QGj5Pq1gs95YvQv+a+Oe2e/l38snB0KZlPSfWjOVs3XNSdMdyTvEaI
 hT24TUMBUeBa/fyy/5Ea1rd8aN4BcQB6WOPbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747854231; x=1748459031;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hId9RuMiwxmpWMJZlGrNAr/AavJSTeVOVGuxlzm5rFg=;
 b=BGVTtPgVMpGTRG6NF1cW/wydMRthuM3NOyV2gvJ162kng3prNru5MjwaXkmcP+px5S
 i8AgLoQ1odMzCk/NlftGc6Sz2kG8fW/qAgW4/mNbXmk9PDFS3JfOGKY706XiKX1Ww9wL
 z5FKbo0YCk4fo4usHLWGm325MpidVaimcxkzeVOL5K2jBV1THocbAcCcSAHtRmkaFLkU
 mpr3XdpfWeNB1l5fror2fCZMom5T0Rrmf7hGXS0Hh3yZsxLjnYnFz2UebL99zIV5Ag01
 nm6iRx7YxuDSmtEW7J08E/92xMIKgcfBg2ygljE01fkkYmEJwlgIUsnzmWnm0VG5AEMZ
 hzKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRGGoNgH/A9oiMtVOidG94utyHAEsoBLZP9xDbA0H+N0RWc3rNe4pcsqJN8u1Qif7b+W0d/HE=@lists.denx.de
X-Gm-Message-State: AOJu0YyJJ7cLSMS65o490is8PfGF0NlbphX/zJwP26FLm8gBs+yfVZ9i
 DhRz55IasqLeY/hBcHDH/VDIyu2N4c20SLerMSaORvjPtb4GtnzC01mPwmIIYti4JL8=
X-Gm-Gg: ASbGncsOevOvx28huAHiEZYcR2HI41F8ZCZ1so2ixZevD//exfiEAtcE4QGbpBnSIcZ
 8So4Eptgd7eRgvQsR36OKg4jv1sjtq1rcoFf1U8ubS4+MIy1B9xovZ1w8aI+BDUIxDDynmUDi4B
 MA932r3671GYx2crI2UNzFXzdYRwIg+fSq1b/TbHmsWYql+86BZUxn4H8rMAxRe/p9M1wP6R8VV
 ROofsJKD6mmb4PcvSuAWOt+5EVq8y0Noyb48f2UsnQjbN9kuwAn/7VZDCv08t5qfcJRnErTr6e/
 EoplFp3tyyyYfpVvSPVQZy2Ddw/trdZJcfkoOPDSTZwqhjg+hgN0B7ueNpUSp2VStvui1XVHbHi
 eBao7OuvvEGtra85/MuCzu/Q=
X-Google-Smtp-Source: AGHT+IHx0eyCBOiW6HvfmDD8nPMGmIkxzt/JUvSE4PKftZgIxkoYZPDpSt1QMgfTf5j4Q+4/ZXBeoQ==
X-Received: by 2002:a05:6830:3816:b0:731:cb3d:67db with SMTP id
 46e09a7af769-734f6af8834mr15463165a34.16.1747854230940; 
 Wed, 21 May 2025 12:03:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm2220097a34.52.2025.05.21.12.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 12:03:49 -0700 (PDT)
Date: Wed, 21 May 2025 13:03:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@redhat.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 neil.armstrong@linaro.org, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v3 0/3] fastboot: add support for generic block
 flashing
Message-ID: <20250521190347.GF100073@bill-the-cat>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
 <174774092427.332438.8643753165301653831.b4-ty@kernel.org>
 <87zff6nhmo.fsf@kernel.org> <20250521151236.GC100073@bill-the-cat>
 <87wma9okxy.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N/hRXldAOpBroc9z"
Content-Disposition: inline
In-Reply-To: <87wma9okxy.fsf@kernel.org>
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


--N/hRXldAOpBroc9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 08:52:41PM +0200, Mattijs Korpershoek wrote:
> Hi Tom,
>=20
> On mer., mai 21, 2025 at 09:12, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Wed, May 21, 2025 at 04:49:35PM +0200, Mattijs Korpershoek wrote:
> >> Hi Neil,
> >>=20
> >> On mar., mai 20, 2025 at 13:35, Mattijs Korpershoek <mkorpershoek@kern=
el.org> wrote:
> >>=20
> >> > Hi,
> >> >
> >> > On Tue, 06 May 2025 18:10:06 +0200, neil.armstrong@linaro.org wrote:
> >> >> This serie permits using any block device as target
> >> >> for fastboot by moving the generic block logic into
> >> >> a common set of helpers and also use them as generic
> >> >> backend.
> >> >>=20
> >> >> The erase logic has been extended to support software
> >> >> erase since only 2 block drivers exposes the erase
> >> >> operation.
> >> >>=20
> >> >> [...]
> >> >
> >> > Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-d=
fu (u-boot-dfu-next)
> >> >
> >> > [1/3] fastboot: blk: introduce fastboot block flashing support
> >> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/8=
8239b5bb04bea2b58f7bf4c3ea72cf832de818c
> >> > [2/3] fastboot: blk: switch emmc to use the block helpers
> >> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/2=
5ab5c32c28b9f25fb193f726f239d75af3c365a
> >> > [3/3] fastboot: integrate block flashing back-end
> >> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a=
885bd8c969e25d03bf406207d89b1145c9490fb
> >>=20
> >> It seems this series cause CI to fail:
> >> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26238
> >>=20
> >> Without the patches applied, it passes:
> >> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26235
> >>=20
> >> Do you have any idea what is going wrong?
> >> I could not find anything obvious by skimming through the logs.
> >
> > It's a Kconfig problem then. Some platform is prompting for a value (not
> > a y/n) and there's no default.
>=20
> You are correct. Thank you for the suggestion.
>=20
> I've applied the following diff to 3/3:
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 68967abb751e..fdf34a6abe1e 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -200,6 +200,7 @@ config FASTBOOT_MMC_USER_NAME
>  config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>         string "Define FASTBOOT block interface name"
>         depends on FASTBOOT_FLASH_BLOCK
> +       default "none"
>         help
>           The fastboot "flash" and "erase" commands support operations
>           on any Block device, this should specify the block device name

Assuming that the code will see "none" and handle the error correctly,
OK. But we really should have a configured true value here, yes?

> @@ -212,6 +213,7 @@ config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>  config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>         int "Define FASTBOOT block device identifier"
>         depends on FASTBOOT_FLASH_BLOCK
> +       default 0
>         help
>           The fastboot "flash" and "erase" commands support operations
>           on any Block device, this should specify the block device

I do not like this at first. If FASTBOOT_FLASH_BLOCK_DEVICE_ID is set,
there should be a valid ID set too yes? Potentially worse, is 0 a valid
option here? If so, is that likely to be a real and common one? In that
case, we should also be updating the help text to make sure it's clear
what the normal range is I think.

--=20
Tom

--N/hRXldAOpBroc9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmguI5MACgkQFHw5/5Y0
tywangv/ZxmBMWrIQKZNn6sATuItOAd/ibRhDfmeJF4Z+eiQk5NlPNZUFXsGOrwp
CvODcuMvs1wLi9mVl8cLadut2CgQNnvbIUSx9vU5t8cJO4jg4Gt0F7b/VRoL+zU0
0//AsRK+brdPU/lf5KcMRpWc4H4cxhplSjxhEYKslXkHTqMnCK5Z+P6dRvU23E/e
QIwPGXusCDiZ2En22DWexySgHO24r2c95hsYty8hm8iUbFEI8OJ51rLmzzPm8aRd
1BsT+zAlS//6c3lUNihgdo9NcxGIazepBIzX4qbMtUeX8nAT7cmqiaXlhAUsPgku
uqZSETLGiAVJ2Y8hIv7D4OcH+5tNnLqEA6b5QOJcp3o5SLFRsJmfD5xEjfESLEM2
qyDJJmdWvu2pQqaMTeIE6UgcvESsf1YOy7KP0qS1F0SqvAqaWSw6tqPxuIqvXTxh
aIkbMh2VE+8lGVbmo5GJJqqntM+0/vYSNf7lsXWwLFFKPp/IDEwL7uPf0CG3yk7t
KuvRrqCS
=ivVP
-----END PGP SIGNATURE-----

--N/hRXldAOpBroc9z--
